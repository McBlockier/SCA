from DB.Connection import ConnectionDB
from datetime import datetime

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
        """
        Obtiene las asignaturas asociadas a un usuario por su ID.

        Parameters:
        - idUser: El ID del usuario del cual se desean obtener las asignaturas.

        Returns:
        - resultados: Un diccionario que contiene las asignaturas asociadas al usuario.

        Description:
        Este método se utiliza para obtener las asignaturas asociadas a un usuario en la base de datos.
        Se conecta a la base de datos y llama al procedimiento almacenado 'ObtenerAsignaturasPorUsuario' pasando el ID del usuario como parámetro.
        Recupera los resultados del procedimiento almacenado y los almacena en un diccionario, donde las claves son los usuarios y los valores son listas de asignaturas asociadas a cada usuario.
        Si se encuentran asignaturas asociadas al usuario, se devuelve un diccionario con los datos.
        Si no se encuentra ninguna asignatura asociada al usuario o si ocurre un error durante el proceso, se imprime un mensaje de error y se devuelve un diccionario vacío.
        """
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
            print(f"Error al obtener las asignaturas por usuario: {ex}")
            return {}


    #Administrador


    def insertMessage(self, idUser, sms):
        """
        Inserta un nuevo mensaje en la base de datos.

        Parameters:
        - idUser: El ID del usuario que envía el mensaje.
        - sms: El contenido del mensaje.

        Returns:
        - None

        Description:
        Este método se utiliza para insertar un nuevo mensaje en la base de datos.
        Se conecta a la base de datos y llama al procedimiento almacenado 'InsertMessage' pasando los parámetros necesarios,
        junto con la hora y la fecha actuales obtenidas automáticamente.
        Después de insertar el mensaje, se confirma la transacción.
        Si ocurre un error durante el proceso, se imprime un mensaje de error.
        """
        try:
            # Obtener la hora y la fecha actuales
            hour = datetime.now().strftime('%H:%M:%S')
            date = datetime.now().strftime('%Y-%m-%d')

            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.callproc("InsertMessage", (idUser, sms, hour, date))
                db.connection.commit()
        except Exception as ex:
            print(f"Error al insertar el mensaje: {ex}")

    def insertReply(self, idUser, reply_text):
        """
        Inserta una nueva respuesta a un mensaje en la base de datos.

        Parameters:
        - idUser: El ID del usuario que envía la respuesta.
        - reply_text: El contenido de la respuesta.

        Returns:
        - bool: True si la inserción fue exitosa, False si ocurrió un error.

        Description:
        Este método se utiliza para insertar una nueva respuesta a un mensaje en la base de datos.
        Se conecta a la base de datos y llama al procedimiento almacenado 'InsertReply' pasando los parámetros necesarios,
        junto con la hora y la fecha actuales obtenidas automáticamente.
        Después de insertar la respuesta, se confirma la transacción.
        Si ocurre un error durante el proceso, se imprime un mensaje de error y se retorna False.
        """
        try:
            # Verificar si el idUser existe en la tabla user antes de la inserción
            if self.checkUserExists(idUser):
                # Obtener la hora y la fecha actuales
                reply_hour = datetime.now().strftime('%H:%M:%S')
                reply_date = datetime.now().strftime('%Y-%m-%d')

                with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                    cursor = db.connection.cursor()
                    cursor.callproc("InsertReply", (idUser, reply_text, reply_hour, reply_date))
                    db.connection.commit()

                # Si la inserción fue exitosa, retornar True
                return True
            else:
                print("El idUser proporcionado no existe en la tabla user.")
                return False
        except Exception as ex:
            print(f"Error al insertar la respuesta: {ex}")
            # Si ocurrió un error, retornar False
            return False

    def checkUserExists(self, idUser):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.execute("SELECT idUser FROM user WHERE idUser = %s", (idUser,))
                result = cursor.fetchone()
                if result:
                    return True  # El idUser existe en la tabla user
                else:
                    return False  # El idUser no existe en la tabla user
        except Exception as ex:
            print(f"Error al verificar si el idUser existe: {ex}")
            return False  # En caso de error, asumimos que el idUser no existe

    def updateReplyStatus(self, idMessage):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.execute("UPDATE messages SET reply = 1 WHERE id = %s", (idMessage,))
                db.connection.commit()
            return True  # Indicar que la actualización fue exitosa
        except Exception as ex:
            print(f"Error al actualizar el estado de respuesta del mensaje: {ex}")
            return False  # Indicar que ocurrió un error durante la actualización

    def getMessageId(self, message_text):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.execute("CALL GetMessageIdBySms(%s)", (message_text,))
                result = cursor.fetchone()
                if result:
                    return result[0]  # Devuelve el idMessage si se encuentra el mensaje
                else:
                    return None  # Devuelve None si no se encuentra el mensaje
        except Exception as ex:
            print(f"Error al obtener el id del mensaje: {ex}")
            return None  # En caso de error, devuelve None

    def get_user_file_counts(self, idUser):
        """
        Obtiene el recuento de archivos de un usuario por su ID.

        Parameters:
        - idUser: El ID del usuario del cual se desea obtener el recuento de archivos.

        Returns:
        - results: Un diccionario que contiene el recuento de archivos del usuario en diferentes categorías.

        Description:
        Este método se conecta a la base de datos y llama al procedimiento almacenado 'GetUserFileCounts' pasando el ID del usuario como parámetro.
        Recupera los resultados del procedimiento almacenado y los almacena en un diccionario, donde las claves representan las categorías de archivos y los valores representan el recuento de archivos correspondiente.
        Las categorías de archivos incluyen rubricas, evidencias, imágenes y videos.
        Si se encuentran los recuentos de archivos del usuario, se devuelve un diccionario con los recuentos.
        Si no se encuentra ningún recuento de archivos para el usuario o si ocurre un error durante el proceso, se imprime un mensaje de error y se devuelve un diccionario vacío.
        """
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
            print("Error al obtener el recuento de archivos del usuario:", error)

        return results


    def search_contact(self, idTeacher):
        """
        Busca un contacto de profesor en la base de datos por su ID.

        Parameters:
        - idTeacher: El ID del profesor que se desea buscar en la base de datos.

        Returns:
        - result_dicts: Lista de diccionarios que contienen los datos del contacto del profesor encontrado en la base de datos.

        Description:
        Este método busca un contacto de profesor en la base de datos utilizando su ID.
        Se conecta a la base de datos, llama al procedimiento almacenado 'search_teacher_by_name' pasando el ID del profesor como parámetro.
        Recupera los resultados del procedimiento almacenado y los convierte en una lista de diccionarios.
        Cada diccionario contiene los datos del contacto del profesor, donde las claves son los nombres de las columnas y los valores son los datos correspondientes.
        Si se encuentra un contacto de profesor, se devuelve una lista de diccionarios con los datos del contacto.
        Si no se encuentra ningún contacto de profesor o si ocurre un error durante la búsqueda, se imprime un mensaje de error y se devuelve una lista vacía.
        """
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
            print(f"Error al buscar el contacto del profesor: {ex}")
            return []


    def GetAllUsers(self):
        """
        Obtiene todos los usuarios de la base de datos.

        Returns:
        - users: Lista de tuplas que contienen los datos de los usuarios. Cada tupla representa un usuario y contiene todos los campos de la tabla 'user'.

        Description:
        Este método realiza una consulta a la base de datos para obtener todos los usuarios almacenados en la tabla 'user'.
        Retorna una lista de tuplas donde cada tupla representa un usuario y contiene todos los campos de la tabla.
        Si ocurre un error durante la consulta a la base de datos, se imprime un mensaje de error y se retorna una lista vacía.
        """
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.execute("SELECT * FROM user")
                users = cursor.fetchall()
                return users
        except Exception as ex:
            print(f"Error al obtener todos los usuarios: {ex}")
            return []


    def GetAllTeachers(self):
        """
        Obtiene todos los profesores de la base de datos.

        Returns:
        - teachers: Lista de tuplas que contienen los datos de los profesores. Cada tupla representa un profesor y contiene todos los campos de la tabla 'teachers'.

        Description:
        Este método realiza una consulta a la base de datos para obtener todos los profesores almacenados en la tabla 'teachers'.
        Retorna una lista de tuplas donde cada tupla representa un profesor y contiene todos los campos de la tabla.
        Si ocurre un error durante la consulta a la base de datos, se imprime un mensaje de error y se retorna una lista vacía.
        """
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.execute("SELECT * FROM teachers")
                teachers = cursor.fetchall()
                return teachers
        except Exception as ex:
            print(f"Error al obtener todos los profesores: {ex}")
            return []

    def delete_by_id(self, procedure_name, id):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                # Llamar al procedimiento almacenado
                cursor.callproc(procedure_name, (id,))
                # Confirmar los cambios en la base de datos
                db.connection.commit()
                return True
        except Exception as ex:
            print(f"Error {ex}")
            return False

    # Llamada al nuevo método para eliminar un usuario por su ID
    def delete_user_by_id(self, id):
        return self.delete_by_id('delete_user', id)

    # Llamadas a los métodos existentes
    def delete_teacher_by_id(self, id):
        return self.delete_by_id('delete_teacher', id)

    def getMessages(self):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                cursor.execute("SELECT idUser, sms, hour FROM messages WHERE reply = FALSE")
                mensajes_no_respondidos = cursor.fetchall()
                mensajes_dict = []
                for mensaje in mensajes_no_respondidos:
                    mensaje_dict = {
                        "usuario": mensaje[0],
                        "mensaje": mensaje[1],
                        "hora": mensaje[2]
                    }
                    mensajes_dict.append(mensaje_dict)
                return mensajes_dict
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

