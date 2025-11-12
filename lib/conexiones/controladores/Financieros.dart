import 'dart:convert';
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Financieros.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

class Financieros {
  // =======================================================
  // 🔹 CONFIGURACIÓN BASE
  static int ID_Financieros = 1;
  static String localRepositoryPath = 'assets/activos/$ID_Financieros/';

  // =======================================================
  /// 🔹 LISTAS PRINCIPALES
  ///  * * * Activos = [] Representa el recurso financiero que tenderá a generar ingresos.
  static List Ingresos = [],
      Egresos = [],
      Activos = [],
      Pasivos = [],
      Patrimonio = [];

  // =======================================================
  // 🔹 VARIABLES AGREGADAS
  static double ingresosTotales = 0;
  static double egresosTotales = 0;
  static double activosTotales = 0;
  static double pasivosTotales = 0;
  static double patrimonioTotales = 0;
  //
  // static double patrimonioTotal = 0;
  static double balanceGlobal = 0;

  static double ingresosAnual = 0;
  static double egresosAnual = 0;
  static double balanceAnual = 0;
  static double ingresosAnualPrevio = 0;
  static double egresosAnualPrevio = 0;
  static double balanceAnualPrevio = 0;

  // =======================================================
  // 🔹 FUNCIONES AUXILIARES DE SEGURIDAD
  // -------------------------------------------------------------------------
// 🧩 Conversión segura y división protegida
  static double _toNum(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    if (v is String)
      return double.tryParse(v.replaceAll(',', '').trim()) ?? 0.0;
    return 0.0;
  }

  static double _safeDiv(dynamic a, dynamic b) {
    final double x = _toNum(a);
    final double y = _toNum(b);
    return (y == 0) ? 0 : x / y;
  }

  static double _safeVal(dynamic v) {
    if (v == null) return 0.0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is String)
      return double.tryParse(v.replaceAll(',', '').trim()) ?? 0.0;
    return 0.0;
  }

  // =======================================================
  // 🔹 FUNCIONES ANALÍTICAS — INDICADORES FINANCIEROS

  /// 🟢 Margen Neto = Balance / Ingresos
  static double get margenNeto =>
      _safeDiv(balanceGlobal, ingresosTotales) * 100;

  /// 🔵 Liquidez = Ingreso / Egreso
  static double get liquidez => _safeDiv(ingresosTotales, egresosTotales);

  /// 🟢 Variación Anual = (Balance actual - Balance previo) / Balance previo
  static double get variacionAnual =>
      _safeDiv(balanceAnual - balanceAnualPrevio, balanceAnualPrevio) * 100;

  /// 🟠 Margen Operativo = (Ingreso anual - Egreso anual) / Ingreso anual
  static double get margenOperativo =>
      _safeDiv(ingresosAnual - egresosAnual, ingresosAnual) * 100;

  /// 🔴 Endeudamiento = Pasivos / Activos
  static double get endeudamiento =>
      _safeDiv(pasivosTotales, activosTotales) * 100;

  /// 🟡 Ratio Patrimonial = Patrimonio / (Activos + Pasivos)
  static double get ratioPatrimonial {
    final double patrimonio = _toNum(patrimonioTotales);
    final double activos = _toNum(activosTotales);
    final double pasivos = _toNum(pasivosTotales);
    return _safeDiv(patrimonio, activos + pasivos) * 100;
  }

  /// 🟣 Eficiencia Mensual = (Ingreso_Mensual / (Ingreso_Anual / 12))
  static double get eficienciaMensual =>
      _safeDiv(ingresosAnual == 0 ? 0 : (ingresosAnual / 12), ingresosAnual) *
      100;

  /// 🟢 Crecimiento del Ingreso = (Ingreso Anual - Ingreso Anual Previo) / Ingreso Anual Previo
  static double get crecimientoIngreso =>
      _safeDiv(ingresosAnual - ingresosAnualPrevio, ingresosAnualPrevio) * 100;

  /// 🔴 Crecimiento del Egreso = (Egreso Anual - Egreso Anual Previo) / Egreso Anual Previo
  static double get crecimientoEgreso =>
      _safeDiv(egresosAnual - egresosAnualPrevio, egresosAnualPrevio) * 100;

  /// 🟢 Rentabilidad sobre Patrimonio = Balance / Patrimonio
  static double get rentabilidadPatrimonial =>
      _safeDiv(balanceGlobal, patrimonioTotales) * 100;

  // =======================================================
  // 🔹 CATEGORÍAS BASE (para los labels existentes)
  static var Categorias = [
    'Ingresos Registrados',
    'Egresos Registrados',
    'Ingreso Global',
    'Egreso Global',
    'Balance Global',
  ];

  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  static void actualizarDesdeMapa(Map<String, dynamic> stats) {
    ingresosTotales = _toNum(stats['Ingreso_Global']);
    egresosTotales = _toNum(stats['Egreso_Global']);
    activosTotales = _toNum(stats['Activos_Registrados']);
    pasivosTotales = _toNum(stats['Pasivos_Registrados']);
    patrimonioTotales = _toNum(stats['Patrimonio']);
    balanceGlobal = _toNum(stats['Balance_Global']);
  }

  // 🔄 Actualizar desde registros crudos
  static void actualizarDesdeActivos(List registros) {
    ingresosTotales = 0;
    egresosTotales = 0;
    activosTotales = 0;
    pasivosTotales = 0;
    patrimonioTotales = 0;

    for (var e in registros) {
      final tipo = (e['Tipo_Recurso'] ?? '').toString();
      final monto = _toDouble(e['Monto_Pagado']);

      switch (tipo) {
        case 'Ingresos':
          ingresosTotales += monto;
          break;
        case 'Egresos':
          egresosTotales += monto;
          break;
        case 'Activos':
          activosTotales += monto;
          break;
        case 'Pasivos':
          pasivosTotales += monto;
          break;
        case 'Patrimonio':
          patrimonioTotales += monto;
          break;
      }
    }

    balanceGlobal =
        (ingresosTotales + activosTotales) - (egresosTotales + pasivosTotales);
  }

  static _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String)
      return double.tryParse(value.replaceAll(',', '').trim()) ?? 0.0;
    return 0.0;
  }
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
    "Internet y Telefonía",
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
  /// Es el Activo Actual a tratar, determinado por ID_Financieros
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
      // Activos.fromJsonItem(Financieros.Activos);
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

  static Future<Map<String, dynamic>> getEstadisticasFinancieras() async {
    return await Actividades.detalles(Databases.siteground_database_regfine,
        getEstadisticasQuery(Activos.ID_Usuarios));
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

  static String getEstadisticasQuery(int ID_Usuario) {
    return "SELECT "
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
        "(SELECT Balance_Global - (Balance_Mensual)) AS Balance_Actual; ";
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
  }

  static void fromJsonItem(List activos) {
    // Limpieza y sumas internas
    Financieros.Ingresos.clear();
    Financieros.Egresos.clear();
    Financieros.Activos.clear();
    Financieros.Pasivos.clear();
    Financieros.Patrimonio.clear();

    for (var element in activos) {
      switch (element['Tipo_Recurso']) {
        case 'Ingresos':
          Financieros.Ingresos.add(element);
          break;
        case 'Egresos':
          Financieros.Egresos.add(element);
          break;
        case 'Activos':
          Financieros.Activos.add(element);
          break;
        case 'Pasivos':
          Financieros.Pasivos.add(element);
          break;
        case 'Patrimonio':
          Financieros.Patrimonio.add(element);
          break;
      }
    }

    // ✅ Calcula totales y balance automáticamente
    Financieros.actualizarDesdeActivos(activos);
  }
}

class FinancierosRepo extends ChangeNotifier {
  static List<dynamic>? _cache;

  static final FinancierosRepo _instance =
      FinancierosRepo._internal(); // 🧠 1️⃣ Instancia estática única
  FinancierosRepo._internal(); // 🧩 2️⃣ Constructor privado
  factory FinancierosRepo() =>
      _instance; // 🔁 3️⃣ Constructor factory que devuelve siempre la misma instancia

  // 🧰 4️⃣ Variables de estado global
  List<Map<String, dynamic>> registros = [];
  Map<String, dynamic> estadisticas = {};
  Map<String, dynamic> resultadosPredictivos = {};

  /// Abrir Hive box (cache persistente)
  Future<void> _openBox() async {
    if (!Hive.isBoxOpen('financieros')) {
      await Hive.openBox('financieros');
    }
  }

  /// Carga los registros desde JSON local (assets/activos/{id}/activos.json)
  Future<List> cargarDesdeLocal({bool force = false}) async {
    if (_cache != null && !force) return _cache!;
    final data = await Archivos.readJsonToMap(
        filePath: "${Financieros.localRepositoryPath}activos.json");
    _cache = data;
    return data;
  }

  /// Sincroniza con la BD remota y guarda el JSON local + Hive
  Future<void> sincronizarRemoto() async {
    final data = await Actividades.consultarAllById(
      Databases.siteground_database_regfine,
      Activos.activos['consultIdQuery'],
      Financieros.ID_Financieros,
    );
    Financieros.Activos = registros = List<Map<String, dynamic>>.from(data);
    await Archivos.createJsonFromMap(data, filePath: Activos.fileAssocieted);
    final box = await Hive.openBox('financieros');
    await box.put('registros', data);
    notifyListeners();
  }

  /// Calcula estadísticas locales sin depender del backend SQL
  Future<Map<String, dynamic>> calcularEstadisticasLocales() async {
    double ingreso = 0, egreso = 0, activos = 0, pasivos = 0;
    for (final item in registros) {
      final tipo = item['Tipo_Recurso'];
      final monto = double.tryParse(item['Monto_Pagado'].toString()) ?? 0;
      switch (tipo) {
        case 'Ingresos':
          ingreso += monto;
          break;
        case 'Egresos':
          egreso += monto;
          break;
        case 'Activos':
          activos += monto;
          break;
        case 'Pasivos':
          pasivos += monto;
          break;
      }
    }
    final balance = ingreso - egreso;
    final patrimonio = (ingreso + activos) - (egreso + pasivos);

    estadisticas = {
      'Ingreso_Global': ingreso,
      'Egreso_Global': egreso,
      'Balance_Global': balance,
      'Activos_Global': activos,
      'Pasivos_Global': pasivos,
      'Patrimonio': patrimonio,
    };

    await Archivos.createJsonFromMap([estadisticas],
        filePath: Activos.fileStadistics);
    notifyListeners();
    return estadisticas;
  }

  /// Consulta las estadísticas desde el servidor remoto
  Future<Map<String, dynamic>> obtenerEstadisticasRemotas() async {
    final data = await Actividades.detalles(
      Databases.siteground_database_regfine,
      Activos.activos['activosStadistics'],
    );
    estadisticas = Map<String, dynamic>.from(data);
    await Archivos.createJsonFromMap([estadisticas],
        filePath: Activos.fileStadistics);
    final box = await Hive.openBox('financieros');
    await box.put('estadisticas', estadisticas);
    notifyListeners();
    return estadisticas;
  }

  /// Carga estadísticas desde Hive o JSON
  Future<Map<String, dynamic>> cargarEstadisticasCache() async {
    await _openBox();
    final box = Hive.box('financieros');
    if (box.containsKey('estadisticas')) {
      estadisticas = Map<String, dynamic>.from(box.get('estadisticas'));
    } else {
      final local =
          await Archivos.readJsonToMap(filePath: Activos.fileStadistics);
      if (local.isNotEmpty) estadisticas = local.first;
    }
    notifyListeners();
    return estadisticas;
  }

  /// Reiniciar / forzar actualización (combina todo)
  Future<void> reiniciar({bool remoto = false}) async {
    if (remoto) {
      await sincronizarRemoto();
      await obtenerEstadisticasRemotas();
    } else {
      await cargarDesdeLocal();
      await calcularEstadisticasLocales();
    }
  }

  //
  /// 📆 Devuelve una lista con los montos totales por mes
  List<double> historialMensual(String tipoRecurso) {
    if (registros.isEmpty) return [];

    final Map<String, double> totales = {};

    for (var reg in registros) {
      final tipo = (reg['Tipo_Recurso'] ?? '').toString().toLowerCase();
      if (!tipo.contains(tipoRecurso.toLowerCase())) continue;

      final fechaStr = reg['Fecha_Pago_Programado']?.toString() ?? '';
      final monto = double.tryParse(reg['Monto_Pagado'].toString()) ?? 0;
      final fecha = DateTime.tryParse(fechaStr);
      if (fecha == null) continue;

      final clave = '${fecha.year}-${fecha.month.toString().padLeft(2, '0')}';
      totales[clave] = (totales[clave] ?? 0) + monto;
    }

    // 🔹 Convertir a lista ordenada por fecha
    final ordenado = totales.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    // 🔹 Devolver solo los montos
    return ordenado.map((e) => e.value).toList();
  }

  DateTime obtenerUltimaFecha(String tipo1, String tipo2) {
    final registros = FinancierosRepo().registros;

    if (registros.isEmpty) return DateTime.now();

    final fechas = registros
        .map((e) => DateTime.tryParse(e['Fecha_Pago_Programado'].toString()))
        .where((f) => f != null)
        .cast<DateTime>()
        .toList();

    if (fechas.isEmpty) return DateTime.now();

    fechas.sort();
    return fechas.last;
  }
}

class FinancierosAnalisis {
  // ---------------------------------------------------------------
  /// 🔸 Conversión segura a double
  static double _toDouble(dynamic v) => double.tryParse(v.toString()) ?? 0.0;

  /// 🔸 División segura para evitar NaN o infinito
  static double _safeDiv(double a, double b) => (b == 0) ? 0 : a / b;
  // ---------------------------------------------------------------

  /// 🧩 Clasifica un concepto en su tipo de recurso principal
  static String clasificarTipo(String concepto) {
    final c = concepto.toLowerCase();
    if (Activos.conceptoIngresos.any((e) => c.contains(e.toLowerCase())))
      return 'Ingresos';
    if (Activos.conceptoEgresos.any((e) => c.contains(e.toLowerCase())))
      return 'Egresos';
    if (Activos.conceptoActivos.any((e) => c.contains(e.toLowerCase())))
      return 'Activos';
    if (Activos.conceptoPasivos.any((e) => c.contains(e.toLowerCase())))
      return 'Pasivos';
    return 'Desconocido';
  }

  // ---------------------------------------------------------------
  // 🔹 ANÁLISIS DE FLUJOS
  // ---------------------------------------------------------------

  /// 💧 Liquidez Real = Ingresos - Pasivos
  static double liquidezReal({
    double? ingresos,
    double? pasivos,
  }) {
    ingresos ??= Financieros.ingresosTotales ?? 0;
    pasivos ??= Financieros.pasivosTotales ?? 0;
    return ingresos - pasivos;
  }

  /// 📉 Elasticidad Financiera = Egresos / Ingresos
  static double elasticidadFinanciera({
    double? ingresos,
    double? egresos,
  }) {
    ingresos ??= Financieros.ingresosTotales ?? 0;
    egresos ??= Financieros.egresosTotales ?? 0;
    return _safeDiv(egresos, ingresos) * 100;
  }

  /// 💡 Capacidad de Inversión = Ingresos - (Egresos + Pasivos)
  static double capacidadInversion({
    double? ingresos,
    double? egresos,
    double? pasivos,
  }) {
    ingresos ??= Financieros.ingresosTotales ?? 0;
    egresos ??= Financieros.egresosTotales ?? 0;
    pasivos ??= Financieros.pasivosTotales ?? 0;
    return ingresos - (egresos + pasivos);
  }

  /// ⚖️ Balance Patrimonial = Activos - Pasivos
  static double balancePatrimonial({
    double? activos,
    double? pasivos,
  }) {
    activos ??= Financieros.activosTotales ?? 0;
    pasivos ??= Financieros.pasivosTotales ?? 0;
    return activos - pasivos;
  }

  /// 📈 Dependencia Vital = Pasivos / Ingresos
  static double dependenciaVital({
    double? ingresos,
    double? pasivos,
  }) {
    ingresos ??= Financieros.ingresosTotales ?? 0;
    pasivos ??= Financieros.pasivosTotales ?? 0;
    return _safeDiv(pasivos, ingresos) * 100;
  }

  /// 🟩 Punto de Equilibrio Vital = promedio mensual de pasivos
  static double puntoEquilibrioVital(List registros) {
    final pasivos = registros.where((r) =>
        (r['Tipo_Recurso'] ?? '').toString().toLowerCase().contains('pasivo'));
    return pasivos.fold(0, (sum, e) => sum + _toDouble(e['Monto_Pagado']));
  }

  // ---------------------------------------------------------------
  // 🔹 ANÁLISIS DE RENDIMIENTO
  // ---------------------------------------------------------------

  /// 💰 Rentabilidad Patrimonial = Balance Global / Patrimonio
  static double rentabilidadPatrimonial({
    double? balanceGlobal,
    double? patrimonio,
  }) {
    balanceGlobal ??= Financieros.egresosTotales ?? 0;
    patrimonio ??= Financieros.patrimonioTotales ?? 0;
    return _safeDiv(balanceGlobal, patrimonio) * 100;
  }

  /// 📊 Margen Neto = Balance Global / Ingreso Global
  static double margenNeto({
    double? ingresos,
    double? balance,
  }) {
    ingresos ??= Financieros.ingresosTotales ?? 0;
    balance ??=
        (Financieros.ingresosTotales ?? 0) - (Financieros.egresosTotales ?? 0);
    return _safeDiv(balance, ingresos) * 100;
  }

  /// 🧭 Ratio Patrimonial = Patrimonio / (Activos + Pasivos)
  static double ratioPatrimonial({
    double? activos,
    double? pasivos,
    double? patrimonio,
  }) {
    activos ??= Financieros.activosTotales ?? 0;
    pasivos ??= Financieros.pasivosTotales ?? 0;
    patrimonio ??= Financieros.patrimonioTotales ?? 0;
    return _safeDiv(patrimonio, (activos + pasivos)) * 100;
  }

  // ---------------------------------------------------------------
  // 🔹 ANÁLISIS DE RIESGO Y TENDENCIA
  // ---------------------------------------------------------------

  /// 🧮 Riesgo de Liquidez = Egresos + Pasivos - Ingresos
  static double riesgoLiquidez({
    double? ingresos,
    double? egresos,
    double? pasivos,
  }) {
    ingresos ??= Financieros.ingresosTotales ?? 0;
    egresos ??= Financieros.egresosTotales ?? 0;
    pasivos ??= Financieros.pasivosTotales ?? 0;
    return (egresos + pasivos) - ingresos;
  }

  /// 🔁 Tendencia de Crecimiento = Δ Ingresos últimos 2 períodos
  static double crecimientoIngresos({
    double? actual,
    double? previo,
  }) {
    actual ??= Financieros.ingresosAnual ?? 0;
    previo ??= Financieros.ingresosAnualPrevio ?? 0;
    return _safeDiv(actual - previo, previo) * 100;
  }

  /// 🔻 Índice de Endeudamiento = Pasivos / Patrimonio
  static double endeudamiento({
    double? pasivos,
    double? patrimonio,
  }) {
    pasivos ??= Financieros.pasivosTotales ?? 0;
    patrimonio ??= Financieros.patrimonioTotales ?? 0;
    return _safeDiv(pasivos, patrimonio) * 100;
  }

  // ---------------------------------------------------------------
  // 🔹 INTERPRETACIONES SEMÁNTICAS
  // ---------------------------------------------------------------

  static String interpretarLiquidez(double valor) {
    if (valor > 0) return "Liquidez positiva: buena gestión del flujo.";
    if (valor == 0) return "Liquidez neutra: equilibrio exacto.";
    return "Liquidez negativa: exceso de gasto o pasivo.";
  }

  static String interpretarEndeudamiento(double tasa) {
    if (tasa < 20) return "Zona verde (saludable)";
    if (tasa < 35) return "Zona amarilla (precaución)";
    return "Zona roja (riesgo alto)";
  }

  //
  static Future<void> calcularProyeccion() async {
    try {
      // 1️⃣ Esperar a que los registros estén cargados
      final repo = FinancierosRepo();
      if (repo.registros.isEmpty) {
        debugPrint(
            "⏳ [FinancierosAnalisis] Sin registros disponibles, omitiendo proyección.");
        return;
      }

      // 2️⃣ Esperar microtask para liberar el frame actual
      await Future.delayed(Duration(milliseconds: 50));

      // 3️⃣ Obtener los historiales
      final ingresos = repo.historialMensual('Ingresos');
      final egresos = repo.historialMensual('Egresos');

      if (ingresos.isEmpty || egresos.isEmpty) {
        debugPrint(
            "⚠️ [FinancierosAnalisis] Datos insuficientes para proyección.");
        return;
      }

      // 4️⃣ Calcular la proyección (usando tu clase predictiva)
      final proy = FinancierosPredictivo.proyectarFlujo(ingresos, egresos);
      final ind = FinancierosPredictivo.indicadores(
        ingresoProy: proy['ingresoProyectado']!,
        egresoProy: proy['egresoProyectado']!,
        pasivosActuales: Financieros.pasivosTotales ?? 0,
      );

      debugPrint(
          "✅ [FinancierosAnalisis] Proyección calculada correctamente: $proy");
      debugPrint("📊 Indicadores: $ind");

      // 5️⃣ Guardar o exponer si hace falta
      // repo.resultadosPredictivos = {
      //   'proyeccion': proy,
      //   'indicadores': ind,
      // };
    } catch (e, s) {
      debugPrint("❌ [FinancierosAnalisis] Error en calcularProyeccion: $e\n$s");
    }
  }
}

class FinancierosPredictivo {
  /// 🧮 Suavizamiento exponencial simple
  static double suavizar(List<double> datos, {double alpha = 0.4}) {
    if (datos.isEmpty) return 0;
    double pred = datos.first;
    for (var i = 1; i < datos.length; i++) {
      pred = alpha * datos[i] + (1 - alpha) * pred;
    }
    return pred;
  }

  /// 🔹 Proyecta ingresos y egresos mensuales
  static Map<String, double> proyectarFlujo(
      List<double> ingresosMensuales, List<double> egresosMensuales,
      {double alpha = 0.4}) {
    final ingresoProyectado = suavizar(ingresosMensuales, alpha: alpha);
    final egresoProyectado = suavizar(egresosMensuales, alpha: alpha);
    final liquidez = ingresoProyectado - egresoProyectado;
    return {
      'ingresoProyectado': ingresoProyectado,
      'egresoProyectado': egresoProyectado,
      'liquidezProyectada': liquidez,
    };
  }

  /// 💸 Calcula indicadores predictivos
  static Map<String, double> indicadores({
    required double ingresoProy,
    required double egresoProy,
    required double pasivosActuales,
  }) {
    final liquidezFutura = egresoProy == 0 ? 0 : ingresoProy / egresoProy;
    final riesgoDeficit = (egresoProy - ingresoProy) / ingresoProy * 100;
    final capacidadEndeudamiento = ingresoProy * 0.35 - pasivosActuales;
    final margenDisponible = ingresoProy - (egresoProy + pasivosActuales);

    return {
      'liquidezFutura': liquidezFutura.toDouble(),
      'riesgoDeficit': riesgoDeficit,
      'capacidadEndeudamiento': capacidadEndeudamiento,
      'margenDisponible': margenDisponible,
    };
  }
}
