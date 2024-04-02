from DB.Connection import ConnectionDB
class Inquiries:
    """
    Clase para realizar consultas y operaciones en la base de datos.
    """
    def __init__(self):
        "Datos para la conexión a la base de datos"
        self.host = "127.0.0.1"
        self.user = "root"
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

                sql_query = "SELECT ValidateLogin(%s, %s)"
                cursor.execute(sql_query, (userName, password))
                result = cursor.fetchone()[0]
                return bool(result)

        except Exception as ex:
            print(f"Error: {ex}")
            return False, "Error al conectar a la base de datos."

    def register_user(self, idUser, password, name, lastName, nControl, rank):
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
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                sql_query = "SELECT RegisterUser(%s, %s, %s, %s, %s, %s)"
                cursor.execute(sql_query, (idUser, password, name, lastName, nControl, rank))
                result = cursor.fetchone()[0]
                db.connection.commit()

                return bool(result), "Usuario registrado correctamente."

        except Exception as ex:
            print(f"Error {ex}")

    def get_user_details_by_id(self, idUser):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor(dictionary=True)

                query = """
                            SELECT rankId, name, lastName, nControl
                            FROM user
                            WHERE idUser = %s
                        """
                cursor.execute(query, (idUser,))
                results = cursor.fetchall()

                return results

        except Exception as ex:
            print(f"Error {ex}")
            return []

    def reset_password(self, newPassword, idUser):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                consulta = "UPDATE user SET password = %s WHERE idUser = %s"
                valores = (newPassword, idUser)
                cursor.execute(consulta, valores)
                db.connection.commit()

                cursor.close()
                db.connection.close()

                # Si la ejecución se realizó sin errores, retornar True
                return True

        except Exception as ex:
            print(f"Error en reset {ex}")
            # Si ocurrió algún error, retornar False
            return False

    def isAvailable(self):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.execute("SELECT 1")
                cursor.close()
                return True

        except Exception as ex:
            print(f"Error en isAvailable {ex}")
            return False