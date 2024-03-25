import sys
import os
import time
import psutil
from PyQt5.QtWidgets import (QLabel, QLineEdit, QPushButton, QWidget, QFrame,
                             QFileDialog, QApplication, QMainWindow)
from PyQt5.QtCore import QTimer, QRect, QPropertyAnimation, QDateTime, QFile, Qt
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
        InstanceWindow = RoundedWindow(self)
        InstanceWindow.startRound(1221, 879)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        # Conectar el botón de salida a la función _closeWindow
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana

        # Conectar el botón de minimizar a la función _minimizeWindow
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana

        # Conectar el botón de cargar archivo extra a la función _upload_extra
        self.uploadExtra.clicked.connect(self._upload_extra)

        # Conectar el botón de cargar archivo académico a la función _upload_acad
        self.uploadAcad.clicked.connect(self._upload_acad)

        # Conectar el botón de ticket a la función _showTicketUI
        self.buttonTicket.clicked.connect(self._showTicketUI)

        # Conectar el botón de perfil a la función _showProfileUI
        self.buttonProfile.clicked.connect(self._showProfileUI)

        # Conectar el botón de configuraciones a la función _showSettingsUI
        self.buttonSettings.clicked.connect(self._showSettingsUI)

        #Conectar el botón de cerrar sesión a la funcion _closeSesion
        self.buttonLoggOut.clicked.connect(self._closeSesion)

        self.buttonNext_2.clicked.connect(self._nextOption)

        self.buttonBack_2.clicked.connect(self._oldOption)

    def initializeVariables(self):

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


        self.message = MessageBox()

    def initializeStyles(self):
       pass

        # Funciones raíz de la ventana
    def _closeWindow(self):
        self.close()

    def _minimizeWindow(self):
        self.showMinimized()

    def update_time(self):
        current_time = QDateTime.currentDateTime()
        time_string = current_time.toString("hh:mm AP")
        self.lbTime.setText(time_string)


    def _nextOption(self):
        self.lbIconText.setText("         Pagos")
        self.lbIconSide.setIcon(QIcon('../Resources/factura-punto-de-venta.png'))

    def _oldOption(self):
        self.lbIconText.setText("         Créditos")
        self.lbIconSide.setIcon(QIcon('../Resources/revision-de-comentarios.png'))

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

            """
           Sección para la vista del estudiante, botones que corresponden a las vistas
           de estudiante, es decir al menu lateral, que son configuración, perfil,
           boleta y lo de pagos, estos botones solo se encargan de mostrar la interfaz
           que le corresponde a cada botón, la programación de cada interfaz es decir
           sus componentes internos, no va incluido, estos solo muestras las UI y las ocultan,
           nada más
           """

    # Métodos (funciones) para mostrar las ventanas o UI de cada apartado
    def _showTicketUI(self):
        try:
            # Crea una instancia de la ventana Ticket y la guarda como un atributo de la clase
            self.ticket_window = Ticket(self)
            self.ticket_window.show()
            self.setEnabled(False)

        except Exception as ex:
            print(f"Error {ex}")

    def _showSettingsUI(self):
       try:
           self.message.information_msgbox("INFORMACIÓN", "Opción no disponible por el momento")
       except Exception as ex:
            print(f"Error {ex}")

    def _showProfileUI(self):
        try:
            self.message.information_msgbox("INFORMACIÓN", "Opción no disponible por el momento")
        except Exception as ex:
            print(f"Error {ex}")

    def _closeSesion(self):
        from Controller.Login import ControllerLogin
        InstanceLogin = ControllerLogin()
        InstanceLogin.show()
        self.hide()
        self.close()

    """
    Fin de la seccion de botones del menu lateral de la vista de estudiante
    """


"""
Clase encargada de hacer la carga de la interfaz correspondiente a lo de boleta
hereda de QMainWindow y de MethodsWindow
"""
class Ticket(QMainWindow, MethodsWindow):
    def __init__(self, windowMain):
        super().__init__()
        loadUi('../UI/Ticket.ui', self)

        self.previous_window = windowMain #Tomamos la ventana anterior para manipular

        self.initializeComponents()
        self.initializeVariables()
        self.initializeStyles()


    def initializeComponents(self):
        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound(928, 676)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent


        # Conectar el botón de salida a la función _closeWindow
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana

        # Conectar el botón de minimizar a la función _minimizeWindow
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana

    def initializeVariables(self):
        pass

    def initializeStyles(self):
        pass

    def hideComponents(self):
        self.buttonMinimize.setVisible(False)

    def _closeWindow(self):
        self.previous_window.setEnabled(True)
        self.hide()
        self.close()

    def _minimizeWindow(self):
        self.previous_window.setEnabled(True)
        self.showMinimized()



class Payments(QMainWindow, MethodsWindow):
    def __init__(self, windowMain):
        super().__init__()
        loadUi('../UI/Payments.ui', self)

        self.previous_window = windowMain #Tomamos la ventana anterior para manipular

        self.initializeComponents()
        self.initializeVariables()
        self.initializeStyles()



    def initializeComponents(self):
        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound(1103, 654)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent


        # Conectar el botón de salida a la función _closeWindow
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana



    def initializeVariables(self):
        pass

    def initializeStyles(self):
        pass

    def hideComponents(self):
        self.buttonMinimize.setVisible(False)


    def _closeWindow(self):
        self.previous_window.setEnabled(True)
        self.hide()
        self.close()


