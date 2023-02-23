import 'package:assistant/conexiones/conexiones.dart';

class Bibliotecas {
  // ignore: non_constant_identifier_names
  static int ID_Bibliografia = 0;
  static String? tituloBibliografia, nombreAutores, palabrasClave;

  static void fromJson(Map<String, dynamic> json) {
    Bibliotecas.ID_Bibliografia = json['ID_Lyben'];
    tituloBibliografia = json['Lyben_Tyttle'];
    nombreAutores = json['Lyben_Autores'];
    palabrasClave = json['Lyben_Keyword'];
  }

  // **** *********** ************** *****
  static List? librerias = [];

  static String documentoBibliografia = "";

  static getImage() {
    Actividades.consultarId(Databases.siteground_database_regasca,
            bibliotecas['consultDocument'], Bibliotecas.ID_Bibliografia)
        .then((value) {
      print("consultImage $value");
      documentoBibliografia = value['Lyben_File'];
    });
  }

  static Map<String, dynamic> biblioteca = {};

  static List<String> catyeA = [
    'Ritmo Sinusal',
    'Ritmo no Sinusal'
  ]; // Especialidades
  static List<String> catyeB = [
    'Ritmo Sinusal',
    'Ritmo no Sinusal'
  ]; // Enfermedades
  static List<String> catyeC = [
    'Ritmo Sinusal',
    'Ritmo no Sinusal'
  ]; // Definición, Clínica, Tratamiento, Pronóstico, Escalas Médicas, . . .
  static List<String> typesBibliotecas = [
    'Radiografías',
    'Ultrasonidos',
    'Tomografías',
    'Resonancias'
  ]; // Concepto:

  static final Map<String, dynamic> bibliotecas = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regasca "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regasca",
    "describeTable": "DESCRIBE libreryan_any;",
    "showColumns": "SHOW columns FROM libreryan_any",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default "
            "FROM information_schema.columns "
            "WHERE table_name = 'libreryan_any'",
    "createQuery": """
    CREATE TABLE libreryan_any (
              ID_Lyben int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              Feca_Lyben_REG date NOT NULL,
              Lyben_Tyttle varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Autores varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Rev_Journal varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Type_Rev varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Anno_Pub varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_DOI varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Database_Id varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Keyword varchar(200) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Absctract varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Methods varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Conclusiones varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Obs varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_File longblob NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
            COMMENT='Tabla para Registro de recursos bibliotecarios.';
            """,
    "truncateQuery": "TRUNCATE libreryan_any",
    "dropQuery": "DROP TABLE libreryan_any",
    "consultQuery": "SELECT ID_Lyben, Feca_Lyben_REG, "
        "Lyben_Tyttle, Lyben_Autores, "
        "Lyben_Rev_Journal, Lyben_Type_Rev, Lyben_Anno_Pub, Lyben_DOI, "
        "Lyben_Database_Id, Lyben_Keyword, "
        "Lyben_Absctract, Lyben_Methods, Lyben_Conclusiones, Lyben_Obs "
        "FROM libreryan_any",
    "consultDocument":
        "SELECT Lyben_File FROM libreryan_any WHERE ID_Lyben = ?",
    "consultIdQuery": "SELECT * FROM libreryan_any WHERE ID_Lyben = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM libreryan_any WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM libreryan_any",
    "consultLastQuery":
        "SELECT * FROM libreryan_any WHERE ID_Pace = ? ORDER BY Feca_PEN DESC",
    "consultByName": "SELECT * FROM libreryan_any WHERE Pace_PEN LIKE '%",
    "registerQuery": "INSERT INTO libreryan_any (Feca_Lyben_REG, "
        "Lyben_Tyttle, Lyben_Autores, "
        "Lyben_Rev_Journal, Lyben_Type_Rev, Lyben_Anno_Pub, Lyben_DOI, "
        "Lyben_Database_Id, Lyben_Keyword, "
        "Lyben_Absctract, Lyben_Methods, Lyben_Conclusiones, Lyben_Obs, "
        "Lyben_File) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,"
        "?,?,from_base64(?))",
    "updateQuery": "UPDATE libreryan_any "
        "SET ID_Lyben = ?, Feca_Lyben_REG = ?, "
        "Lyben_Tyttle = ?, Lyben_Autores = ?, "
        "Lyben_Rev_Journal = ?, Lyben_Type_Rev = ?, Lyben_Anno_Pub = ?, Lyben_DOI = ?, "
        "Lyben_Database_Id = ?, Lyben_Keyword = ?, "
        "Lyben_Absctract = ?, Lyben_Methods = ?, Lyben_Conclusiones = ?, Lyben_Obs = ?, "
        "Lyben_File = from_base64(?) "
        "WHERE ID_Lyben = ?",
    "updateDoQuery": "UPDATE libreryan_any "
        "SET Pace_PEN_realized = ? "
        "WHERE ID_Lyben = ?",
    "deleteQuery": "DELETE FROM libreryan_any WHERE ID_Lyben = ?",
    "antropoColumns": [
      "ID_Pace",
    ],
    "antropoItems": [],
    "antropoColums": [],
    "antropoStats": [],
    "electroStadistics": "SELECT "
        "(SELECT IFNULL(count(*), 0) FROM libreryan_any WHERE Pace_Ses = ?) as Total_Mujeres,"
        "(SELECT IFNULL(count(*), 0) FROM libreryan_any) as Total_Pacientes;"
  };
}

class Fragmentos {
  // ignore: non_constant_identifier_names
  static int ID_Fragmento = 0;

  static List? fragmentaciones = [];

  static Map<String, dynamic> biblioteca = {};

  static List<String> catyeA = [
    'Ritmo Sinusal',
    'Ritmo no Sinusal'
  ]; // Especialidades
  static List<String> catyeB = [
    'Ritmo Sinusal',
    'Ritmo no Sinusal'
  ]; // Enfermedades
  static List<String> catyeC = [
    'Ritmo Sinusal',
    'Ritmo no Sinusal'
  ]; // Definición, Clínica, Tratamiento, Pronóstico, Escalas Médicas, . . .
  static List<String> typesFragmentos = [
    'Radiografías',
    'Ultrasonidos',
    'Tomografías',
    'Resonancias'
  ]; // Concepto:

  static final Map<String, dynamic> fragmentos = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regasca "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regasca",
    "describeTable": "DESCRIBE libreryan_fray;",
    "showColumns": "SHOW columns FROM libreryan_fray",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default "
            "FROM information_schema.columns "
            "WHERE table_name = 'libreryan_fray'",
    "createQuery": """
    CREATE TABLE libreryan_fray (
              ID_Lyben_fray int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              ID_Lyben int(10) NOT NULL,
              Lyben_Catego_A varchar(150) COLLATE utf8_unicode_ci NOT NULL, 
              Lyben_Catego_B varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Catego_C varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Keywords varchar(200) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Concepto varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Fray varchar(500) COLLATE utf8_unicode_ci NOT NULL 
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
            COMMENT='Tabla para Fragmentos obtenidos mediante recursos bibliotecarios.';
            """,
    "truncateQuery": "TRUNCATE libreryan_fray",
    "dropQuery": "DROP TABLE libreryan_fray",
    "consultQuery": "SELECT * FROM libreryan_fray",
    "consultDocument":
        "SELECT Lyben_File FROM libreryan_fray WHERE ID_Lyben = ?",
    "consultIdQuery": "SELECT * FROM libreryan_fray WHERE ID_Lyben = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM libreryan_fray WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM libreryan_fray",
    "consultLastQuery":
        "SELECT * FROM libreryan_fray WHERE ID_Pace = ? ORDER BY Feca_PEN DESC",
    "consultByName": "SELECT * FROM libreryan_fray WHERE Pace_PEN LIKE '%",
    "registerQuery": "INSERT INTO libreryan_fray ("
        "ID_Lyben, Lyben_Catego_A, Lyben_Catego_B, Lyben_Catego_C, "
        "Lyben_Keywords, Lyben_Concepto, "
        "Lyben_Fray) "
        "VALUES (?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE libreryan_fray "
        "SET ID_Lyben_fray = ?, ID_Lyben = ?, "
        "Lyben_Catego_A = ?, Lyben_Catego_B = ?, Lyben_Catego_C = ?, "
        "Lyben_Keywords = ?, Lyben_Concepto = ?,"
        "Lyben_Fray = ? "
        "WHERE ID_Lyben_fray = ?",
    "deleteQuery": "DELETE FROM libreryan_fray WHERE ID_Lyben = ?",
    "antropoColumns": [
      "ID_Pace",
    ],
    "antropoItems": [],
    "antropoColums": [],
    "antropoStats": [],
    "electroStadistics": "SELECT "
        "(SELECT IFNULL(count(*), 0) FROM libreryan_fray WHERE Pace_Ses = ?) as Total_Mujeres,"
        "(SELECT IFNULL(count(*), 0) FROM libreryan_fray) as Total_Pacientes;"
  };
}
