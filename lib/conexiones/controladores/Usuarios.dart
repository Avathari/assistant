class Usuarios {
  Usuarios(nombre, apellidoPaterno, apellidoMaterno, imagenUsuario) {
    Usuarios.nombreCompleto = "$apellidoPaterno $apellidoMaterno $nombre";
    Usuarios.imagenUsuario = "$imagenUsuario";
  }

  Usuarios.fromJson(Map json) {
    nombreCompleto =
        "${json['Us_Ape_Pat']} ${json['Us_Ape_Pat']} ${json['Us_Nome']}";
    imagenUsuario = json['Us_Fiat'];
  }
  static int ID_Usuario = 0;

  static String? nombreCompleto;
  static String? imagenUsuario;

  static Map<String, dynamic> Usuario = {};

  static final List<String> Categorias = [
    "Administrador",
    "Médico Interno de Pregrado",
    "Médico Pasante de Servicio Social",
    "Medicina General",
    "Médico Especialista",
    "Técnico(a) en Enfermería General",
    "Enfermería General",
    "Enfermería Especialista",
    "Técnico(a) Asistenciales",
    "Secretarías",
    "Capturistas de Datos",
    "Ingenieros y Programadores",
    "Administradores y Directivos",
    "Guardías de Seguridad",
    "Especialistas en Logística y Límpieza",
    "Encargados de Mantenimiento de Equipos y Áreas",
    "Servicios de Traslados Intrahospitalarios",
    "Servicios de Traslados Extrahospitalarios"
  ];
  static final List<String> Permisos = [
    "Administrador",
    "Médico Interno de Pregrado",
    "Médico Pasante de Servicio Social",
    "Médico General",
    "Médico Especialista",
    "Directivo",
    "Enfermería General",
    "Enfermería Especialista",
    "Jefatura de Enfermería",
    "Capturista"
  ];
  static final List<String> Areas = [
    "Medicina General",
    "Medicina Interna",
    "Cirugía General",
    "Pediatría",
    "Ginecología y Obstetricia",
    "Anestesiología",
    "Alergología",
    "Reumatología",
    "Cardiología",
    "Medicina Física y Rehabilitación",
    "Radiología e Imagenología",
    "Neonatología",
    "Infectología",
    "Neumología",
    "Cirugía de Columna",
    "Neurocirugía",
    "Neurología",
    // "----------------------------------------",
    "Enfermería Asistencial",
    "Técnico(a) en Enfermería General",
    "Enfermería General",
    "Enfermería Quirúrgica",
    "Enfermería Ginecoobstetra",
    "Enfermería Pediátrica",
    //"----------------------------------------",
    "Secretarías y Capturistas de Datos",
    "Servicios de Mantenimiento y Logística",
    "Ambulancias y Camilleros",
    "Contadores y Administradores",
    "Abodados",
    "Directores y Sub-Directores"
  ];
  static final List<String> Status = [
    "Activo",
    "Inactivo",
  ];

  static final Map<String, dynamic> usuarios = {
    "createDatabase": "CREATE DATABASE IF NOT EXISTS `bd_regusua` "
        "DEFAULT CHARACTER SET utf8 "
        "COLLATE utf8_unicode_ci;",
    "showTables": "SHOW tables;",
    "dropDatabase": "DROP DATABASE `bd_regusua`",
    "describeTable": "DESCRIBE usuarios;",
    "showColumns": "SHOW columns FROM usuarios",
    "showInformation":
        "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_name = 'usuarios'",
    "createQuery": """CREATE TABLE `usuarios` (
              `ID_Usuario` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
              `Us_Nome` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Us_Ape_Pat` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Us_Ape_Mat` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Us_Usuario` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Us_Passe` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Us_Permi` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Us_EspeL` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Us_Area` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Us_Stat` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Us_Fiat` longblob NOT NULL,
              `Usu_ADAM_AGE` varchar(200) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
            COMMENT='En esta Tabla se agregan los usuarios que usan el Sistema';""",
    "truncateQuery": "TRUNCATE usuarios",
    "dropQuery": "DROP TABLE usuarios",
    "consultQuery": "SELECT ID_Usuario, Us_Nome, Us_Ape_Pat, Us_Ape_Mat, "
        "Us_Usuario, from_base64(Us_Passe) as Us_Passe, "
        "Us_Permi, Us_EspeL, "
        "Us_Area, Us_Stat, "
        "Us_Fiat, "
        "Usu_ADAM_AGE FROM usuarios",
    "consultIdQuery": "SELECT ID_Usuario, Us_Nome, Us_Ape_Pat, Us_Ape_Mat, "
        "Us_Usuario, from_base64(Us_Passe) as Us_Passe, "
        "Us_Permi, Us_EspeL, "
        "Us_Area, Us_Stat, "
        "Us_Fiat, "
        "Usu_ADAM_AGE FROM usuarios WHERE ID_Usuario = ?",
    "consultAllIdsQuery": "SELECT ID_Usuario FROM usuarios",
    "consultLastQuery": "SELECT * FROM usuarios ORDER BY ID_Usuario DESC",
    "consultByName": "SELECT Us_Fiat FROM usuarios WHERE Us_Nome LIKE '%",
    "registerQuery": "INSERT INTO usuarios (Us_Nome, Us_Ape_Pat, Us_Ape_Mat, "
        "Us_Usuario, Us_Passe, "
        "Us_Permi, Us_EspeL, Us_Area, Us_Stat, "
        "Us_Fiat, "
        "Usu_ADAM_AGE) "
        "VALUES (?,?,?,?,to_base64(?),?,?,?,?,from_base64(?),?)",
    "updateQuery":
        "UPDATE usuarios SET ID_Usuario = ?, Us_Nome = ?, Us_Ape_Pat = ?, Us_Ape_Mat = ?, "
            "Us_Usuario = ?, Us_Passe = to_base64(?), "
            "Us_Permi = ?, Us_EspeL = ?, Us_Area = ?, Us_Stat = ?, "
            "Us_Fiat = from_base64(?), "
            "Usu_ADAM_AGE = ? WHERE ID_Usuario = ?",
    "deleteQuery": "DELETE FROM usuarios WHERE ID_Usuario = ?",
    "usuariosColumns": [
      "ID_Usuario",
      "Us_Nome",
      "Us_Ape_Pat",
      "Us_Ape_Mat",
      "Us_Usuario",
      "Us_Passe",
      "Us_Permi",
      "Us_EspeL",
      "Us_Area",
      "Us_Stat",
      "Us_Fiat",
      "Usu_ADAM_AGE"
    ],
    "usuariosItems": [
      "ID_Usuario",
      "Nombre_Completo",
      "Apellido_Paterno",
      "Apellido_Materno",
      "Usuario",
      "Contraseña",
      "Permisos",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado_por"
    ],
    "usuariosColums": [
      "ID Usuario",
      "Nombre Completo",
      "Apellido Paterno",
      "Apellido Materno",
      "Usuario",
      "Contraseña",
      "Permiso(s)",
      "Especialización",
      "Area",
      "Estatus",
      "Anexado Por"
    ],
    "usuariosStats": [
      "Total_Administradores",
      "Total_Mip",
      "Total_Mpss",
      "Total_Mg",
      "Total_Medesp",
      "Total_Tegra",
      "Total_Enfra",
      "Total_Enfesp",
      "Total_Tec",
      "Total_Secre",
      "Total_Captu",
      "Total_Inge",
      "Total_Directivos",
      "Total_Guardias",
      "Total_Logistica",
      "Total_Mantenimiento",
      "Total_Traslado_Intra",
      "otal_Traslado_Extra",
    ],
    "usuariosStadistics": "SELECT "
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[0]}') as Total_Administradores,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[1]}') as Total_Mip,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[2]}') as Total_Mpss,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[3]}') as Total_Mg,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[4]}') as Total_Medesp,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[5]}') as Total_Tegra,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[6]}') as Total_Enfra,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[7]}') as Total_Enfesp,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[8]}') as Total_Tec,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[9]}') as Total_Secre,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[10]}') as Total_Captu,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[11]}') as Total_Inge,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[12]}') as Total_Directivos,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[13]}') as Total_Guardias,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[14]}') as Total_Logistica,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[15]}') as Total_Mantenimiento,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[16]}') as Total_Traslado_Intra,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Permi` = '${Usuarios.Categorias[17]}') as Total_Traslado_Extra,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Stat` = 'Activo') as Total_Activos,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios WHERE `Us_Stat` = 'Inactivo') as Total_Inactivos,"
        "(SELECT IFNULL(count(*), 0) FROM bd_regusua.usuarios) as Total_Usuarios;"
  };
}
