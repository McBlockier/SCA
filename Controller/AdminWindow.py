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
    QRect,
    QEvent,
    QPoint,
    QEasingCurve
)
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
import matplotlib.pyplot as plt
import numpy as np
import mplcursors
import random
import locale
from PyQt5.uic import loadUi
from datetime import timedelta
from Controller.Message import MessageBox #Clase responsable de mostrar mensajes gráficos

class AdminController(QMainWindow, MethodsWindow):
    """Clase para controlar la ventana principal de la aplicación."""

    def __init__(self):
        """Inicializa la ventana principal."""
        super().__init__()
        loadUi("../UI/Admin.ui", self)

        self.initializeComponents()
        self.initializeVariables()

        #Variables globales
        self.dataTable = None
        self.messages = None

    def initializeComponents(self):
        """
        Inicializa los componentes de la ventana principal.

        Description:
        Este método se encarga de inicializar todos los componentes necesarios en la ventana principal de la aplicación.
        Configura la ventana con bordes redondeados y agrega eventos de movimiento del ratón.
        También inicializa las gráficas y los datos de ejemplo, configura los botones de minimizar y cerrar la aplicación,
        así como los temporizadores para la animación y los botones del panel lateral de la ventana principal.
        Además, establece las conexiones de los botones y widgets a sus respectivos métodos y eventos.

        Returns:
        - None
        """
        InstanceWindow = RoundedWindow(self)
        InstanceWindow.startRound(1495, 889) #Dimensiones de la ventana
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        # Clases para el dibujado gráfico
        self.grafica1 = Canvas_grafica2()
        self.grafica_dos.addWidget(self.grafica1)

        self.grafica2 = Canvas_grafica3()
        self.grafica_tres.addWidget(self.grafica2)

        self.showActivityReports()
        self.dataHeader()

        # Botones de minimizar y cerrar la aplicación
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana

        # Temporizador para animación
        self.timerT = QTimer(self)
        self.timerT.timeout.connect(self.update_time)
        self.timerT.start(1000)

        # Botones del panel lateral de la ventana principal
        self.buttonDashboard.clicked.connect(self.__showFramePanel)
        self.buttonMessage.clicked.connect(self.__showFrameMessage)
        self.buttonLogout.clicked.connect(self.__closeSesion)
        self.buttonStudents.clicked.connect(self.__showFrameStudents)
        self.buttonReports.clicked.connect(self.__showFrameReports)
        self.buttonSearch.clicked.connect(self.onTextChanged)

        # Botones del panel de mensajes
        self.linkComents.clicked.connect(lambda: self.linksSelect('Comments'))
        self.linkReports.clicked.connect(lambda: self.linksSelect('Reports'))
        self.linkAnswers.clicked.connect(lambda: self.linksSelect('Answers'))

        # Botones de contestar mensajes de caja 1 y caja 2
        self.buttonReply.clicked.connect(lambda: self.animationMessage('FirstBox'))
        self.buttonReply2.clicked.connect(lambda: self.animationMessage('SecondBox'))

        # Botones para marcar con estrella
        self.buttonStarUp.clicked.connect(lambda: self.showStarUp('buttonStarUp'))
        self.buttonStarUp2.clicked.connect(lambda: self.showStarUp('buttonStarUp2'))

        # Botones de la vista de reporte
        self.buttonEvi.clicked.connect(lambda: self.selectFile('doc'))
        self.buttonRub.clicked.connect(lambda: self.selectFile('doc'))
        self.buttonImg.clicked.connect(lambda: self.selectFile('img'))
        self.buttonVid.clicked.connect(lambda: self.selectFile('media'))

        # Boton de contactos
        self.buttonOpenChat.clicked.connect(self.__showFrameMessage)

        # Frame default
        self.framePanel.raise_()

        # Campos de ScrollAreas(tabla usuarios y docentes)
        self.__updateScrollTeachers()
        self.__updateScrollUsers()

        # Detectar click en las tablas
        self.tableUsers.cellClicked.connect(lambda row, col:
                                            self.on_cell_clicked(row, self.tableUsers))  # Tabla de alumnos
        self.tableTeacher.cellClicked.connect(lambda row, col:
                                              self.on_cell_clicked(row, self.tableTeacher))  # Tabla de docentes

        #Botones de crear nueva fila en cada tabla
        self.buttonCreateUsers.clicked.connect(lambda: self.createRow(self.tableUsers))#Crear en estudiantes
        self.buttonCreateTeacher.clicked.connect(lambda: self.createRow(self.tableTeacher))  # Crear en docentes

        #Botones de borrado de filas en cada tabla
        self.buttonDeleteUser.clicked.connect(lambda: self.deleteRow("Student"))#Borrado para estudiantes
        self.buttonDeleteTeacher.clicked.connect(lambda: self.deleteRow("Teacher"))#Borrado para docentes

        try:
            #Limitador de caracteres de los QLineEdit de Message
            self.setupLineEdit(self.lineEdit_3, self.lbLimit)
            self.setupLineEdit(self.lineEdit_2, self.lbLimit2)

            self.lbLimit.setText("Carácteres disponibles 240")
            self.lbLimit2.setText("Carácteres disponibles 240")

        except Exception as ex:
            print(f"Error {ex}")

        self.load_information("None", "Null")

        #Colocar mensajes de cada boton emergente
        self.b1.clicked.connect(lambda: self.setMessageButton('b1'))
        self.b2.clicked.connect(lambda: self.setMessageButton('b2'))
        self.b3.clicked.connect(lambda: self.setMessageButton('b3'))
        self.b4.clicked.connect(lambda: self.setMessageButton('b4'))
        self.b5.clicked.connect(lambda: self.setMessageButton('b5'))

        #Botones de enviar respuesta
        self.buttonSendSms1.clicked.connect(lambda: self.reply("reply1"))
        self.buttonSendSms2.clicked.connect(lambda: self.reply("reply2"))


    def load_information(self, type, messages):
        try:
            if type == "Answers":

                self.loadMessages(messages)
            else:

                from DB.Requests import Inquiries
                InstanceInquiries = Inquiries()

                messages = InstanceInquiries.getMessages()

                # Carga los mensajes
                self.loadMessages(messages)
        except Exception as ex:
            print(f"Error {ex}")

    def loadMessages(self, messages):
        try:
            # Verificar si hay mensajes con reply igual a 1
            has_reply_1 = any(message.get('reply') == 1 for message in messages)

            # Deshabilitar los botones de respuesta si hay mensajes con reply igual a 1
            self.buttonReply.setEnabled(not has_reply_1)
            self.buttonReply2.setEnabled(not has_reply_1)

            # Deshabilitar los campos de entrada si hay mensajes con reply igual a 1
            self.lineEdit_2.setEnabled(not has_reply_1)
            self.lineEdit_3.setEnabled(not has_reply_1)

            # Configurar los mensajes disponibles
            for i in range(5):
                if i < len(messages):
                    message = messages[i]
                    label_message = getattr(self, f"lb{i + 1}")
                    label_date = getattr(self, f"lbD{i + 1}")
                    label_user = getattr(self, f"lbUser{i + 1}")
                    label_reply = getattr(self, f"r{i + 1}")
                    button = getattr(self, f"b{i + 1}")

                    # Configurar el texto del mensaje
                    label_message.setText(message.get('mensaje', ''))

                    # Configurar la fecha del mensaje
                    time_delta = message.get('hora')
                    if isinstance(time_delta, timedelta):
                        formatted_time = self.format_time_delta(time_delta)
                        label_date.setText(formatted_time)
                    else:
                        label_date.setText("")

                    # Configurar el usuario del mensaje
                    label_user.setText(message.get('usuario', ''))

                    # Configurar el estado de "Revisado" si el mensaje tiene reply igual a 1
                    if message.get('reply') == 1:
                        label_reply.setText("Revisado")
                    else:
                        label_reply.setText("")

                    # Mostrar los QLabel y los QPushButtons correspondientes
                    label_message.setVisible(True)
                    label_date.setVisible(True)
                    label_user.setVisible(True)
                    label_reply.setVisible(True)
                    button.setVisible(True)
                else:
                    # Ocultar los QLabel y los QPushButtons si no hay información disponible
                    label_message = getattr(self, f"lb{i + 1}")
                    label_date = getattr(self, f"lbD{i + 1}")
                    label_user = getattr(self, f"lbUser{i + 1}")
                    label_reply = getattr(self, f"r{i + 1}")
                    button = getattr(self, f"b{i + 1}")

                    label_message.setVisible(False)
                    label_date.setVisible(False)
                    label_user.setVisible(False)
                    label_reply.setVisible(False)
                    button.setVisible(False)

            # Cargar la vista previa de los mensajes
            self.loadPreviewSms(messages)

        except Exception as ex:
            print(f"Error inesperado: {ex}")


    def load_icon(self, button, icon_number):
        try:
            icon_path = f"../Resources/{icon_number}-color.png"
            button.setIcon(QIcon(icon_path))
        except Exception as ex:
            print(f"Error: {ex}")


    def calculate_icon_numbers(self, user_message_count):
        return {user: min(message_count, 3) for user, message_count in user_message_count.items()}


    def loadPreviewSms(self, messages):
        try:
            user_message_count = {}  # Diccionario para almacenar el usuario y la cantidad de mensajes

            # Contar la cantidad de mensajes para cada usuario
            for message in messages:
                user = message.get('usuario')
                if user:
                    user_message_count[user] = user_message_count.get(user, 0) + 1

            # Asignar un número de icono a cada usuario según su cantidad de mensajes
            icon_numbers = self.calculate_icon_numbers(user_message_count)

            # Asignar iconos a los QPushButton para cada usuario
            for i, (user, icon_number) in enumerate(icon_numbers.items()):
                if i < 3:  # Limitar a 3 usuarios
                    button = getattr(self, f"s{i + 1}")
                    self.load_icon(button, icon_number)

            # Display the latest message for each user in QLabel widgets lbU1 to lbU4
            for i, (user, message_count) in enumerate(user_message_count.items()):
                if i < 3:  # Limitar a 3 usuarios
                    label_user = getattr(self, f"lbU{i + 1}")
                    label_user.setText(f"{user}")

        except Exception as ex:
            print(f"Error inesperado: {ex}")


    def onTextChanged(self):
        try:
            self.load_information("None", "Null")

            # Obtener el usuario a buscar desde el campo de búsqueda
            user_to_search = self.searchContact.text()

            # Verificar si el usuario está en la lista de mensajes
            found_messages = [message for message in self.messages if message['usuario'] == user_to_search]

            if found_messages:

                # Mostrar solo lbU1 y s1
                self.lbU1.setText(user_to_search)
                self.s1.setVisible(True)
                self.lbU1.setVisible(True)

                # Ocultar lbU2 hasta lbU4, s2 y s3, t2 hasta t4, i2 hasta i4 (si existen)
                for i in range(2, 5):
                    label_user = getattr(self, f"lbU{i}")
                    label_user.setVisible(False)
                    if i <= 3:  # Solo ocultar s2 y s3 si existen
                        button_s = getattr(self, f"s{i}")
                        button_s.setVisible(False)
                    label_t = getattr(self, f"t{i}")
                    label_t.setVisible(False)
                    label_i = getattr(self, f"i{i}")
                    label_i.setVisible(False)

            else:
                MessageBox.information_msgbox("INFORMACIÓN", "El usuario no fue encontrado.")

        except Exception as ex:
            print(f"Error onTextChanged: {ex}")

    def format_time_delta(self, delta):
        hours, remainder = divmod(delta.seconds, 3600)
        minutes, seconds = divmod(remainder, 60)
        return f"{hours:02d}:{minutes:02d}"


    def setMessageButton(self, typeButton):
        try:
            saveOldText1 = self.label_sms.text()
            saveOldText2 = self.label_sms2.text()

            if typeButton == "b1":
                self.label_sms.setText(self.lb1.text())
                self.lb1.setText(saveOldText1)
                self.userSms.setText(self.lbUser1.text())
            elif typeButton == "b2":
                self.label_sms.setText(self.lb2.text())
                self.lb2.setText(saveOldText1)
                self.userSms.setText(self.lbUser2.text())
            elif typeButton == "b3":
                self.label_sms2.setText(self.lb3.text())
                self.lb3.setText(saveOldText2)
                self.userSms2.setText(self.lbUser3.text())
            elif typeButton == "b4":
                self.label_sms2.setText(self.lb4.text())
                self.lb4.setText(saveOldText2)
                self.userSms2.setText(self.lbUser4.text())
            elif typeButton == "b5":
                self.label_sms2.setText(self.lb5.text())
                self.lb5.setText(saveOldText2)
                self.userSms2.setText(self.lbUser5.text())

            # Habilitar el ajuste automático de texto para los QLabel
            self.label_sms.setWordWrap(True)
            self.label_sms2.setWordWrap(True)

        except Exception as ex:
            print(f"Error: {ex}")


    def reply(self, typeButton):
        try:
            from DB.Requests import Inquiries
            InstanceInquiries = Inquiries()

            if typeButton in ["reply1", "reply2"]:
                # Determinar el QLabel y el userSms correspondientes
                label_sms = self.label_sms if typeButton == "reply1" else self.label_sms2
                userSms = self.userSms.text() if typeButton == "reply1" else self.userSms2.text()

                line_edit = self.lineEdit_3 if typeButton == "reply1" else self.lineEdit_2

                # Verificar si el campo de texto no está vacío o nulo
                if line_edit.toPlainText().strip():  # Si hay texto en el campo
                    if InstanceInquiries.insertReply(userSms, line_edit.toPlainText()):
                        MessageBox.information_msgbox("INFORMACION",
                                                      "La respuesta del mensaje fue enviada correctamente")
                        self.load_information("None", "Null")
                        self.lineEdit_2.clear()  # Limpiar los campos de texto
                        self.lineEdit_3.clear()

                        # Obtener el idMessage del mensaje
                        idMessage = InstanceInquiries.getMessageId(label_sms.text())
                        # Actualizar el estado de respuesta del mensaje
                        if idMessage:
                            InstanceInquiries.updateReplyStatus(idMessage)
                        else:
                            print("No se encontró el idMessage del mensaje.")
                    else:
                        MessageBox.input_error_msgbox("ERROR", "La respuesta del mensaje no fue enviada correctamente")
                else:
                    MessageBox.input_error_msgbox("ERROR", "Por favor ingrese la respuesta antes de enviarla")
        except Exception as ex:
            print(f"Error in reply: {ex}")


    def initializeVariables(self):
        self.first_animation = None
        self.second_animation = None
        self.indexButton = 0
        self.dataTable = None

    def __showFrame(self, frame):
        """
        Muestra el marco especificado y oculta los demás.

        Parameters:
        - frame: El marco que se desea mostrar.

        Returns:
        - None

        Description:
        Este método muestra el marco especificado y oculta los demás marcos en la ventana principal.
        Recorre todos los marcos disponibles y los eleva si coinciden con el marco especificado;
        de lo contrario, los baja para ocultarlos.
        """
        frames = [self.framePanel, self.frameMessage, self.frameStudents, self.frameReports_2]
        for f in frames:
            if f == frame:
                f.raise_()
            else:
                f.lower()

    def __showFramePanel(self):
        self.__showFrame(self.framePanel)

    def __showFrameMessage(self):
        self.__showFrame(self.frameMessage)

    def __showFrameStudents(self):
        self.__showFrame(self.frameStudents)

    def __showFrameReports(self):
        self.__showFrame(self.frameReports_2)

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

                self.load_information("None", "Null")

            elif type == "Reports":
                self.frameComments.setStyleSheet(common_style)
                self.frameReports.setStyleSheet(selected_style)
                self.frameAnswers.setStyleSheet(common_style)
                MessageBox.information_msgbox("INFORMACIÓN", "Sistema de reportes aún no disponible")

            elif type == "Answers":
                self.frameComments.setStyleSheet(common_style)
                self.frameReports.setStyleSheet(common_style)
                self.frameAnswers.setStyleSheet(selected_style)

                from DB.Requests import Inquiries
                InstanceInquieries = Inquiries()

                value, messages = InstanceInquieries.get_messages_with_answer()
                if value:
                    self.load_information("Answers", messages)

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


    def createRow(self, table):
        try:
            row_count = table.rowCount()
            table.insertRow(row_count)
            for col in range(table.columnCount()):
                item = QTableWidgetItem("")
                table.setItem(row_count, col, item)
            # Desplazar la tabla hacia la nueva fila
            item = table.item(row_count, 0)  # Obtener el primer elemento de la nueva fila
            table.scrollToItem(item)  # Desplazar la tabla hasta ese elemento
            table.editItem(item)  # Hacer editable el primer campo de la nueva fila

            # Conectar la señal itemChanged a una función para manejar los cambios en la fila nueva
            table.itemChanged.connect(lambda item: self.on_item_changed(item, table, row_count))
        except Exception as ex:
            print(f"Error al crear una nueva fila: {ex}")


    #Función para realizar el borrado en cada tabla, según se especifique en typeButton
    def deleteRow(self, typeButton):
        try:
            from DB.Requests import Inquiries
            InstanceInquiries = Inquiries()

            # Validar si self.dataTable tiene información
            if not self.dataTable:
                MessageBox.information_msgbox("INFORMACIÓN",
                                              "Primero debes seleccionar una celda de la fila que desea eliminar de la tabla, para poder realizar esta acción")
                return

            success_message = "El usuario ha sido borrado exitósamente"
            failure_message = "El usuario no ha sido borrado exitósamente"

            if typeButton == "Student":
                success = InstanceInquiries.delete_user_by_id(self.dataTable['ID Usuario'])
                self.__updateScrollUsers() #Actualizamos la tabla de estudiantes
            elif typeButton == "Teacher":
                success = InstanceInquiries.delete_teacher_by_id(self.dataTable['ID'])
                self.__updateScrollTeachers() #Actualizamos la tabla de docentes

            if success:
                MessageBox.information_msgbox("INFORMACIÓN", success_message)
            else:
                MessageBox.information_msgbox("INFORMACIÓN", failure_message)

        except Exception as ex:
            print(f"Error al eliminar {ex}")

    def on_item_changed(self, item, table, row):
        """
        Maneja el evento de cambio de un elemento en la tabla.

        Parameters:
        - item: El QTableWidgetItem que ha cambiado.
        - table: La QTableWidget en la que se realizó el cambio.
        - row: El índice de la fila en la que se realizó el cambio.

        Returns:
        - None

        Description:
        Este método se utiliza para manejar el evento de cambio de un elemento en la tabla.
        Actualiza los datos de la fila cambiada en el diccionario 'dataTable'.
        """
        try:
            header_item = table.horizontalHeaderItem(item.column())
            if header_item:
                self.dataTable[header_item.text()] = item.text()
                print(self.dataTable)
        except Exception as ex:
            print(f"Error al manejar cambio de elemento: {ex}")


    def on_cell_clicked(self, row, table):
        """
        Maneja el evento de clic en una celda de la tabla.

        Parameters:
        - row: Índice de la fila en la que se hizo clic.
        - table: QTableWidget en la que se hizo clic en la celda.

        Returns:
        - None

        Description:
        Este método se utiliza para manejar el evento de clic en una celda de la tabla.
        Recibe como parámetros el índice de la fila en la que se hizo clic y la tabla en la que se encuentra la celda.
        Extrae los datos de la fila seleccionada y los almacena en el atributo 'dataTable' del objeto actual.

        Si ocurre algún error durante la ejecución del método, se imprime un mensaje de error detallado.
        """
        try:
            row_data = {}
            for col in range(table.columnCount()):
                header_item = table.horizontalHeaderItem(col)
                item = table.item(row, col)
                if header_item and item:
                    row_data[header_item.text()] = item.text()
            self.dataTable = row_data
            self.setInformationLabel()
        except Exception as ex:
            print(f"Error al manejar clic en celda: {ex}")

    def setInformationLabel(self):
        try:
            if isinstance(self.dataTable, dict):
                if 'Matricula' in self.dataTable:
                    if self.dataTable['Matricula'] is not None:
                        if hasattr(self.userTeacher, 'setText') and hasattr(self.typeDoc, 'setText') and hasattr(
                                self.serieDo, 'setText'):
                            self.userTeacher.setText(self.dataTable['Nombre'])
                            self.typeDoc.setText("Docente")
                            self.serieDo.setText("Matricula: " + self.dataTable['Matricula'])
                        else:
                            print(
                                "Error: Alguno de los atributos de texto de docente no está correctamente configurado.")
                elif 'ID Usuario' in self.dataTable:
                    if hasattr(self.lbUserStudent, 'setText') and hasattr(self.lbTypeUser, 'setText') and hasattr(
                            self.control, 'setText') and hasattr(self.note, 'setText') and hasattr(self.grade,
                                                                                                   'setText'):
                        self.lbUserStudent.setText(self.dataTable.get('ID Usuario', ''))
                        self.lbTypeUser.setText("Alumno")
                        self.control.setText("N. Control: " + str(self.dataTable.get('No. Control', '')))
                        self.note.setText("Calificación: " + str(self.dataTable.get('Puntaje', '')))
                        self.grade.setText("Semestre: " + str(self.dataTable.get('Semestre', '')))
                    else:
                        print("Error: Alguno de los atributos de texto de alumno no está correctamente configurado.")
            else:
                print("Error: dataTable no es un diccionario.")
        except KeyError as ex:
            print(f"Error al manejar la clave: {ex}")
        except Exception as ex:
            print(f"Error inesperado: {ex}")

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
                    self.buttonReply.setStyleSheet(
                        "QPushButton {" 
                        "    background-color: #337ffe;"
                        "    color: white;"
                        "    border-radius: 10px;"
                        "}"
                        "QPushButton:hover {" 
                        "    background-color: #4b8bff;"
                        "}")

                    self.buttonReply2.setStyleSheet(
                        "QPushButton {" 
                        "    background-color: #ecf1f6;"
                        "    color: #84b1fa;"
                        "    border-radius: 10px;"
                        "}"
                        "QPushButton:hover {" 
                        "    background-color: #337ffe;"
                        "    color: white;"
                        "}")


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

                    self.buttonReply2.setStyleSheet(
                        "QPushButton {"
                        "    background-color: #337ffe;"
                        "    color: white;"
                        "    border-radius: 10px;"
                        "}"
                        "QPushButton:hover {"
                        "    background-color: #4b8bff;"
                        "}")

                    self.buttonReply.setStyleSheet(
                        "QPushButton {"
                        "    background-color: #ecf1f6;"
                        "    color: #84b1fa;"
                        "    border-radius: 10px;"
                        "}"
                        "QPushButton:hover {"
                        "    background-color: #337ffe;"
                        "    color: white;"
                        "}")

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
            # Usar el índiceButton para determinar qué botón utilizar
            if indexButton == 'buttonStarUp':
                button = self.buttonStarUp
            elif indexButton == 'buttonStarUp2':
                button = self.buttonStarUp2
            else:
                print("Índice de botón no válido")
                return

            # Verificar el estado actual del botón y cambiar al estado opuesto
            if button.property("star_state") == "on":
                button.setIcon(QIcon("../Resources/star_off.png"))
                button.setProperty("star_state", "off")
            else:
                button.setIcon(QIcon("../Resources/star_on.png"))
                button.setProperty("star_state", "on")

            # Aplicar los cambios en las propiedades
            button.style().unpolish(button)
            button.style().polish(button)
            button.update()

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

    import random

    def showActivityReports(self):
        try:
            self.type = ["Rub", "Ev", "Img", "Vid"]
            # Generar datos aleatorios para self.data
            self.data = [random.randint(10, 100) for _ in
                         range(4)]  # Genera una lista de 4 números aleatorios entre 10 y 100
            self.showChart(self.graphicsOverView_2, self.type, self.data, "")
            self.showPerfomanceTeacher()
        except Exception as ex:
            print(f"Error inesperado: {ex}")

    def showPerfomanceTeacher(self):
        try:
            # Datos de ejemplo (meses y altas/bajas)
            self.months = ["En", "Feb", "Mar", "Abr", "May", "Jun",
                           "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
            # Generar datos aleatorios para self.data
            self.data = [random.randint(10, 50) for _ in
                         range(11)]  # Genera una lista de 11 números aleatorios entre 10 y 50
            self.data.append(random.randint(10, 50))  # Añade un valor aleatorio para "Dic"
            self.showChart(self.graphicsOverView, self.months, self.data, "Desempeño docente")
        except Exception as ex:
            print(f"Error inesperado: {ex}")

    def setupLineEdit(self, lineEdit, label):
        try:
            # Conecta la señal textChanged al método actualizar_caracteres_restantes
            lineEdit.textChanged.connect(lambda: self.actualizar_caracteres_restantes(lineEdit, label))

            # Instala un filtro de eventos en el QLineEdit para capturar eventos de teclado
            lineEdit.installEventFilter(self)
        except Exception as ex:
            print(f"Error setupLineEdit {ex}")

    def actualizar_caracteres_restantes(self, lineEdit, label):
        try:
            # Obtener el texto actual del QTextEdit
            texto = lineEdit.toPlainText()

            # Limitar el texto a 140 caracteres si excede el límite
            if len(texto) > 240:
                texto = texto[:240]
                lineEdit.setPlainText(texto)

            # Calcular la cantidad de caracteres restantes
            caracteres_restantes = 240 - len(texto)

            # Actualizar el QLabel con la cantidad de caracteres restantes
            label.setText(f"Caracteres disponibles: {caracteres_restantes}")


        except Exception as ex:
            print(f"Error actualizar_caracteres_restantes: {ex}")

    def dataHeader(self):
        try:
            # Establecer la localización para el formateo
            locale.setlocale(locale.LC_ALL, '')

            # Generar y establecer el número aleatorio en self.lbDown
            self.lbDown.setText(str(random.randint(20, 1900)))

            # Generar un número aleatorio en el rango especificado para self.lbM
            random_number = random.randint(1000, 20000)

            # Formatear el número sin decimales con el símbolo de dólar y miles separados por comas
            formatted_number = locale.format_string('%d', random_number, grouping=True)

            # Establecer el texto en self.lbM
            self.lbM.setText(f"${formatted_number}")

            # Establecer el texto en self.lbA y self.lbDoc
            self.lbA.setText("120")
            self.lbDoc.setText("30")

        except Exception as ex:
            print(f"Error en dataHeader: {ex}")

    def eventFilter(self, obj, event):
        try:
            # Verificar si el evento es un evento de teclado
            if event.type() == QEvent.KeyPress:
                # Si el QTextEdit alcanza el límite de 140 caracteres
                if len(obj.toPlainText()) >= 240:
                    # Permitir borrar caracteres presionando la tecla Backspace o Delete
                    if event.key() == Qt.Key_Backspace or event.key() == Qt.Key_Delete:
                        return False
                    # Bloquear la adición de caracteres presionando cualquier otra tecla
                    else:
                        return True

            # Dejar que el QTextEdit maneje otros eventos de teclado
            return super().eventFilter(obj, event)
        except Exception as ex:
            print(f"Error eventFilter: {ex}")


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

            self.draw_grafica()

        except Exception as ex:
            print(f"Error __ini__ Class  Canvas_grafica2 {ex}")


    def draw_grafica(self):
        try:
            nombres = ['Reprovado', 'Asesoria', 'Aprovado']
            colores_hex = ['#4bcfeb', '#91a5ff', '#f343ff']
            tamaño = [random.randint(20, 90) for _ in range(3)]
            explotar = [0.05, 0.05, 0.05]

            colores_rgb = [(int(col[1:3], 16) / 255, int(col[3:5], 16) / 255, int(col[5:7], 16) / 255) for col in
                           colores_hex]

            plt.title("Tipos de trabajos", color='#51517f', size=12, family="Segoe UI")

            self.patches, texts, autotexts = self.ax.pie(tamaño, explode=explotar, labels=nombres, colors=colores_rgb,
                                                         autopct='%1.0f%%', pctdistance=0.6, shadow=True, startangle=90,
                                                         radius=0.8, labeldistance=1.1)

            self.ax.axis('equal')
            self.ax.set_facecolor('white')
            self.ax.set_aspect('equal')
            plt.close(self.fig)

            self.mpl_connect('button_press_event', self.on_click)

        except Exception as ex:
            print(f"Error en draw_grafica {ex}")

    def on_click(self, event):
        try:
            import matplotlib.pyplot as plt
            import mplcursors
            from PyQt5.QtWidgets import QFileDialog
            from Controller.Message import MessageBox

            options = QFileDialog.Options()
            fileName, _ = QFileDialog.getSaveFileName(self, "Guardar gráfico como PNG", "Gráfico.png",
                                                      "PNG (*.png)", options=options)
            if fileName:
                self.fig.savefig(fileName)
                MessageBox.information_msgbox("INFORMACIÓN", "El gráfico se ha guardado exitosamente.")

        except Exception as ex:
            print(f"Error: {ex}")


class Canvas_grafica3(FigureCanvas):
    def __init__(self, parent=None):
        try:
            self.fig, self.ax = plt.subplots(1, dpi=100, figsize=(6, 6), sharey=True)
            super().__init__(self.fig)

            self.draw_grafica()

        except Exception as ex:
            print(f"Error __ini__ Class  Canvas_grafica3 {ex}")

    def draw_grafica(self):
        try:
            nombres = ['Práctica', 'Ejercicio', 'Presentación']
            colores_hex = ['#4bcfeb', '#91a5ff', '#f343ff']
            tamaño = [random.randint(20, 90) for _ in range(3)]
            explotar = [0.05, 0.05, 0.05]

            colores_rgb = [(int(col[1:3], 16) / 255, int(col[3:5], 16) / 255, int(col[5:7], 16) / 255) for col in
                           colores_hex]

            plt.title("Tipos de trabajos", color='#51517f', size=12, family="Segoe UI")

            self.patches, texts, autotexts = self.ax.pie(tamaño, explode=explotar, labels=nombres, colors=colores_rgb,
                                                         autopct='%1.0f%%', pctdistance=0.6, shadow=True, startangle=90,
                                                         radius=0.8, labeldistance=1.1)

            self.ax.axis('equal')
            self.ax.set_facecolor('white')
            self.ax.set_aspect('equal')
            plt.close(self.fig)

            self.mpl_connect('button_press_event', self.on_click)

        except Exception as ex:
            print(f"Error en draw_grafica {ex}")

    def on_click(self, event):
        try:
            import matplotlib.pyplot as plt
            import mplcursors
            from PyQt5.QtWidgets import QFileDialog
            from Controller.Message import MessageBox

            options = QFileDialog.Options()
            fileName, _ = QFileDialog.getSaveFileName(self, "Guardar gráfico como PNG", "Gráfico.png",
                                                      "PNG (*.png)", options=options)
            if fileName:
                self.fig.savefig(fileName)
                MessageBox.information_msgbox("INFORMACIÓN", "El gráfico se ha guardado exitosamente.")

        except Exception as ex:
            print(f"Error: {ex}")


