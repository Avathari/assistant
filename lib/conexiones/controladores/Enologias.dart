import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';

class Enologias {
  static int ID_Enologias = 0;
  static String imagenEnologia = "";
  //
  static Map<String, dynamic> Enologia = {};
  //
  static List<dynamic> Enologicos = [];

  static var fileAssocieted = 'assets/vault/enologicos/enologicos.json';

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regenolo,
            Enologias.enologias['consultLastQuery'], Enologias.ID_Enologias)
        .then((value) {
// Enfermedades de base del paciente, asi como las Hospitalarias.
      Enologias.Enologia = value;
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regenolo,
            Enologias.enologias['consultIdQuery'], Enologias.ID_Enologias)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Enologias.Enologicos = value;
    });
  }

  static final Map<String, dynamic> enologias = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regenolo "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regenolo",
    "describeTable": "DESCRIBE eno_iden;",
    "showColumns": "SHOW columns FROM eno_iden",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'eno_iden'",
    "createQuery": """
CREATE TABLE eno_iden (
                  ID_Enologias int(11) NOT NULL,
                  VinoNombre varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  MarcaVino varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Bodega varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Volumen varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  ZonaCrianza varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Crianza varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  Variedad varchar(300) COLLATE utf8_unicode_ci NOT NULL, 
                  PVP varchar(300) COLLATE utf8_unicode_ci NOT NULL, 
                  Foto_Vino longblob NOT NULL 
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci COMMENT='Tabla para Bitacora de productos enológicos';
            """,
    "truncateQuery": "TRUNCATE eno_iden",
    "dropQuery": "DROP TABLE eno_iden",
    "consultQuery": "SELECT * FROM eno_iden",
    "consultIdQuery": "SELECT * FROM eno_iden WHERE ID_Enologias = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM eno_iden WHERE ID_Enologias = ?",
    "consultAllIdsQuery": "SELECT ID_Enologias FROM eno_iden",
    "consultLastQuery": "SELECT * FROM eno_iden WHERE ID_Enologias = ?",
    "consultByName": "SELECT * FROM eno_iden WHERE Pace_APP_DEG LIKE '%",
    "registerQuery":
        "INSERT INTO eno_iden (ID_Enologias, VinoNombre, MarcaVino, "
            "Bodega, Volumen, ZonaCrianza, Crianza, "
            "Variedad, PVP) "
            "VALUES (?,?,?,?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE eno_iden "
        "SET ID_Enologias = ?,  VinoNombre = ?,  MarcaVino = "
        "?,  Bodega = ?,  Volumen = ?,  ZonaCrianza = ?,  "
        "Crianza = ?,  Variedad = ?, "
        "PVP = ?, Foto_Vino = ? "
        "WHERE ID_Enologias = ?",
    "deleteQuery": "DELETE FROM eno_iden WHERE ID_Enologias = ?",
    "sexualesColumns": [
      "ID_Enologias",
    ],
    "sexualesItems": [
      "ID_Enologias",
    ],
    "sexualesColums": [
      "ID Paciente",
    ],
    "sexualesStats": [
      "Total_Administradores",
    ],
    "sexualesStadistics": "SELECT "
        "(SELECT IFNULL(AVG('Pace_SV_tas'), 0) FROM eno_iden WHERE ID_Enologias = '${Enologias.ID_Enologias}') as Promedio_TAS,"
        "(SELECT IFNULL(AVG('Pace_SV_tad'), 0) FROM eno_iden WHERE ID_Enologias = '${Enologias.ID_Enologias}') as Promedio_TAD,"
        "(SELECT IFNULL(count(*), 0) FROM eno_iden WHERE ID_Enologias = '${Enologias.ID_Enologias}') as Total_Registros;"
  };

  static fromJson(Map<String, dynamic> json) {
    Terminal.printExpected(message: "Enologias : : $json");
  }
}
