from DB.Connection import ConnectionDB

class Inquiries:
    """
    Clase para realizar consultas y operaciones en la base de datos.

    Attributes:
        host (str): El nombre del host donde se encuentra la base de datos.
        user (str): El nombre de usuario para acceder a la base de datos.
        password (str): La contraseña del usuario para acceder a la base de datos.
        database (str): El nombre de la base de datos a la que se quiere conectar.
    """

    def __init__(self):

        """
        Constructor de la clase.
        """
        self.host = "127.0.0.1"
        self.user = "root"
        self.password = "root"
        self.database = "sca_database"

    def validate_login(self, userName, password):
        """
        Método para validar el inicio de sesión de un usuario.

        Args:
            userName (str): Nombre de usuario.
            password (str): Contraseña del usuario.

        Returns:
            bool: Resultado de la validación.
            str: Mensaje descriptivo en caso de error.
        """
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                sql_query = "SELECT ValidateLogin(%s, %s)"
                cursor.execute(sql_query, (userName, password))
                result = cursor.fetchone()[0]
                return bool(result), "Inicio de sesión exitoso."

        except Exception as ex:
            print(f"Error: {ex}")
            return False, "Error al conectar a la base de datos."

    def register_user(self, idUser, password, name, lastName, nControl, rank):
        """
        Método para registrar un nuevo usuario en la base de datos.

        Args:
            idUser (str): Identificador del usuario.
            password (str): Contraseña del usuario.
            name (str): Nombre del usuario.
            lastName (str): Apellido del usuario.
            nControl (int): Número de control del usuario.
            rankId (int): ID del rango de usuario.

        Returns:
            bool: Resultado del registro.
            str: Mensaje descriptivo del resultado del registro.
        """
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                #Llamamos a la función RegisterUser()
                sql_query = "SELECT RegisterUser(%s, %s, %s, %s, %s, %s)"
                cursor.execute(sql_query, (idUser, password, name, lastName, nControl, rank))
                result = cursor.fetchone()[0]
                db.connection.commit()

                return bool(result), "Usuario registrado correctamente."

        except Exception as ex:
            print(f"Error {ex}")

    def get_user_details_by_id(self, idUser):
        """
        Método para obtener los detalles de un usuario por su ID.

        Args:
            idUser (str): Identificador del usuario.

        Returns:
            list: Lista de diccionarios con los detalles del usuario.
        """
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor(dictionary=True)

                query = """
                            SELECT rankId, name, lastName, nControl, semester, regular, score, idUser
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
        """
        Método para restablecer la contraseña de un usuario.

        Args:
            newPassword (str): Nueva contraseña del usuario.
            idUser (str): Identificador del usuario.

        Returns:
            bool: True si se realizó la actualización correctamente, False si no.
        """
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                consulta = "UPDATE user SET password = %s WHERE idUser = %s"
                valores = (newPassword, idUser)
                cursor.execute(consulta, valores)
                db.connection.commit()

                cursor.close()
                db.connection.close()

                return True

        except Exception as ex:
            print(f"Error en reset {ex}")
            return False

    def isAvailable(self):
        """
        Método para verificar si la base de datos está disponible.

        Returns:
            bool: True si la base de datos está disponible, False si no.
        """
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.execute("SELECT idUser FROM user LIMIT 1")
                result = cursor.fetchone()
                cursor.close()
                return result is not None

        except Exception as ex:
            print(f"Error {ex}")
            print("\nLa base de datos no se encuentra, por favor configure la información\n"
                  "de la base de datos en DB/Requests -> Inquiries en el método __init__\n"
                  "allí se debe poner la información para la conexión con la base de datos.")

    def get_subject_by_user(self, idUser):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                # Llamar al procedimiento almacenado
                cursor.callproc('ObtenerAsignaturasPorUsuario', [idUser])

                # Obtener los resultados
                resultados = {}
                for result in cursor.stored_results():
                    for row in result.fetchall():
                        usuario = row[0]
                        asignaturas = row[1].split(',')  # Convertir la cadena de asignaturas en una lista
                        resultados[usuario] = asignaturas

                # Cerrar cursor y conexión
                cursor.close()
                db.connection.close()

                return resultados

        except Exception as ex:
            print(f"Error {ex}")








#Administrador
    def insertMessage(self, idUser, sms, hour, date):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.callproc("InsertMessage", (idUser, sms, hour, date))
                db.connection.commit()
        except Exception as ex:
            print(f"Error inserting message: {ex}")


    def insertReply(self, idMessage, idUser, reply_text, reply_hour, reply_date):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.callproc("InsertReply", (idMessage, idUser, reply_text, reply_hour, reply_date))
                db.connection.commit()
        except Exception as ex:
            print(f"Error inserting reply: {ex}")


    def get_user_file_counts(self, idUser):
        results = {}
        try:
            with mysql.connector.connect(
                host=self.host,
                user=self.user,
                password=self.password,
                database=self.database
            ) as db:
                cursor = db.cursor()

                cursor.callproc("GetUserFileCounts", (idUser,))
                for result in cursor.stored_results():
                    file_counts = result.fetchall()
                    # Almacenar resultados en un diccionario
                    results['rubrica_count'] = file_counts[0][0]
                    results['evidencia_count'] = file_counts[0][1]
                    results['imagen_count'] = file_counts[0][2]
                    results['video_count'] = file_counts[0][3]

        except mysql.connector.Error as error:
            print("Error:", error)

        return results

    def search_contact(self, idTeacher):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                # Llamar al procedimiento almacenado
                cursor.callproc('search_teacher_by_name', (idTeacher,))

                # Recuperar los resultados
                for result in cursor.stored_results():
                    columns = result.column_names
                    rows = result.fetchall()
                    result_dicts = []
                    for row in rows:
                        result_dict = {}
                        for i, value in enumerate(row):
                            result_dict[columns[i]] = value
                        result_dicts.append(result_dict)
                    return result_dicts

        except Exception as ex:
            print(f"Error {ex}")


"""
Este metodo es la base para hacer tus propios métodos y mandar a llamar las funciones o metodos almacenados
que requieras, solo quita el pass y alli mismo escribe tu lógica o pegala allí

 def metodoBase(self):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                 pass
        except Exception as ex:
            print(f"Error {ex}")

"""

