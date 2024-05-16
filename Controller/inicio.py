import sys
from PyQt5.QtWidgets import QMainWindow
from PyQt5.uic import loadUi
from Controller.Implements import MethodsWindow, MotionFrame, RoundedWindow
from Controller.MainWindow import MessageBox

class ControllerInin(QMainWindow, MethodsWindow):
    def __init__(self):
        super().__init__()
        loadUi('../UI/servicios.ui', self)

        # Inicialización de variables y componentes
        self.initializeVariables()
        self.initializeComponents()

    def initializeVariables(self):
        instanceWindow = RoundedWindow(self)
        instanceWindow.startRound(916, 623)
        instanceMotion = MotionFrame(self)

        # Conexión de eventos del mouse de la ventana a métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = instanceMotion.mousePressEvent
        self.mouseMoveEvent = instanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = instanceMotion.mouseReleaseEvent

        self.message = MessageBox()

    def initializeComponents(self):
        # Botones del formulario REGISTER
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana
        self.buttonBack.clicked.connect(self._backToLogin) #Boton de regreso al login

    def _closeWindow(self):
        self.close()

    def _minimizeWindow(self):
        self.showMinimized()

    def _backToLogin(self):
        try:
            from Controller.Login import ControllerLogin
            instanceLogin = ControllerLogin()
            instanceLogin.show()
            self.hide()
            self.close()
        except Exception as ex:
            print(f"Error: {ex}")