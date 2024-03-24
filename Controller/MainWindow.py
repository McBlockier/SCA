import sys
import os
import psutil
import time
from PyQt5.QtWidgets import QApplication, QMainWindow, QLabel, QLineEdit, QPushButton
from PyQt5.QtCore import QTimer, QRect, QPropertyAnimation, QDateTime, QFile
from PyQt5.QtGui import QPixmap, QMovie, QIcon
from PyQt5.uic import loadUi
from Controller.Implements import RoundedWindow, MotionFrame, MethodsWindow
from Controller.Message import MessageBox
class WindowADM(QMainWindow, MethodsWindow):
    def __init__(self):
        super().__init__()
        loadUi('../UI/Administrator.ui', self)

        self.initializeComponents()
        self.initializeVariables()
        self.initializeStyles()

    def initializeComponents(self):
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana

    def initializeVariables(self):
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound()
        self.setFixedSize(1211, 856)

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
        self.timerB.start(5000)

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
            if charging:
                self.battery.setIcon(QIcon('../Resources/perno-de-bateria.png'))
            else:
                if percent == 100:
                    self.battery.setIcon(QIcon('../Resources/bateria-llena.png'))
                elif percent >= 70:
                    self.battery.setIcon(QIcon('../Resources/bateria-tres-cuartos.png'))
                elif percent >= 50:
                    self.battery.setIcon(QIcon('../Resources/la-mitad-de-la-bateria.png'))
                elif percent >= 30:
                    self.battery.setIcon(QIcon('../Resources/cuarto-de-bateria.png'))
                elif percent <= 20:
                    self.battery.setIcon(QIcon('../Resources/exclamacion-de-bateria.png'))

            self.lbCharge.setText(str(percent) + '%')

        except Exception as ex:
            print(f"Error {ex}")
