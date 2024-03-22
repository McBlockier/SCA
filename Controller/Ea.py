from threading import Thread
import numpy as np
import locale
from PyQt6.QtWidgets import QApplication, QMainWindow, QWidget, QLineEdit, QPushButton,  QVBoxLayout
from PyQt6.QtCore import Qt, QObject, pyqtSignal, pyqtSlot
from PyQt6.uic import loadUi
from cryptography.fernet import Fernet
from Controller.Connection import ConexionSQLite, UsuarioDAO

class Encrypt:
    def __init__(self):
        self.key = Fernet.generate_key()

    def encrypt_data(self, text):
        try:
            cipher = Fernet(self.key)
            encrypted_bytes = cipher.encrypt(text.encode())
            encrypted_text = encrypted_bytes.decode()  # Convertir los bytes cifrados a texto
            return encrypted_text, self.key
        except Exception as ex:
            print(f"Error -> {ex}")

    def decrypt_data(self, encrypted_text, key):
        cipher = Fernet(key)
        decrypted_text = cipher.decrypt(encrypted_text).decode()
        return decrypted_text

class MethodsWindow:
    """
    Clase base para definir métodos abstractos para la configuración de ventanas.

    Esta clase proporciona métodos abstractos que deben ser implementados por las subclases
    para inicializar los componentes de la interfaz de usuario, variables y estilos.

    Attributes:
        Ninguno

    Methods:
        initializeComponents(self):
            Método abstracto para inicializar los componentes de la interfaz de usuario.

        initializeVariables(self):
            Método abstracto para inicializar las variables necesarias para la ventana.

        initializeStyles(self):
            Método abstracto para aplicar estilos a los componentes de la interfaz de usuario.
    """

    def initializeComponents(self):
        """
        Inicializa los componentes de la interfaz de usuario.

        Este método debe ser implementado por las subclases para configurar
        los componentes de la interfaz de usuario, como botones, etiquetas, etc.

        Returns:
            None
        """
        pass

    def initializeVariables(self):
        """
        Inicializa las variables necesarias para la ventana.

        Este método debe ser implementado por las subclases para inicializar
        cualquier variable que sea necesaria para la ventana.

        Returns:
            None
        """
        pass

    def initializeStyles(self):
        """
        Aplica estilos a los componentes de la interfaz de usuario.

        Este método debe ser implementado por las subclases para aplicar estilos
        a los componentes de la interfaz de usuario, como colores, fuentes, etc.

        Returns:
            None
        """
        pass

class ThreadWorker(Thread):
    def __init__(self, username, callback):
        super().__init__()
        self.username = username
        self.callback = callback

    def run(self):
        try:
            # Realiza la validación del nombre de usuario
            conexion = ConexionSQLite('../DB/FingerSpeak.sqlite')
            usuario_dao = UsuarioDAO(conexion)
            result = usuario_dao.value_username(self.username)
            # Llama al callback con el resultado
            self.callback(result)
        except Exception as ex:
            print(f"Error de tipo -> {ex}")

class MethodsTranslate:
    """
    Clase base para definir métodos relacionados con la traducción de textos.

    Esta clase proporciona métodos abstractos que deben ser implementados por las subclases
    para traducir textos a diferentes idiomas y obtener componentes de la interfaz de usuario.

    Attributes:
        Ninguno

    Methods:
        translate_to_spanish(self):
            Método abstracto para traducir textos al español.

        translate_to_english(self):
            Método abstracto para traducir textos al inglés.

        translate_to_chinese(self):
            Método abstracto para traducir textos al chino.

        translate_to_french(self):
            Método abstracto para traducir textos al francés.

        get_components(self):
            Método abstracto para obtener componentes de la interfaz de usuario.

        init_locale_lenguaje(self):
            Método abstracto para inicializar la configuración de idioma.
    """

    def translate_to_spanish(self):
        """
        Traduce los textos al español.

        Este método debe ser implementado por las subclases para traducir
        los textos de la interfaz de usuario al español.

        Returns:
            None
        """
        pass

    def translate_to_english(self):
        """
        Traduce los textos al inglés.

        Este método debe ser implementado por las subclases para traducir
        los textos de la interfaz de usuario al inglés.

        Returns:
            None
        """
        pass

    def translate_to_chinese(self):
        """
        Traduce los textos al chino.

        Este método debe ser implementado por las subclases para traducir
        los textos de la interfaz de usuario al chino.

        Returns:
            None
        """
        pass

    def translate_to_french(self):
        """
        Traduce los textos al francés.

        Este método debe ser implementado por las subclases para traducir
        los textos de la interfaz de usuario al francés.

        Returns:
            None
        """
        pass

    def translate_to_portuguese(self):
        pass

    def get_components(self):
        """
        Obtiene componentes de la interfaz de usuario.

        Este método debe ser implementado por las subclases para obtener
        los componentes de la interfaz de usuario que se traducirán.

        Returns:
            None
        """
        pass

    def init_locale_lenguaje(self):
        """
        Inicializa la configuración de idioma.

        Este método debe ser implementado por las subclases para inicializar
        la configuración de idioma de la aplicación.

        Returns:
            None
        """
        pass

class RoundedWindow:
    """
    Clase para hacer ventanas con bordes redondeados.

    Esta clase proporciona un método para configurar una ventana con bordes redondeados.

    Attributes:
        window (QWidget): La ventana que se va a configurar con bordes redondeados.

    Methods:
        startRound(self):
            Configura la ventana con bordes redondeados.
    """
    def __init__(self, window):
        """
        Inicializa la clase RoundedWindow.

        Args:
            window (QWidget): La ventana que se va a configurar con bordes redondeados.

        Returns:
            None
        """
        self.window = window

    def startRound(self):
        """
        Configura la ventana con bordes redondeados.

        Este método configura la ventana para que tenga bordes redondeados
        y establece su tamaño fijo y fondo translúcido.

        Returns:
            None
        """
        self.window.setWindowFlags(self.window.windowFlags() | Qt.FramelessWindowHint)
        self.window.setFixedSize(480, 636)
        self.window.setAttribute(Qt.WA_TranslucentBackground)
        # Establecer activados los botones (Esto puede requerir ajustes dependiendo de la implementación)
        self.window.buttonExit.setChecked(True)  # Botón salir
        self.window.buttonMinimize.setChecked(True)  # Botón minimizar

class MotionFrame(QWidget):
    """
    Clase para manejar eventos de arrastre de ventanas.

    Esta clase hereda de QWidget y proporciona métodos para manejar eventos del mouse
    para permitir el arrastre de la ventana al hacer clic y arrastrar el mouse.

    Attributes:
        window (QWidget): La ventana que se puede arrastrar.
        dragging (bool): Indica si se está arrastrando la ventana.
        offset (QPoint): Guarda la posición del cursor en relación con la ventana.

    Methods:
        mousePressEvent(self, event):
            Maneja el evento de clic del mouse.

        mouseMoveEvent(self, event):
            Maneja el evento de movimiento del mouse.

        mouseReleaseEvent(self, event):
            Maneja el evento de liberación del mouse.
    """

    def __init__(self, window):
        """
        Inicializa la clase MotionFrame.

        Args:
            window (QWidget): La ventana que se puede arrastrar.

        Returns:
            None
        """
        super().__init__(window)
        self.window = window

        self.dragging = False  # Inicializar el atributo dragging
        self.offset = None  # Inicializar el atributo offset

    def mousePressEvent(self, event):
        """
        Maneja el evento de clic del mouse.

        Si el botón presionado es el botón izquierdo del mouse,
        comienza el arrastre de la ventana y guarda la posición del cursor.

        Args:
            event: El evento de clic del mouse.

        Returns:
            None
        """
        if event.button() == Qt.LeftButton:
            self.dragging = True
            self.offset = event.pos()

    def mouseMoveEvent(self, event):
        """
        Maneja el evento de movimiento del mouse.

        Si estamos arrastrando la ventana, mueve la ventana según la posición del cursor.

        Args:
            event: El evento de movimiento del mouse.

        Returns:
            None
        """
        if self.dragging:
            self.window.move(event.globalPos() - self.offset)

    def mouseReleaseEvent(self, event):
        """
        Maneja el evento de liberación del mouse.

        Si se suelta el botón izquierdo del mouse, detiene el arrastre de la ventana.

        Args:
            event: El evento de liberación del mouse.

        Returns:
            None
        """
        if event.button() == Qt.LeftButton:
            self.dragging = False
            self.offset = None

class WindowState(QApplication):
    """
    Clase para controlar el estado de la ventana y la aplicación.

    Esta clase hereda de QApplication y proporciona un método para cerrar la ventana
    y salir de la aplicación.

    Attributes:
        window (QWidget): La ventana que se va a cerrar.

    Methods:
        closeApp(self):
            Cierra la ventana actual y sale de la aplicación.
    """
    def __init__(self, window):
        """
        Inicializa la clase WindowState.

        Args:
            window (QWidget): La ventana que se va a cerrar.

        Returns:
            None
        """
        super().__init__([])
        self.window = window

    def closeApp(self):
        """
        Cierra la ventana actual y sale de la aplicación.

        Este método cierra la ventana actual y sale de la aplicación,
        liberando los recursos asociados.

        Returns:
            None
        """
        self.window.close()
        self.quit()