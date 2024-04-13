import sys
import math
from PyQt5.QtWidgets import (
    QApplication,
    QMainWindow,
    QGraphicsScene,
    QGraphicsTextItem,
    QSizePolicy,
    QGraphicsView,
    QFileDialog,
    QVBoxLayout,
    QScrollArea,
    QWidget,
    QCheckBox,
    QLabel,
    QTableWidget,
    QTableWidgetItem
)
from PyQt5.QtGui import (
    QColor,
    QBrush,
    QFont,
    QIcon
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
    QDateTime,
    QPropertyAnimation,
    QRect
)
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
import matplotlib.pyplot as plt
import numpy as np
import mplcursors
from PyQt5.uic import loadUi
from Controller.Message import MessageBox #Clase responsable de mostrar mensajes gráficos



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
        InstanceWindow.startRound(1495, 889)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.grafica1 = Canvas_grafica2()
        self.grafica_dos.addWidget(self.grafica1)

        self.grafica2 = Canvas_grafica3()
        self.grafica_tres.addWidget(self.grafica2)

        # Datos de ejemplo (meses y altas/bajas)
        self.months = ["En", "Feb", "Mar", "Abr", "May", "Jun",
                       "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
        self.data = [50, 70, 80, 75, 90, 20, 60, 90, 80, 60, 40, 60]
        self.showChart(self.graphicsOverView, self.months, self.data, "Desempeño docente")
        self.showActivityReports()

        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana

        self.timerT = QTimer(self)
        self.timerT.timeout.connect(self.update_time)
        self.timerT.start(1000)


        #Botones del panel leteral
        self.buttonDashboard.clicked.connect(self.__showFramePanel)
        self.buttonMessage.clicked.connect(self.__showFrameMessage)
        self.buttonLogout.clicked.connect(self.__closeSesion)
        self.buttonStudents.clicked.connect(self.__showFrameStudents)
        self.buttonReports.clicked.connect(self.__showFrameReports)
        self.buttonSearch.clicked.connect(self.onTextChanged)

        #Botones del panel de mensajes
        self.linkComents.clicked.connect(lambda: self.linksSelect('Comments'))
        self.linkReports.clicked.connect(lambda: self.linksSelect('Reports'))
        self.linkAnswers.clicked.connect(lambda: self.linksSelect('Answers'))

        #Botones de contestar mensajes de caja 1 y caja 2
        self.buttonReply.clicked.connect(lambda: self.animationMessage('FirstBox'))
        self.buttonReply2.clicked.connect(lambda: self.animationMessage('SecondBox'))

        #Botones para marcar con estrella
        self.buttonStarUp.clicked.connect(lambda: self.showStarUp('buttonStarUp'))
        self.buttonStarUp2.clicked.connect(lambda: self.showStarUp('buttonStarUp2'))

        #Botones de la vista de reporte
        self.buttonEvi.clicked.connect(lambda: self.selectFile('doc'))
        self.buttonRub.clicked.connect(lambda: self.selectFile('doc'))
        self.buttonImg.clicked.connect(lambda: self.selectFile('img'))
        self.buttonVid.clicked.connect(lambda: self.selectFile('media'))

        #Boton de contactos
        self.buttonOpenChat.clicked.connect(self.__showFrameMessage)

        #Frame default
        self.framePanel.raise_()


        #Campos de ScrollAreas
        self.__updateScrollTeachers()
        self.__updateScrollUsers()

    def onTextChanged(self):

        try:
            from DB.Requests import Inquiries
            Instance = Inquiries()
            value = Instance.search_contact(self.searchContact.text())
            print(value[0]['name'])

        except Exception as ex:
            print(f"Error {ex}")

    def __showFramePanel(self):
        self.framePanel.raise_()
        self.frameMessage.lower()
        self.frameReports_2.lower()

    def __showFrameMessage(self):
        self.frameMessage.raise_()
        self.framePanel.lower()
        self.frameStudents.lower()
        self.frameReports_2.lower()

    def __showFrameStudents(self):
        self.frameMessage.lower()
        self.framePanel.lower()
        self.frameStudents.raise_()
        self.frameReports_2.lower()

    def __showFrameReports(self):
        self.frameMessage.lower()
        self.framePanel.lower()
        self.frameStudents.lower()
        self.frameReports_2.raise_()


    def __closeSesion(self):
        try:

            if MessageBox.question_msgbox("PREGUNTA", "¿Está seguro(a) de salir al inicio de sesión?"):
                from Controller.Login import ControllerLogin
                Instance = ControllerLogin()
                Instance.show()
                self.hide()
                self.close()

        except Exepcion as ex:
            print(f"Error {ex}")


    def initializeVariables(self):
        self.first_animation = None
        self.second_animation = None
        self.indexButton = 0

    def linksSelect(self, type):
        try:
            # Definimos los estilos comunes
            common_style = "QFrame { background-color:transparent; border: none; border-radius: 10px; }"
            selected_style = "QFrame { background-color:#fffefe; border: none; border-radius: 10px; }"

            # Establecemos los estilos según el tipo
            if type == "Comments":
                self.frameComments.setStyleSheet(selected_style)
                self.frameReports.setStyleSheet(common_style)
                self.frameAnswers.setStyleSheet(common_style)
            elif type == "Reports":
                self.frameComments.setStyleSheet(common_style)
                self.frameReports.setStyleSheet(selected_style)
                self.frameAnswers.setStyleSheet(common_style)
            elif type == "Answers":
                self.frameComments.setStyleSheet(common_style)
                self.frameReports.setStyleSheet(common_style)
                self.frameAnswers.setStyleSheet(selected_style)
        except Exception as ex:
            print(f"Error linksSelect {ex}")




    def __updateScrollUsers(self):
        """Actualiza la tabla de usuarios."""
        try:
            # Obtener todos los usuarios de la base de datos
            from DB.Requests import Inquiries
            Instance = Inquiries()
            valueAll = Instance.GetAllUsers()

            # Encabezados de columna para la tabla de usuarios
            column_headers = ["ID Usuario", "Contraseña", "Nombre", "Apellido", "No. Control", "ID Rango",
                              "Semestre", "Regular", "Puntaje"]

            # Rellenar la tabla de usuarios
            self._fillTable(valueAll, self.tableUsers, column_headers, 9)

        except Exception as ex:
            print(f"Error al actualizar la tabla de usuarios: {ex}")

    def __updateScrollTeachers(self):
        """Actualiza la tabla de profesores."""
        try:
            # Obtener todos los profesores de la base de datos
            from DB.Requests import Inquiries
            Instance = Inquiries()
            valueAll = Instance.GetAllTeachers()

            # Encabezados de columna para la tabla de profesores
            column_headers = ["ID", "Nombre", "Matricula"]

            # Rellenar la tabla de profesores
            self._fillTable(valueAll, self.tableTeacher, column_headers, 3)

        except Exception as ex:
            print(f"Error al actualizar la tabla de profesores: {ex}")

    def _fillTable(self, valueAll, table, column_headers, columns):
        """Rellena una tabla con los valores proporcionados y alterna el color de las filas."""
        try:
            # Establecer el número de filas y columnas
            table.setRowCount(len(valueAll))
            table.setColumnCount(columns)

            # Establecer los encabezados de las columnas
            table.setHorizontalHeaderLabels(column_headers)

            # Colores personalizados para las filas
            colors = [QColor("#fefeff"), QColor("#ecf3fc")]

            # Insertar los datos en la tabla
            for row, user in enumerate(valueAll):
                for column, data in enumerate(user):
                    item = QTableWidgetItem(str(data))
                    table.setItem(row, column, item)

                    # Alternar el color de fondo de las filas
                    color_index = row % len(colors)
                    background_color = colors[color_index]
                    text_color = QColor(Qt.black)

                    item.setBackground(background_color)
                    item.setForeground(text_color)


        except Exception as ex:
            print(f"Error al rellenar la tabla: {ex}")


    def animationMessage(self, typeBox):
        try:
            if typeBox == "FirstBox":
                if self.frameBoxFirst.height() == 261 and self.frameBoxSecond.height() == 481:
                    self.first_animation = QPropertyAnimation(self.frameBoxFirst, b"geometry")
                    self.first_animation.setDuration(1000)

                    final_rect_first = QRect(self.frameBoxFirst.geometry().x(),
                                             self.frameBoxFirst.geometry().y(),
                                             self.frameBoxFirst.geometry().width(),
                                             481)  # Aumenta la altura a 481

                    self.first_animation.setStartValue(self.frameBoxFirst.geometry())
                    self.first_animation.setEndValue(final_rect_first)

                    self.second_animation = QPropertyAnimation(self.frameBoxSecond, b"geometry")
                    self.second_animation.setDuration(1000)

                    final_rect_second = QRect(self.frameBoxSecond.geometry().x(),
                                              self.frameBoxSecond.geometry().y() + self.frameBoxSecond.geometry().height() - 261,
                                              # Mueve la caja hacia abajo en 261 píxeles
                                              self.frameBoxSecond.geometry().width(),
                                              261)  # Disminuye la altura a 261

                    self.second_animation.setStartValue(self.frameBoxSecond.geometry())
                    self.second_animation.setEndValue(final_rect_second)

                    self.first_animation.start()
                    self.second_animation.start()

                    QTimer.singleShot(1200, self.checkAnimation)

            elif typeBox == "SecondBox":
                if self.frameBoxSecond.height() == 261 and self.frameBoxFirst.height() == 481:
                    self.first_animation = QPropertyAnimation(self.frameBoxFirst, b"geometry")
                    self.first_animation.setDuration(1000)

                    final_rect_first = QRect(self.frameBoxFirst.geometry().x(),
                                             self.frameBoxFirst.geometry().y(),
                                             self.frameBoxFirst.geometry().width(),
                                             261)  # Aumenta la altura a 481

                    self.first_animation.setStartValue(self.frameBoxFirst.geometry())
                    self.first_animation.setEndValue(final_rect_first)

                    self.second_animation = QPropertyAnimation(self.frameBoxSecond, b"geometry")
                    self.second_animation.setDuration(1000)

                    #Segunda caja, debe aumentar su altura hacia arriba sin moverse de su lugar

                    final_rect_second = QRect(self.frameBoxSecond.geometry().x(),
                                              self.frameBoxSecond.geometry().y() - (481 - 261),
                                              # La caja 2 aumenta su altura hacia arriba sin moverse de su lugar
                                              self.frameBoxSecond.geometry().width(),
                                              481)  # Aumenta la altura a 481

                    self.second_animation.setStartValue(self.frameBoxSecond.geometry())
                    self.second_animation.setEndValue(final_rect_second)

                    self.first_animation.start()
                    self.second_animation.start()

                    QTimer.singleShot(1200, self.checkAnimation)

        except Exception as ex:
            print(f"Error animationMessage {ex}")

    def checkAnimation(self):
        try:
            if self.first_animation is not None and self.second_animation is not None:
                first_animation_state = self.first_animation.state()
                second_animation_state = self.second_animation.state()

                if first_animation_state == QPropertyAnimation.Running or second_animation_state == QPropertyAnimation.Running:
                    QTimer.singleShot(200, self.checkAnimation)
                else:
                    pass
        except Exception as ex:
            print(f"Error checkAnimation {ex}")

    def showStarUp(self, indexButton):
        try:
            current_icon = self.buttonStarUp.icon()
            current_icon2 = self.buttonStarUp2.icon()
            if indexButton == 'buttonStarUp':
                pass
            elif indexButton == 'buttonStarUp2':
                pass
        except Exception as ex:
            print(f"Error showStarUp {ex}")

    def showChart(self, view, months, data, title):
        """Muestra un gráfico de barras."""
        try:

            self.scene = QGraphicsScene()
            view.setScene(self.scene)

            # Activar el scroll en modo automático
            view.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOn)
            view.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOn)

            bar_width = 25
            bar_spacing = 25  # Ajusta este valor para cambiar el espaciado entre las barras
            max_height = max(data)
            min_value = min(data)
            max_value = max(data)

            # Definir una paleta de colores
            palette = [QColor("#4aceeb"), QColor("#6fc2ff"), QColor("#91a5ff"), QColor("#b485ff"), QColor("#d764ff"),
                       QColor("#f343ff")]

            # Limpiamos la escena antes de volver a dibujar
            self.scene.clear()

            # Agregar título al gráfico
            title = QGraphicsTextItem(title)
            title_font = QFont("Segoe UI", 10, QFont.Bold)
            title.setFont(title_font)
            title_width = title.boundingRect().width()
            title_height = title.boundingRect().height()
            title.setPos(view.viewport().width() - title_width - 10, 10)
            self.scene.addItem(title)

            # Obtener altura máxima para las barras y espacio adicional para el título
            max_bar_height = 320 - title_height - 20

            # Dibujar barras y etiquetas
            for i, value in enumerate(data):
                bar_height = (value / max_height) * max_bar_height
                rect = self.scene.addRect(bar_spacing * (i + 1) + bar_width * i, max_bar_height - bar_height, bar_width,
                                          bar_height)

                # Establecer color de la barra
                color_index = int((value - min_value) / (max_value - min_value) * (len(palette) - 1))
                rect.setBrush(QBrush(palette[color_index]))

                # Etiqueta para el mes
                month_label = QGraphicsTextItem(months[i])
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
            line = self.scene.addLine(bar_spacing, max_bar_height, (len(months) + 1) * (bar_spacing + bar_width),
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
        try:
            current_time = QDateTime.currentDateTime()
            time_string = current_time.toString("hh:mm AP")
            self.lbTime.setText(time_string)
        except Exception as ex:
            print(f"Error update_time {ex}")


    def showActivityReports(self):
        # Datos de ejemplo (meses y altas/bajas)
        self.months = ["Rub", "Ev", "Img", "Vid"]
        self.data = [45, 57, 23, 10]
        self.showChart(self.graphicsOverView_2, self.months, self.data, "")


    def selectFile(self, file_type):
        try:
            # Configurar los filtros de archivos según el tipo especificado
            if file_type == 'doc':
                file_filter = "Archivo de documento (*.pdf *.doc *.docx)"
            elif file_type == 'img':
                file_filter = "Archivos de imagén (*.png *.jpg)"
            elif file_type == 'media':
                file_filter = "Archivo de video (*.mp4 *.avi *.mov)"
            else:
                file_filter = "All files (*)"

            # Abrir el diálogo del explorador de archivos
            file_path, _ = QFileDialog.getOpenFileName(None, f"Select {file_type.capitalize()} file",
                                                       filter=file_filter)

            # Devolver la ruta del archivo seleccionado
            return file_path

        except Exception as ex:
            print(f"Error: {ex}")


class Canvas_grafica2(FigureCanvas):
    def __init__(self, parent=None):
        try:
            self.fig, self.ax = plt.subplots(1, dpi=100, figsize=(6, 6), sharey=True)
            super().__init__(self.fig)

            nombres = ['Práctica', 'Ejercicio', 'Presentación']
            colores_hex = ['#4bcfeb', '#91a5ff', '#f343ff']
            tamaño = [20, 26, 30]
            explotar = [0.05, 0.05, 0.05]

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
        except Exception as ex:
            print(f"Error __ini__ Class  Canvas_grafica2 {ex}")


class Canvas_grafica3(FigureCanvas):
    def __init__(self, parent=None):
        try:
            self.fig, self.ax = plt.subplots(1, dpi=100, figsize=(6, 6), sharey=True)
            super().__init__(self.fig)

            nombres = ['Aprobo', 'Reprobo', 'Asesoria']
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
        except Exception as ex:
            print(f"Error __ini__ Class  Canvas_grafica3 {ex}")







