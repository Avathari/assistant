import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';

class Vocablos {
  static String localRepositoryPath = 'assets/'
      'lexema/${ID_Vocablos.toString()}/';
  static int ID_Vocablos = 1;
  static List Lexemas = [];
}

class Lexemas {
  static int ID_Usuarios = 1;
  static int ID_Vocablos = 1;
  static var fileAssocieted = '${Vocablos.localRepositoryPath}lexema.json';
  static var fileStadistics =
      '${Vocablos.localRepositoryPath}lexemaStadistics.json';
  //
  static String selectedDiagnosis = "";
  //

  static Map<String, dynamic> Lexema = {};

  static var actualDiagno;

  static void registros() {
    Actividades.consultarAllById(Databases.siteground_database_vocal,
            Lexemas.lexema['consultByIdPrimaryQuery'], Vocablos.ID_Vocablos)
        .then((value) {
      Vocablos.Lexemas = value;
      Archivos.createJsonFromMap(value,
          filePath: "${Vocablos.localRepositoryPath}lexema.json");
    });
  }

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_vocal,
            Lexemas.lexema['consultLastQuery'], Vocablos.ID_Vocablos)
        .then((value) {
      Lexemas.Lexema =
          value; // Enfermedades de base del paciente, asi como las Hospitalarias.
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_vocal,
            Lexemas.lexema['consultIdQuery'], Vocablos.ID_Vocablos)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Vocablos.Lexemas = value;
    });
  }

  static final Map<String, dynamic> lexema = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regvocal "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regvocal",
    "describeTable": "DESCRIBE lexema;",
    "showColumns": "SHOW columns FROM lexema",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns "
            "WHERE table_name = 'Lexemas'",
    "createQuery": """
    CREATE TABLE `voca_iden` (
              `ID_Vocal` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
              `Tipo_Vocal` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
              `Subtipo_Vocal` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
              `Categoria_Vocal` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
              `Nominacion_Vocal` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
              `Trasliteracion` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
              `Fonematica` varchar(200) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB 
            DEFAULT CHARSET=utf8 
            COLLATE=utf8_unicode_ci 
            COMMENT='En esta Tabla se agregan los sara_iden_iden que usan el Sistema';
            """,
    "truncateQuery": "TRUNCATE voca_iden",
    "dropQuery": "DROP TABLE voca_iden",
    "consultQuery": "SELECT * FROM voca_iden",
    "consultIdQuery": "SELECT * FROM voca_iden WHERE ID_Usuario = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM voca_iden WHERE ID_Usuario = ?",
    // "consultAllIdsQuery": "SELECT ID_Usuario FROM lexema",
    "consultLastQuery": "SELECT * FROM voca_iden WHERE ID_Usuario = ?",
    "consultByName": "SELECT * FROM voca_iden WHERE Tipo_Recurso LIKE '?",
    "registerQuery": "INSERT INTO voca_iden (Tipo_Vocal, Subtipo_Vocal, Categoria_Vocal, Nominacion_Vocal, " 
    "Trasliteracion, Fonematica) "
        "VALUES (?,?,?,?,?,?,?)",
    "updateQuery": "UPDATE voca_iden "
        "SET ID_Vocal = ?, Tipo_Vocal = ?, Subtipo_Vocal = ?, Categoria_Vocal = ?, Nominacion_Vocal = " 
  "?, Trasliteracion = ?, Fonematica = ? WHERE ID_Vocal = ?",
    "deleteQuery": "DELETE FROM voca_iden WHERE ID_Vocal = ?",
    "lexemaStadistics": "SELECT "
        "(SELECT IFNULL(COUNT(`Tipo_Recurso`), '0') FROM lexema WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Ingresos') as Ingresos_Registrados, "
        "(SELECT IFNULL(COUNT(`Tipo_Recurso`), '0') FROM lexema WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Egresos') as Egresos_Registrados, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM lexema WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Ingresos') as Ingreso_Global, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM lexema WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Egresos') as Egreso_Global, "
        "(SELECT Ingreso_Global - Egreso_Global) as Balance_Global; "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM lexema WHERE `ID_Usuario` = 1 AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) as Ingreso_Anual, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) as Egreso_Anual, "
    // "(SELECT Ingreso_Anual - Egreso_Anual) AS Balance_Anual, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM lexema WHERE `ID_Usuario` = 1 AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) as Ingreso_Anual_Previo, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) as Egreso_Anual_Previo, "
    // "(SELECT Balance_Global - (Ingreso_Anual_Previo - Egreso_Anual_Previo)) as Balance_Previo_Año, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM lexema WHERE `ID_Usuario` = 1 AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) as Ingreso_Mes_Previo, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) as Egreso_Mes_Previo, "
    // "(SELECT Balance_Global - (Ingreso_Mes_Previo - Egreso_Mes_Previo)) AS Balance_Previo_Mes, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM lexema WHERE `ID_Usuario` = 1 AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Ingreso_Mensual, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND (MONTH(`Feca_Fine`) = MONTH(CURRENT_DATE)) AND YEAR(`Feca_Fine`) = year(CURRENT_DATE)) as Egreso_Mensual, "
    // "(SELECT Ingreso_Mensual - Egreso_Mensual) AS Balance_Mensual, "
    // "(SELECT Balance_Global - (Balance_Mensual)) AS Balance_Actual, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Uno, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Dos, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Tres, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Cuatro, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Cinco, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Seis, "
    // "(SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Uno, "
    // "(SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Dos, "
    // "(SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Tres, "
    // "(SELECT (Ingreso_Global / 100) * 55) AS Cuenta_Global_Cuatro, "
    // "(SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Cinco, "
    // "(SELECT (Ingreso_Global / 100) * 5) AS Cuenta_Global_Seis, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Uno, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Dos, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Tres, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Cuatro, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Cinco, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Seis, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Uno, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Dos, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Tres, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 55) AS Cuenta_Anual_Previo_Cuatro, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Cinco, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 5) AS Cuenta_Anual_Previo_Seis, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Uno, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Dos, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Tres, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Cuatro, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Cinco, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Seis, "
    // "(SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Uno, "
    // "(SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Dos, "
    // "(SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Tres, "
    // "(SELECT (Ingreso_Anual / 100) * 55) AS Cuenta_Anual_Cuatro, "
    // "(SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Cinco, "
    // "(SELECT (Ingreso_Anual / 100) * 5) AS Cuenta_Anual_Seis, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Uno, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Dos, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Tres, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Cuatro, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Cinco, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Seis, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Uno, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Dos, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Tres, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 55) AS Cuenta_Mensual_Previo_Cuatro, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Cinco, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 5) AS Cuenta_Mensual_Previo_Seis, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Uno, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Dos, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Tres, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Cuatro, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Cinco, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Seis, "
    // "(SELECT (Ingreso_Mensual / 100) * 10) AS Cuenta_Mensual_Uno, "
    // "(SELECT (Ingreso_Mensual / 100) * 10) AS Cuenta_Mensual_Dos, "
    // "(SELECT (Ingreso_Mensual / 100) * 10) AS Cuenta_Mensual_Tres, "
    // "(SELECT (Ingreso_Mensual / 100) * 55) AS Cuenta_Mensual_Cuatro, "
    // "(SELECT (Ingreso_Mensual / 100) * 10) AS Cuenta_Mensual_Cinco, "
    // "(SELECT (Ingreso_Mensual / 100) * 5) AS Cuenta_Mensual_Seis, "
    // "(SELECT (Ingreso_Mensual / 100) * 10) AS Cuenta_Mensual_Uno, "
    // "(SELECT (Cuenta_Mensual_Uno - Egreso_Mensual_Cuenta_Uno)) AS Cuenta_Mensual_Balance_Uno, "
    // "(SELECT (Cuenta_Mensual_Dos - Egreso_Mensual_Cuenta_Dos)) AS Cuenta_Mensual_Balance_Dos, "
    // "(SELECT (Cuenta_Mensual_Tres - Egreso_Mensual_Cuenta_Tres)) AS Cuenta_Mensual_Balance_Tres,"
    // "(SELECT (Cuenta_Mensual_Cuatro - Egreso_Mensual_Cuenta_Cuatro)) AS Cuenta_Mensual_Balance_Cuatro,"
    // "(SELECT (Cuenta_Mensual_Cinco - Egreso_Mensual_Cuenta_Cinco)) AS Cuenta_Mensual_Balance_Cinco,"
    // "(SELECT (Cuenta_Mensual_Seis - Egreso_Mensual_Cuenta_Seis)) AS Cuenta_Mensual_Balance_Seis;"
  };
}
