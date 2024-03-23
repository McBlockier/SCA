import mysql.connector

class ConnectionDB:
    """
    Clase para manejar la conexión a la base de datos MySQL.
    """

    def __init__(self, host, user, password, database):
        """
        Constructor de la clase.

        :param host: El nombre del host donde se encuentra la base de datos.
        :param user: El nombre de usuario para acceder a la base de datos.
        :param password: La contraseña del usuario para acceder a la base de datos.
        :param database: El nombre de la base de datos a la que se quiere conectar.
        """
        self.host = host
        self.user = user
        self.password = password
        self.database = database
        self.connection = None

    def __enter__(self):
        """
        Método para utilizar la clase en un contexto de gestión de recursos (with).

        :return: La instancia de la clase.
        """
        self.connect()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        """
        Método llamado al salir de un contexto de gestión de recursos (with).
        Cierra la conexión a la base de datos.

        :param exc_type: Tipo de excepción.
        :param exc_value: Valor de la excepción.
        :param traceback: Traza de la excepción.
        """
        self.close()

    def connect(self):
        """
        Establece la conexión a la base de datos.
        """
        self.connection = mysql.connector.connect(
            host=self.host,
            user=self.user,
            password=self.password,
            database=self.database
        )

    def close(self):
        """
        Cierra la conexión a la base de datos.
        """
        if self.connection is not None and self.connection.is_connected():
            self.connection.close()
