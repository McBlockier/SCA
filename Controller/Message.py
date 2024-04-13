from PyQt5.QtWidgets import QMessageBox, QApplication
from PyQt5.QtGui import QIcon
from PyQt5.QtCore import QTimer, QPropertyAnimation, QPoint, QEasingCurve

# Definición de la clase MsgBox, que hereda de QMessageBox
class MsgBox(QMessageBox):
    def __init__(self, title, text):
        super().__init__()  # Llamar al constructor de la clase base
        self.setWindowTitle(title)  # Establecer el título del cuadro de mensaje
        self.setText(text)  # Establecer el texto del cuadro de mensaje

    # Método para establecer un icono personalizado en el cuadro de mensaje
    def set_custom_icon(self, icon_path):
        q_icon = QIcon(icon_path)  # Crear un objeto QIcon con la ruta especificada
        self.setIconPixmap(q_icon.pixmap(64, 64))  # Establecer el icono del cuadro de mensaje

    # Método para desvanecer el cuadro de mensaje
    def fade_out(self):
        self.animation = QPropertyAnimation(self, b"windowOpacity")  # Crear una animación de propiedad para la opacidad de la ventana
        self.animation.setDuration(1000)  # Establecer la duración de la animación en milisegundos
        self.animation.setStartValue(1.0)  # Establecer la opacidad inicial
        self.animation.setEndValue(0.0)  # Establecer la opacidad final
        self.animation.setEasingCurve(QEasingCurve.OutQuad)  # Aplicar una curva de aceleración/deceleración
        self.animation.finished.connect(self.close)  # Conectar la señal finished de la animación al método close
        self.animation.start()  # Iniciar la animación

    # Método para actualizar la opacidad del cuadro de mensaje
    def update_opacity(self):
        self.opacity -= 0.1  # Reducir la opacidad en 0.1 en cada iteración
        self.setWindowOpacity(self.opacity)  # Establecer la opacidad de la ventana del cuadro de mensaje
        if self.opacity <= 0:  # Si la opacidad es menor o igual a cero
            self.timer.stop()  # Detener el temporizador
            self.close()  # Cerrar el cuadro de mensaje



# Definición de la clase MessageBox para mostrar diferentes tipos de cuadros de mensaje
class MessageBox:
    # Método estático para mostrar un cuadro de mensaje de "correcto"
    @staticmethod
    def correct_msgbox(title, text):
        msg_box = MsgBox(title, text)  # Crear un objeto MsgBox con el título y el texto proporcionados
        icon = '../Resources/correct.png'  # Ruta del icono "correcto"
        msg_box.set_custom_icon(icon)  # Establecer el icono personalizado en el cuadro de mensaje
        msg_box.setStandardButtons(QMessageBox.Ok)  # Establecer el botón estándar del cuadro de mensaje
        msg_box.buttonClicked.connect(msg_box.fade_out)  # Conectar el clic del botón al método fade_out del cuadro de mensaje
        msg_box.exec_()  # Ejecutar el cuadro de mensaje


    # Método estático para mostrar un cuadro de mensaje de "error de entrada"
    @staticmethod
    def input_error_msgbox(title, text):
        msg_box = MsgBox(title, text)  # Crear un objeto MsgBox con el título y el texto proporcionados
        icon = '../Resources/input_error.png'  # Ruta del icono "error de entrada"
        msg_box.set_custom_icon(icon)  # Establecer el icono personalizado en el cuadro de mensaje
        msg_box.setStandardButtons(QMessageBox.Ok)  # Establecer el botón estándar del cuadro de mensaje
        msg_box.buttonClicked.connect(msg_box.fade_out)  # Conectar el clic del botón al método fade_out del cuadro de mensaje
        msg_box.exec_()  # Ejecutar el cuadro de mensaje


    # Método estático para mostrar un cuadro de mensaje de "advertencia"
    @staticmethod
    def warning_msgbox(title, text):
        msg_box = MsgBox(title, text)  # Crear un objeto MsgBox con el título y el texto proporcionados
        icon = '../Resources/warning.png'  # Ruta del icono "advertencia"
        msg_box.set_custom_icon(icon)  # Establecer el icono personalizado en el cuadro de mensaje
        msg_box.setStandardButtons(QMessageBox.Ok)
        msg_box.buttonClicked.connect(msg_box.fade_out)  # Conectar el clic del botón al método fade_out del cuadro de mensaje
        msg_box.exec_()  # Ejecutar el cuadro de mensaje


    # Método estático para mostrar un cuadro de mensaje de "información"
    @staticmethod
    def information_msgbox(title, text):
        msg_box = MsgBox(title, text)  # Crear un objeto MsgBox con el título y el texto proporcionados
        icon = '../Resources/information.png'  # Ruta del icono "información"
        msg_box.set_custom_icon(icon)  # Establecer el icono personalizado en el cuadro de mensaje
        msg_box.setStandardButtons(QMessageBox.Ok)  # Establecer los botones estándar del cuadro de mensaje
        msg_box.buttonClicked.connect(msg_box.fade_out)  # Conectar el clic del botón al método fade_out del cuadro de mensaje
        msg_box.exec_()  # Ejecutar el cuadro de mensaje


    @staticmethod
    def question_msgbox(title, text):
        msg_box = QMessageBox()
        msg_box.setWindowTitle(title)
        msg_box.setText(text)
        icon = QMessageBox.Question
        msg_box.setIcon(icon)
        msg_box.setStandardButtons(QMessageBox.Yes | QMessageBox.No)
        reply = msg_box.exec_()
        return reply == QMessageBox.Yes


    @staticmethod
    def not_found_msgbox(title, text):
        msg_box = MsgBox(title, text)  # Crear un objeto MsgBox con el título y el texto proporcionados
        icon = '../Resources/notFound.png'  # Ruta del icono "información"
        msg_box.set_custom_icon(icon)  # Establecer el icono personalizado en el cuadro de mensaje
        msg_box.setStandardButtons(
            QMessageBox.Ok)  # Establecer los botones estándar del cuadro de mensaje
        msg_box.buttonClicked.connect(
            msg_box.fade_out)  # Conectar el clic del botón al método fade_out del cuadro de mensaje
        msg_box.exec_()  # Ejecutar el cuadro de mensaje
