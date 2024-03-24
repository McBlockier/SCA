import sys
import os
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
        self.setFixedSize(1227, 856)

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