import sys
from PyQt5.QtWidgets import QApplication, QMessageBox
from Controller.Login import ControllerLogin
from Controller.Message import MessageBox as sms

def main():
    try:
        from DB.Requests import Inquiries
        InstanceBD = Inquiries()
        if InstanceBD.isAvailable():
            app = QApplication(sys.argv)
            window = ControllerLogin()
            window.show()
            sys.exit(app.exec_())
        else:
            sms.input_error_msgbox("ERROR!", "La base de datos no se encuentra, porfavor configure la información"
                                             "de la base de datos en DB/Requests -> Inquiries en el metodo __init__"
                                             "allí se debe poner la información para la conexión con la base de datos.")

    except ImportError as e:
        sms.input_error_msgbox("ERROR!", f"Error de importación de tipo {str(e)}")

    except Exception as e:
        sms.input_error_msgbox("ERROR!", f"El error es {str(e)}")

if __name__ == '__main__':
    main()