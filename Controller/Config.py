from Controller.Implements import ThreadWorker, MethodsWindow
from Controller.Message import MessageBox

class Settings(MethodsWindow):
    def __init__(self, window):
        self.getWindow = window
        self.message = MessageBox()

        # Crear una instancia del ThreadWorker
        worker = ThreadWorker()
        read_thread = Thread(target=worker.readSettings)
        read_thread.start()  # Inicia el hilo para leer información
        read_thread.join()

    def initializeComponents(self):
        pass

    def initializeVariables(self):
        pass
