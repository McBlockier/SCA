import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QLabel
from PyQt5.QtCore import QTimer, QRect, QPropertyAnimation, QDateTime
from PyQt5.QtGui import QPixmap, QMovie
from PyQt5.uic import loadUi
from Controller.Implements import RoundedWindow, MotionFrame, MethodsWindow

class ControllerLogin(QMainWindow, MethodsWindow):
    def __init__(self):
        super().__init__()
        loadUi('../UI/Login.ui', self)

        self.initializeComponents()
        self.initializeVariables()
        self.initializeStyles()

    def initializeComponents(self):
        try:
            InstanceWindow = RoundedWindow(self)
            InstanceWindow.startRound()

            InstanceMotion = MotionFrame(self)

            # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
            self.mousePressEvent = InstanceMotion.mousePressEvent
            self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
            self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent


            #Botones del formulario LOGIN
            self.buttonExit.clicked.connect(self._closeWindow)#Cerrar ventana
            self.buttonMinimize.clicked.connect(self._minimizeWindow)#Minimizar ventana
            self.buttonLogin.clicked.connect(self._validateLogin)#Botón de logeo

            self.timeShow.setGeometry(10, 10, 48, 48)
        except Exception as ex:
            print(f"Error initializeComponents -> {ex}")

    def initializeVariables(self):
        self.image_paths = ['../Resources/iniciar-sesion.png',
                            '../Resources/presentacion.png', '../Resources/reclutamiento.png']
        self.current_image_index = 0
        # Mostrar la primera imagen
        self.show_image()

        # Configurar temporizador para cambiar las imágenes
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.change_image)
        self.timer.start(6500)  # Cambiar cada 6.5 segundos

        # Cargar el GIF usando QMovie
        movie = QMovie('../Resources/reloj.gif')
        self.timeShow.setMovie(movie)
        # Escalar el GIF al tamaño deseado
        movie.setScaledSize(self.timeShow.size())

        # Iniciar la reproducción del GIF
        movie.start()

        # Configurar un QTimer para ejecutar la función update_time() cada 1 segundo
        self.timerT = QTimer(self)
        self.timerT.timeout.connect(self.update_time)
        self.timerT.start(1000)  # Ejecutar cada 1000 ms (1 segundo)

        # Llamar a update_time() inicialmente para mostrar la hora actual
        self.update_time()

    def initializeStyles(self):
        pass

    def hideComponents(self):
        pass


    #Función para validar el inicio de sesión
    def _validateLogin(self):
        pass

    #Funcion para transición de imagenes
    def show_image(self):
        pixmap = QPixmap(self.image_paths[self.current_image_index])
        self.images.setPixmap(pixmap.scaled(self.images.size(), aspectRatioMode=True))

    def change_image(self):
        try:
            # Crear animación de desplazamiento hacia la posición final
            animation = QPropertyAnimation(self.images, b"geometry")
            animation.setDuration(2000)  # Duración de la animación en milisegundos

            # Definir los valores inicial y final de la animación
            start_rect = QRect(50, 160, 271, 261)  # Posición inicial del QLabel
            end_rect = QRect(50, 160, 271, 261)  # Posición final del QLabel

            animation.setStartValue(start_rect)
            animation.setEndValue(end_rect)

            # Cambiar al índice de imagen siguiente
            self.current_image_index += 1
            if self.current_image_index >= len(self.image_paths):
                self.current_image_index = 0

            # Mostrar la imagen actualizada
            self.show_image()

            # Iniciar la animación
            animation.start()
        except Exception as ex:
            print(f"Error {ex}")

    #Funciones raíz de la ventana
    def _closeWindow(self):
        self.close()
    def _minimizeWindow(self):
        self.showMinimized()

    def update_time(self):
        current_time = QDateTime.currentDateTime()
        time_string = current_time.toString("hh:mm AP")
        self.setTime.setText(time_string)