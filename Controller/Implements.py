from PyQt5.QtCore import Qt, QPoint, QTimer, QObject
from PyQt5.QtWidgets import QWidget
from abc import ABC, abstractmethod
from threading import Thread
import json

class ThreadWorker(Thread):
    def __init__(self):
        """
        Constructor de la clase ThreadWorker.
        """
        super().__init__()  # Llama al constructor de la clase padre Thread
        self.running = False  # Bandera para indicar si el hilo está corriendo
        self.archivo_json = "../Files/settings.json"  # Ruta del archivo JSON
        self.information = None  # Almacenará la información leída del archivo JSON

    def run(self):
        """
        Método run() que será ejecutado cuando se inicie el hilo.
        """
        self.running = True  # Marca el hilo como corriendo

    def saveSettings(self, info_to_save):
        """
        Método para guardar la información en un archivo JSON.

        Args:
            info_to_save: Información a guardar en el archivo JSON.
        """
        try:
            # Abre el archivo JSON en modo escritura
            with open(self.archivo_json, "w") as archivo:
                # Escribe la información en el archivo JSON con formato legible
                json.dump(info_to_save, archivo, indent=4)
        except Exception as ex:
            # Captura cualquier excepción que ocurra durante el proceso de guardado
            print(f"Error {ex}")

    def readSettings(self):
        """
        Método para leer la información desde un archivo JSON.

        Returns:
            La información leída del archivo JSON.
        """
        try:
            # Abre el archivo JSON en modo lectura
            with open(self.archivo_json, "r") as archivo:
                # Carga la información desde el archivo JSON
                self.information = json.load(archivo)
            # Retorna la información leída
            return self.information
        except Exception as ex:
            # Captura cualquier excepción que ocurra durante el proceso de lectura
            print(f"Error {ex}")

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

    def startRound(self, width, height):
        """
        Configura la ventana con bordes redondeados.

        Este método configura la ventana para que tenga bordes redondeados
        y establece su tamaño fijo y fondo translúcido.

        Returns:
            None
        """
        self.window.setWindowFlags(self.window.windowFlags() | Qt.FramelessWindowHint)
        self.window.setAttribute(Qt.WA_TranslucentBackground)
        self.window.setFixedSize(width, height)
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


# Clase abstracta para implementar sus métodos ya predefinidos y no estar recreando a cada momento
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

    def hideComponents(self):
        """
        Oculta los componentes específicos de la ventana Ticket.

        """
        pass

    def _closeWindow(self):
        """
        Cierra la ventana Ticket y habilita la ventana anterior.

        """
        pass

    def _minimizeWindow(self):
        """
        Minimiza la ventana Ticket y habilita la ventana anterior.

        """
        pass