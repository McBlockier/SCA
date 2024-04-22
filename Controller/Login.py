from PyQt5.QtWidgets import QMainWindow,  QLineEdit
from PyQt5.QtCore import QTimer, QRect, QPropertyAnimation, QDateTime
from PyQt5.QtGui import QPixmap, QMovie, QIcon
from PyQt5.uic import loadUi
from Controller.Implements import RoundedWindow, MotionFrame, MethodsWindow
from Controller.Message import MessageBox
import json
import os
from concurrent.futures import ThreadPoolExecutor
from threading import Thread

class ControllerLogin(QMainWindow, MethodsWindow):
    def __init__(self):
        super().__init__()
        loadUi('../UI/Login.ui', self)


        self.initializeComponents()
        self.initializeVariables()


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
            self.remember.stateChanged.connect(self._on_checkbox_state_changed) #Link de reinicio de contraseña

            self.services.clicked.connect(self.__services)  # Boton de servicios
            self.aboutUs.clicked.connect(self.__aboutUs)  # Boton de acerca de nosotros
            self.home.clicked.connect(self.__home)  # Boton de inicio
            self.forgotPassword.clicked.connect(self._forgotPassword)

            self.timeShow.setGeometry(10, 10, 48, 48)

            self.__checkDataBase()#Checamos la base de datos, para ver si esta bien
            self._readLogged() #Leemos el historial por si puso mantener sesion


        except Exception as ex:
            print(f"Error initializeComponents -> {ex}")


    def initializeVariables(self):
        try:
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
            self.saved_password = ""
        except Exception as ex:
            print(f"Error initializeVariables -> {ex}")

    #Función para validar el inicio de sesión
    def _validateLogin(self):
        try:
            from DB.Requests import Inquiries
            InstanceInquiries = Inquiries()

            # Obtener los valores de usuario y contraseña del formulario y limpiarlos
            username = self.userName.toPlainText().strip() #QPlainTextEdit
            password = self.password.text().strip()         #QLineEdit

            # Verificar que tanto el nombre de usuario como la contraseña no estén vacíos
            if username and password:
                # Si ambos campos tienen valores, continuar con la validación del inicio de sesión
                success = InstanceInquiries.validate_login(username, password)
                if success:
                    getRank = InstanceInquiries.get_user_details_by_id(username) #Obtenemos información del estudiante desde la BD
                    if getRank[0]['rankId'] == 1:

                         #Aqui se cargan las vistas de administrador
                        from Controller.AdminWindow import AdminController
                        Instance = AdminController(getRank)
                        Instance.show()
                        self.hide()
                        self.close()

                    elif getRank[0]['rankId'] == 2:

                        #Aqui se cargan las vistas para el alumno
                        from Controller.MainWindow import WindowADM
                        window = WindowADM(getRank)
                        window.show()
                        self.hide()
                        self.close()

                    elif getRank[0]['rankId'] == 3:

                        # Aqui se cargan las vistas de docente
                        from Controller.AdminWindow import AdminController
                        Instance = AdminController(getRank)
                        Instance.show()
                        self.hide()
                        self.close()

                else:
                    self.message.information_msgbox("INFORMACIÓN", "El usuario o contraseña no son correctos")
                    self.userName.setPlainText("")
                    self.password.setText("")
                    self.remember.setChecked(False)
            else:
                # Si alguno de los campos está vacío, mostrar un mensaje de advertencia
                self.message.information_msgbox("ADVERTENCIA",
                                              "Por favor ingrese tanto el nombre de usuario como la contraseña.")

        except Exception as ex:
            print(f"Error _validateLogin -> {ex}")


    def _readLogged(self):
        try:
            file_path = "../Files/loggedHistroy.json"

            if os.path.exists(file_path):
                with open(file_path, "r") as file:
                    # Utilizamos ThreadPoolExecutor para ejecutar la lectura del archivo en un hilo separado
                    with ThreadPoolExecutor() as executor:
                        # La función read_json se ejecutará en otro hilo y retornará el resultado
                        future = executor.submit(self.read_json, file)
                        # Obtenemos el resultado cuando esté disponible
                        data = future.result()

                        # Si hay datos en el archivo, puedes hacer lo que necesites con ellos
                        if data:
                            self.userName.setPlainText(data['userName'])
                            self.password.setText(data['password'])
                            self.saved_password = data['password']
                            self.remember.setChecked(True)

                        else:
                            self.remember.setChecked(False)
                            return None
            else:
                print("El archivo JSON no existe")
                return None

        except Exception as ex:
            print(f"Error _readLogged -> {ex}")  # Aquí se imprime la descripción completa del error
            return None

        # Función para leer el contenido del archivo JSON

    def read_json(self, file):
        try:
            # Intenta cargar el archivo JSON y devuelve los datos si tiene un formato válido
            return json.load(file)
        except json.JSONDecodeError as e:
            # Si el archivo JSON no tiene un formato válido, devuelve None
            print(f"Error al decodificar el JSON: {e}")
            return None

    def _forgotPassword(self):
        try:
            InstanceForgot = ResetPasswordUI(self)
            InstanceForgot.show()
        except Exception as ex:
            print(f"Error _forgotPassword -> {ex}")

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
            print(f"Error change_image -> {ex}")


    def __checkDataBase(self):
        try:
            from DB.Requests import Inquiries
            if Inquiries.isAvailable:
                self.buttonDB.setVisible(False)
            else:
                self.buttonDB.setVisible(True)
        except Exception as ex:
            print(f"Error __checkDataBase -> {ex}")

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
            print(f"Error _showRegister -> {ex}")

        # Función para alternar la visibilidad de la contraseña

    def _on_checkbox_state_changed(self, state):
        try:
            if state == 2:  # 2 corresponde a seleccionado, 0 a deseleccionado
                userName = self.userName.toPlainText().strip()
                password = self.password.text().strip()

                self._saveInfo(userName, password)

        except Exception as ex:
            print(f"Error _on_checkbox_state_changed -> {ex}")

    def _saveInfo(self, userName, password):
        try:
            file_path = "../Files/loggedHistroy.json"

            if userName != "" and password != "":
                # Crear un diccionario con los datos
                data = {
                    "userName": userName,
                    "password": password
                }

                # Verificar si el archivo existe
                if os.path.exists(file_path):
                    # Leer los datos existentes si el archivo no está vacío
                    if os.stat(file_path).st_size > 0:
                        with open(file_path, "r") as file:
                            json_data = json.load(file)
                    else:
                        json_data = {}  # Crear un diccionario vacío si el archivo está vacío
                    # Actualizar los datos existentes con los nuevos datos
                    json_data.update(data)
                else:
                    json_data = data  # Usar solo los nuevos datos si el archivo no existe

                # Escribir los datos actualizados en el archivo JSON
                with open(file_path, "w") as file:
                    json.dump(json_data, file, indent=4)

            else:
                MessageBox.information_msgbox("INFORMACIÓN",
                                                "Debes primero ingresar los datos como nombre de usuario y contraseña")
                self.remember.setChecked(False)

        except Exception as ex:
            print(f"Error _saveInfo -> {ex}")



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




class ResetPasswordUI(QMainWindow, MethodsWindow):
    def __init__(self, window):
        super().__init__()
        loadUi('../UI/ResetPassword.ui', self)
        self.window = window

        self.initializeComponents()

    def initializeComponents(self):

        InstanceWindow = RoundedWindow(self)
        InstanceWindow.startRound(553, 501)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.buttonAccept.clicked.connect(self.accept)
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana


        self.window.setEnabled(False)
        self.buttonMinimize.setVisible(False)

    def _closeWindow(self):
        self.window.setEnabled(True)
        self.hide()
        self.close()

    def _minimizeWindow(self):
        super()._minimizeWindow()

    def accept(self):
        try:
            from DB.Requests import Inquiries
            InstanceInquiries = Inquiries()

            password = self.password.text().strip()
            password_2 = self.password_2.text().strip()

            if password and password_2:
                if password == password_2:
                    value = InstanceInquiries.reset_password(password, self.window.userName.toPlainText())
                    print(value)
                    if value:
                        MessageBox.information_msgbox("INFORMACIÓN", "Contraseña actualizada correctamente")
                        self.window.setEnabled(True)
                        self._closeWindow()
                    else:
                        MessageBox.information_msgbox("ADVERTENCIA", "No se pudo actualizar la contraseña")
                else:
                    MessageBox.information_msgbox("ADVERTENCIA", "Las contraseñas no coinciden")
            else:
                MessageBox.information_msgbox("ADVERTENCIA", "Debe llenar ambos campos para cambiar la contraseña")

        except Exception as ex:
            print(f"Error {ex}")