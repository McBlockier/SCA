from DB.Connection import ConnectionDB
from datetime import datetime
from datetime import timedelta
import json

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


    def get_messages_with_answer(self):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor(dictionary=True)

                # Llamar al procedimiento almacenado sin argumentos
                cursor.callproc("GetRespondedMessagesWithTable")

                # Recuperar los datos de los mensajes respondidos
                result = next(cursor.stored_results(), None)
                if result is not None:
                    # Procesar los datos de los mensajes respondidos
                    messages = []
                    for row in result.fetchall():
                        message_data = {
                            'usuario': row['idUser'],
                            'mensaje': row['sms'],
                            'hora': timedelta(seconds=row['hour'].seconds),
                            'reply': row['reply']
                        }
                        messages.append(message_data)

                    # Devolver directamente la lista de mensajes
                    return True, messages
                else:
                    # No se encontraron mensajes respondidos
                    return False, []

        except Exception as ex:
            print(f"Error in get_messages_with_answer: {ex}")
            return False, []

    def create_user(self, dataTable):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                # Llamar al procedimiento almacenado
                cursor.callproc('create_user', (
                    dataTable['ID Usuario'],
                    dataTable['Contraseña'],
                    dataTable['Nombre'],
                    dataTable['Apellido'],
                    int(dataTable['No. Control']),
                    int(dataTable['ID Rango']),
                    int(dataTable['Semestre']),
                    dataTable['Regular'],
                    int(dataTable['Puntaje'])
                ))

                db.connection.commit()  # Confirmar la transacción

                return True  # Retornar True si la inserción fue exitosa

        except Exception as ex:
            print(f"Error {ex}")
            return False  # Retornar False en caso de error


    def create_teacher(self, dataTable):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                # Llamar al procedimiento almacenado
                cursor.callproc('create_teacher', (
                    dataTable['Nombre'],
                    dataTable['Matricula']
                ))

                db.connection.commit()  # Confirmar la transacción

                return True  # Retornar True si la inserción fue exitosa

        except Exception as ex:
            print(f"Error {ex}")
            return False  # Retornar False en caso de error

    def update_user(self, dataTable):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                print(dataTable)

                # Extraer el ID del usuario del diccionario dataTable
                user_id = dataTable.get('ID Usuario')
                if not user_id:
                    print("No se proporcionó el ID del usuario.")
                    return False

                # Ejecutar el procedimiento almacenado para actualizar el usuario
                cursor.callproc('update_user_by_id', (
                    user_id,
                    dataTable.get('Contraseña'),
                    dataTable.get('Nombre'),
                    dataTable.get('Apellido'),
                    dataTable.get('No. Control'),
                    dataTable.get('ID Rango'),
                    dataTable.get('Semestre'),
                    dataTable.get('Regular'),
                    dataTable.get('Puntaje')
                ))

                # Confirmar los cambios en la base de datos
                db.connection.commit()

                return True

        except Exception as ex:
            print(f"Error al actualizar el usuario: {ex}")
            return False


    def update_teacher(self, dataTable):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                # Extraer el ID del profesor del diccionario dataTable
                teacher_id = dataTable.get('ID')
                if not teacher_id:
                    print("No se proporcionó el ID del profesor.")
                    return False

                # Ejecutar el procedimiento almacenado para actualizar el profesor
                cursor.callproc('update_teacher_by_id', (
                    int(teacher_id),  # Convertir a entero
                    dataTable.get('Nombre'),
                    dataTable.get('Matricula')
                ))

                # Confirmar los cambios en la base de datos
                db.connection.commit()

                return True
        except Exception as ex:
            print(f"Error al actualizar el profesor: {ex}")
            return False


#Evidences

    def count_evidences_by_issue(self, teacher, issue):
        try:
            # Conectar a la base de datos
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                # Contar las evidencias asociadas al problema (issue) y al profesor específicos
                cursor.execute("SELECT COUNT(*) FROM evidences WHERE teacher = %s AND issue = %s", (teacher, issue))
                count = cursor.fetchone()[0]

                return count
        except Exception as ex:
            print(f"Error counting evidences: {ex}")
            return -1  # Retornar un valor negativo en caso de error

    def get_unscored_evidences(self):
        try:
            # Conectar a la base de datos
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                # Obtener las evidencias no calificadas (score NULL o 0) y agruparlas por usuario
                cursor.execute(
                    "SELECT MAX(semester) AS semester, idUser, MAX(score) AS score FROM evidences_student WHERE score IS NULL OR score = 0 GROUP BY idUser"
                )
                unscored_evidences = cursor.fetchall()

                return unscored_evidences
        except Exception as ex:
            print(f"Error getting unscored evidences: {ex}")
            return None  # Retornar None en caso de error


    def insert_to_evidences(self, name, file, type, forUser, semester, subject, teacher, issue):
        try:
            # Verificar cuántas evidencias hay asociadas a este problema (issue) y profesor
            evidences_count = self.count_evidences_by_issue(teacher, issue)

            # Si hay menos de 3 evidencias, permitir la inserción
            if evidences_count < 3:
                # Convertir la lista de diccionarios a una cadena JSON
                for_user_json = json.dumps(forUser)
                print(for_user_json)

                # Obtener la fecha y hora actual
                current_date = datetime.now().date()
                current_hour = datetime.now().time().strftime('%H:%M:%S')

                # Conectar a la base de datos
                with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                    cursor = db.connection.cursor()

                    # Insertar la evidencia en la tabla
                    cursor.execute(
                        "INSERT INTO evidences (name, file, type, forUser, semester, date, hour, subject, teacher, issue) "
                        "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                        (
                        name, file, type, for_user_json, semester, current_date, current_hour, subject, teacher, issue))

                    # Confirmar los cambios en la base de datos
                    db.connection.commit()

                    return True
            else:
                from Controller.Message import MessageBox
                MessageBox.warning_msgbox("ADVERTENCIA", f"Ya no se pueden agregar mas evidencias para el tema {issue}")
                return False
        except Exception as ex:
            print(f"Error al insertar evidencias: {ex}")
            return False

    def get_users_by_semester(self, selected_semester):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                # Verificar si se proporcionó el semestre
                if not selected_semester:
                    print("No se proporcionó el semestre.")
                    return []

                # Consultar los usuarios con el semestre seleccionado
                users = []
                query = "SELECT idUser, name FROM user WHERE semester = %s"
                cursor.execute(query, (selected_semester,))
                rows = cursor.fetchall()
                for row in rows:
                    user_info = {
                        'idUser': row[0],
                        'name': row[1]
                    }
                    users.append(user_info)  # Agregar información del usuario a la lista
                return users

        except Exception as ex:
            print(f"Error user by semesters {ex}")
            return []

    def get_teacher_subjects(self, teacher_name):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                # Verificar si se proporcionó el nombre del docente
                if not teacher_name:
                    print("No se proporcionó el nombre del docente.")
                    return []

                # Consultar las asignaturas del docente
                subjects = []
                query = """
                    SELECT s.nombre
                    FROM subjects s
                    JOIN subjects_taught_by_teacher st ON s.idAsignatura = st.subject_id
                    JOIN teachers t ON st.teacher_id = t.teacher_id
                    WHERE t.name = %s
                """
                cursor.execute(query, (teacher_name,))
                rows = cursor.fetchall()
                for row in rows:
                    subjects.append(row[0])  # Agregar nombre de asignatura a la lista
                return subjects

        except Exception as ex:
            print(f"Error teacher subjects {ex}")
            return []

    def get_files_by_teacher(self, teacher_name):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                query = "SELECT id, name, type, LENGTH(file) AS size FROM evidences WHERE teacher = %s"
                params = (teacher_name,)
                cursor.execute(query, params)
                files = cursor.fetchall()
                return files
        except Exception as ex:
            print(f"Error {ex}")


    def get_users_by_semester_order(self, semester):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                # Consulta SQL para seleccionar usuarios de acuerdo al semestre indicado y ordenarlos por semestre
                query = "SELECT * FROM user WHERE semester = %s ORDER BY semester ASC"
                cursor.execute(query, (semester,))

                # Obtener los resultados de la consulta
                users = cursor.fetchall()

                return users

        except Exception as ex:
            print(f"Error {ex}")
            return None


    def execute_sql_script(self, sql_script):
        try:
            # Lista para almacenar los resultados
            results = []

            # Conectar a la base de datos
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()

                # Ejecutar el script SQL
                cursor.execute(sql_script)

                # Obtener los resultados
                results = cursor.fetchall()

        except Exception as ex:
            print(f"Error executing SQL script: {ex}")

        return results


"""
    def method(self, dataTable):
        try:
            with ConnectionDB(self.host, self.user, self.password, self.database) as db:
                cursor = db.connection.cursor()
                    pass

        except Exception as ex:
            print(f"Error {ex}")


"""



