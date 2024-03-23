import sys
from PyQt5.QtWidgets import QMainWindow
from PyQt5.uic import loadUi
from Controller.Implements import MethodsWindow, MotionFrame, RoundedWindow
class ControllerRegister(QMainWindow, MethodsWindow):
    def __init__(self):
        super().__init__()
        loadUi('../UI/Register.ui', self)

        # Llamamos a los inicializadores
        self.InitializeVariables()
        self.InitializeComponents()
        self.InitializeStyles()

    def InitializeVariables(self):
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound()

    def InitializeComponents(self):
        # Botones del formulario REGISTER
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana
        self.buttonBack.clicked.connect(self._backToLogin) #Boton de regreso al login
        self.buttonRegister.clicked.connect(self._registerUser) #Boton para hacer el registro en la BD

    def InitializeStyles(self):
        pass

    def _registerUser(self):
        """
        Aqui se valida los campos ingresados y se registra el usuario con su información en la base de datos
        :return:
        """
        pass


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