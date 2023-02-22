
class Bibliotecas {
  // ignore: non_constant_identifier_names
  static int ID_Bibliografia = 0;

  static List<String> librerias = [];
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
              Lyben_Absctract varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Methods varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Conclusiones varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Obs varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Catego_A varchar(150) COLLATE utf8_unicode_ci NOT NULL, 
              Lyben_Catego_B varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Catego_C varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_Concepto varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              Lyben_File longblob NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
            COMMENT='Tabla para Registro de recursos bibliotecarios.';
            """,
    "truncateQuery": "TRUNCATE libreryan_any",
    "dropQuery": "DROP TABLE libreryan_any",
    "consultQuery": "SELECT * FROM libreryan_any",
    "consultIdQuery": "SELECT * FROM libreryan_any WHERE ID_Hosp = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM libreryan_any WHERE ID_Pace = ?",
    "consultAllIdsQuery": "SELECT ID_Pace FROM libreryan_any",
    "consultLastQuery":
        "SELECT * FROM libreryan_any WHERE ID_Pace = ? ORDER BY Feca_PEN DESC",
    "consultByName": "SELECT * FROM libreryan_any WHERE Pace_PEN LIKE '%",
    "registerQuery": "INSERT INTO libreryan_any ("
        "Feca_Lyben_REG, "
        "Lyben_Tyttle, Lyben_Autores, "
        "Lyben_Rev_Journal, Lyben_Type_Rev, Lyben_Anno_Pub, Lyben_DOI, "
        "Lyben_Database_Id, "
        "Lyben_Absctract, Lyben_Methods, Lyben_Conclusiones, Lyben_Obs, "
        "Lyben_Catego_A, Lyben_Catego_B, Lyben_Catego_C, Lyben_Concepto "
        // "Lyben_File "
        ") "
        "VALUES (?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?,?,?,?)", // ?
    "updateQuery": "UPDATE libreryan_any "
        "SET ID_Lyben = ?, Feca_Lyben_REG = ?, "
        "Lyben_Tyttle = ?, Lyben_Autores = ?, "
        "Lyben_Rev_Journal = ?, Lyben_Type_Rev = ?, Lyben_Anno_Pub = ?, Lyben_DOI = ?, "
        "Lyben_Database_Id = ?, "
        "Lyben_Absctract = ?, Lyben_Methods = ?, Lyben_Conclusiones = ?, Lyben_Obs = ?, "
        "Lyben_Catego_A = ?, Lyben_Catego_B = ?, Lyben_Catego_C = ?, Lyben_Concepto = ? "
        // "Lyben_File = ?, "
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
