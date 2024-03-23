from DB.Connection import ConnectionDB

class Inquiries:
    """
    Clase para realizar consultas y operaciones en la base de datos.
    """

    def __init__(self):
        """
        Constructor de la clase.
        Inicializa los parámetros de conexión a la base de datos.
        """
        self.host = ""
        self.user = ""
        self.password = ""
        self.database = ""

    def start_to_connection(self):
        """
        Método para establecer los datos de conexión a la base de datos.
        """
        # Datos de conexión
        self.host = "localhost"
        self.user = "McBlockier"
        self.password = "root"
        self.database = "sca_database"

    def validate_login(self, userName, password):
        """
        Método para validar el inicio de sesión de un usuario.

        :param userName: Nombre de usuario.
        :param password: Contraseña del usuario.
        :return: Resultado de la validación.
        """
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.callproc('ValidateLoginWithRank', (userName, password))
                result = cursor.fetchone()

                cursor.close()
                return result

        except Exception as ex:
            print(f"Error {ex}")

    def register_user(self, idUser, password, name, lastName, nControl, rankId):
        """
        Método para registrar un nuevo usuario en la base de datos.

        :param idUser: Identificador del usuario.
        :param password: Contraseña del usuario.
        :param name: Nombre del usuario.
        :param lastName: Apellido del usuario.
        :param nControl: Número de control del usuario.
        :param rankId: ID del rango de usuario.
        :return: Resultado del registro y mensaje descriptivo.
        """
        try:
            # Parámetros de salida
            success = None
            message = None

            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                cursor.callproc('RegisterUser', (idUser, password, name, lastName,
                                                 nControl, rankId, success, message))
                cursor.execute('SELECT @_RegisterUser_6, @_RegisterUser_7')
                result = cursor.fetchone()
                success = result[0]
                message = result[1]

                # Confirmar los cambios si la transacción fue exitosa
                db.connection.commit()

        except Exception as ex:
            print(f"Error {ex}")
            success = False
            message = "Error al registrar usuario."

        finally:
            cursor.close()
            db.connection.close()

        return success, message