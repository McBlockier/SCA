import sys
import math
from PyQt5.QtWidgets import (
    QApplication,
    QMainWindow,
    QGraphicsScene,
    QGraphicsTextItem,
    QSizePolicy,
    QGraphicsView,
)
from PyQt5.QtGui import (
    QColor,
    QBrush,
    QFont,
)
from Controller.Implements import(
    MethodsWindow,
    RoundedWindow,
    MotionFrame,
    ThreadWorker
)
from PyQt5.QtCore import(
    Qt,
    QRectF,
    QTimer,
    QDateTime
)
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
import matplotlib.pyplot as plt
import numpy as np
import mplcursors
from PyQt5.uic import loadUi



class AdminController(QMainWindow, MethodsWindow):
    """Clase para controlar la ventana principal de la aplicación."""

    def __init__(self):
        """Inicializa la ventana principal."""
        super().__init__()
        loadUi("../UI/Admin.ui", self)

        self.initializeComponents()
        self.initializeVariables()


    def initializeComponents(self):
        """Inicializa los componentes de la ventana."""
        InstanceWindow = RoundedWindow(self)
        InstanceWindow.startRound(1409, 891)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.grafica1 = Canvas_grafica2()
        self.grafica_dos.addWidget(self.grafica1)

        self.grafica2 = Canvas_grafica3()
        self.grafica_tres.addWidget(self.grafica2)

        self.chartPerformance()#Llamamos a la gráfica de desempeño

        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana

        self.timerT = QTimer(self)
        self.timerT.timeout.connect(self.update_time)
        self.timerT.start(1000)

    def initializeVariables(self):
        pass


    def chartPerformance(self):
        """Ejemplo de cómo mostrar un gráfico."""
        try:
            self.scene = QGraphicsScene()
            self.graphicsOverView.setScene(self.scene)

            # Datos de ejemplo (meses y altas/bajas)
            self.months = ["En", "Feb", "Mar", "Abr", "May", "Jun",
                           "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
            self.data = [50, 70, 80, 75, 90, 20, 60, 90, 80, 60, 40, 60]

            # Llamar a la función para mostrar el gráfico
            self.showChart(self.graphicsOverView)

        except Exception as ex:
            print(f"Error {ex}")

    def showChart(self, view):
        """Muestra un gráfico de barras."""
        try:

            # Activar el scroll en modo automático
            view.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOn)
            view.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOn)

            bar_width = 25
            bar_spacing = 25  # Ajusta este valor para cambiar el espaciado entre las barras
            max_height = max(self.data)
            min_value = min(self.data)
            max_value = max(self.data)

            # Definir una paleta de colores
            palette = [QColor("#4aceeb"), QColor("#6fc2ff"), QColor("#91a5ff"), QColor("#b485ff"), QColor("#d764ff"),
                       QColor("#f343ff")]

            # Limpiamos la escena antes de volver a dibujar
            self.scene.clear()

            # Agregar título al gráfico
            title = QGraphicsTextItem("Desempeño docente")
            title_font = QFont("Segoe UI", 10, QFont.Bold)
            title.setFont(title_font)
            title_width = title.boundingRect().width()
            title_height = title.boundingRect().height()
            title.setPos(view.viewport().width() - title_width - 10, 10)
            self.scene.addItem(title)

            # Obtener altura máxima para las barras y espacio adicional para el título
            max_bar_height = 320 - title_height - 20

            # Dibujar barras y etiquetas
            for i, value in enumerate(self.data):
                bar_height = (value / max_height) * max_bar_height
                rect = self.scene.addRect(bar_spacing * (i + 1) + bar_width * i, max_bar_height - bar_height, bar_width,
                                          bar_height)

                # Establecer color de la barra
                color_index = int((value - min_value) / (max_value - min_value) * (len(palette) - 1))
                rect.setBrush(QBrush(palette[color_index]))

                # Etiqueta para el mes
                month_label = QGraphicsTextItem(self.months[i])
                month_label.setPos(
                    bar_spacing * (i + 1) + bar_width * i + bar_width / 2 - month_label.boundingRect().width() / 2,
                    max_bar_height + 5)
                self.scene.addItem(month_label)

                # Etiqueta para la cantidad
                quantity_label = QGraphicsTextItem(str(value))
                quantity_label_width = quantity_label.boundingRect().width()
                quantity_label_height = quantity_label.boundingRect().height()
                quantity_label.setPos(bar_spacing * (i + 1) + bar_width * i + bar_width / 2 - quantity_label_width / 2,
                                      max_bar_height - bar_height - quantity_label_height - 5)
                quantity_label.setRotation(-90)  # Rotar etiqueta en vertical
                self.scene.addItem(quantity_label)

            # Dibujar línea
            line = self.scene.addLine(bar_spacing, max_bar_height, (len(self.months) + 1) * (bar_spacing + bar_width),
                                      max_bar_height)
            pen = line.pen()
            pen.setColor(Qt.red)
            pen.setWidth(2)
            line.setPen(pen)

            # Ajustamos el tamaño de la escena al tamaño de la vista
            self.scene.setSceneRect(0, 0, view.viewport().width(), view.viewport().height())

        except Exception as ex:
            print(f"Error: {ex}")

    def _closeWindow(self):
        self.close()

        # Función para minimizar la ventana
    def _minimizeWindow(self):

        self.showMinimized()

    def update_time(self):

        current_time = QDateTime.currentDateTime()
        time_string = current_time.toString("hh:mm AP")
        self.lbTime.setText(time_string)

class Canvas_grafica2(FigureCanvas):
    def __init__(self, parent=None):
        self.fig, self.ax = plt.subplots(1, dpi=100, figsize=(6, 6), sharey=True)
        super().__init__(self.fig)

        nombres = ['Prácticas', 'Ejercicio', 'Evaluación', 'Presentación']
        colores_hex = ['#4bcfeb', '#91a5ff', '#b485ff', '#f343ff']
        tamaño = [20, 26, 30, 24]
        explotar = [0.05, 0.05, 0.05, 0.05]

        colores_rgb = [(int(col[1:3], 16)/255, int(col[3:5], 16)/255, int(col[5:7], 16)/255) for col in colores_hex]

        plt.title("Tipos de trabajos", color='#51517f', size=12, family="Segoe UI")

        patches, texts, autotexts = self.ax.pie(tamaño, explode=explotar, labels=nombres, colors=colores_rgb,
                                                autopct='%1.0f%%', pctdistance=0.6, shadow=True, startangle=90,
                                                radius=0.8, labeldistance=1.1)

        self.ax.axis('equal')
        self.ax.set_facecolor('white')
        self.ax.set_aspect('equal')
        plt.close(self.fig)

        # Agregar efecto hover con cambio de color
        cursor = mplcursors.cursor(hover=True)

        @cursor.connect("add")
        def on_hover(sel):
            sel.annotation.set_text(sel.artist.get_label())
            sel.artist.set_color('lightgrey')

        @cursor.connect("remove")
        def on_leave(sel):
            sel.artist.set_color(colores_rgb[nombres.index(sel.artist.get_label())])


class Canvas_grafica3(FigureCanvas):
    def __init__(self, parent=None):
        self.fig, self.ax = plt.subplots(1, dpi=100, figsize=(6, 6), sharey=True)
        super().__init__(self.fig)

        nombres = ['Aprovo', 'Reprovo', 'Asesoria']
        colores_hex = ['#4bcfeb', '#91a5ff', '#b485ff']
        tamaño = [50, 20, 40]
        explotar = [0.05, 0.05, 0.05]

        colores_rgb = [(int(col[1:3], 16)/255, int(col[3:5], 16)/255, int(col[5:7], 16)/255) for col in colores_hex]

        plt.title("Desempeño de alumnos", color='#51517f', size=12, family="Segoe UI")

        patches, texts, autotexts = self.ax.pie(tamaño, explode=explotar, labels=nombres, colors=colores_rgb,
                                                autopct='%1.0f%%', pctdistance=0.6, shadow=True, startangle=90,
                                                radius=0.8, labeldistance=1.1)

        self.ax.axis('equal')
        self.ax.set_facecolor('white')
        self.ax.set_aspect('equal')
        plt.close(self.fig)

        # Agregar efecto hover con cambio de color
        cursor = mplcursors.cursor(hover=True)

        @cursor.connect("add")
        def on_hover(sel):
            sel.annotation.set_text(sel.artist.get_label())
            sel.artist.set_color('lightgrey')

        @cursor.connect("remove")
        def on_leave(sel):
            sel.artist.set_color(colores_rgb[nombres.index(sel.artist.get_label())])



