import sys
from PyQt5.QtWidgets import QMainWindow
from PyQt5.uic import loadUi
from Controller.Implements import MethodsWindow, MotionFrame, RoundedWindow
from Controller.MainWindow import MessageBox
class ControllerRegister(QMainWindow, MethodsWindow):
    def __init__(self):
        super().__init__()
        loadUi('../UI/Register.ui', self)

        # Llamamos a los inicializadores
        self.initializeVariables()
        self.initializeComponents()


    def initializeVariables(self):
        InstanceWindow = RoundedWindow(self)
        InstanceWindow.startRound(830, 665)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.message = MessageBox()


    def initializeComponents(self):
        # Botones del formulario REGISTER
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana
        self.buttonBack.clicked.connect(self._backToLogin) #Boton de regreso al login
        self.buttonRegister.clicked.connect(self._registerUser) #Boton para hacer el registro en la BD

    def _registerUser(self):
        try:
            from DB.Requests import Inquiries
            InstanceInquiries = Inquiries()

            # Obtener los datos del usuario desde los campos de entrada
            userName = self.userName.toPlainText().strip()
            password = self.password.text().strip()
            confirmPass = self.confirmPassword.text().strip()
            names = self.name.toPlainText().strip()
            lastNames = self.lastName.toPlainText().strip()
            controlNum = self.controlNumber.toPlainText().strip()

            # Verificar si las contraseñas coinciden
            if password != confirmPass:
                self.message.warning_msgbox("ADVERTENCIA!", "Las contraseñas ingresadas no coinciden")
                return

            # Realizar el registro del usuario
            success, message = InstanceInquiries.register_user(userName, password, names, lastNames,
                                                               controlNum, 2)
            # Mostrar mensaje de éxito o advertencia
            if success:
                self.message.information_msgbox("Éxito", "Usuario registrado correctamente.")
                self._backToLogin()
            else:
                self.message.information_msgbox("ADVERTENCIA", "No se pudo hacer el registro")

            # Limpiar los campos de entrada
            self.clearInputFields()

        except Exception as ex:
            print(f"Error {ex}")

    def clearInputFields(self):
        """Limpiar los campos de entrada."""
        self.userName.setPlainText("")
        self.password.setText("")
        self.confirmPassword.setText("")
        self.name.setPlainText("")
        self.lastName.setPlainText("")
        self.controlNumber.setPlainText("")

    #Funciones raíz de la ventana
    def _closeWindow(self):
        self.close()
    def _minimizeWindow(self):
        self.showMinimized()

    def _backToLogin(self):
        try:
            from Controller.Login import ControllerLogin
            InstanceLogin = ControllerLogin()
            InstanceLogin.show()
            self.hide()
            self.close()
        except Exception as ex:
            print(f"Error {ex}")