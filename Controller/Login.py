from PyQt5.QtWidgets import QMainWindow,  QLineEdit
from PyQt5.QtCore import QTimer, QRect, QPropertyAnimation, QDateTime
from PyQt5.QtGui import QPixmap, QMovie, QIcon
from PyQt5.uic import loadUi
from Controller.Implements import RoundedWindow, MotionFrame, MethodsWindow
from Controller.Message import MessageBox

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
            InstanceWindow.startRound(830, 665)
            InstanceMotion = MotionFrame(self)

            # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
            self.mousePressEvent = InstanceMotion.mousePressEvent
            self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
            self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

            #Botones del formulario LOGIN
            self.buttonExit.clicked.connect(self._closeWindow)#Cerrar ventana
            self.buttonMinimize.clicked.connect(self._minimizeWindow)#Minimizar ventana
            self.buttonLogin.clicked.connect(self._validateLogin)#Botón de logeo
            self.buttonRegister.clicked.connect(self._showRegister)  # Botón de registro
            self.buttonView.clicked.connect(self._viewPassword) #Boton de ver contraseña

            self.services.clicked.connect(self.__services)  # Boton de servicios
            self.aboutUs.clicked.connect(self.__aboutUs)  # Boton de acerca de nosotros
            self.home.clicked.connect(self.__home)  # Boton de inicio


            self.timeShow.setGeometry(10, 10, 48, 48)

            self.__checkDataBase()
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
        self.isPasswordVisible = False
        self.message = MessageBox() #variable para invocar un mensaje

        self.buttonDB.setVisible(False)



    def initializeStyles(self):
        pass

    def hideComponents(self):
        pass

    #Función para validar el inicio de sesión
    def _validateLogin(self):
        try:
            from Controller.MainWindow import WindowADM
            InstanceWindow = WindowADM()
            InstanceWindow.show()
            self.hide()
            self.close()
        except Exception as ex:
            print(f"Error {ex}")

    #Funcion para transición de imagenes
    def show_image(self):
        pixmap = QPixmap(self.image_paths[self.current_image_index])
        self.images.setPixmap(pixmap.scaled(self.images.size(), aspectRatioMode=True))

        # Función para cambiar la imagen

    def change_image(self):
        """
        Cambia la imagen mostrada en un QLabel con una animación de desplazamiento.
        """
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


    def __checkDataBase(self):
        try:
            from DB.Requests import Inquiries
            if Inquiries.isAvailable:
                self.buttonDB.setVisible(False)
            else:
                self.buttonDB.setVisible(True)
        except Exception as ex:
            print(f"Error {ex}")

        # Función para mostrar la ventana de registro
    def _showRegister(self):
        """
        Muestra la ventana de registro.
        """
        try:
            from Controller.Register import ControllerRegister
            InstaceRegister = ControllerRegister()
            InstaceRegister.show()
            self.hide()
            self.close()
        except Exception as ex:
            print(f"Error {ex}")

        # Función para alternar la visibilidad de la contraseña

    def _viewPassword(self):
        """
        Alterna la visibilidad de la contraseña en un QLineEdit y cambia el ícono del botón según sea necesario.
        """
        self.isPasswordVisible = not self.isPasswordVisible
        echo_mode = QLineEdit.Normal if self.isPasswordVisible else QLineEdit.Password
        icon_path = "../Resources/view_on.png" if self.isPasswordVisible else "../Resources/view_off.png"

        self.password.setEchoMode(echo_mode)
        self.buttonView.setIcon(QIcon(icon_path))


    #Botones complementarios(servicios, acerca de nosotros y inicio)
    def __services(self):
        self.message.information_msgbox("INFORMACIÓN", "No disponible por el momento")
    def __aboutUs(self):
        self.message.information_msgbox("INFORMACIÓN", "No disponible por el momento")
    def __home(self):
        self.message.information_msgbox("INFORMACIÓN", "No disponible por el momento")


        # Función para cerrar la ventana
    def _closeWindow(self):
        self.close()

        # Función para minimizar la ventana
    def _minimizeWindow(self):

        self.showMinimized()

        # Función para actualizar el tiempo en un widget de la interfaz
    def update_time(self):

        current_time = QDateTime.currentDateTime()
        time_string = current_time.toString("hh:mm AP")
        self.setTime.setText(time_string)