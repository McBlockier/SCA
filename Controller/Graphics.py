from PyQt5.QtWidgets import QLabel, QHBoxLayout, QVBoxLayout, QWidget, QScrollArea
from PyQt5.QtGui import QPixmap
from PyQt5.QtCore import Qt

class FileWidget(QWidget):
    def __init__(self, file_info):
        super().__init__()
        self.file_info = file_info
        self.setup_ui()

    def setup_ui(self):
        # Crear layout principal horizontal
        layout = QHBoxLayout()
        layout.setContentsMargins(0, 0, 0, 0)  # Eliminar los márgenes

        # Obtener la extensión del archivo y cargar el icono correspondiente
        file_extension = self.file_info[2].lower()
        icon_path = f"../Resources/{file_extension}.png"
        pixmap = QPixmap(icon_path).scaled(48, 48)  # Escalar el icono a 48x48
        label_icon = QLabel()
        label_icon.setPixmap(pixmap)
        label_icon.setContentsMargins(0, 0, 5, 0)  # Agregar un margen a la derecha

        # Crear layout para la información del archivo (nombre y tamaño)
        info_layout = QVBoxLayout()

        # Crear etiqueta para el nombre del archivo
        label_name = QLabel(self.file_info[1])
        label_name.setStyleSheet("font: 12pt Segoe UI;")  # Establecer la fuente y el tamaño de la letra
        label_name.setAlignment(Qt.AlignLeft)  # Alinear el nombre a la izquierda

        # Calcular el tamaño del archivo en KB, MB o GB
        file_size = self.file_info[3]
        kb_size = file_size / 1024
        mb_size = kb_size / 1024
        gb_size = mb_size / 1024
        if gb_size >= 1:
            size_str = f"{gb_size:.2f} GB"
        elif mb_size >= 1:
            size_str = f"{mb_size:.2f} MB"
        elif kb_size >= 1:
            size_str = f"{kb_size:.2f} KB"
        else:
            size_str = f"{file_size} bytes"

        # Crear etiqueta para el tamaño del archivo
        label_size = QLabel(f"Size: {size_str}")
        label_size.setStyleSheet("font: 12pt Segoe UI;")  # Establecer la fuente y el tamaño de la letra
        label_size.setAlignment(Qt.AlignLeft)  # Alinear el tamaño a la izquierda

        # Agregar etiquetas al layout de información
        info_layout.addWidget(label_name)
        info_layout.addWidget(label_size)

        # Agregar el icono y el layout de información al layout principal
        layout.addWidget(label_icon)
        layout.addLayout(info_layout)

        # Establecer el layout principal en el widget
        self.setLayout(layout)