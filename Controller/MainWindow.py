import psutil
from PyQt5.QtWidgets import QFileDialog, QMainWindow
from PyQt5.QtCore import QTimer, QDateTime
from PyQt5.QtGui import QMovie, QIcon
from PyQt5.uic import loadUi
from PyQt5.uic.properties import QtWidgets

from Controller.Implements import RoundedWindow, MotionFrame, MethodsWindow
from Controller.Message import MessageBox
from DB.Requests import ConnectionDB

class WindowADM(QMainWindow, MethodsWindow):
    def __init__(self, information):
        super().__init__()
        loadUi('../UI/Student.ui', self)

        self.information = information #Obtenemos la información del estudiante

        self.initializeComponents()
        self.initializeVariables()
        self.initializeStyles()

    def initializeComponents(self):
        InstanceWindow = RoundedWindow(self)
        InstanceWindow.startRound(1221, 879)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        # Conectar el botón de salida a la función _closeWindow
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana

        # Conectar el botón de minimizar a la función _minimizeWindow
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana

        # Conectar el botón de cargar archivo extra a la función _upload_extra
        self.uploadExtra.clicked.connect(self._upload_extra)

        # Conectar el botón de cargar archivo académico a la función _upload_acad
        self.uploadAcad.clicked.connect(self._upload_acad)

        # Conectar el botón de ticket a la función _showTicketUI
        self.buttonTicket.clicked.connect(self._showTicketUI)

        # Conectar el botón de perfil a la función _showProfileUI
        self.buttonProfile.clicked.connect(self._showProfileUI)
        #conecta al boton de las materias
        self.materia1.clicked.connect(self._showMateriasUI)
        self.materia2.clicked.connect(self._showMateriasUI)
        self.materia3.clicked.connect(self._showMateriasUI)
        self.materia4.clicked.connect(self._showMateriasUI)
        self.materia5.clicked.connect(self._showMateriasUI)


        #concecta al boton de mensajes alumnos
        self.mensajesAl.clicked.connect(self._showMensajesAl)




        # Conectar el botón de configuraciones a la función _showSettingsUI
        self.buttonSettings.clicked.connect(self._showSettingsUI)

        #Conectar el botón de cerrar sesión a la funcion _closeSesion
        self.buttonLoggOut.clicked.connect(self._closeSesion)

        self.buttonNext_2.clicked.connect(self._nextOption)

        self.buttonBack_2.clicked.connect(self._oldOption)


        #QLabels

        self._setInformation()




    def initializeVariables(self):

        # Cargar el GIF usando QMovie
        movie = QMovie('../Resources/reloj.gif')
        self.clock.setMovie(movie)
        # Escalar el GIF al tamaño deseado
        movie.setScaledSize(self.clock.size())

        # Iniciar la reproducción del GIF
        movie.start()

        # Configurar un QTimer para ejecutar la función update_time() cada 1 segundo
        self.timerT = QTimer(self)
        self.timerT.timeout.connect(self.update_time)
        self.timerT.start(1000)  # Ejecutar cada 1000 ms (1 segundo)

        # Creamos el QTimer
        self.timerB = QTimer()
        # Conectamos la señal timeout del QTimer a la función monitor_battery_percentage
        self.timerB.timeout.connect(self.monitor_battery)
        # Configuramos el QTimer para que se ejecute cada 5 segundos (5000 milisegundos)

        self.timerB.start(1500) #1.5s


        self.message = MessageBox()

    def initializeStyles(self):
       pass

        # Funciones raíz de la ventana
    def _closeWindow(self):
        self.close()

    def _minimizeWindow(self):
        self.showMinimized()

    def update_time(self):
        current_time = QDateTime.currentDateTime()
        time_string = current_time.toString("hh:mm AP")
        self.lbTime.setText(time_string)


    def _setInformation(self):
        try:
            self.setUserName.setText(self.information[0]['name'])  # Ponemos el nombre en el label

            # Mapeo de números de semestre a su equivalente en texto
            semester_mapping = {
                1: "1er",
                2: "2do",
                3: "3er",
                4: "4to",
                5: "5to",
                6: "6to",
                7: "7mo",
                8: "8vo"
            }

            # Obtener el número de semestre del usuario
            semester = self.information[0]['semester']

            # Verificar si el número de semestre está en el mapeo
            if semester in semester_mapping:
                # Establecer el texto del QLabel con el equivalente en texto del semestre
                self.lbSemester_2.setText(semester_mapping[semester])
            else:
                # Si el número de semestre no está en el mapeo, establecer un texto por defecto
                self.lbSemester_2.setText("Semestre Desconocido")

            self._subjects()  # Llamamos la función para establecer las asignaturas

        except KeyError as ex:
            print(f"Error: La clave no existe -> {ex}")
        except IndexError as ex:
            print(f"Error: El índice está fuera de rango -> {ex}")
        except Exception as ex:
            print(f"Error _setInformation -> {ex}")

    def _subjects(self):
        try:
            from DB.Requests import Inquiries
            InstanceInquiries = Inquiries()

            subjects = InstanceInquiries.get_subject_by_user(self.information[0]['idUser'])

            # Verificar si hay asignaturas asociadas al usuario
            if subjects:
                first_user = next(iter(subjects))  # Obtener el primer usuario en el diccionario
                subjects_of_first_user = subjects[first_user]  # Obtener las asignaturas del primer usuario
                if subjects_of_first_user:
                    # Obtener los primeros cinco sujetos del primer usuario
                    first_five_subjects_of_first_user = subjects_of_first_user[:5]
                    # Establecer los textos de los QLabel y habilitar wordWrap
                    for index, subject in enumerate(first_five_subjects_of_first_user, start=1):
                        label = getattr(self, f"lb{index}")
                        label.setText(subject)
                        label.setWordWrap(True)
                        self._change_icon_subject(subject)
                else:
                    self.message.information_msgbox("INFORMACIÓN", "No se encontraron asignaturas para el usuario")
            else:
                self.message.information_msgbox("INFORMACIÓN", "No se encontraron asignaturas para ningún usuario")

        except Exception as ex:
            print(f"Error _subjects -> {ex}")

    def _change_icon_subject(self, subject):
        try:
            pass
        except Exception as ex:
            print(f"Error {ex}")

    def _nextOption(self):
        self.lbIconText.setText("         Pagos")
        self.lbIconSide.setIcon(QIcon('../Resources/factura-punto-de-venta.png'))

    def _oldOption(self):
        self.lbIconText.setText("         Créditos")
        self.lbIconSide.setIcon(QIcon('../Resources/revision-de-comentarios.png'))

    def monitor_battery(self):
        try:
            battery = psutil.sensors_battery()
            if battery is not None:
                percent = battery.percent
                charging = battery.power_plugged
                self.change_icon_battery(percent, charging)
            else:
                 print("No se puede obtener información sobre la batería.")
        except Exception as ex:
            print(f"Error {ex}")

    def change_icon_battery(self, percent, charging):
        try:
            icon_path = '../Resources/'
            icon_name = ''

            if charging:
                icon_name = 'perno-de-bateria.png'
            else:
                if percent == 100:
                    icon_name = 'bateria-llena.png'
                elif percent >= 70:
                    icon_name = 'bateria-tres-cuartos.png'
                elif percent >= 50:
                    icon_name = 'la-mitad-de-la-bateria.png'
                elif percent >= 30:
                    icon_name = 'cuarto-de-bateria.png'
                elif percent <= 20:
                    icon_name = 'exclamacion-de-bateria.png'

            if icon_name:
                icon = QIcon(icon_path + icon_name)
                self.battery.setIcon(icon)
                self.lbCharge.setText(str(percent) + '%')
            else:
                print("La batería esta muy baja en energía")

        except Exception as ex:
            print(f"Error {ex}")


    def _upload_file(self):
        try:
            # Abrir un cuadro de diálogo para seleccionar un archivo
            file_dialog = QFileDialog(self)
            file_dialog.setWindowTitle('Seleccionar archivo a subir')
            file_dialog.setFileMode(QFileDialog.ExistingFiles)
            file_dialog.setNameFilter("Archivos de imagen (*.png *.jpg);;Archivos PDF (*.pdf)")

            # Ejecutar el cuadro de diálogo
            if file_dialog.exec_():
                selected_files = file_dialog.selectedFiles()
                return selected_files
        except Exception as e:
            print(f"Error al abrir el cuadro de diálogo: {e}")

    def _upload_extra(self):
        try:
            selected_files = self._upload_file()
            if selected_files:
                print("Archivos seleccionados para Extra:", selected_files)
                self.files_extra = selected_files  # Guardamos el archivo, para subirlo

        except Exception as e:
            print(f"Error al subir archivos Extra: {e}")


    def _upload_acad(self):
        try:
            selected_files = self._upload_file()
            if selected_files:
                print("Archivos seleccionados para Acad:", selected_files)
                self.files_acad = selected_files  # Guardamos el archivo, para subirlo
        except Exception as e:
            print(f"Error al subir archivos Acad: {e}")

            """
           Sección para la vista del estudiante, botones que corresponden a las vistas
           de estudiante, es decir al menu lateral, que son configuración, perfil,
           boleta y lo de pagos, estos botones solo se encargan de mostrar la interfaz
           que le corresponde a cada botón, la programación de cada interfaz es decir
           sus componentes internos, no va incluido, estos solo muestras las UI y las ocultan,
           nada más
           """

    # Métodos (funciones) para mostrar las ventanas o UI de cada apartado
    def _showTicketUI(self):
        try:
            # Crea una instancia de la ventana Ticket y la guarda como un atributo de la clase
            self.ticket_window = Ticket(self)
            self.ticket_window.show()
            self.setEnabled(False)

        except Exception as ex:
            print(f"Error {ex}")

    def _showSettingsUI(self):
       try:
           self.ticket_window = SettingsUI(self)
           self.ticket_window.show()
           self.setEnabled(False)

       except Exception as ex:
            print(f"Error {ex}")


#se debe agregar la vista del perfil de alumno
    def _showProfileUI(self):
        try:
            self.perfil_window = Perfil(self, self.information)
            self.perfil_window.show()
            self.setEnabled(False)

            #self.cierra.clicked.connect(self._closeWindowPerfil)  # Cerrar ventana perfil
            #self.minimiza.clicked.connect(self._minimizeWindowPerfil)  # Minimizar ventana perfil
        except Exception as ex:
            print(f"Error {ex}")

    def _showMateriasUI(self):
        try:
            self.materia_window = Materias(self, self.information)
            self.materia_window.show()
            self.setEnabled(False)

        except Exception as ex:
            print(f"Error {ex}")

    def _showMensajesAl(self):
        try:
            self.mensajeAl_window = mensajesAl(self, self.information)
            self.mensajeAl_window.show()
            self.setEnabled(False)

        except Exception as ex:
            print(f"Error {ex}")

    def _closeSesion(self):
        from Controller.Login import ControllerLogin
        InstanceLogin = ControllerLogin()
        InstanceLogin.show()
        self.hide()
        self.close()

    """
    Fin de la seccion de botones del menu lateral de la vista de estudiante
    """


"""
Clase encargada de hacer la carga de la interfaz correspondiente a lo de boleta
hereda de QMainWindow y de MethodsWindow
"""
class Ticket(QMainWindow, MethodsWindow):
    def __init__(self, windowMain):
        super().__init__()
        loadUi('../UI/Ticket.ui', self)

        self.previous_window = windowMain #Tomamos la ventana anterior para manipular

        self.initializeComponents()
        self.initializeVariables()
        self.initializeStyles()


    def initializeComponents(self):
        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound(928, 676)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent


        # Conectar el botón de salida a la función _closeWindow
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana

        # Conectar el botón de minimizar a la función _minimizeWindow
        self.buttonMinimize.clicked.connect(self._minimizeWindow)  # Minimizar ventana

    def initializeVariables(self):
        pass

    def initializeStyles(self):
        pass

    def hideComponents(self):
        self.buttonMinimize.setVisible(False)

    def _closeWindow(self):
        self.previous_window.setEnabled(True)
        self.hide()
        self.close()

    def _minimizeWindow(self):
        self.previous_window.setEnabled(True)
        self.showMinimized()

class Perfil(QMainWindow, MethodsWindow):
    def __init__(self, windowMain, information):
        super().__init__()
        loadUi('../UI/profile.ui', self)

        self.information = information

        self.previous_window = windowMain #Tomamos la ventana anterior para manipular

        self.initializeComponents()
        self.initializeVariables()


    def initializeComponents(self):
        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound(800, 600)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.buttonExit.clicked.connect(self._closeWindow)
        self.buttonMinimize.setVisible(False)

        self.usuario.setText(self.information[0]['idUser'])
        self.num.setText(str(self.information[0]['nControl']))
        self.nombre.setText(self.information[0]['name'])
        self.apellido.setText(self.information[0]['lastName'])
        self.semestre.setText(str(self.information[0]['semester']))
        self.puntos.setText(str(self.information[0]['score']))

    def initializeVariables(self):

        pass


    def _closeWindow(self):
        self.previous_window.setEnabled(True)
        self.hide()
        self.close()

class Materias(QMainWindow, MethodsWindow):
    def __init__(self, windowMain, information):
        super().__init__()
        loadUi('../UI/materias.ui', self)
        self.contadorUni = 0

        self.information = information

        self.previous_window = windowMain #Tomamos la ventana anterior para manipular

        self.initializeComponents()
        self.initializeVariables()


    def initializeComponents(self):
        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound(1171, 884)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.temasXUni()

        self.buttonExit.clicked.connect(self._closeWindow)
        self.buttonMinimize.setVisible(False)

        #para los botones subir
        self.subir1_3.clicked.connect(lambda: self._subir('subir1_3'))
        self.subir2_3.clicked.connect(lambda: self._subir('subir2_3'))
        self.subir3_3.clicked.connect(lambda: self._subir('subir3_3'))

        #para los temas atras y adelante
        self.backUni.clicked.connect(lambda: self.contadorMaterias('atras'))
        self.nextUni.clicked.connect(lambda: self.contadorMaterias('siguiente'))

    def _subir(self, button_name):
        try:
            selected_files = self._upload_file()
            if selected_files:
                print("Archivos seleccionados:", selected_files)
                # Agregamos los archivos seleccionados a una lista específica según el botón presionado
                if button_name == 'subir1_3':
                    self.subir1_3(self._subir_a_db)
                elif button_name == 'subir2_3':
                    self.archivos_subir2_3(self._subir_a_db)
                elif button_name == 'subir3_3':
                    self.archivos_subir3_3(self._subir_a_db)
        except Exception as e:
            print("Error al subir archivos:", e)

    def _subir_a_db(self):
        try:
            from DB.Requests import Inquiries
            Isntacia= Inquiries()

            Isntacia.insert_to_evidences()

            print("Subiendo archivos a la base de datos...")
        except Exception as e:
            print("Error al subir archivos a la base de datos:", e)

    def contadorMaterias(self, typeButton):
        try:
            if typeButton == "siguiente" and self.contadorUni == 7:
                MessageBox.information_msgbox("INFORMACIÓN", "Solo existen 7 temas")
            elif typeButton == "atras" and self.contadorUni == 0:
                MessageBox.information_msgbox("INFORMACIÓN", "No pueden haber menos de 0 temas")
            elif typeButton == "siguiente" and self.contadorUni == 6:
                MessageBox.information_msgbox("INFORMACIÓN", "Solo existen 6 temas")
            elif typeButton == "siguiente" and self.contadorUni == 5:
                MessageBox.information_msgbox("INFORMACIÓN", "Solo existen 5 temas")
            elif typeButton == "siguiente" and self.contadorUni == 4:
                MessageBox.information_msgbox("INFORMACIÓN", "Solo existen 4 temas")
            else:
                self.contadorUni += 1 if typeButton == "siguiente" else -1
                self.icono()
                self.temasXUni()

        except Exception as e:

            MessageBox.warning_msgbox("ERROR", f"Error en contadorMaterias: {str(e)}")

    def icono(self):
        try:
            # Obtener la ruta del archivo de ícono basado en el valor de contador Unidades
            icon_path = f"../Resources/{self.contadorUni}-color.png"

            # Validar el valor de contadorUnidades y ajustar la ruta del ícono si es necesario
            if self.contadorUni < 0:
                self.contadorUni = 0
            elif self.contadorUni > 7:
                self.contadorUni = 7


            # Crear un objeto QIcon con la ruta del archivo de ícono
            icon = QIcon(icon_path)

            # Establecer el ícono en el botón verUnidad
            self.verUni.setIcon(icon)
        except Exception as e:
            MessageBox.warning_msgbox("ERROR", f"Error en icono: {str(e)}")

    def temasXUni(self):
        try:
            from DB.Requests import Inquiries
            Instancia = Inquiries()

            value = Instancia.Usertemas(self.previous_window.setUserName.text())
            print(value)
            


        except Exception as e:
            MessageBox.warning_msgbox("ERROR", f"Error en temas: {str(e)}")


    def _upload_file(self):
        try:
            # Abrir un cuadro de diálogo para seleccionar un archivo
            file_dialog = QFileDialog(self)
            file_dialog.setWindowTitle('Seleccionar archivo a subir')
            file_dialog.setFileMode(QFileDialog.ExistingFiles)
            file_dialog.setNameFilter("Archivos de imagen (*.png *.jpg);;Archivos PDF (*.pdf)")

            # Ejecutar el cuadro de diálogo
            if file_dialog.exec_():
                selected_files = file_dialog.selectedFiles()
                return selected_files
        except Exception as e:
            print(f"Error al abrir el cuadro de diálogo: {e}")

    def _closeWindow(self):
        self.previous_window.setEnabled(True)
        self.hide()
        self.close()





class mensajesAl(QMainWindow):
    def __init__(self, windowMain, information):
        super().__init__()
        loadUi('../UI/mensajesAlumno.ui', self)

        self.information = information
        self.previous_window = windowMain  # Tomamos la ventana anterior para manipular

        self.initializeComponents()

    def initializeComponents(self):
        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound(800, 600)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.buttonExit.clicked.connect(self._closeWindow)
        self.buttonMinimize.setVisible(False)
        self.Guardar.clicked.connect(self.guardarMensaje)
        self.Historial.clicked.connect(self.verMensajes)


    def guardarMensaje(self):
        from DB.Requests import Inquiries
        from Controller.Message import MessageBox

        ola = Inquiries()
        mensaje = self.mensaje.toPlainText()

        # Verificar si el mensaje está vacío
        if not mensaje:
            MessageBox.warning_msgbox("ADVERTENCIA", "El mensaje está vacío")
            return

        try:
            ola.insertMessage(self.information[0]['idUser'], mensaje)
            MessageBox.correct_msgbox("ÉXITO", "Mensaje enviado correctamente")
            self.mensaje.clear()

        except Exception as e:
            MessageBox.correct_msgbox("ERROR", f"Ha ocurrido un error al enviar el mensaje: {str(e)}")



    def verMensajes(self):
     pass

    def _closeWindow(self):
        self.previous_window.setEnabled(True)
        self.hide()
        self.close()


"""
Clase encargada de cargar la UI de los pagos
"""

class Payments(QMainWindow, MethodsWindow):
    def __init__(self, windowMain):
        super().__init__()
        loadUi('../UI/Payments.ui', self)

        self.previous_window = windowMain #Tomamos la ventana anterior para manipular

        self.initializeComponents()
        self.initializeVariables()
        self.initializeStyles()

    def initializeComponents(self):
        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound(1103, 654)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent


        # Conectar el botón de salida a la función _closeWindow
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana

    def initializeVariables(self):
        pass

    def initializeStyles(self):
        pass

    def hideComponents(self):
        self.buttonMinimize.setVisible(False)


    def _closeWindow(self):
        self.previous_window.setEnabled(True)
        self.hide()
        self.close()


"""
Clase encargada de cargar la UI de las configuraciones
la funcionalidad se encuentra en el Controller/Config.py
en la clase Settings, aqui solo carga la UI y se asignan los eventos
a los botones.
"""

class SettingsUI(QMainWindow, MethodsWindow):
    def __init__(self, windowMain):
        super().__init__()
        loadUi('../UI/Settings.ui', self)

        self.previous_window = windowMain #Tomamos la ventana anterior para manipular

        self.initializeComponents()
        self.initializeVariables()
        self.initializeStyles()


    def initializeComponents(self):
        self.InstanceWindow = RoundedWindow(self)
        self.InstanceWindow.startRound(896, 619)
        InstanceMotion = MotionFrame(self)

        # Conectar los eventos del mouse de la ventana a los métodos correspondientes de la instancia de MotionFrame
        self.mousePressEvent = InstanceMotion.mousePressEvent
        self.mouseMoveEvent = InstanceMotion.mouseMoveEvent
        self.mouseReleaseEvent = InstanceMotion.mouseReleaseEvent

        self.buttonMinimize.setVisible(False)
        # Conectar el botón de salida a la función _closeWindow
        self.buttonExit.clicked.connect(self._closeWindow)  # Cerrar ventana
        self.buttonProfile.clicked.connect(self._showProfileSettings)
        self.buttonProcess.clicked.connect(self._showProcessSettings)


    def initializeVariables(self):
        pass

    def initializeStyles(self):
        pass

    def hideComponents(self):
        pass


    def _showProfileSettings(self):
        try:
            self.frameUser.raise_()
            self.frameProcess.lower()
        except Exception as ex:
            print(f"Error {ex}")


    def _showProcessSettings(self):
        try:
            self.frameUser.lower()
            self.frameProcess.raise_()
        except Exception as ex:
            print(f"Error {ex}")


    def save(self):
        from Controller.Config import Settings
        settings = Settings(self)

    def _closeWindow(self):
        self.previous_window.setEnabled(True)
        self.hide()
        self.close()



