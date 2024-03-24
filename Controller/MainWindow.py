import sys
import os
import psutil
import time
from PyQt5.QtWidgets import QApplication, QMainWindow, QLabel, QLineEdit, QPushButton, QWidget, QFrame, QFileDialog
from PyQt5.QtCore import QTimer, QRect, QPropertyAnimation, QDateTime, QFile
from PyQt5.QtGui import QPixmap, QMovie, QIcon, QImage
from PyQt5.uic import loadUi
from Controller.Implements import RoundedWindow, MotionFrame, MethodsWindow
from Controller.Message import MessageBox
from PIL import Image

class WindowADM(QMainWindow, MethodsWindow):
    def __init__(self):
        super().__init__()
        loadUi('../UI/Student.ui', self)

        self.initializeComponents()
        self.initializeVariables()
        self.initializeStyles()

    def initializeComponents(self):
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana
        self.uploadExtra.clicked.connect(self._upload_extra)
        self.uploadAcad.clicked.connect(self._upload_acad)

    def initializeVariables(self):
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound()
        self.setFixedSize(1221, 879)

        # Cargar el GIF usando QMovie
        movie = QMovie('../Resources/reloj.gif')
        self.clock.setMovie(movie)
        # Escalar el GIF al tamaño deseado
        movie.setScaledSize(self.clock.size())

        # Iniciar la reproducción del GIF
        movie.start()

        # Configurar un QTimer para ejecutar la función update_time() cada 1 segundo
        self.timerT = QTimer(self)
        self.timerT.timeout.connect(self.update_time)
        self.timerT.start(1000)  # Ejecutar cada 1000 ms (1 segundo)

        # Creamos el QTimer
        self.timerB = QTimer()
        # Conectamos la señal timeout del QTimer a la función monitor_battery_percentage
        self.timerB.timeout.connect(self.monitor_battery)
        # Configuramos el QTimer para que se ejecute cada 5 segundos (5000 milisegundos)
        self.timerB.start(1500) #1.5s


    def initializeStyles(self):
        try:
            with open('../Styles/stylesMainWindow.css', 'r') as f:  # Abrir archivo de estilos
                styles = f.read()  # Leer los estilos
                self.setStyleSheet(styles)  # Aplicar los estilos a la ventana
        except Exception as ex:
            print(f"Hubo un error al inicializar los estilos: {ex}")  # Manejar cualquier error

        # Funciones raíz de la ventana
    def _closeWindow(self):
        self.close()

    def _minimizeWindow(self):
        self.showMinimized()

    def update_time(self):
        current_time = QDateTime.currentDateTime()
        time_string = current_time.toString("hh:mm AP")
        self.lbTime.setText(time_string)

    def monitor_battery(self):
        try:
            battery = psutil.sensors_battery()
            if battery is not None:
                percent = battery.percent
                charging = battery.power_plugged
                self.change_icon_battery(percent, charging)
            else:
                 print("No se puede obtener información sobre la batería.")
        except Exception as ex:
            print(f"Error {ex}")

    def change_icon_battery(self, percent, charging):
        try:
            icon_path = '../Resources/'
            icon_name = ''

            if charging:
                icon_name = 'perno-de-bateria.png'
            else:
                if percent == 100:
                    icon_name = 'bateria-llena.png'
                elif percent >= 70:
                    icon_name = 'bateria-tres-cuartos.png'
                elif percent >= 50:
                    icon_name = 'la-mitad-de-la-bateria.png'
                elif percent >= 30:
                    icon_name = 'cuarto-de-bateria.png'
                elif percent <= 20:
                    icon_name = 'exclamacion-de-bateria.png'

            if icon_name:
                icon = QIcon(icon_path + icon_name)
                self.battery.setIcon(icon)
                self.lbCharge.setText(str(percent) + '%')
            else:
                print("No se pudo encontrar el icono adecuado para el porcentaje de la batería.")

        except Exception as ex:
            print(f"Error {ex}")


    def _upload_file(self):
        try:
            # Abrir un cuadro de diálogo para seleccionar un archivo
            file_dialog = QFileDialog(self)
            file_dialog.setWindowTitle('Seleccionar archivo a subir')
            file_dialog.setFileMode(QFileDialog.ExistingFiles)
            file_dialog.setNameFilter("Archivos de imagen (*.png *.jpg);;Archivos PDF (*.pdf)")

            # Ejecutar el cuadro de diálogo
            if file_dialog.exec_():
                selected_files = file_dialog.selectedFiles()
                return selected_files
        except Exception as e:
            print(f"Error al abrir el cuadro de diálogo: {e}")

    def _upload_extra(self):
        try:
            selected_files = self._upload_file()
            if selected_files:
                print("Archivos seleccionados para Extra:", selected_files)
                self.files_extra = selected_files  # Guardamos el archivo, para subirlo

        except Exception as e:
            print(f"Error al subir archivos Extra: {e}")

    def _upload_acad(self):
        try:
            selected_files = self._upload_file()
            if selected_files:
                print("Archivos seleccionados para Acad:", selected_files)
                self.files_acad = selected_files  # Guardamos el archivo, para subirlo
        except Exception as e:
            print(f"Error al subir archivos Acad: {e}")
