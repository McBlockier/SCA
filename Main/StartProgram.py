from PyQt5.QtWidgets import QApplication
from Controller.Login import ControllerLogin

#Función principal
if __name__ == '__main__':
    try:
        app = QApplication([])
        window = ControllerLogin()
        window.show()
        app.exec()
    except Exception as e:
        print("Se ha producido una excepción:", e)
        input("Presiona cualquier tecla para salir...")