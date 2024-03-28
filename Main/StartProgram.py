import sys
from PyQt5.QtWidgets import QApplication, QMessageBox
from Controller.Login import ControllerLogin
from Controller.Message import MessageBox as sms

def main():
    try:
        app = QApplication(sys.argv)
        window = ControllerLogin()
        window.show()
        sys.exit(app.exec_())

    except ImportError as e:
        sms.input_error_msgbox("ERROR!", f"Error de importación de tipo {str(e)}")

    except Exception as e:
        sms.input_error_msgbox("ERROR!", f"El error es {str(e)}")

if __name__ == '__main__':
    main()