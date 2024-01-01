import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';

class Financieros {
  static String localRepositoryPath = 'assets/'
      'activos/${ID_Financieros.toString()}/';
  static int ID_Financieros = 1;
  // **************************************************************************
  static List Ingresos = [];
  static List Egresos = [];
  static List Activos = [];
  static List Pasivos = [];
  static List Patrimonio = [];
// **************************************************************************
  static double? ingresosTotales;
  static double? egresosTotales;
  static double? activosTotales;
  static double? pasivosTotales;
  static double? patriminiosTotales;
  // **************************************************************************
  static var Categorias = [
    'Ingresos Registrados',
    'Egresos Registrados',
    'Ingreso Global',
    'Egreso Global',
    'Balance Global'
  ];
}

class Activos {
  static int ID_Usuarios = 1;
  static int ID_Financieros = 1;
  static var fileAssocieted = '${Financieros.localRepositoryPath}activos.json';
  static var fileStadistics =
      '${Financieros.localRepositoryPath}activosStadistics.json';
  static String imagenActivo = "";
  // **************************************************************************
  static List tipoRecurso = [
    'Ingresos',
    'Egresos',
    'Activos',
    'Pasivos',
    'Patrimonio',
  ];
  // **************************************************************************
  static List conceptoIngresos = [
    "Aguinaldo",
    "Becas",
    "Finiquito",
    "Inversiones",
    "Rectificaciones",
    "Salarios eventuales",
    "Sueldo",
    "Vales y despensas",
    "Patrocinios y Apoyos",
    "Prestamos devueltos",
  ];
  static List conceptoEgresos = [
    "Artilugios",
    "Bailes y Salón",
    "Gimnasios",
    "Hoteles y viajes",
    "Prestamos no devueltos",
    "Retiros Bancarios",
    "Restaurantes y bares",
    "Mercados, Supermercados y Establecimientos",
    "Vinos y licores",
    "Gastos varios",
    "Medios de Transporte",
    "Diplomados",
    "Salud",
    "Papeleria, documentación y derivados",
  ];
  static List conceptoActivos = [
    "Sofipos",
    "Bonos Nacionales",
    "Criptomonedas",
    "Acciones EEUU",
    "Acciones Econ. Desarrolladas",
    "Acciones Econ. en Desarrollo",
    "Bienes raices",
    "Bonos Internacionales",
    "Bonos Inflacionarios",
  ];
  static List conceptoPasivos = [
    "Agua y Drenaje",
    "Alimentación",
    "Automóvil",
    "Multas e Infracciones Viáles",
    "Electricidad",
    "Gas",
    "Lavanderia y Tintorerías",
    "Ropa y Artilugios",
    "Productos de Auto-cuidado",
    "Gasolina",
    "Mantenimiento del Hogar",
    "Rentas y Alquiler",
  ];
  static List conceptoPatrimonio = [
    'Activos',
    'Activos',
    'Activos',
  ];
  // **************************************************************************
  static List cuentaAsignada = [
    'Cuenta No 1: Libertad Financiera',
    'Cuenta No 2: Ahorro a Largo Plazo',
    'Cuenta No 3: Desarrollo Personal',
    'Cuenta No 4: Necesidades Básicas',
    'Cuenta No 5: Ocio',
    'Cuenta No 6: Donativos',
  ];
  static List intervaloProgramado = [
    'Diario',
    'Semanal',
    'Mensual',
    'Bimensual',
    'Anual',
  ];
  static List estadoActual = [
    'Saldado',
    'Vigente',
  ];

  // **************************************************************************
  static Map<String, dynamic> Activo = {};
  static Future<Map<String, dynamic>> getImage() async {
    return Actividades.consultarId(Databases.siteground_database_regfine,
        Activos.activos['consultImageByIdQuery'], Activos.ID_Financieros);
  }

  static Future<void> registros() async {
    Actividades.consultarAllById(Databases.siteground_database_regfine,
            Activos.activos['consultIdQuery'], Financieros.ID_Financieros)
        .then((value) {
      // **************************************************************************
      Activos.fromJsonItem(Financieros.Activos);
      // **************************************************************************
      Financieros.Activos = value;
      // **************************************************************************
      Archivos.createJsonFromMap(value,
          filePath: Activos.fileAssocieted); //activos.json
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message:
              "ERROR : : : Error al Conectar con la Base de Datos - $error : : $stackTrace");
      // **************************************************************************
    });
  }

  static Future<List> getActivos() {
    return Actividades.consultarAllById(Databases.siteground_database_regfine,
        Activos.activos['consultByIdPrimaryQuery'], Financieros.ID_Financieros);
  }

  static void ultimoRegistro() {
    Actividades.consultarId(Databases.siteground_database_regfine,
            Activos.activos['consultLastQuery'], Financieros.ID_Financieros)
        .then((value) {
      Activos.Activo =
          value; // Enfermedades de base del paciente, asi como las Hospitalarias.
    });
  }

  static void consultarRegistro() {
    Actividades.consultarAllById(Databases.siteground_database_regfine,
            Activos.activos['consultIdQuery'], Financieros.ID_Financieros)
        .then((value) {
      // Enfermedades de base del paciente, asi como las Hospitalarias.
      Financieros.Activos = value;
    });
  }

  static final Map<String, dynamic> activos = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS bd_regpace "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE bd_regpace",
    "describeTable": "DESCRIBE activos;",
    "showColumns": "SHOW columns FROM activos",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'Activos'",
    "createQuery": """CREATE TABLE activos (
                        ID_Registro int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                        ID_Usuario int(11) NOT NULL,
                        Concepto_Recurso tinyint(1) NOT NULL,
                        Tipo_Recurso varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        Cuenta_Asignada varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                        Fecha_Pago_Programado int(200) NOT NULL,
                        Intervalo_Programado tinyint(1) NOT NULL,
                        Monto_Programado varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        Interes_Acordado tinyint(1) NOT NULL,
                        Monto_Pagado varchar(200) COLLATE utf8_unicode_ci NOT NULL, 
                        Monto_Restante varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        Estado_Actual varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        Fecha_Proximo_Pago varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        Fecha_Baja varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        Descripcion varchar(1000) COLLATE utf8_unicode_ci NOT NULL
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
                        COMMENT='Tabla para Antecedentes Financieros del Usuario';
            """,
    "truncateQuery": "TRUNCATE activos",
    "dropQuery": "DROP TABLE activos",
    "consultQuery": "SELECT * FROM activos",
    "consultIdQuery":
        "SELECT ID_Registro, Concepto_Recurso, Tipo_Recurso, Cuenta_Asignada, "
            "Fecha_Pago_Programado, Intervalo_Programado, "
            "Monto_Programado, Interes_Acordado, Monto_Pagado, Monto_Restante, "
            "Estado_Actual, Fecha_Proximo_Pago, Fecha_Baja, Descripcion "
            "FROM activos WHERE ID_Usuario = ?",
    "consultImageByIdQuery":
        "SELECT Fine_IMG FROM activos WHERE ID_Registro = ?",
    "consultByIdPrimaryQuery": "SELECT * FROM activos WHERE ID_Usuario = ?",
    // "consultAllIdsQuery": "SELECT ID_Registro FROM activos",
    "consultLastQuery": "SELECT * FROM activos WHERE ID_Usuario = ?",
    "consultByName": "SELECT * FROM activos WHERE Tipo_Recurso LIKE '%",
    "registerQuery": "INSERT INTO activos (ID_Usuario, "
        "Concepto_Recurso, Tipo_Recurso, Cuenta_Asignada, "
        "Fecha_Pago_Programado, Intervalo_Programado, "
        "Monto_Programado, Interes_Acordado, Monto_Pagado, Monto_Restante, "
        "Estado_Actual, Fecha_Proximo_Pago, Fecha_Baja, Descripcion, Fine_IMG) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,"
        "?,?,?,?, from_base64(?))",
    "updateQuery": "UPDATE activos "
        "SET ID_Registro = ?, ID_Usuario = ?, "
        "Concepto_Recurso = ?, Tipo_Recurso = ?, Cuenta_Asignada = ?, "
        "Fecha_Pago_Programado = ?, Intervalo_Programado = ?, "
        "Monto_Programado = ?, Interes_Acordado = ?, Monto_Pagado = ?, Monto_Restante = ?, "
        "Estado_Actual = ?, Fecha_Proximo_Pago = ?, Fecha_Baja = ?, "
        "Descripcion = ?, Fine_IMG = from_base64(?) "
        "WHERE ID_Registro = ?",
    "deleteQuery": "DELETE FROM activos WHERE ID_Registro = ?",
    "activosStadistics": "SELECT "
        "(SELECT IFNULL(COUNT(`Tipo_Recurso`), '0') FROM activos WHERE `ID_Usuario` = 1) as Total_Registrados, "
        "(SELECT IFNULL(COUNT(`Tipo_Recurso`), '0') FROM activos WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Ingresos') as Ingresos_Registrados, "
        "(SELECT IFNULL(COUNT(`Tipo_Recurso`), '0') FROM activos WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Egresos') as Egresos_Registrados, "
        "(SELECT IFNULL(COUNT(`Tipo_Recurso`), '0') FROM activos WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Activos') as Activos_Registrados, "
        "(SELECT IFNULL(COUNT(`Tipo_Recurso`), '0') FROM activos WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Pasivos') as Pasivos_Registrados, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Ingresos') as Ingreso_Global, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Egresos') as Egreso_Global, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Activos') as Activos_Global, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND Tipo_Recurso = 'Pasivos') as Pasivos_Global, "
        "(SELECT Ingreso_Global - Egreso_Global) as Balance_Parcial, " // Ingresos menos Egresos
        "(SELECT (Ingreso_Global + Activos_Global) - (Egreso_Global + Pasivos_Global)) as Patrimonio, " // Patrimonio
        "(SELECT (Ingreso_Global + Activos_Global + Egreso_Global + Pasivos_Global)) as Total_Global, " // Sumatoria Global
        "(SELECT (Ingreso_Global) - (Egreso_Global + Pasivos_Global)) as Balance_Global, " // Patrimonio sin Activos
        // ******************************  * **** *** ** * **
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 "
        "AND Tipo_Recurso = 'Ingresos' "
        "AND YEAR(`Fecha_Pago_Programado`) = YEAR(CURRENT_DATE)) as Ingreso_Anual, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 "
        "AND Tipo_Recurso = 'Egresos' "
        "AND YEAR(`Fecha_Pago_Programado`) = YEAR(CURRENT_DATE)) as Egreso_Anual, "
        "(SELECT Ingreso_Anual + Egreso_Anual) as Total_Anual, "
        "(SELECT Ingreso_Anual - Egreso_Anual) as Balance_Anual, "
        // ******************************  * **** *** ** * **
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 "
        "AND Tipo_Recurso = 'Ingresos' "
        "AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) as Ingreso_Anual_Previo, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 "
        "AND Tipo_Recurso = 'Egresos' "
        "AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) as Egreso_Anual_Previo, "
        "(SELECT (Ingreso_Anual_Previo + Egreso_Anual_Previo)) as Total_Previo_Año, "
        "(SELECT Balance_Global - (Ingreso_Anual_Previo - Egreso_Anual_Previo)) as Balance_Previo_Año, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 "
        "AND MONTH(`Fecha_Pago_Programado`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) "
        "AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) as Ingreso_Mes_Previo, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 "
        "AND MONTH(`Fecha_Pago_Programado`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) "
        "AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) as Egreso_Mes_Previo, "
        "(SELECT (Ingreso_Mes_Previo - Egreso_Mes_Previo)) AS Total_Previo_Mes, "
        "(SELECT Balance_Global - (Ingreso_Mes_Previo - Egreso_Mes_Previo)) AS Balance_Previo_Mes, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 "
        "AND Tipo_Recurso = 'Ingresos' "
        "AND (MONTH(`Fecha_Pago_Programado`) = MONTH(CURRENT_DATE)) "
        "AND YEAR(`Fecha_Pago_Programado`) = year(CURRENT_DATE)) as Ingreso_Mensual, "
        "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 "
        "AND Tipo_Recurso = 'Egresos' "
        "AND (MONTH(`Fecha_Pago_Programado`) = MONTH(CURRENT_DATE)) "
        "AND YEAR(`Fecha_Pago_Programado`) = year(CURRENT_DATE)) as Egreso_Mensual, "
        "(SELECT Ingreso_Mensual + Egreso_Mensual) AS Total_Mensual, "
        "(SELECT Ingreso_Mensual - Egreso_Mensual) AS Balance_Mensual, "
        "(SELECT Balance_Global - (Balance_Mensual)) AS Balance_Actual; "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND `Fecha_Pago_Programado` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Uno, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND `Fecha_Pago_Programado` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Dos, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND `Fecha_Pago_Programado` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Tres, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND `Fecha_Pago_Programado` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Cuatro, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND `Fecha_Pago_Programado` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Cinco, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND `Fecha_Pago_Programado` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Seis, "
    // "(SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Uno, "
    // "(SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Dos, "
    // "(SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Tres, "
    // "(SELECT (Ingreso_Global / 100) * 55) AS Cuenta_Global_Cuatro, "
    // "(SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Cinco, "
    // "(SELECT (Ingreso_Global / 100) * 5) AS Cuenta_Global_Seis, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Uno, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Dos, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Tres, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Cuatro, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Cinco, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Seis, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Uno, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Dos, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Tres, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 55) AS Cuenta_Anual_Previo_Cuatro, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Cinco, "
    // "(SELECT (Ingreso_Anual_Previo / 100) * 5) AS Cuenta_Anual_Previo_Seis, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND YEAR(`Fecha_Pago_Programado`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Uno, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND YEAR(`Fecha_Pago_Programado`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Dos, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND YEAR(`Fecha_Pago_Programado`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Tres, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND YEAR(`Fecha_Pago_Programado`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Cuatro, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND YEAR(`Fecha_Pago_Programado`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Cinco, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND YEAR(`Fecha_Pago_Programado`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Seis, "
    // "(SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Uno, "
    // "(SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Dos, "
    // "(SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Tres, "
    // "(SELECT (Ingreso_Anual / 100) * 55) AS Cuenta_Anual_Cuatro, "
    // "(SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Cinco, "
    // "(SELECT (Ingreso_Anual / 100) * 5) AS Cuenta_Anual_Seis, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND MONTH(`Fecha_Pago_Programado`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Uno, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND MONTH(`Fecha_Pago_Programado`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Dos, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND MONTH(`Fecha_Pago_Programado`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Tres, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND MONTH(`Fecha_Pago_Programado`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Cuatro, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND MONTH(`Fecha_Pago_Programado`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Cinco, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND MONTH(`Fecha_Pago_Programado`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Fecha_Pago_Programado`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Seis, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Uno, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Dos, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Tres, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 55) AS Cuenta_Mensual_Previo_Cuatro, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Cinco, "
    // "(SELECT (Ingreso_Mes_Previo / 100) * 5) AS Cuenta_Mensual_Previo_Seis, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND (MONTH(`Fecha_Pago_Programado`) = CURRENT_DATE) AND YEAR(`Fecha_Pago_Programado`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Uno, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND (MONTH(`Fecha_Pago_Programado`) = CURRENT_DATE) AND YEAR(`Fecha_Pago_Programado`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Dos, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND (MONTH(`Fecha_Pago_Programado`) = CURRENT_DATE) AND YEAR(`Fecha_Pago_Programado`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Tres, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND (MONTH(`Fecha_Pago_Programado`) = CURRENT_DATE) AND YEAR(`Fecha_Pago_Programado`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Cuatro, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND (MONTH(`Fecha_Pago_Programado`) = CURRENT_DATE) AND YEAR(`Fecha_Pago_Programado`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Cinco, "
    // "(SELECT IFNULL(SUM(`Monto_Pagado`), '0') FROM activos WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND (MONTH(`Fecha_Pago_Programado`) = CURRENT_DATE) AND YEAR(`Fecha_Pago_Programado`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Seis, "
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

  static void fromJsonItem(List activos) {
    Financieros.ingresosTotales = 0;
    Financieros.egresosTotales = 0;
    Financieros.activosTotales = 0;
    Financieros.pasivosTotales = 0;
    Financieros.patriminiosTotales = 0;
    //
    activos.forEach((element) {

      //
      if (element['Tipo_Recurso'] == 'Ingresos') {
        Financieros.Ingresos.add(element);
        // Sumar montos . . .
        // Terminal.printWarning(message: " . . . ${element}");
        Financieros.ingresosTotales = (Financieros.ingresosTotales!+ element['Monto_Pagado']);
        // Sumar montos por Mes . . .
        // var mensual = Financieros.Ingresos.


      }
      if (element['Tipo_Recurso'] == 'Egresos') {
        Financieros.Egresos.add(element);
        Financieros.egresosTotales = (Financieros.egresosTotales!+ element['Monto_Pagado']);
      }
      if (element['Tipo_Recurso'] == 'Activos') {
        Financieros.Activos.add(element);
        Financieros.activosTotales = (Financieros.activosTotales!+ element['Monto_Pagado']);
      }
      if (element['Tipo_Recurso'] == 'Pasivos') {
        Financieros.Pasivos.add(element);
        Financieros.pasivosTotales = (Financieros.pasivosTotales!+ element['Monto_Pagado']);
      }
      if (element['Tipo_Recurso'] == 'Patrimonio') {
        Financieros.Patrimonio.add(element);
        Financieros.patriminiosTotales = (Financieros.patriminiosTotales!+ element['Monto_Pagado']);
      }
//

    });

    // MUESTRA
    Terminal.printWarning(message: " . . . "
        " ### #### ###### ## # . . . . BALANCE REGISTRADO ### #### ###### ## # . . . ."
        "\n ACTIVOS TOTALES : ${activos.length} : . . . "
        "\n ${Financieros.ingresosTotales} : : ${Financieros.Ingresos.length}"
        "\n ${Financieros.egresosTotales} : : ${Financieros.Egresos.length}"
        "\n ${Financieros.activosTotales} : : ${Financieros.Activos.length}"
        "\n ${Financieros.pasivosTotales} : : ${Financieros.Pasivos.length}"
        "\n ${Financieros.patriminiosTotales} : : ${Financieros.Patrimonio.length}"
        "\n");
  }
}
