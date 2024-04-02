import mysql.connector

class ConnectionDB:
    """
    Clase para manejar la conexión a una base de datos MySQL.

    Attributes:
        host (str): El nombre del host donde se encuentra la base de datos.
        user (str): El nombre de usuario para acceder a la base de datos.
        password (str): La contraseña del usuario para acceder a la base de datos.
        database (str): El nombre de la base de datos a la que se quiere conectar.
        connection (mysql.connector.connection.MySQLConnection): La conexión a la base de datos.
    """

    def __init__(self, host, user, password, database):
        """
        Constructor de la clase.

        Args:
            host (str): El nombre del host donde se encuentra la base de datos.
            user (str): El nombre de usuario para acceder a la base de datos.
            password (str): La contraseña del usuario para acceder a la base de datos.
            database (str): El nombre de la base de datos a la que se quiere conectar.
        """
        self.host = host
        self.user = user
        self.password = password
        self.database = database
        self.connection = None

    def __enter__(self):
        """
        Método para utilizar la clase en un contexto de gestión de recursos (with).

        Returns:
            ConnectionDB: La instancia de la clase.
        """
        self.connect()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        """
        Método llamado al salir de un contexto de gestión de recursos (with).
        Cierra la conexión a la base de datos.

        Args:
            exc_type (type): Tipo de excepción.
            exc_value (Exception): Valor de la excepción.
            traceback (Traceback): Traza de la excepción.
        """
        self.close()

    def connect(self):
        """
        Establece la conexión a la base de datos.

        Raises:
            mysql.connector.Error: Si ocurre un error al conectarse a la base de datos.
        """
        try:
            self.connection = mysql.connector.connect(
                host=self.host,
                user=self.user,
                password=self.password,
                database=self.database
            )
        except mysql.connector.Error as e:
            raise e

    def close(self):
        """
        Cierra la conexión a la base de datos.
        """
        if self.connection is not None and self.connection.is_connected():
            self.connection.close()
