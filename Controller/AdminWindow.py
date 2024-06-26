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
    QTableWidgetItem,
    QMessageBox,
    QPushButton
)
from PyQt5.QtGui import (
    QColor,
    QBrush,
    QFont,
    QIcon,
    QPixmap
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
import os
import re
import shutil
from PyQt5.uic import loadUi
from datetime import timedelta
from Controller.Message import MessageBox #Clase responsable de mostrar mensajes gráficos


class AdminController(QMainWindow, MethodsWindow):
    """Clase para controlar la ventana principal de la aplicación."""

    def __init__(self, information):
        """Inicializa la ventana principal."""
        super().__init__()
        loadUi("../UI/Admin.ui", self)

        # Variables globales
        self.dataTable = None
        self.messages = None
        self.rowNew = False
        self.selected_item = None
        self.select_subject = None
        self.select_t = None
        self.counterSemester = 0
        self.files_dict = {} #Diccionario para guardar los archivos de evidencias por su nombre
        self.getNames = [] #Arreglo para los nombres

        self.information = information

        self.initializeComponents()
        self.initializeVariables()
        self.hideComponents()



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


        self.lbProfile.setText(self.information[0]['name'] + " " + self.information[0]['lastName'])

        # Clases para el dibujado gráfico
        self.grafica1 = Canvas_grafica2()
        self.grafica_dos.addWidget(self.grafica1)

        self.grafica2 = Canvas_grafica3()
        self.grafica_tres.addWidget(self.grafica2)

        self.showActivityReports()
        self.dataHeader()

        #ComboBox
        for i in range(1, 10):
            self.comboBoxSemester.addItem(str(i))

        for x in range(0,7):
            self.comboT.addItem(str(x))

        self.comboBoxGroup.addItem("A")
        self.comboBoxGroup.addItem("B")
        self.__fillComboViews()
        self.__fillComboScores()
        self.__fillComboSemester()

        self.comboBoxSemester.currentIndexChanged.connect(self.onComboBoxIndexChanged)
        self.subjects.currentIndexChanged.connect(self.onComboBoxIndexChanged2)
        self.comboT.currentIndexChanged.connect(self.onComboBoxIndexChanged3)
        from DB.Requests import Inquiries
        InstanceInquiries = Inquiries()
        values = InstanceInquiries.get_teacher_subjects(self.information[0]['name'] + " " + self.information[0]['lastName'])
        self.subjects.addItems(values)

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
        self.buttonCali.clicked.connect(self.showFrameCali)
        self.backR.clicked.connect(self.backReports)
        self.backSemester.clicked.connect(lambda : self.increment_counterSemester("decrement"))
        self.nextSemester.clicked.connect(lambda: self.increment_counterSemester("increment"))


        # Boton de contactos
        self.buttonOpenChat.clicked.connect(self.__showFrameMessage)

        # Frame default
        self.framePanel.raise_()

        # Campos de ScrollAreas(tabla usuarios y docentes)
        self.__updateScrollTeachers()
        self.__updateScrollUsers()
        self.loadFilesRecents()

        # Detectar click en las tablas
        self.tableUsers.cellClicked.connect(lambda row, col:
                                            self.on_cell_clicked(row, self.tableUsers))  # Tabla de alumnos

        self.tableTeacher.cellClicked.connect(lambda row, col:
                                              self.on_cell_clicked(row, self.tableTeacher))  # Tabla de docentes

        self.userEvidences.cellClicked.connect(lambda row, col:
                                              self.on_cell_clicked(row, self.userEvidences)) #Tabla de evidencias

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
        self.buttonDelete.clicked.connect(lambda: self.delete_messages("delete1"))
        self.buttonDelete2.clicked.connect(lambda: self.delete_messages("delete2"))

        # Conectar la señal currentIndexChanged de cada ComboBox a la función correspondiente
        self.semester.currentIndexChanged.connect(self.handle_combo_box_selection)
        self.score.currentIndexChanged.connect(self.handle_combo_box_selection)
        self.views.currentIndexChanged.connect(self.handle_combo_box_selection)


        #Botones de la vista, calificar evidencias
        self.btnEvidences.clicked.connect(self.__buttonEvidences)
        self.d1.clicked.connect(lambda: self.download_evidence("down1"))
        self.d2.clicked.connect(lambda: self.download_evidence("down2"))
        self.d3.clicked.connect(lambda: self.download_evidence("down3"))

        self.btnSearch_student.clicked.connect(lambda: self.search_info_by_user("student"))
        self.btnSearch_teacher.clicked.connect(lambda: self.search_info_by_user("teacher"))
        self.backTable.clicked.connect(self.__updateScrollUsers)
        self.backTable2.clicked.connect(self.__updateScrollTeachers)


    def hideComponents(self):
        if self.information[0]['rankId'] == 3:

            self.buttonStudents.setEnabled(False)
            self.buttonCali.setEnabled(True)
            self.comboBoxSemester.setEnabled(True)
            self.comboBoxGroup.setEnabled(True)
            self.comboT.setEnabled(True)
            self.subjects.setEnabled(True)
            self.buttonMessage.setEnabled(True)

        if self.information[0]['rankId'] == 1:

            self.buttonStudents.setEnabled(True)
            self.buttonCali.setEnabled(False)
            self.comboBoxSemester.setEnabled(False)
            self.comboBoxGroup.setEnabled(False)
            self.comboT.setEnabled(False)
            self.subjects.setEnabled(False)
            self.buttonMessage.setEnabled(False)

    def search_info_by_user(self, typeButton):
        try:
            from DB.Requests import Inquiries
            from Controller.Message import MessageBox
            InstanceInquiries = Inquiries()

            data_to_search = ""

            if typeButton == "student":
                column_headers = ["ID Usuario", "Contraseña", "Nombre", "Apellido", "No. Control", "ID Rango",
                                  "Semestre", "Regular", "Puntaje"]
                data_to_search = self.search_student.text()


                if data_to_search:
                    valueAll = InstanceInquiries.search_info_by_student(data_to_search)
                    self._fillTable(valueAll, self.tableUsers, column_headers, 9)
                    self.search_student.setText("")
                else:
                    MessageBox.warning_msgbox("ADVERTENCIA", "Por favor ingresa datos para buscar.")

            elif typeButton == "teacher":

                teacher_column_headers = ["ID Profesor", "Nombre", "Matrícula"]
                data_to_search = self.search_teacher.text()

                if data_to_search:
                    valueAll = InstanceInquiries.get_teachers_by_search_term(data_to_search)
                    self._fillTable(valueAll, self.tableTeacher, teacher_column_headers, 3)
                    self.search_teacher.setText("")
                else:
                    MessageBox.warning_msgbox("ADVERTENCIA", "Por favor ingresa datos para buscar.")

        except Exception as ex:
            print(f"Se produjo un error en la base de datos {ex}")



    def download_evidence(self, typeButton):
        try:
            from Controller.Message import MessageBox
            if self.dataTable:
                if self.files_dict:
                    if typeButton in ["down1", "down2", "down3"]:
                        file_index = int(
                            typeButton[-1]) - 1  # Convertir el último dígito del tipo de botón en un índice (0, 1, 2)
                        file_key = list(self.files_dict.keys())[file_index]  # Obtener la clave correspondiente al índice
                        file_path = self.files_dict.get(file_key)
                        if file_path:
                            # Abrir un cuadro de diálogo para que el usuario seleccione la carpeta de destino
                            save_folder = QFileDialog.getExistingDirectory(self, "Seleccionar carpeta de destino", "/")
                            if save_folder:
                                # Copiar el archivo a la carpeta seleccionada
                                shutil.copy(file_path, save_folder)
                                MessageBox.information_msgbox("INFORMACIÓN", "El archivo ha sido guardado con éxito.")
                            else:
                                MessageBox.information_msgbox("INFORMACIÓN", "No se seleccionó ninguna carpeta de destino.")
                        else:
                            MessageBox.information_msgbox("INFORMACIÓN", "No hay archivo asociado")
                    else:
                        MessageBox.information_msgbox("INFORMACIÓN", "Tipo de botón no válido.")
                else:
                    MessageBox.input_error_msgbox("ERROR", "No hay archivos para guardar")
            else:
                MessageBox.information_msgbox("INFORMACIÓN", "Seleccione algún usuario para cargar sus evidencias")
        except Exception as ex:
            print(f"Error {ex}")



    def __buttonEvidences(self):
        try:
            from DB.Requests import Inquiries
            from Controller.Message import MessageBox
            InstanceInquiries = Inquiries()

            scores = [self.c1.value(), self.c2.value(), self.c3.value()]  # Lista de puntajes

            # Preguntamos si está de acuerdo con aplicar los cambios
            if MessageBox.question_msgbox("PREGUNTA", "¿Está de acuerdo con aplicar los cambios?"):
                if self.dataTable and self.getNames:
                    for i, score in enumerate(scores):
                        if score is not None and i < len(self.getNames):
                            sql_query = f"""
                                CALL actualizar_score_evidencia(
                                    '{self.getNames[i]}',
                                    '{self.dataTable['Usuario']}',
                                    {score},
                                    @p_success
                                );
                                SELECT @p_success;
                            """
                            value = InstanceInquiries.execute_sql_script(sql_query)
                            if value:
                                MessageBox.correct_msgbox("ÉXITO", "Los cambios se han aplicado con éxito")
                            else:
                                MessageBox.input_error_msgbox("ERROR", "Los cambios no se han aplicado")

                else:
                    MessageBox.warning_msgbox("ADVERTENCIA", "No hay evidencias cargadas, seleccione el usuario")

        except Exception as ex:
            print(f"Error: {ex}")

    def remove_html_tags(self, text):
        clean = re.compile('<.*?>')
        return re.sub(clean, '', text)


    def delete_messages(self, typeButton):
        try:
            from DB.Requests import Inquiries
            from Controller.Message import MessageBox
            InstanceInquiries = Inquiries()

            if typeButton in ['delete1', 'delete2']:
                userSms = self.userSms.text() if typeButton == 'delete1' else self.userSms2.text()
                labelSms = self.remove_html_tags(self.label_sms.text()) if typeButton == 'delete1' else (
                    self.remove_html_tags(self.label_sms2.text()))

                if MessageBox.question_msgbox("PREGUNTA", "¿Está seguro(a) de hacer esta acción?"):
                    sql = f"CALL DeleteMessage('{userSms}', '{labelSms}', @success)"
                    InstanceInquiries.execute_sql_script(sql)

                    result = InstanceInquiries.execute_sql_script("SELECT @success")
                    success = result[0]

                    # Verificar si el mensaje fue eliminado correctamente
                    if success:
                        MessageBox.correct_msgbox("ÉXITO", "El mensaje ha sido eliminado correctamente.")
                    else:
                        MessageBox.correct_msgbox("ERROR", "No se encontro o no se puede eliminar el mensaje")

                    self.load_information("Null", "Null")

        except ImportError:
            print("No se pudo importar el módulo.")
        except Exception as ex:
            print(f"Error: {ex}")



    def increment_counterSemester(self, typeButton):
        if typeButton == "increment":
            if self.counterSemester == 6:
                MessageBox.information_msgbox("INFORMACIÓN", "Solo existen 6 unidades")
            else:
                self.counterSemester += 1
        elif typeButton == "decrement":
            if self.counterSemester == 0:
                MessageBox.information_msgbox("INFORMACIÓN", "No pueden haber menos de 0 unidades")
            else:
                self.counterSemester -= 1 #Quitamos 1 para que el contador se mantenga en 6 y no pase de 6

        if self.dataTable and 'Usuario' in self.dataTable:
            self.load_evidences_by_user() #Actualizamos constantemente las evidencias
        else:
            MessageBox.information_msgbox("INFORMACIÓN", "Seleccione algún usuario de la tabla para ver las evidencias")
            self.counterSemester = 0 #Regresamos a 0 el contador

        self.setIconSemester()



    def setIconSemester(self):
        # Obtener la ruta del archivo de ícono basado en el valor de counterSemester
        icon_path = f"../Resources/{self.counterSemester}-color.png"

        # Validar el valor de counterSemester y ajustar la ruta del ícono si es necesario
        if self.counterSemester < 0:
            self.counterSemester = 0
        elif self.counterSemester > 6:
            self.counterSemester = 6

        # Crear un objeto QIcon con la ruta del archivo de ícono
        icon = QIcon(icon_path)


        # Establecer el ícono en el botón viewSemester
        self.viewSemester.setIcon(icon)


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
        self.frameCali.setVisible(False)
        self.frame_24.setVisible(False)
        self.backR.setVisible(False)
        self.__showFrame(self.frameReports_2)

    def showFrameCali(self):
        self.frameCali.setVisible(True)
        self.frame_24.setVisible(True)
        self.backR.setVisible(True)
        self.loadUserEvidence()

    def backReports(self):
        self.frameCali.setVisible(False)
        self.frame_24.setVisible(False)
        self.backR.setVisible(False)


    def load_information(self, type, messages):
        try:
            if type == "Answers":

                self.loadMessages(messages)
            else:

                from DB.Requests import Inquiries
                InstanceInquiries = Inquiries()

                messages = InstanceInquiries.getMessages()
                self.messages = messages

                # Carga los mensajes
                self.loadMessages(messages)
        except Exception as ex:
            print(f"Error {ex}")



    # En el método donde se crea y se agrega el QScrollArea
    def loadFilesRecents(self):
        try:
            # El ScrollArea se llama self.scrollFiles
            from DB.Requests import Inquiries
            InstanceInquiries = Inquiries()

            # Obtener la lista de archivos recientes para el profesor actual
            fileRecents = InstanceInquiries.get_files_by_teacher(self.information[0]['name'])

            # Iterar sobre la lista de archivos recientes y actualizar los QPushButton y QLabel correspondientes
            for i, file_info in enumerate(fileRecents):
                # Obtener la extensión del archivo
                file_extension = file_info[2].lower()

                # Cargar el icono correspondiente según la extensión del archivo
                icon_path = f"../Resources/{file_extension}.png"
                pixmap = QPixmap(icon_path).scaled(32, 32)  # Escalar el icono a 48x48
                icon = QIcon(pixmap)
                button_icon = getattr(self, f"bf{i + 1}")  # Obtener el QPushButton correspondiente
                button_icon.setIcon(icon)
                button_icon.setIconSize(pixmap.size())

                # Actualizar el QLabel correspondiente con el nombre del archivo
                label_name = getattr(self, f"lf{i + 1}")  # Obtener el QLabel correspondiente
                label_name.setText(file_info[1])
                label_name.setAlignment(Qt.AlignCenter)  # Alinear el nombre al centro
                label_name.setStyleSheet("background-color: transparent;")  # Establecer fondo transparente

                # Calcular el tamaño del archivo en KB, MB, GB o TB
                file_size = file_info[3]
                kb_size = file_size / 1024
                mb_size = kb_size / 1024
                gb_size = mb_size / 1024
                tb_size = gb_size / 1024
                if tb_size >= 1:
                    size_str = f"{tb_size:.2f} TB"
                elif gb_size >= 1:
                    size_str = f"{gb_size:.2f} GB"
                elif mb_size >= 1:
                    size_str = f"{mb_size:.2f} MB"
                elif kb_size >= 1:
                    size_str = f"{kb_size:.2f} KB"
                else:
                    size_str = f"{file_size} bytes"

                # Actualizar el QLabel correspondiente con el tamaño del archivo
                label_size = getattr(self, f"lz{i + 1}")  # Obtener el QLabel correspondiente
                label_size.setText(f"{size_str}")
                #label_size.setAlignment(Qt.AlignCenter)  # Alinear el tamaño al centro
                label_size.setStyleSheet("background-color: transparent;")  # Establecer fondo transparente

                # Limitar a 4 archivos para evitar exceso de elementos en el ScrollArea
                if i >= 3:
                    break

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



    def loadUserEvidence(self):
        try:
            self.userEvidences.setColumnCount(3)  # Establecer el número de columnas
            self.userEvidences.setHorizontalHeaderLabels(["Semestre", "Usuario", "Puntaje"])
            from DB.Requests import Inquiries
            InstanceInquiries = Inquiries()
            unscored_evidences = InstanceInquiries.get_unscored_evidences()

            # Verificar si se obtuvieron datos
            if unscored_evidences:
                # Verificar si self.selected_item no es nulo
                if self.selected_item is not None:
                    # Filtrar las evidencias por semestre
                    unscored_evidences = [evidence for evidence in unscored_evidences if
                                          evidence[0] == int(self.selected_item)]

                # Eliminar duplicados de la lista de evidencias (solo una entrada por usuario)
                unique_evidences = {}
                for evidence in unscored_evidences:
                    idUser = evidence[1]
                    if idUser not in unique_evidences:
                        unique_evidences[idUser] = evidence

                # Establecer el número de filas en función de la cantidad de datos obtenidos
                self.userEvidences.setRowCount(len(unique_evidences))

                # Iterar sobre los datos únicos y agregarlos a la tabla
                for row, evidence in enumerate(unique_evidences.values()):
                    semester = evidence[0]
                    idUser = evidence[1]
                    score = evidence[2]

                    # Crear y establecer los elementos QTableWidgetItem
                    self.userEvidences.setItem(row, 0, QTableWidgetItem(str(semester)))
                    self.userEvidences.setItem(row, 1, QTableWidgetItem(idUser))
                    self.userEvidences.setItem(row, 2, QTableWidgetItem(str(score)))

                # Ajustar el tamaño de las columnas al contenido
                self.userEvidences.resizeColumnsToContents()

        except Exception as ex:
            print(f"Error: {ex}")

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



    def __fillComboSemester(self):
        # Datos para llenar el ComboBox
        semesters = ["1er", "2do", "3er", "4rto", "5to", "6xto", "8vo", "9no"]

        # Limpiar el ComboBox antes de llenarlo
        self.semester.clear()

        # Agregar los datos al ComboBox
        self.semester.addItems(semesters)



    def __fillComboScores(self):
        # Datos para llenar el ComboBox
        scores = ["Reprobados", "Aprobados", "Excelencia", "Regulares"]

        # Limpiar el ComboBox antes de llenarlo
        self.score.clear()

        # Agregar los datos al ComboBox
        self.score.addItems(scores)



    def __fillComboViews(self):
        # Datos para llenar el ComboBox
        views = ["Estudiantes regulares", "Estudiantes reprobados", "Estudiantes reinscriptos"]

        # Limpiar el ComboBox antes de llenarlo
        self.views.clear()

        # Agregar los datos al ComboBox
        self.views.addItems(views)

    def handle_combo_box_selection(self):
        try:
            from DB.Requests import Inquiries
            InstanceInquiries = Inquiries()

            # Obtener el ComboBox que emitió la señal
            sender = self.sender()
            selected_item = sender.currentText()

            # Verificar si el ComboBox que emitió la señal
            if sender == self.semester:
                self.moduleSemester(InstanceInquiries, selected_item)
            elif sender == self.score:
                self.moduleScore(InstanceInquiries, selected_item)
            elif sender == self.views:
                self.moduleViews(InstanceInquiries, selected_item)

        except Exception as ex:
            print(f"Error at handle_combo_box_selection {ex}")


    def moduleSemester(self, InstanceInquiries, selected_item):
        try:
            self.tableUsers.clearContents()  # Elimina el contenido de las celdas
            self.tableUsers.setRowCount(0)  # Establece el número de filas en 0

            # Mapeo de nombres de semestres a números enteros
            semester_mapping = {
                "1er": 1,
                "2do": 2,
                "3er": 3,
                "4rto": 4,
                "5to": 5,
                "6xto": 6,
                "8vo": 8,
                "9no": 9
            }
            column_headers = ["ID Usuario", "Contraseña", "Nombre", "Apellido", "No. Control", "ID Rango",
                              "Semestre", "Regular", "Puntaje"]

            # Obtener el número de semestre correspondiente al nombre del semestre seleccionado
            semester_number = semester_mapping.get(selected_item)

            # Si no se encontró un número de semestre correspondiente, imprimir un mensaje de error
            if semester_number is None:
                MessageBox.input_error_msgbox("ERROR", "El tipo de dato no es el correcto")
                return

            # Obtener los usuarios del semestre seleccionado y ordenarlos por semestre
            valueAll = InstanceInquiries.get_users_by_semester_order(semester_number)

            self._fillTable(valueAll, self.tableUsers, column_headers, 9)
        except Exception as ex:
            print(f"Error {ex}")

    def moduleScore(self, InstanceInquiries, selected_item):
        try:
            self.tableUsers.clearContents()  # Elimina el contenido de las celdas
            self.tableUsers.setRowCount(0)  # Establece el número de filas en 0

            if selected_item == "Reprovados":
                column_headers = ["ID Usuario", "Nombre", "Apellido", "N. Control", "ID Rango", "Semestre", "Estado"]
                valueAll = InstanceInquiries.execute_sql_script("SELECT * FROM estudiantes_reprobados")
                self._fillTable(valueAll, self.tableUsers, column_headers, 6)
            elif selected_item == "Aprobados":
                column_headers = ["ID Usuario", "Nombre", "Apellido", "N. Control", "ID Rango", "Semestre", "Estado"]
                valueAll = InstanceInquiries.execute_sql_script("SELECT * FROM estudiantes_aprobados")
                self._fillTable(valueAll, self.tableUsers, column_headers, 8)
            elif selected_item == "Excelencia":
                column_headers = ["ID Usuario", "Nombre", "Apellido", "N. Control", "ID Rango", "Semestre", "Puntaje"]
                valueAll = InstanceInquiries.execute_sql_script("SELECT * FROM estudiantes_con_alto_score")
                self._fillTable(valueAll, self.tableUsers, column_headers, 8)
            elif selected_item == "Regulares":
                column_headers = ["ID Usuario", "Nombre", "Apellido", "N. Control", "ID Rango", "Semestre", "Regular"]
                valueAll = InstanceInquiries.execute_sql_script("SELECT * FROM estudiantesregulares")
                self._fillTable(valueAll, self.tableUsers, column_headers, 8)
        except Exception as ex:
            print(f"Error: {ex}")


    def moduleViews(self, InstanceInquiries, selected_item):
        try:
            self.tableUsers.clearContents()  # Elimina el contenido de las celdas
            self.tableUsers.setRowCount(0)  # Establece el número de filas en 0

            if selected_item == "Estudiantes regulares":
                column_headers = ["ID Usuario", "Contraseña", "Nombre", "Apellido", "N. Control", "ID Rango",
                                  "Semestre", "Regular"]
                valueAll = InstanceInquiries.execute_sql_script("SELECT * FROM estudiantesregulares")
                self._fillTable(valueAll, self.tableUsers, column_headers, 8)
            elif selected_item == "Estudiantes reprobados":
                column_headers = ["ID Usuario", "Contraseña", "Nombre", "Apellido", "N. Control", "ID Rango",
                                  "Semestre", "Regular"]
                valueAll = InstanceInquiries.execute_sql_script("SELECT * FROM estudiantesregulares")
                self._fillTable(valueAll, self.tableUsers, column_headers, 8)
            elif selected_item == "Estudiantes reinscriptos":
                column_headers = ["ID", "Usuario", "Nombre", "Apellido", "Semestre", "Fecha",
                                  "Estado"]
                valueAll = InstanceInquiries.execute_sql_script("SELECT * FROM view_reinscripcion")
                self._fillTable(valueAll, self.tableUsers, column_headers, 7)
        except Exception as ex:
            print(f"Error: {ex}")


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
            self.rowNew = True
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
            table.keyPressEvent = lambda event: self.onKeyPress(event, table)
        except Exception as ex:
            print(f"Error al crear una nueva fila: {ex}")


    def onKeyPress(self, event, tableAction):
        try:
            if event.key() == Qt.Key_Enter or event.key() == Qt.Key_Return:
                value = MessageBox.question_msgbox("PREGUNTA", "¿Esta seguro(a) de realizar esta operación?")
                if tableAction == self.tableUsers and value:
                    self.__actionUser__()
                elif tableAction == self.tableTeacher and value:
                    self.__actionTeacher__()
            else:
                super().keyPressEvent(event)

        except Exception as ex:
            print(f"Error al crear una nueva fila: {ex}")

    def __actionUser__(self):
        try:
            if self.rowNew:
                # Verificar campos solo si se está creando una nueva fila
                valid = True
                errors = []

                # Verificar cada campo del diccionario
                for key, value in self.dataTable.items():
                    if key == 'No. Control':
                        if not value.isdigit() or len(value) != 8:
                            valid = False
                            errors.append("El campo 'No. Control' debe tener 8 dígitos numéricos.")
                    elif key == 'ID Rango':
                        if value not in ['1', '2', '3']:
                            valid = False
                            errors.append("El campo 'ID Rango' debe ser 1, 2 o 3.")
                    elif key == 'Semestre':
                        if not value.isdigit() or not 1 <= int(value) <= 9:
                            valid = False
                            errors.append("El campo 'Semestre' debe ser un número entre 1 y 9.")
                    elif key == 'Regular':
                        if value not in ['Si', 'No']:
                            valid = False
                            errors.append("El campo 'Regular' debe ser 'Si' o 'No'.")
                    elif key == 'Puntaje':
                        if not value.isdigit() or not 0 <= int(value) <= 100:
                            valid = False
                            errors.append("El campo 'Puntaje' debe ser un número entre 0 y 100.")

                if valid:
                    from DB.Requests import Inquiries
                    InstanceInquiries = Inquiries()
                    if InstanceInquiries.create_user(self.dataTable):
                        MessageBox.correct_msgbox("ÉXITO", "El usuario fue creado exitosamente.")
                        self.rowNew = False
                        self.__updateScrollUsers()
                    else:
                        MessageBox.input_error_msgbox("ERROR", "No se pudo crear el usuario.")
                        self.rowNew = False
                else:
                    for error in errors:
                        MessageBox.information_msgbox("INFORMACIÓN", f"{error}")
            else:
                from DB.Requests import Inquiries
                InstanceInquiries = Inquiries()

                if InstanceInquiries.update_user(self.dataTable):
                    MessageBox.correct_msgbox("ÉXITO", "La información del usuario fue actualizada exitosamente.")
                    self.rowNew = False
                    self.__updateScrollUsers()
                else:
                    MessageBox.input_error_msgbox("ERROR",
                                                  "La información del usuario no fue actualizada exitosamente.")
        except Exception as ex:
            print(f"Error al crear una nueva fila: {ex}")


    def __actionTeacher__(self):
        try:
            if self.rowNew:
                # Verificar campos solo si se está creando una nueva fila
                valid = True
                errors = []

                # Verificar el nombre (debe contener solo letras)
                if not self.dataTable['Nombre'].isalpha():
                    valid = False
                    errors.append("El campo 'Nombre' debe contener solo letras.")

                # Intentar convertir la matrícula a un número
                try:
                    matricula = int(self.dataTable['Matricula'])
                except ValueError:
                    matricula = None

                # Verificar la matrícula (debe ser numérica y tener una longitud de 5)
                if matricula is None or len(str(matricula)) != 5:
                    valid = False
                    errors.append("El campo 'Matrícula' debe ser numérico y tener una longitud de 5.")

                if valid:
                    from DB.Requests import Inquiries
                    InstanceInquiries = Inquiries()
                    if InstanceInquiries.create_teacher(self.dataTable):
                        MessageBox.correct_msgbox("ÉXITO", "El docente fue creado exitosamente.")
                        self.rowNew = False
                        self.__updateScrollTeachers()
                    else:
                        MessageBox.input_error_msgbox("ERROR", "No se pudo crear el docente.")
                else:
                    for error in errors:
                        MessageBox.information_msgbox("INFORMACIÓN", f"{error}")
            else:
                from DB.Requests import Inquiries
                InstanceInquiries = Inquiries()
                if InstanceInquiries.update_teacher(self.dataTable):
                    MessageBox.correct_msgbox("ÉXITO", "La información del docente fue actualizada exitosamente.")
                    self.rowNew = False
                    self.__updateScrollTeachers()
                else:
                    MessageBox.input_error_msgbox("ERROR", "La información del docente no fue actualizada exitosamente.")
        except Exception as ex:
            print(f"Error al crear un nuevo docente: {ex}")



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
            self.load_evidences_by_user()
            table.keyPressEvent = lambda event: self.onKeyPress(event, table)
        except Exception as ex:
            print(f"Error al manejar clic en celda: {ex}")


#Método para actualizar /O cargar las evidencias por usuario
    def load_evidences_by_user(self):
        try:
            if 'Usuario' in self.dataTable:
                from DB.Requests import Inquiries
                InstanceInquiries = Inquiries()

                idUser = self.dataTable['Usuario']  # Obtenemos el usuario
                issue = int(self.counterSemester)  # Obtenemos el tema
                semester = int(self.dataTable['Semestre'])  # Obtenemos el semestre

                # Limpiar los QSpinBox
                for i in range(1, 4):
                    c_widget = getattr(self, f"c{i}")
                    c_widget.setValue(0)

                # valeAll almacena todos los resultados que retorne la consulta en la BD
                valueAll = InstanceInquiries.execute_sql_script(f"""
                    SELECT name, file, score, issue
                    FROM evidences_student
                    WHERE semester = {semester} AND idUser = '{idUser}' AND issue = {issue}
                """)

                if valueAll:
                    self.files_dict = {}  # Diccionario para almacenar los archivos por nombre

                    # Iterar sobre los resultados obtenidos de la consulta SQL
                    for i, (name, file, score, issue) in enumerate(valueAll):
                        # Construir el nuevo nombre con el valor de counterSemester y el número de le
                        new_name = f"{self.counterSemester}.{i + 1} {name}" if name else "Evidencia no entregada"
                        self.getNames.append(name)

                        # Actualizar el QLabel correspondiente con el nuevo nombre
                        le_widget = getattr(self, f"le{i + 1}")
                        le_widget.setText(new_name)

                        # Almacenar el archivo en el diccionario usando el nuevo nombre como clave
                        self.files_dict[new_name] = file if name else None

                        # Actualizar el QSpinBox correspondiente con el score
                        c_widget = getattr(self, f"c{i + 1}")
                        c_widget.setValue(score)

                    # Limpiar los QSpinBox restantes
                    for i in range(len(valueAll) + 1, 4):
                        c_widget = getattr(self, f"c{i}")
                        c_widget.clear()

                else:
                    # Si valueAll está vacío, configurar todos los QLabel como "Evidencia no entregada"
                    for i in range(1, 4):
                        getattr(self, f"le{i}").setText("Evidencia no entregada")

        except Exception as ex:
            print(f"Error al manejar load_evidences_by_user: {ex}")


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

    def onComboBoxIndexChanged(self, index):
        try:
            # Obtener el texto del elemento seleccionado
            self.selected_item = self.comboBoxSemester.currentText()
            self.loadUserEvidence()
            if self.dataTable is not None:
                if 'Usuario' in self.dataTable:
                    self.load_evidences_by_user()
        except Exception as ex:
            print(f"Error onComboBoxIndexChanged: {ex}")

    def onComboBoxIndexChanged2(self, index):
        self.select_subject = self.subjects.currentText()

    def onComboBoxIndexChanged3(self, index):
        self.select_t = self.comboT.currentText()



#Evidences buttons
    def selectFile(self, file_type):
        try:
            from DB.Requests import Inquiries
            InstanceInquiries = Inquiries()

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

            # Verificar si se seleccionó un archivo
            if file_path:
                # Obtener otros parámetros necesarios para insertar en la tabla de evidencias
                name = os.path.basename(file_path)  # Obtener el nombre del archivo
                file = open(file_path, 'rb').read()  # Leer el archivo en modo binario

                type = file_type
                if self.selected_item is not None:
                    forUser = InstanceInquiries.get_users_by_semester(self.selected_item)
                    semester = self.selected_item
                else:
                    MessageBox.warning_msgbox("ADVERTENCIA", "Seleccione el semestre al cual subirá el archivo")

                subject = self.select_subject
                teacher = self.information[0]['name']
                if self.select_t is not None:

                    # Llamar al método insert_to_evidences con los parámetros recopilados
                    success = InstanceInquiries.insert_to_evidences(name, file, type,
                                                                    forUser, semester, subject, teacher, int(self.select_t))
                    if success:
                        MessageBox.correct_msgbox("ÉXITO", "El archivo fue subido correctamente")
                    else:
                        MessageBox.input_error_msgbox("ERROR", "No se pudo subir el archivo")
            else:
                MessageBox.warning_msgbox("ADVERTENCIA", "No ha seleccionado el archivo")

            # Devolver la ruta del archivo seleccionado (puede ser útil para otras operaciones)
            return file_path

        except Exception as ex:
            print(f"Error in selectFile: {ex}")


#Ends




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

            plt.title("Desempeño alumnos", color='#51517f', size=12, family="Segoe UI")

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


