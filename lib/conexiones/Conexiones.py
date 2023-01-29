# Controladores de Bases de Datos < bd_ >
class Controladores:
    class Actividades:
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regfarma` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        show_information = "SELECT column_name, data_type, is_nullable, " \
                           "column_default  " \
                           "FROM information_schema.columns " \
                           "WHERE table_name = 'farma_iden'"
        drop_database = "DROP DATABASE `bd_regfarma`"

        class Actividades:
            Actividades = ['ID_Actividades', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                           'Variedad',
                           'PVP', 'Foto_Vino']
            cols_enologias = ['ID Actividades', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_iden;"
            show_columns = "SHOW columns FROM farma_iden"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_iden'"

            create_Query = """CREATE TABLE `farma_iden` (
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
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='En esta Tabla se agregan los sara_iden_iden que usan el Sistema';"""
            consult_Query = "SELECT * FROM farma_iden"
            consult_ids_Query = "SELECT ID_Actividades FROM farma_iden"
            consult_partial_Query = "SELECT ID_Actividades, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                    "Crianza, Variedad, PVP FROM farma_iden "
            consult_last_Query = "SELECT * FROM farma_iden ORDER BY ID_Actividades DESC"
            consult_last_partial_Query = "SELECT ID_Actividades, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                                         "Sara_Ape_Mat " \
                                         "FROM farma_iden ORDER BY ID_Sara DESC"
            consult_id_Query = "SELECT ID_Actividades, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                               "Sara_Ape_Mat FROM farma_iden WHERE ID_Sara = "
            consult_name_Query = "SELECT ID_Actividades, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                 "Crianza, PVP Variedad FROM farma_iden WHERE VinoNombre LIKE '%"
            consult_photo_Query = "SELECT Foto_Vino FROM farma_iden"
            consult_photo_id_Query = "SELECT Foto_Vino FROM farma_iden WHERE ID_Actividades = "
            consult_photo_name_Query = "SELECT Foto_Vino FROM farma_iden WHERE Us_Nome LIKE '%"
            register_Query = "INSERT INTO farma_iden (ID_Actividades, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                             "Crianza, PVP) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            register_photo_Query = "INSERT INTO farma_iden (ID_Actividades, VinoNombre," \
                                   " MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                   "Crianza, PVP, Foto_Vino) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s"
            update_id_Query = "UPDATE farma_iden SET ID_Actividades = %s, " \
                              "ID_Actividades = %s, VinoNombre = %s, MarcaVino = %s, Bodega = %s, Volumen = %s, " \
                              "ZonaCrianza = %s, " \
                              "Crianza, PVP = %s WHERE ID_Sara = "
            delete_Query = "DELETE FROM farma_iden WHERE ID_Actividades = "
            truncate_table_Query = "TRUNCATE farma_iden"
            drop_table_Query = "DROP TABLE farma_iden"

    class Farmacos:
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regfarma` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        show_information = "SELECT column_name, data_type, is_nullable, " \
                           "column_default  " \
                           "FROM information_schema.columns " \
                           "WHERE table_name = 'farma_iden'"
        drop_database = "DROP DATABASE `bd_regfarma`"

        class Farmacos:
            Farmacos = ['ID_Farmacos', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                        'Variedad',
                        'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Farmacos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_iden;"
            show_columns = "SHOW columns FROM farma_iden"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_iden'"

            create_Query = """CREATE TABLE `farma_iden` (
                  `ID_Farmacos` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `NombreFarmaco` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `FormulaQuimica` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
                  `GrupoFarmacologico` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `SubGrupoFarmacologico` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `PrincipioActivo` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `SubTipoFarmacologico` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Foto_Farmaco` longblob NOT NULL
                ) ENGINE=InnoDB 
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='En esta Tabla se agregan los datos generales de los fármacos';"""
            consult_Query = "SELECT * FROM farma_iden"
            consult_ids_Query = "SELECT ID_Farmacos FROM farma_iden"
            consult_partial_Query = "SELECT ID_Farmacos, NombreFarmaco, " \
                                    "FormulaQuimica, GrupoFarmacologico, SubGrupoFarmacologico, " \
                                    "PrincipioActivo, SubTipoFarmacologico FROM farma_iden "
            consult_last_Query = "SELECT * FROM farma_iden ORDER BY ID_Farmacos DESC"
            consult_last_partial_Query = "SELECT ID_Farmacos, NombreFarmaco, " \
                                         "FormulaQuimica, GrupoFarmacologico, SubGrupoFarmacologico, " \
                                         "PrincipioActivo, SubTipoFarmacologico " \
                                         "FROM farma_iden ORDER BY ID_Farmacos DESC"
            consult_id_Query = "SELECT ID_Farmacos, NombreFarmaco, " \
                               "FormulaQuimica, GrupoFarmacologico, SubGrupoFarmacologico, " \
                               "PrincipioActivo, SubTipoFarmacologico " \
                               "FROM farma_iden WHERE ID_Farmacos = "
            consult_name_Query = "SELECT ID_Farmacos, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                 "Crianza, PVP Variedad FROM farma_iden WHERE VinoNombre LIKE '%"
            consult_photo_Query = "SELECT Foto_Farmaco FROM farma_iden"
            consult_photo_id_Query = "SELECT Foto_Farmaco " \
                                     "FROM farma_iden WHERE ID_Farmacos = "
            consult_photo_name_Query = "SELECT Foto_Farmaco " \
                                       "FROM farma_iden WHERE NombreFarmaco LIKE '%"
            register_Query = "INSERT INTO farma_iden (NombreFarmaco, " \
                             "FormulaQuimica, GrupoFarmacologico, SubGrupoFarmacologico, " \
                             "PrincipioActivo, SubTipoFarmacologico) " \
                             "VALUES (%s,%s,%s,%s,%s,%s)"
            register_photo_Query = "INSERT INTO farma_iden (NombreFarmaco, " \
                                   "FormulaQuimica, GrupoFarmacologico, SubGrupoFarmacologico, " \
                                   "PrincipioActivo, SubTipoFarmacologico, Foto_Farmaco) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE farma_iden " \
                              "SET ID_Farmacos = %s, NombreFarmaco = %s, " \
                              "FormulaQuimica = %s, GrupoFarmacologico = %s, " \
                              "SubGrupoFarmacologico = %s, PrincipioActivo = %s, " \
                              "SubTipoFarmacologico = %s " \
                              "WHERE ID_Farmacos = "
            update_id_photo_Query = "UPDATE farma_iden " \
                                    "SET ID_Farmacos = %s, NombreFarmaco = %s, " \
                                    "FormulaQuimica = %s, GrupoFarmacologico = %s, " \
                                    "SubGrupoFarmacologico = %s, PrincipioActivo = %s, " \
                                    "SubTipoFarmacologico = %s, Foto_Farmaco = %s " \
                                    "WHERE ID_Farmacos = "
            delete_Query = "DELETE FROM farma_iden WHERE ID_Farmacos = "
            truncate_table_Query = "TRUNCATE farma_iden"
            drop_table_Query = "DROP TABLE farma_iden"

        class Generales:
            Generales = ['ID_Generales', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                         'Variedad',
                         'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Generales', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_gene;"
            show_columns = "SHOW columns FROM farma_gene"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_gene'"

            create_Query = """CREATE TABLE `farma_gene` (
                  `ID_Generales` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Farmaco` int(11) NOT NULL,
                  `Descripcion_General` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
                  `Contraindicaciones` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
                  `Precauciones_Generales` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
                  `Categoria_Embarazo` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
                  `Categoria_Lactancia` varchar(800) COLLATE utf8_unicode_ci NOT NULL, 
                  `Riesgos_Asociados` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
                  `Recomendaciones_Almacenamiento` varchar(800) COLLATE utf8_unicode_ci NOT NULL, 
                  `Manejo_Sobredosificacion` varchar(800) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 
            COLLATE=utf8_unicode_ci 
            COMMENT='Tabla para Registro de Principios Generales.';
            """
            consult_Query = "SELECT * FROM farma_gene"
            consult_ids_Query = "SELECT ID_Generales FROM farma_gene"
            consult_id_Query = "SELECT * FROM farma_gene WHERE ID_Generales = "
            register_Query = "INSERT INTO farma_gene (ID_Farmaco, " \
                             "Descripcion_General, Contraindicaciones, " \
                             "Precauciones_Generales, Categoria_Embarazo, Categoria_Lactancia, " \
                             "Riesgos_Asociados, Recomendaciones_Almacenamiento, Manejo_Sobredosificacion) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE farma_gene SET ID_Generales= %s, ID_Farmaco= %s, " \
                              "Descripcion_General= %s, Contraindicaciones= %s, Precauciones_Generales= %s, " \
                              "Categoria_Embarazo= %s, Categoria_Lactancia= %s, " \
                              "Riesgos_Asociados= %s, Recomendaciones_Almacenamiento= %s, Manejo_Sobredosificacion= %s " \
                              "WHERE ID_Generales = "
            delete_Query = "DELETE FROM farma_gene WHERE ID_Generales = "
            truncate_table_Query = "TRUNCATE farma_gene"
            drop_table_Query = "DROP TABLE farma_gene"

        class Activos:
            Activos = ['ID_Activo', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                       'Variedad',
                       'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Activos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_act;"
            show_columns = "SHOW columns FROM farma_act"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_act'"

            create_Query = """CREATE TABLE `farma_act` (
                  `ID_Activo` int(11) NOT NULL,
                  `ID_Farmaco` int(11) NOT NULL,
                  `PrincipioActivo` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `MecanismoMetabolismo` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
                  `Biodisponibilidad` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
                  `BiodisponibilidadAbsoluta` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
                  `BiodisponibilidadRelativa` varchar(10) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Principios Activos.';
            """
            consult_Query = "SELECT * FROM farma_act"
            consult_ids_Query = "SELECT ID_Activo FROM farma_act"
            consult_id_Query = "SELECT * FROM farma_act WHERE ID_Activo = "
            register_Query = "INSERT INTO farma_act (ID_Farmaco, " \
                             "PrincipioActivo, MecanismoMetabolismo, " \
                             "Biodisponibilidad, BiodisponibilidadAbsoluta, BiodisponibilidadRelativa) " \
                             "VALUES (%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE farma_act SET ID_Activo= %s, ID_Farmaco= %s, " \
                              "PrincipioActivo= %s, MecanismoMetabolismo= %s, Biodisponibilidad= %s, " \
                              "BiodisponibilidadAbsoluta= %s, BiodisponibilidadRelativa= %s " \
                              "WHERE ID_Activo = "
            delete_Query = "DELETE FROM farma_act WHERE ID_Activo = "
            truncate_table_Query = "TRUNCATE farma_act"
            drop_table_Query = "DROP TABLE farma_act"

        class Dosis:
            Dosis = ['ID_Dosis', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                     'Variedad',
                     'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Dosis', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_dose;"
            show_columns = "SHOW columns FROM farma_dose"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_dose'"

            create_Query = """CREATE TABLE `farma_dose` (
                  `ID_Dosis` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Farmaco` int(11) NOT NULL,
                  `IndicacionTerapeutica` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `DosisInicial` int(11) NOT NULL,
                  `ViaDeterminada` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
                  `DosisMinima` int(11) NOT NULL,
                  `DosisMaxima` int(11) NOT NULL,
                  `UnidadMedida` varchar(100) COLLATE utf8_unicode_ci NOT NULL, 
                  `AumentoUnidadMedida` int(11) NOT NULL,
                  `Horario` varchar(100) COLLATE utf8_unicode_ci NOT NULL, 
                  `Comentario` varchar(800) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT 
                CHARSET=utf8 COLLATE=utf8_unicode_ci 
                COMMENT='En esta Tabla se agregan los rangos de dosificación del Fármaco';"""
            consult_Query = "SELECT * FROM farma_dose"
            consult_ids_Query = "SELECT ID_Dosis FROM farma_dose"
            consult_last_Query = "SELECT * FROM farma_dose ORDER BY ID_Dosis DESC"
            consult_id_Query = "SELECT * FROM farma_dose WHERE ID_Dosis = "
            register_Query = "INSERT INTO farma_dose (ID_Farmaco, IndicacionTerapeutica, " \
                             "DosisInicial, ViaDeterminada, DosisMinima, " \
                             "DosisMaxima, UnidadMedida, AumentoUnidadMedida, " \
                             "Horario, Comentario) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE farma_dose " \
                              "SET ID_Dosis = %s, ID_Farmaco = %s, IndicacionTerapeutica = %s, " \
                              "DosisInicial = %s, ViaDeterminada = %s, " \
                              "DosisMinima = %s, DosisMaxima = %s, " \
                              "UnidadMedida = %s, AumentoUnidadMedida = %s, " \
                              "Horario = %s, Comentario =%s " \
                              "WHERE ID_Dosis = "
            delete_Query = "DELETE FROM farma_dose WHERE ID_Dosis = "
            truncate_table_Query = "TRUNCATE farma_dose"
            drop_table_Query = "DROP TABLE farma_dose"

        class Efectos:
            Efectos = ['ID_Efectos', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                       'Variedad',
                       'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Efectos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_efe;"
            show_columns = "SHOW columns FROM farma_efe"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_efe'"

            create_Query = """CREATE TABLE `farma_efe` (
                  `ID_Efectos` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Farma` int(11) NOT NULL,
                  `SistemaAfectado` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Efecto` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Descripcion` longtext COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Registro de Efectos Farmacológicos.';
            """
            consult_Query = "SELECT * FROM farma_efe"
            consult_ids_Query = "SELECT ID_Efectos FROM farma_efe"
            consult_id_Query = "SELECT *  FROM farma_efe WHERE ID_Efectos = "
            register_Query = "INSERT INTO farma_efe (ID_Farma, SistemaAfectado, Efecto, Descripcion) " \
                             "VALUES (%s,%s,%s,%s)"
            update_id_Query = "UPDATE farma_efe SET ID_Efectos = %s, " \
                              "ID_Farma = %s, SistemaAfectado = %s, Efecto = %s, Descripcion = %s " \
                              "WHERE ID_Efectos = "
            delete_Query = "DELETE FROM farma_efe WHERE ID_Efectos = "
            truncate_table_Query = "TRUNCATE farma_efe"
            drop_table_Query = "DROP TABLE farma_efe"

        class Farmacocineticos:
            Farmacocineticos = ['ID_Farmacocineticos', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza',
                                'Crianza',
                                'Variedad',
                                'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Farmacocineticos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_fam;"
            show_columns = "SHOW columns FROM farma_fam"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_fam'"

            create_Query = """CREATE TABLE `farma_fam` (
                  `ID_Farmacocinetica` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Farma` int(11) NOT NULL,
                  `VelocidadDilucion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `CapaIonizacion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Solubilidad` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `CineticaDilucion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `ConcentracionFarmaco` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `CirculacionSitioAbsorcion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `SuperficieAbsorcion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `MecanismoDifusion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `UnionProteinas` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `VolumenDistrubucion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `TasaExcrecionPKa` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `RedistribucionTisular` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `DiferenciaConcentracionTisular` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `SuperficieRecambio` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `DificultadBarrerasNaturales` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `EstadoEquilibrioComponentesTisulares` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `VidaMediaEliminacion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `AclaramientoRenal` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `AclaramientoHepatico` varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB 
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Registro de Farmacinética del Fármaco.';
            """
            consult_Query = "SELECT * FROM farma_fam"
            consult_ids_Query = "SELECT ID_Farmacocinetica FROM farma_fam"
            consult_id_Query = "SELECT *  FROM farma_fam WHERE ID_Farma = "
            register_Query = "INSERT INTO farma_fam (ID_Farma, VelocidadDilucion, CapaIonizacion, " \
                             "Solubilidad, CineticaDilucion, ConcentracionFarmaco, CirculacionSitioAbsorcion, " \
                             "SuperficieAbsorcion, MecanismoDifusion, UnionProteinas, VolumenDistrubucion, " \
                             "TasaExcrecionPKa, RedistribucionTisular, DiferenciaConcentracionTisular, " \
                             "SuperficieRecambio, DificultadBarrerasNaturales, EstadoEquilibrioComponentesTisulares, " \
                             "VidaMediaEliminacion, AclaramientoRenal, AclaramientoHepatico) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE farma_fam SET ID_Farmacocinetica = %s, ID_Farma = %s, VelocidadDilucion = %s, " \
                              "CapaIonizacion = %s, Solubilidad = %s, CineticaDilucion = %s, ConcentracionFarmaco = " \
                              "%s, CirculacionSitioAbsorcion = %s, SuperficieAbsorcion = %s, MecanismoDifusion = %s, " \
                              "UnionProteinas = %s, VolumenDistrubucion = %s, TasaExcrecionPKa = %s, " \
                              "RedistribucionTisular = %s, DiferenciaConcentracionTisular = %s, SuperficieRecambio = " \
                              "%s, DificultadBarrerasNaturales = %s, EstadoEquilibrioComponentesTisulares = %s, " \
                              "VidaMediaEliminacion = %s, AclaramientoRenal = %s, AclaramientoHepatico = %s " \
                              "WHERE ID_Farmacocinetica = "
            delete_Query = "DELETE FROM farma_fam WHERE ID_Farmacocinetica = "
            truncate_table_Query = "TRUNCATE farma_fam"
            drop_table_Query = "DROP TABLE farma_fam"

        class Farmacodinamia:
            Farmacodinamia = ['ID_Farmacodinamia', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza',
                              'Crianza',
                              'Variedad',
                              'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Farmacodinamia', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_dinam;"
            show_columns = "SHOW columns FROM farma_dinam"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_dinam'"

            create_Query = """CREATE TABLE `farma_dinam` (
                  `ID_Farmacodinamia` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Farmaco` int(11) NOT NULL,
                  `DosisToxica` double NOT NULL,
                  `DosisLetal` double NOT NULL,
                  `DosisEfectiva` double NOT NULL,
                  `DosisIneficaz` double NOT NULL,
                  `Horario` varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT 
                CHARSET=utf8 COLLATE=utf8_unicode_ci 
                COMMENT='En esta Tabla se agregan los rangos de dosificación del Fármaco';"""
            consult_Query = "SELECT * FROM farma_dinam"
            consult_ids_Query = "SELECT ID_Farmacodinamia FROM farma_dinam"
            consult_last_Query = "SELECT * FROM farma_dinam ORDER BY ID_Farmacodinamia DESC"
            consult_id_Query = "SELECT * FROM farma_dinam WHERE ID_Farmaco = "
            register_Query = "INSERT INTO farma_dinam (ID_Farmaco, " \
                             "DosisToxica, DosisLetal, DosisEfectiva, " \
                             "DosisIneficaz) " \
                             "VALUES (%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE farma_dinam " \
                              "SET ID_Farmacodinamia = %s, ID_Farmaco = %s, " \
                              "DosisToxica = %s, " \
                              "DosisLetal = %s, DosisEfectiva = %s, " \
                              "DosisIneficaz = %s " \
                              "WHERE ID_Farmacodinamia = "
            delete_Query = "DELETE FROM farma_dinam WHERE ID_Farmacodinamia = "
            truncate_table_Query = "TRUNCATE farma_dinam"
            drop_table_Query = "DROP TABLE farma_dinam"

        class Interacciones:
            Interacciones = ['ID_Interacciones', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza',
                             'Crianza',
                             'Variedad',
                             'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Interacciones', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_inte;"
            show_columns = "SHOW columns FROM farma_inte"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_inte'"

            create_Query = """CREATE TABLE `farma_inte` (
                  `ID_Interaccion` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Farma` int(11) NOT NULL,
                  `FarmacoInteractor` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `ReceptorMolecular` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `TipoInteraccion` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Fenomeno` longtext COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB 
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Registro de Interacciones Farmacologicas.';
            """
            consult_Query = "SELECT * FROM farma_inte"
            consult_ids_Query = "SELECT ID_Interacciones FROM farma_inte"
            consult_id_Query = "SELECT * FROM farma_inte WHERE ID_Interaccion = "
            register_Query = "INSERT INTO farma_inte (ID_Farma, " \
                             "FarmacoInteractor, ReceptorMolecular, TipoInteraccion, Fenomeno) " \
                             "VALUES (%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE farma_inte SET ID_Interaccion = %s, ID_Farma = %s, FarmacoInteractor = %s, " \
                              "ReceptorMolecular = %s, TipoInteraccion = %s, Fenomeno = %s " \
                              "WHERE ID_Interaccion = "
            delete_Query = "DELETE FROM farma_inte WHERE ID_Interaccion = "
            truncate_table_Query = "TRUNCATE farma_inte"
            drop_table_Query = "DROP TABLE farma_inte"

        class Presentaciones:
            Presentaciones = ['Presentaciones', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza',
                              'Crianza',
                              'Variedad',
                              'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Presentaciones', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_pre;"
            show_columns = "SHOW columns FROM farma_pre"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_pre'"

            create_Query = """CREATE TABLE `farma_pre` (
                  `ID_Presentaciones` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Farmacos` int(11) NOT NULL,
                  `Farma_Dem` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Farma_For` longtext COLLATE utf8_unicode_ci NOT NULL,
                  `Farma_Lab` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Farma_Pre` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pesaje` int(11) NOT NULL,
                  `Uni_Pesaje` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Volumen` int(11) NOT NULL,
                  `Uni_Volumen` varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB 
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla de Registro para Presentaciones Farmaceúticas';
            """
            consult_Query = "SELECT * FROM farma_pre"
            consult_ids_Query = "SELECT ID_Presentaciones FROM farma_pre"
            consult_id_Query = "SELECT * FROM farma_pre WHERE ID_Presentaciones = "
            consult_name_Query = "SELECT * FROM farma_pre WHERE Farma_Pre LIKE '%"
            register_Query = "INSERT INTO farma_pre (ID_Farmacos, Farma_Dem, Farma_For, " \
                             "Farma_Lab, Farma_Pre, Pesaje, Uni_Pesaje, Volumen, Uni_Volumen) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE farma_pre SET ID_Presentaciones=%s, " \
                              "ID_Farmacos=%s, Farma_Dem=%s, Farma_For=%s, " \
                              "Farma_Lab=%s, Farma_Pre=%s, Pesaje=%s, Uni_Pesaje=%s, " \
                              "Volumen=%s, Uni_Volumen=%s " \
                              "WHERE ID_Presentaciones = "
            delete_Query = "DELETE FROM farma_pre WHERE ID_Presentaciones = "
            truncate_table_Query = "TRUNCATE farma_pre"
            drop_table_Query = "DROP TABLE farma_pre"

        class Selectividad:
            Selectividad = ['ID_Selectividad', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                            'Variedad',
                            'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Selectividad', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE farma_sele;"
            show_columns = "SHOW columns FROM farma_sele"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'farma_sele'"

            create_Query = """CREATE TABLE `farma_sele` (
                  `ID_Selectividad` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Farmaco` int(11) NOT NULL,
                  `EstructuraMolecular` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
                  `Denominacion` longtext COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB 
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Registro de Selectividad Molecular del Fármaco.';"""
            consult_Query = "SELECT * FROM farma_sele"
            consult_ids_Query = "SELECT ID_Selectividad FROM farma_sele"
            consult_last_Query = "SELECT * FROM farma_sele ORDER BY ID_Selectividad DESC"
            consult_id_Query = "SELECT * FROM farma_sele WHERE ID_Selectividad = "
            register_Query = "INSERT INTO farma_sele (ID_Farmaco, EstructuraMolecular, Denominacion) " \
                             "VALUES (%s,%s,%s)"
            update_id_Query = "UPDATE farma_sele SET ID_Selectividad = %s, " \
                              "ID_Farmaco = %s, EstructuraMolecular = %s, Denominacion  = %s" \
                              "WHERE ID_Selectividad = "
            delete_Query = "DELETE FROM farma_sele WHERE ID_Selectividad = "
            truncate_table_Query = "TRUNCATE farma_sele"
            drop_table_Query = "DROP TABLE farma_sele"

    class Clasificaciones:
        show_tables = "SHOW tables;"
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_cie` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        drop_database = "DROP DATABASE `bd_cie`"

        class Cie:
            cie = ["ID_Diagnóstico", "Clave", "Diagnostico"]
            cols_cie = ["ID_Diagnóstico", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE cie;"
            show_columns = "SHOW columns FROM cie"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'cie'"

            create_Query = """CREATE TABLE `cie` (
              `ID_Dia` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
              `ID_Cie_Dia` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Cie_Dia` varchar(50) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='En esta Tabla se agregan los cie que usan el Sistema';"""

            consult_Query = "SELECT * FROM cie"
            consult_ids_Query = "SELECT ID_Dia FROM cie"
            consult_partial_Query = "SELECT ID_Dia, ID_Cie_Dia Cie_Dia  FROM cie"
            consult_last_Query = "SELECT * FROM cie ORDER BY ID_Dia DESC"
            consult_last_partial_Query = "SELECT ID_Dia, ID_Cie_Dia, Cie_Dia " \
                                         "FROM cie ORDER BY ID_Dia DESC"
            consult_id_Query = "SELECT ID_Dia, ID_Cie_Dia Us_Stat FROM cie WHERE ID_Dia = "
            consult_name_Query = "SELECT Cie_Dia FROM cie WHERE Cie_Dia LIKE '"
            register_Query = "INSERT INTO cie (ID_Dia, ID_Cie_Dia, Cie_Dia) " \
                             "VALUES (%s,%s,%s)"
            update_id_Query = "UPDATE cie SET ID_Dia = %s, ID_Cie_Dia = %s, Cie_Dia = %s " \
                              "WHERE ID_Dia = "
            delete_Query = "DELETE FROM cie WHERE ID_Dia = "
            truncate_table_Query = "TRUNCATE cie"
            drop_table_Query = "DROP TABLE cie"

        class Nic:
            nic_int = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_nic_int = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE nic_int;"
            show_columns = "SHOW columns FROM nic_int"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'nic_int'"

            create_Query = """CREATE TABLE `nic_int` (
              `ID_Dia` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
              `ID_Cie_Dia` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Cie_Dia` varchar(50) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='En esta Tabla se agregan los nic_int que usan el Sistema';"""

            consult_Query = "SELECT * FROM nic_int"
            consult_ids_Query = "SELECT ID_Dia FROM nic_int"
            consult_partial_Query = "SELECT ID_Dia, ID_Cie_Dia Cie_Dia  FROM nic_int"
            consult_last_Query = "SELECT * FROM nic_int ORDER BY ID_Dia DESC"
            consult_id_Query = "SELECT ID_Dia, ID_Cie_Dia Us_Stat FROM nic_int WHERE ID_Dia = "
            consult_name_Query = "SELECT ID_Dia, ID_Cie_Dia Us_Stat FROM nic_int WHERE ID_Cie_Dia LIKE '%"
            register_Query = "INSERT INTO nic_int (ID_Cie_Dia Cie_Dia Us_Ape_Mat, Us_Usuario, " \
                             "Us_Passe, Us_Permi, Us_EspeL, Us_Area, Us_Stat, Usu_ADAM_AGE) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE nic_int SET ID_Dia = %s, ID_Cie_Dia = %s, Cie_Dia = %s, Us_Ape_Mat = %s, Us_Usuario = %s, " \
                              "Us_Passe = %s, Us_Permi = %s, Us_EspeL = %s, Us_Area = %s, Us_Stat = %s, Usu_ADAM_AGE = " \
                              "%s WHERE ID_Dia = "
            delete_Query = "DELETE FROM nic_int WHERE ID_Dia = "
            truncate_table_Query = "TRUNCATE nic_int"
            drop_table_Query = "DROP TABLE nic_int"

    class Auxiliares:
        show_tables = "SHOW tables;"
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regasca` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        drop_database = "DROP DATABASE `bd_regasca`"

        Estadisticas = ["Fecha_Actual", "Ingreso_Global", "Egreso_Global", "Ingreso_Previo", "Egreso_Previo",
                        "Saldo_Remanente", "Ingreso_Actual", "Egreso_Actual", "Balance_Actual", "Balance_General"]
        cols_estadisticas = ["Fecha Actual", "Ingreso Global", "Egreso Global", "Ingreso Previo", "Egreso Previo",
                             "Saldo Remanente", "Ingreso Actual", "Egreso Actual", "Balance Actual",
                             "Balance General"]

        query_estadisticas = """
            SELECT 
                (SELECT CURRENT_DATE) as Fecha_Actual, 
                (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_inge WHERE `ID_Usuario` = 1) as Ingreso_Global, 
                (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1) as Egreso_Global, 
                (SELECT Ingreso_Global - Egreso_Global) as Balance_Global, 
                (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_inge WHERE `ID_Usuario` = 1 AND `Feca_Fine`< CURRENT_DATE) as Ingreso_Previo, 
                (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Feca_Fine`< CURRENT_DATE) as Egreso_Previo, 
                (SELECT Ingreso_Previo - Egreso_Previo) as Saldo_Remanente, 
                (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_inge WHERE `ID_Usuario` = 1 AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Ingreso_Actual, 
                (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND (MONTH(`Feca_Fine`) = MONTH(CURRENT_DATE)) AND YEAR(`Feca_Fine`) = year(CURRENT_DATE)) as Egreso_Actual,
                (SELECT Ingreso_Actual - Egreso_Actual) AS Balance_Actual, 
                (SELECT Saldo_Remanente+Balance_Actual) as Balance_General;
            """

        class Archivero:
            describe_table = "DESCRIBE reg_files;"
            show_columns = "SHOW columns FROM reg_files"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'reg_files'"

            create_Query = """CREATE TABLE `reg_files` (
               `ID_Files` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
               `Fecha_Realizacion` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
               `Nombre_Archivo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
               `Extension_Archivo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
               `Binario_Archivo` longblob NOT NULL
             ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Clasificar Archivos Varios.'"""
            consult_Query = "SELECT * FROM reg_files"
            consult_ids_Query = "SELECT ID_Files FROM reg_files"
            consult_partial_Query = "SELECT * FROM reg_files "
            consult_last_Query = "SELECT * FROM reg_files ORDER BY ID_Files DESC"
            consult_last_partial_Query = "SELECT * FROM reg_files ORDER BY ID_Files DESC"
            consult_id_Query = "SELECT * FROM reg_files WHERE ID_Files = "
            consult_name_Query = "SELECT *  FROM reg_files WHERE Nombre_Archivo LIKE '%"
            consult_file_Query = "SELECT Binario_Archivo FROM reg_files"
            consult_file_id_Query = "SELECT Binario_Archivo FROM reg_files WHERE ID_Files = "
            consult_file_name_Query = "SELECT Binario_Archivo FROM reg_files WHERE Fine_Actte LIKE '%"
            register_Query = "INSERT INTO reg_files (Fecha_Realizacion, " \
                             "Nombre_Archivo, Extension_Archivo, Binario_Archivo) " \
                             "VALUES (%s,%s,%s,%s)"
            register_file_Query = "INSERT INTO reg_files (Fecha_Realizacion, " \
                                  "Nombre_Archivo, Extension_Archivo, Binario_Archivo) " \
                                  "VALUES (%s,%s,%s,%s)"
            update_id_Query = "UPDATE reg_files SET ID_Files = %s, " \
                              "Fecha_Realizacion = %s, Nombre_Archivo = %s, Extension_Archivo = %s, Binario_Archivo = %s " \
                              "WHERE ID_Files = "
            delete_Query = "DELETE FROM reg_files WHERE ID_Files = "
            truncate_table_Query = "TRUNCATE reg_files"
            drop_table_Query = "DROP TABLE reg_files"

    class Financieros:
        var_estadisticas = ["Fecha_Actual", "Ingreso_Global", "Egreso_Global", "Balance_Global",
                            "Ingreso_Previo", "Egreso_Previo", "Saldo_Remanente",
                            "Ingreso_Actual", "Egreso_Actual", "Balance_Actual", "Balance_:General"]
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regfine` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        drop_database = "DROP DATABASE `bd_regfine`"

        Estadisticas = ["Fecha_Actual", "Ingreso_Global", "Egreso_Global", "Ingreso_Previo", "Egreso_Previo",
                        "Saldo_Remanente", "Ingreso_Actual", "Egreso_Actual", "Balance_Actual", "Balance_General"]
        cols_estadisticas = ["Fecha Actual", "Ingreso Global", "Egreso Global", "Ingreso Previo", "Egreso Previo",
                             "Saldo Remanente", "Ingreso Actual", "Egreso Actual", "Balance Actual", "Balance General"]

        query_estadisticas = """
                    SELECT 
                        (SELECT CURRENT_DATE) as Fecha_Actual, 
                        (SELECT IFNULL(COUNT(`ID_Fine_`), '0') FROM us_fine_inge WHERE `ID_Usuario` = 1) as Ingresos_Registrados, 
                        (SELECT IFNULL(COUNT(`ID_Fine_`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1) as Egresos_Registrados, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_inge WHERE `ID_Usuario` = 1) as Ingreso_Global, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1) as Egreso_Global, 
                        (SELECT Ingreso_Global - Egreso_Global) as Balance_Global,                  
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_inge WHERE `ID_Usuario` = 1 AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) as Ingreso_Anual, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) as Egreso_Anual, 
                        (SELECT Ingreso_Anual - Egreso_Anual) AS Balance_Anual, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_inge WHERE `ID_Usuario` = 1 AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) as Ingreso_Anual_Previo, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) as Egreso_Anual_Previo, 
                        (SELECT Balance_Global - (Ingreso_Anual_Previo - Egreso_Anual_Previo)) as Balance_Previo_Año, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_inge WHERE `ID_Usuario` = 1 AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) as Ingreso_Mes_Previo, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) as Egreso_Mes_Previo, 
                        (SELECT Balance_Global - (Ingreso_Mes_Previo - Egreso_Mes_Previo)) AS Balance_Previo_Mes, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_inge WHERE `ID_Usuario` = 1 AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Ingreso_Mensual, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND (MONTH(`Feca_Fine`) = MONTH(CURRENT_DATE)) AND YEAR(`Feca_Fine`) = year(CURRENT_DATE)) as Egreso_Mensual,
                        (SELECT Ingreso_Mensual - Egreso_Mensual) AS Balance_Mensual,
                        (SELECT Balance_Global - (Balance_Mensual)) AS Balance_Actual, 
                        (SELECT IFNULL(SUM(`Fine_Acce` * `Fine_Uni`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Uno, 
                        (SELECT IFNULL(SUM(`Fine_Acce` * `Fine_Uni`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Dos, 
                        (SELECT IFNULL(SUM(`Fine_Acce` * `Fine_Uni`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Tres, 
                        (SELECT IFNULL(SUM(`Fine_Acce` * `Fine_Uni`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Cuatro, 
                        (SELECT IFNULL(SUM(`Fine_Acce` * `Fine_Uni`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Cinco, 
                        (SELECT IFNULL(SUM(`Fine_Acce` * `Fine_Uni`), '0') FROM us_fine_enge WHERE `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND `Feca_Fine` <= CURDATE() AND `ID_Usuario` = 1) AS Egreso_Global_Cuenta_Seis, 
                        (SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Uno, 
                        (SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Dos, 
                        (SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Tres, 
                        (SELECT (Ingreso_Global / 100) * 55) AS Cuenta_Global_Cuatro, 
                        (SELECT (Ingreso_Global / 100) * 10) AS Cuenta_Global_Cinco, 
                        (SELECT (Ingreso_Global / 100) * 5) AS Cuenta_Global_Seis, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Uno,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Dos,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Tres,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Cuatro,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Cinco,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR))) AS Egreso_Anual_Previo_Cuenta_Seis,
                        (SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Uno,
                        (SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Dos,
                        (SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Tres,
                        (SELECT (Ingreso_Anual_Previo / 100) * 55) AS Cuenta_Anual_Previo_Cuatro,
                        (SELECT (Ingreso_Anual_Previo / 100) * 10) AS Cuenta_Anual_Previo_Cinco,
                        (SELECT (Ingreso_Anual_Previo / 100) * 5) AS Cuenta_Anual_Previo_Seis, 
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Uno,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Dos,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Tres,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Cuatro,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Cinco,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND YEAR(`Feca_Fine`) = YEAR(CURRENT_DATE)) AS Egreso_Anual_Cuenta_Seis,
                        (SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Uno,
                        (SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Dos,
                        (SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Tres,
                        (SELECT (Ingreso_Anual / 100) * 55) AS Cuenta_Anual_Cuatro,
                        (SELECT (Ingreso_Anual / 100) * 10) AS Cuenta_Anual_Cinco,
                        (SELECT (Ingreso_Anual / 100) * 5) AS Cuenta_Anual_Seis,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Uno,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Dos,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Tres,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Cuatro,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Cinco,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND MONTH(`Feca_Fine`) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND YEAR(`Feca_Fine`) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))) AS Egreso_Mensual_Previo_Cuenta_Seis, 
                        (SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Uno,
                        (SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Dos,
                        (SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Tres,
                        (SELECT (Ingreso_Mes_Previo / 100) * 55) AS Cuenta_Mensual_Previo_Cuatro,
                        (SELECT (Ingreso_Mes_Previo / 100) * 10) AS Cuenta_Mensual_Previo_Cinco,
                        (SELECT (Ingreso_Mes_Previo / 100) * 5) AS Cuenta_Mensual_Previo_Seis,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 1: Libertad Financiera' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Uno,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 2: Ahorro a Largo Plazo' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Dos,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 3: Desarrollo Personal' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Tres,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 4: Necesidades Básicas' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Cuatro,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 5: Ocio' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Cinco,
                        (SELECT IFNULL(SUM(`Fine_Acce`*`Fine_Uni`), '0') FROM us_fine_enge WHERE `ID_Usuario` = 1 AND `Fine_Cue_` = 'Cuenta No. 6: Donativos' AND (MONTH(`Feca_Fine`) = CURRENT_DATE) AND YEAR(`Feca_Fine`) = CURRENT_DATE) as Egreso_Mensual_Cuenta_Seis, 
                        (SELECT (Ingreso_Mensual / 100) * 10) AS Cuenta_Mensual_Uno,
                        (SELECT (Ingreso_Mensual / 100) * 10) AS Cuenta_Mensual_Dos,
                        (SELECT (Ingreso_Mensual / 100) * 10) AS Cuenta_Mensual_Tres,
                        (SELECT (Ingreso_Mensual / 100) * 55) AS Cuenta_Mensual_Cuatro,
                        (SELECT (Ingreso_Mensual / 100) * 10) AS Cuenta_Mensual_Cinco,
                        (SELECT (Ingreso_Mensual / 100) * 5) AS Cuenta_Mensual_Seis,
                        (SELECT (Ingreso_Mensual / 100) * 10) AS Cuenta_Mensual_Uno,
                        (SELECT (Cuenta_Mensual_Uno - Egreso_Mensual_Cuenta_Uno)) AS Cuenta_Mensual_Balance_Uno,
                        (SELECT (Cuenta_Mensual_Dos - Egreso_Mensual_Cuenta_Dos)) AS Cuenta_Mensual_Balance_Dos,
                        (SELECT (Cuenta_Mensual_Tres - Egreso_Mensual_Cuenta_Tres)) AS Cuenta_Mensual_Balance_Tres,
                        (SELECT (Cuenta_Mensual_Cuatro - Egreso_Mensual_Cuenta_Cuatro)) AS Cuenta_Mensual_Balance_Cuatro,
                        (SELECT (Cuenta_Mensual_Cinco - Egreso_Mensual_Cuenta_Cinco)) AS Cuenta_Mensual_Balance_Cinco,
                        (SELECT (Cuenta_Mensual_Seis - Egreso_Mensual_Cuenta_Seis)) AS Cuenta_Mensual_Balance_Seis;
                    """

        class Ingresos:
            Financieros_Ingresos = ['ID_Fine_',
                                    'ID_Usuario',
                                    'Feca_Fine',
                                    'Fine_Cata_A',
                                    'Fine_Cata_B',
                                    'Fine_Cata_C',
                                    'Fine_Actte',
                                    'Fine_Acce',
                                    'Fine_Uni',
                                    'Fine_Desc']
            cols_ingresos = ["ID", "ID Usuario", "Fecha de Ingreso",
                             "Categoria A", "Categoría B", "Categoría C",
                             "Concepto", "Monto", "Unidades", "Descripción"]

            describe_table = "DESCRIBE us_fine_inge;"
            show_columns = "SHOW columns FROM us_fine_inge"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'us_fine_inge'"

            create_Query = """CREATE TABLE `us_fine_inge` (
                      `ID_Fine_` int(10) NOT NULL AUTO_INCREMENT,
                      `ID_Usuario` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                      `Feca_Fine` date NOT NULL,
                      `Fine_Cata_A` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                      `Fine_Cata_B` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                      `Fine_Cata_C` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                      `Fine_Actte` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                      `Fine_Acce` double NOT NULL,
                      `Fine_Uni` int(10) NOT NULL,
                      `Fine_Desc` longtext COLLATE utf8_unicode_ci NOT NULL,
                      PRIMARY KEY (`ID_Fine_`)
                ) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Ingresos Financieros.';
            """
            consult_Query = "SELECT * FROM us_fine_inge"
            consult_pair_Query = "SELECT Feca_Fine, (Fine_Acce * Fine_Uni) FROM us_fine_inge ORDER BY Feca_Fine ASC"
            consult_ids_Query = "SELECT ID_Fine_ FROM us_fine_inge"
            consult_partial_Query = "SELECT * FROM us_fine_inge "
            consult_last_Query = "SELECT * FROM us_fine_inge ORDER BY ID_Fine_ DESC"
            consult_last_partial_Query = "SELECT * FROM us_fine_inge ORDER BY ID_Fine_ DESC"
            consult_id_Query = "SELECT * FROM us_fine_inge WHERE ID_Fine_ = "
            consult_name_Query = "SELECT *  FROM us_fine_inge WHERE Fine_Cata_A LIKE '%"
            consult_photo_Query = "SELECT Foto_Vino FROM us_fine_inge"
            consult_photo_id_Query = "SELECT Foto_Vino FROM us_fine_inge WHERE ID_Fine_ = "
            consult_photo_name_Query = "SELECT Foto_Vino FROM us_fine_inge WHERE Fine_Actte LIKE '%"
            register_Query = "INSERT INTO us_fine_inge (ID_Usuario, Feca_Fine, " \
                             "Fine_Cata_A, Fine_Cata_B, Fine_Cata_C, " \
                             "Fine_Actte, Fine_Acce, Fine_Uni, Fine_Desc) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            register_photo_Query = "INSERT INTO us_fine_inge (ID_Usuario, Feca_Fine, Fine_Cata_A, Fine_Cata_B, " \
                                   "Fine_Cata_C, Fine_Actte, Fine_Acce, Fine_Uni, Fine_Desc) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE us_fine_inge SET ID_Usuario = %s, Feca_Fine = %s, Fine_Cata_A = %s, " \
                              "Fine_Cata_B = %s, Fine_Cata_C = %s, Fine_Actte = %s, Fine_Acce = %s, " \
                              "Fine_Uni = %s, Fine_Desc = %s WHERE ID_Fine_ = "
            delete_Query = "DELETE FROM us_fine_inge WHERE ID_Fine_ = "
            truncate_table_Query = "TRUNCATE us_fine_inge"
            drop_table_Query = "DROP TABLE us_fine_inge"

        class Egresos:
            Financieros_Egresos = ['ID_Fine_',
                                   'ID_Usuario',
                                   'Feca_Fine',
                                   'Fine_Cata_A',
                                   'Fine_Cata_B',
                                   'Fine_Cata_C',
                                   'Fine_Cue_',
                                   'Fine_Actte',
                                   'Fine_Acce',
                                   'Fine_Uni',
                                   'Fine_Desc']
            cols_egresos = ["ID", "ID_Usuario", "Fecha de Gasto", "Categoria A", "Categoría B", "Categoría C",
                            "Tipo de Cuenta", "Concepto", "Monto", "Unidades", "Descripción"]

            describe_table = "DESCRIBE us_fine_enge;"
            show_columns = "SHOW columns FROM us_fine_enge"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'us_fine_enge'"

            create_Query = """CREATE TABLE `us_fine_enge` (
                  `ID_Fine_` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Usuario` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `Feca_Fine` date NOT NULL,
                  `Fine_Cata_A` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Fine_Cata_B` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Fine_Cata_C` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Fine_Cue_` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Fine_Actte` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Fine_Acce` double NOT NULL,
                  `Fine_Uni` int(10) NOT NULL,
                  `Fine_Desc` longtext COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Activities Financieros.';
            """
            consult_Query = "SELECT * FROM us_fine_enge ORDER BY ID_Fine_ DESC"
            consult_pair_Query = "SELECT Feca_Fine, (Fine_Acce * Fine_Uni) FROM us_fine_enge ORDER BY Feca_Fine ASC"
            consult_ids_Query = "SELECT ID_Fine_ FROM us_fine_enge"
            consult_partial_Query = "SELECT * FROM us_fine_enge "
            consult_last_Query = "SELECT * FROM us_fine_enge ORDER BY ID_Fine_ DESC"
            consult_last_partial_Query = "SELECT * FROM us_fine_enge ORDER BY ID_Fine_ DESC"
            consult_id_Query = "SELECT * FROM us_fine_enge WHERE ID_Fine_ = "
            consult_name_Query = "SELECT *  FROM us_fine_enge WHERE Fine_Cata_A LIKE '%"
            register_Query = "INSERT INTO us_fine_enge (ID_Usuario, Feca_Fine, Fine_Cata_A, Fine_Cata_B, Fine_Cata_C, " \
                             "Fine_Cue_, Fine_Actte, Fine_Acce, Fine_Uni, Fine_Desc) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s, %s)"
            register_photo_Query = "INSERT INTO us_fine_enge (ID_Usuario, Feca_Fine, Fine_Cata_A, Fine_Cata_B, " \
                                   "Fine_Cata_C, Fine_Cue_, Fine_Actte, Fine_Acce, Fine_Uni, Fine_Desc) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s, %s)"
            update_id_Query = "UPDATE us_fine_enge " \
                              "SET ID_Fine_ = %s, ID_Usuario = %s, Feca_Fine = %s, " \
                              "Fine_Cata_A = %s, Fine_Cata_B = %s, " \
                              "Fine_Cata_C = %s, " \
                              "Fine_Cue_ = %s, " \
                              "Fine_Actte = %s, Fine_Acce = %s, Fine_Uni = %s, Fine_Desc = %s " \
                              "WHERE ID_Fine_ = "
            delete_Query = "DELETE FROM us_fine_enge WHERE ID_Fine_ = "
            truncate_table_Query = "TRUNCATE us_fine_enge"
            drop_table_Query = "DROP TABLE us_fine_enge"

        class Adeudos:
            class Auxiliares:
                PAGO_REALIZADO = ["Si", "No"]
                ESTADO_ACTUAL = ["Alta", "Baja", "Pendiente"]

            Financieros_Egresos = ['ID',
                                   'ID_Registro',
                                   'Tipo_Recurso',
                                   'Concepto_Recurso',
                                   'Fecha_Pago_Programado',
                                   'Intervalo_Programado',
                                   'Monto_Programado',
                                   'Interes_Acordado',
                                   'Pago_Realizado',
                                   'Monto_Pagado',
                                   'Monto_Restate',
                                   'Estado_Actual',
                                   'Fecha_Proximo_Pago',
                                   'Fecha_Baja']
            cols_egresos = ['ID Adeudo',
                            'ID Registro',
                            'Concepto del Recurso',
                            'Tipo de Recurso',
                            'Fecha de Pago Programado',
                            'Intervalo Programado',
                            'Monto Programado',
                            'Interes Acordado',
                            'Pago Realizado',
                            'Monto Pagado',
                            'Monto Restante',
                            'Estado Actual',
                            'Fecha de Proximo Pago',
                            'Fecha de Baja']

            describe_table = "DESCRIBE us_fine_addem;"
            show_columns = "SHOW columns FROM us_fine_addem"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'us_fine_addem'"

            create_Query = """CREATE TABLE `us_fine_addem` (
              `ID_Adeudo` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
              `ID_Registro` int(10) NOT NULL,
              `Concepto_Recurso` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Tipo_Recurso` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Fecha_Pago_Programado` DATE NOT NULL,
              `Intervalo_Programado` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Monto_Programado` DOUBLE NOT NULL,
              `Interes_Acordado` DOUBLE NOT NULL,
              `Pago_Realizado` BOOLEAN NOT NULL,
              `Monto_Pagado` DOUBLE NOT NULL,
              `Monto_Restante` DOUBLE NOT NULL,
              `Estado_Actual` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `Fecha_Proximo_Pago` DATE NOT NULL,
              `Fecha_Baja` DATE NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='En esta Tabla se agregan las Deudas o Acreditaciones del estado Financiero';"""
            consult_Query = "SELECT * FROM us_fine_addem"
            consult_ids_Query = "SELECT ID_Fine_ FROM us_fine_addem"
            consult_last_Query = "SELECT * FROM us_fine_addem ORDER BY ID_Adeudo DESC"
            consult_id_Query = "SELECT * FROM us_fine_addem WHERE ID_Adeudo = "
            consult_name_Query = "SELECT *  FROM us_fine_addem WHERE Tipo_Recurso LIKE '%"
            register_Query = "INSERT INTO us_fine_addem (ID_Registro, Tipo_Recurso, Fecha_Pago_Programado, " \
                             "Intervalo_Programado, Monto_Programado, Interes_Acordado, Pago_Realizado, Monto_Pagado, " \
                             "Monto_Restante, Estado_Actual, Fecha_Proximo_Pago, Fecha_Baja) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            register_photo_Query = "INSERT INTO us_fine_addem (ID_Registro, Tipo_Recurso, Fecha_Pago_Programado, " \
                                   "Intervalo_Programado, Monto_Programado, Interes_Acordado, Pago_Realizado, " \
                                   "Monto_Pagado, Monto_Restante, Estado_Actual, Fecha_Proximo_Pago, Fecha_Baja) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE us_fine_addem SET ID_Adeudo = %s, ID_Registro = %s, Tipo_Recurso = %s, " \
                              "Fecha_Pago_Programado = %s, Intervalo_Programado = %s, Monto_Programado = %s, Interes_Acordado = %s, " \
                              "Pago_Realizado = %s, Monto_Pagado = %s, Monto_Restante = %s, Estado_Actual = %s, Fecha_Proximo_Pago = %s, " \
                              "Fecha_Baja  = %s" \
                              "WHERE ID_Fine_ = "
            delete_Query = "DELETE FROM us_fine_addem WHERE ID_Adeudo = "
            truncate_table_Query = "TRUNCATE us_fine_addem"
            drop_table_Query = "DROP TABLE us_fine_addem"

        class Monetarios:
            describe_table = "DESCRIBE mone_iden;"
            show_columns = "SHOW columns FROM mone_iden"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'mone_iden'"

            create_Query = """CREATE TABLE `usuarios` (
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
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='En esta Tabla se agregan los sara_iden_iden que usan el Sistema';"""
            consult_Query = "SELECT * FROM mone_iden"
            consult_ids_Query = "SELECT ID_Monetario FROM mone_iden"
            consult_partial_Query = "SELECT $Total FROM mone_iden"
            consult_last_Query = "SELECT * FROM mone_iden ORDER BY ID_Monetario DESC"
            consult_last_partial_Query = "SELECT * FROM mone_iden ORDER BY ID_Monetario DESC"
            consult_id_Query = "SELECT * FROM mone_iden WHERE ID_Monetario = "
            consult_name_Query = "SELECT *  FROM mone_iden WHERE Fine_Cata_A LIKE '%"
            consult_photo_Query = "SELECT Foto_Vino FROM mone_iden"
            consult_photo_id_Query = "SELECT Foto_Vino FROM mone_iden WHERE ID_Monetario = "
            consult_photo_name_Query = "SELECT Foto_Vino FROM mone_iden WHERE Fine_Actte LIKE '%"
            register_Query = "INSERT INTO mone_iden (ID_Monetario, C_Centavos, Uno, Dos, " \
                             "Cinco, Diez, Vente, Cincuenta, Cien, Doscientos, Quinientos, Mil, Total) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            register_photo_Query = "INSERT INTO mone_iden (ID_Monetario, C_Centavos, Uno, Dos, " \
                                   "Cinco, Diez, Vente, Cincuenta, Cien, Doscientos, Quinientos, Mil, Total) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE mone_iden SET ID_Monetario = %s, C_Centavos = %s, Uno = %s, Dos = %s, Cinco = %s, " \
                              "Diez = %s, Vente = %s, Cincuenta = %s, Cien = %s, Doscientos = %s, " \
                              "Quinientos = %s, Mil = %s, Total = %s " \
                              "WHERE ID_Monetario = "
            delete_Query = "DELETE FROM mone_iden WHERE ID_Monetario = "
            truncate_table_Query = "TRUNCATE mone_iden"
            drop_table_Query = "DROP TABLE mone_iden"

    class Bursatiles:
        show_tables = "SHOW tables;"
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regasca` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        drop_database = "DROP DATABASE `bd_regasca`"

    class Enologias:
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regenolo` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        drop_database = "DROP DATABASE `bd_regenolo`"
        show_tables = "SHOW tables;"

        class Identificaciones:
            describe_table = "DESCRIBE eno_iden;"
            show_tables = "SHOW tables;"
            show_columns = "SHOW columns FROM eno_iden"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'eno_iden'"

            create_Query = """CREATE TABLE `eno_iden` (
                  `ID_Enologias` int(11) NOT NULL AUTO_INCREMENT,
                  `VinoNombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `MarcaVino` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Bodega` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Volumen` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `ZonaCrianza` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Crianza` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Variedad` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `PVP` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
                  `Foto_Vino` longblob NOT NULL,
                  PRIMARY KEY (`ID_Enologias`)
                ) ENGINE=InnoDB AUTO_INCREMENT=1
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para GestiÃ³n de Vinos y Licores';
            """
            consult_Query = "SELECT * FROM eno_iden"
            consult_ids_Query = "SELECT ID_Enologias FROM eno_iden"
            consult_partial_Query = "SELECT ID_Enologias, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                    "Crianza, Variedad, PVP FROM eno_iden "
            consult_last_Query = "SELECT * FROM eno_iden ORDER BY ID_Enologias DESC"
            consult_last_partial_Query = "SELECT ID_Enologias, " \
                                         "VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                         "Crianza, Variedad, PVP " \
                                         "FROM eno_iden ORDER BY ID_Enologias DESC"
            consult_id_Query = "SELECT ID_Enologias, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                               "Sara_Ape_Mat FROM eno_iden WHERE ID_Sara = "
            consult_name_Query = "SELECT ID_Enologias, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                 "Crianza, PVP Variedad FROM eno_iden WHERE VinoNombre LIKE '%"
            consult_photo_Query = "SELECT Foto_Vino FROM eno_iden"
            consult_photo_id_Query = "SELECT Foto_Vino FROM eno_iden WHERE ID_Enologias = "
            consult_photo_name_Query = "SELECT Foto_Vino FROM eno_iden WHERE Us_Nome LIKE '%"
            register_Query = "INSERT INTO eno_iden (ID_Enologias, " \
                             "VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                             "Crianza, PVP) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            register_photo_Query = "INSERT INTO eno_iden (VinoNombre," \
                                   " MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                   "Crianza, PVP, Foto_Vino) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s"
            update_id_Query = "UPDATE eno_iden SET ID_Enologias = %s, " \
                              "ID_Enologias = %s, VinoNombre = %s, MarcaVino = %s, Bodega = %s, Volumen = %s, " \
                              "ZonaCrianza = %s, " \
                              "Crianza, PVP = %s WHERE ID_Enologias = "
            update_photo_id_Query = "UPDATE eno_iden SET ID_Enologias = %s, " \
                                    "ID_Enologias = %s, VinoNombre = %s, MarcaVino = %s, " \
                                    "Bodega = %s, Volumen = %s, ZonaCrianza = %s, " \
                                    "Crianza, PVP = %s, Foto_Vino = %s WHERE ID_Sara = "
            delete_Query = "DELETE FROM eno_iden WHERE ID_Enologias = "
            truncate_table_Query = "TRUNCATE eno_iden"
            drop_table_Query = "DROP TABLE eno_iden"

        class Gustativa:
            describe_table = "DESCRIBE eno_gustativa;"
            show_tables = "SHOW tables;"
            show_columns = "SHOW columns FROM eno_gustativa"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'eno_gustativa'"

            create_Query = """CREATE TABLE `eno_gustativa` (
                  `ID_Gustativa` int(10) NOT NULL AUTO_INCREMENT,
                  `ID_Enologias` int(11) NOT NULL,
                  `Cuerpo` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Gusto` longtext COLLATE utf8_unicode_ci NOT NULL,
                  `PesoFruta` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Evaluacion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `IntensidadRetronasal` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Variacion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Persistencia` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `IntensidadPostgusto` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Duracion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `NotasDominantes` varchar(100) COLLATE utf8_unicode_ci NOT NULL, 
                    PRIMARY KEY (`ID_Gustativa`)
                ) ENGINE=InnoDB AUTO_INCREMENT=1
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla de Caracteristicas Enologicas, Fase Visual';
            """
            consult_Query = "SELECT * FROM eno_gustativa"
            consult_ids_Query = "SELECT ID_Gustativa,  FROM eno_gustativa"
            consult_last_Query = "SELECT * FROM eno_gustativa ORDER BY ID_Gustativa,  DESC"
            consult_id_Query = "SELECT * FROM eno_gustativa WHERE ID_Gustativa,  = "
            register_Query = "INSERT INTO eno_gustativa (ID_Enologias, Cuerpo, Gusto, " \
                             "PesoFruta, Evaluacion, IntensidadRetronasal, Variacion, " \
                             "Persistencia, IntensidadPostgusto, Duracion, NotasDominantes) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE eno_gustativa SET " \
                              "ID_Gustativa = %s, ID_Enologias = %s, Cuerpo = %s, Gusto = %s, " \
                              "PesoFruta = %s, Evaluacion = %s, IntensidadRetronasal = %s, " \
                              "Variacion = %s, Persistencia = %s, IntensidadPostgusto = %s, Duracion = %s, " \
                              "NotasDominantes = %s " \
                              "WHERE ID_Gustativa,  = "
            delete_Query = "DELETE FROM eno_gustativa WHERE ID_Gustativa,  = "
            truncate_table_Query = "TRUNCATE eno_gustativa"
            drop_table_Query = "DROP TABLE eno_gustativa"

        class Olfativa:
            describe_table = "DESCRIBE eno_olfativa;"
            show_tables = "SHOW tables;"
            show_columns = "SHOW columns FROM eno_olfativa"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'eno_olfativa'"

            create_Query = """CREATE TABLE `eno_olfativa` (
                      `ID_Olfativa` int(10) NOT NULL AUTO_INCREMENT,
                      `ID_Enologias` int(11) NOT NULL,
                      `Intensidad` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      `Aroma` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      `Penetrancia` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      `Dimensionalidad` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      `Calidad` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      `Bouquet` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      PRIMARY KEY (`ID_Olfativa`)
                ) ENGINE=InnoDB AUTO_INCREMENT=1
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla de Caracteristicas Enologicas, Fase Olfativa';
            """
            consult_Query = "SELECT * FROM eno_olfativa"
            consult_ids_Query = "SELECT ID_Olfativa FROM eno_olfativa"
            consult_last_Query = "SELECT * FROM eno_olfativa ORDER BY ID_Olfativa DESC"
            consult_id_Query = "SELECT * FROM eno_olfativa WHERE ID_Olfativa = "
            register_Query = "INSERT INTO eno_olfativa (ID_Enologias, Intensidad, " \
                             "Aroma, Penetrancia, Dimensionalidad, Calidad, Bouquet) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE eno_olfativa " \
                              "SET ID_Olfativa = %s, ID_Enologias = %s, Intensidad = %s, " \
                              "Aroma = %s, Penetrancia = %s, Dimensionalidad = %s, " \
                              "Calidad = %s, Bouquet = %s " \
                              "WHERE ID_Olfativa = "
            delete_Query = "DELETE FROM eno_olfativa WHERE ID_Olfativa = "
            truncate_table_Query = "TRUNCATE eno_olfativa"
            drop_table_Query = "DROP TABLE eno_olfativa"

        class Visual:
            describe_table = "DESCRIBE eno_visual;"
            show_tables = "SHOW tables;"
            show_columns = "SHOW columns FROM eno_visual"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'eno_visual'"

            create_Query = """CREATE TABLE `eno_visual` (
                      `ID_Visual` int(10) NOT NULL AUTO_INCREMENT,
                      `ID_Enologias` int(11) NOT NULL,
                      `Intensidad` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      `Color` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      `Tonalidad` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      `Variacion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      `Evolucion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      `Aspecto` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                      PRIMARY KEY (`ID_Visual`)
                ) ENGINE=InnoDB AUTO_INCREMENT=1
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla de Caracteristicas Enologicas, Fase Visual';
            """
            consult_Query = "SELECT * FROM eno_visual"
            consult_ids_Query = "SELECT ID_Enologias FROM eno_visual"
            consult_last_Query = "SELECT * FROM eno_visual ORDER BY ID_Visual DESC"
            consult_id_Query = "SELECT * WHERE ID_Visual = "
            register_Query = "INSERT INTO eno_visual (ID_Enologias, Intensidad, " \
                             "Color, Tonalidad, Variacion, Evolucion, Aspecto) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE eno_visual " \
                              "SET ID_Visual = %s, ID_Enologias = %s, Intensidad = %s, " \
                              "Color = %s, Tonalidad = %s, Variacion = %s, " \
                              "Evolucion = %s, Aspecto = %s " \
                              "WHERE ID_Visual = "
            delete_Query = "DELETE FROM eno_visual WHERE ID_Visual = "
            truncate_table_Query = "TRUNCATE eno_visual"
            drop_table_Query = "DROP TABLE eno_visual"

    class Heraldicas:
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regheral` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        show_information = "SELECT column_name, data_type, is_nullable, " \
                           "column_default  " \
                           "FROM information_schema.columns " \
                           "WHERE table_name = 'farma_iden'"
        drop_database = "DROP DATABASE `bd_regheral`"

        class Identificaciones:
            Farmacos = ['ID_Heraldica', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                        'Variedad',
                        'PVP', 'Foto_Arma']
            cols_enologias = ['ID Farmacos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE heral_iden;"
            show_columns = "SHOW columns FROM heral_iden"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'heral_iden'"

            create_Query = """CREATE TABLE `heral_iden` (
                  `ID_Heraldica` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ArmaNombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `TipoArma` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `UsoArma` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `FuncionamientoArma` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `ObjetivoArma` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `PaisOrigen` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `MarcaFabricante` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `PVP` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
                  `Foto_Arma` longblob NOT NULL
                ) ENGINE=InnoDB 
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='En esta Tabla se agregan los datos generales de las armas';"""
            consult_Query = "SELECT * FROM heral_iden"
            consult_ids_Query = "SELECT ID_Heraldica FROM heral_iden"
            consult_partial_Query = "SELECT ID_Heraldica, ArmaNombre, TipoArma, UsoArma, FuncionamientoArma, " \
                                    "ObjetivoArma, PaisOrigen, MarcaFabricante, PVP FROM heral_iden "
            consult_last_Query = "SELECT * FROM heral_iden ORDER BY ID_Heraldica DESC"
            consult_last_partial_Query = "SELECT ID_Heraldica, ArmaNombre, TipoArma, UsoArma, FuncionamientoArma, " \
                                         "ObjetivoArma, PaisOrigen, MarcaFabricante, PVP " \
                                         "FROM heral_iden ORDER BY ID_Heraldica DESC"
            consult_id_Query = "SELECT ID_Heraldica, ArmaNombre, TipoArma, UsoArma, FuncionamientoArma, ObjetivoArma, " \
                               "PaisOrigen, MarcaFabricante, PVP " \
                               "FROM heral_iden WHERE ID_Heraldica = "
            consult_name_Query = "SELECT ID_Heraldica, ArmaNombre, TipoArma, UsoArma, FuncionamientoArma, " \
                                 "ObjetivoArma, PaisOrigen, MarcaFabricante, PVP FROM heral_iden WHERE VinoNombre " \
                                 "LIKE '% "
            consult_photo_Query = "SELECT Foto_Arma FROM heral_iden"
            consult_photo_id_Query = "SELECT Foto_Arma " \
                                     "FROM heral_iden WHERE ID_Heraldica = "
            consult_photo_name_Query = "SELECT Foto_Arma " \
                                       "FROM heral_iden WHERE NombreFarmaco LIKE '%"
            register_Query = "INSERT INTO heral_iden (ArmaNombre, TipoArma, UsoArma, FuncionamientoArma, " \
                             "ObjetivoArma, PaisOrigen, MarcaFabricante, PVP) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            register_photo_Query = "INSERT INTO heral_iden (ArmaNombre, TipoArma, UsoArma, FuncionamientoArma, " \
                                   "ObjetivoArma, PaisOrigen, MarcaFabricante, PVP, Foto_Arma) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE heral_iden " \
                              "SET ID_Heraldica = %s, ArmaNombre = %s, TipoArma = %s, UsoArma = %s, " \
                              "FuncionamientoArma = %s, ObjetivoArma = %s, PaisOrigen = %s, MarcaFabricante = %s, " \
                              "PVP = %s " \
                              "WHERE ID_Heraldica = "
            update_id_photo_Query = "UPDATE heral_iden " \
                                    "SET ID_Heraldica = %s, ArmaNombre = %s, TipoArma = %s, UsoArma = %s, " \
                                    "FuncionamientoArma = %s, ObjetivoArma = %s, PaisOrigen = %s, MarcaFabricante = " \
                                    "%s, PVP = %s, Foto_Arma = %s " \
                                    "WHERE ID_Heraldica = "
            delete_Query = "DELETE FROM heral_iden WHERE ID_Heraldica = "
            truncate_table_Query = "TRUNCATE heral_iden"
            drop_table_Query = "DROP TABLE heral_iden"

        class Catalogos:
            Activos = ['ID_Heraldica_Cata', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                       'Variedad',
                       'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Activos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE heral_cata;"
            show_columns = "SHOW columns FROM heral_cata"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'heral_cata'"

            create_Query = """CREATE TABLE `heral_cata` (
                  `ID_Heraldica_Cata` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Heraldica` int(11) NOT NULL,
                  `Nombre` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Descripcion` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
                  `Foto_Arma` longblob NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Catalogos de Armas.';
            """
            consult_Query = "SELECT * FROM heral_cata"
            consult_ids_Query = "SELECT ID_Heraldica_Cata FROM heral_cata"
            consult_id_Query = "SELECT * FROM heral_cata WHERE ID_Heraldica_Cata = "
            register_Query = "INSERT INTO heral_cata (ID_Heraldica, Nombre, Descripcion) " \
                             "VALUES (%s,%s,%s)"
            update_id_Query = "UPDATE heral_cata " \
                              "SET ID_Heraldica_Cata = %s, ID_Heraldica = %s, Nombre = %s, Descripcion = %s, Foto_Arma = %s " \
                              "WHERE ID_Heraldica_Cata = "
            delete_Query = "DELETE FROM heral_cata WHERE ID_Heraldica_Cata = "
            truncate_table_Query = "TRUNCATE heral_cata"
            drop_table_Query = "DROP TABLE heral_cata"

        class Mecanismos:
            Dosis = ['ID_Mecanismo', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                     'Variedad',
                     'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Dosis', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE heral_mecanismo;"
            show_columns = "SHOW columns FROM heral_mecanismo"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'heral_mecanismo'"

            create_Query = """CREATE TABLE `heral_mecanismo` (
                  `ID_Mecanismo` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Heraldicas` int(11) NOT NULL,
                  `SistemaDisparo` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `TipoDisparo` longtext COLLATE utf8_unicode_ci NOT NULL,
                  `DisparosMinuto` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `TipoEnfriamiento` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `MiraPoste` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `RadioMiras` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `AlzaCorrederas` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Laser` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Lamparas` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `NotasDominantes` varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT 
                CHARSET=utf8 COLLATE=utf8_unicode_ci 
                COMMENT='En esta Tabla se agregan los rangos de dosificación del Fármaco';"""
            consult_Query = "SELECT * FROM heral_mecanismo"
            consult_ids_Query = "SELECT ID_Mecanismo FROM heral_mecanismo"
            consult_last_Query = "SELECT * FROM heral_mecanismo ORDER BY ID_Mecanismo DESC"
            consult_id_Query = "SELECT * FROM heral_mecanismo WHERE ID_Mecanismo = "
            register_Query = "INSERT INTO heral_mecanismo (ID_Heraldicas, SistemaDisparo, TipoDisparo, DisparosMinuto, TipoEnfriamiento, MiraPoste, RadioMiras, AlzaCorrederas, Laser, Lamparas, NotasDominantes) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s, %s)"
            update_id_Query = "UPDATE heral_mecanismo " \
                              "SET ID_Mecanismo = %s, ID_Heraldicas = %s, SistemaDisparo = %s, TipoDisparo = %s, DisparosMinuto = %s, TipoEnfriamiento = %s, MiraPoste = %s, RadioMiras = %s, AlzaCorrederas = %s, Laser = %s, Lamparas = %s, NotasDominantes = %s " \
                              "WHERE ID_Mecanismo = "
            delete_Query = "DELETE FROM heral_mecanismo WHERE ID_Mecanismo = "
            truncate_table_Query = "TRUNCATE heral_mecanismo"
            drop_table_Query = "DROP TABLE heral_mecanismo"

        class Municiones:
            Efectos = ['ID_Municion', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                       'Variedad',
                       'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Efectos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE heral_municion;"
            show_columns = "SHOW columns FROM heral_municion"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'heral_municion'"

            create_Query = """CREATE TABLE `heral_municion` (
                  `ID_Municion` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Heraldicas` int(11) NOT NULL,
                  `Calibre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `CapacidadMunicion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `CapacidadTiro` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `VelocidadInicial` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `CadenciaTiro` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `AlcanceEfectivo` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `AlcanceMaximo` varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Registro de Efectos Farmacológicos.';
            """
            consult_Query = "SELECT * FROM heral_municion"
            consult_ids_Query = "SELECT ID_Municion FROM heral_municion"
            consult_id_Query = "SELECT *  FROM heral_municion WHERE ID_Municion = "
            register_Query = "INSERT INTO heral_municion (ID_Heraldicas, Calibre, " \
                             "CapacidadMunicion, CapacidadTiro, VelocidadInicial, CadenciaTiro, " \
                             "AlcanceEfectivo, AlcanceMaximo) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE heral_municion " \
                              "SET ID_Municion = %s, ID_Heraldicas = %s, " \
                              "Calibre = %s, CapacidadMunicion = %s, " \
                              "CapacidadTiro = %s, VelocidadInicial = %s, " \
                              "CadenciaTiro = %s, AlcanceEfectivo = %s, " \
                              "AlcanceMaximo = %s " \
                              "WHERE ID_Municion = "
            delete_Query = "DELETE FROM heral_municion WHERE ID_Municion = "
            truncate_table_Query = "TRUNCATE heral_municion"
            drop_table_Query = "DROP TABLE heral_municion"

        class Dimensiones:
            Farmacocineticos = ['ID_Farmacocineticos', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza',
                                'Crianza',
                                'Variedad',
                                'PVP', 'Foto_Farmaco']
            cols_enologias = ['ID Farmacocineticos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE heral_visual;"
            show_columns = "SHOW columns FROM heral_visual"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'heral_visual'"

            create_Query = """CREATE TABLE `heral_visual` (
                  `ID_Dimensiones` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
                  `ID_Heraldica` int(11) NOT NULL,
                  `Calibre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `LongitudGeneral` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `LongitudCanon` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `LongitudRayada` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `TipoRayado` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `PesoVacio` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `PesoCargado` varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB 
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Registro de las Dimensiones del Arma.';
            """
            consult_Query = "SELECT * FROM heral_visual"
            consult_ids_Query = "SELECT ID_Dimensiones FROM heral_visual"
            consult_id_Query = "SELECT *  FROM heral_visual WHERE ID_Dimensiones = "
            register_Query = "INSERT INTO heral_visual (ID_Heraldica, Calibre, LongitudGeneral, " \
                             "LongitudCanon, " \
                             "LongitudRayada, TipoRayado, PesoVacio, PesoCargado) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE heral_visual " \
                              "SET ID_Dimensiones = %s, ID_Heraldica = %s, Calibre = %s, LongitudGeneral = %s, " \
                              "LongitudCanon = %s, LongitudRayada = %s, TipoRayado = %s, PesoVacio = %s, " \
                              "PesoCargado = %s " \
                              "WHERE ID_Dimensiones = "
            delete_Query = "DELETE FROM heral_visual WHERE ID_Dimensiones = "
            truncate_table_Query = "TRUNCATE heral_visual"
            drop_table_Query = "DROP TABLE heral_visual"

    class Hospitalarios:
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_reghosp` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        drop_database = "DROP DATABASE `bd_reghosp`"

        class Licencias:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE licen_med;"
            show_columns = "SHOW columns FROM licen_med"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'licen_med'"

            create_Query = """CREATE TABLE licen_med (
                          `ID_Licen_Med` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                          `ID_Pace` int(10) NOT NULL,
                          `Folio` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                          `Dias_Otorgados` int(10) NOT NULL,
                          `Fecha_Realizacion` date NOT NULL,
                          `Fecha_Inicio` date NOT NULL,
                          `Fecha_Termino` date NOT NULL,
                          `Motivo_Incapacidad` varchar(200) COLLATE utf8_unicode_ci NOT NULL, 
                          `Caracter` varchar(200) COLLATE utf8_unicode_ci NOT NULL, 
                          `Lugar_Expedicion` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 
                    COLLATE=utf8_unicode_ci 
                    COMMENT='Tabla para Registro de Expedición de Licencias Médicas.';
                    """
            consult_Query = "SELECT * FROM licen_med"
            consult_ids_Query = "SELECT ID_Pace FROM licen_med"
            consult_last_Query = "SELECT * FROM licen_med ORDER BY ID_Pace DESC"
            consult_licen_Query = "SELECT * FROM licen_med ORDER BY ID_Licen_Med DESC"
            consult_id_Query = "SELECT * FROM licen_med WHERE ID_Licen_Med = "
            register_Query = "INSERT INTO licen_med (ID_Pace, Folio, Dias_Otorgados, " \
                             "Fecha_Realizacion, Fecha_Inicio, Fecha_Termino, " \
                             "Motivo_Incapacidad, Caracter, Lugar_Expedicion) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE licen_med " \
                              "SET ID_Licen_Med = %s, ID_Pace = %s, Folio = %s, " \
                              "Dias_Otorgados = %s, Fecha_Realizacion = %s, Fecha_Inicio = %s, Fecha_Termino = %s, " \
                              "Motivo_Incapacidad = %s, Caracter = %s, Lugar_Expedicion = %s " \
                              "WHERE ID_Licen_Med = "
            delete_Query = "DELETE FROM licen_med WHERE ID_Licen_Med = "
            truncate_table_Query = "TRUNCATE licen_med"
            drop_table_Query = "DROP TABLE licen_med"

        class Quirurgicos:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE ciru_pro;"
            show_columns = "SHOW columns FROM ciru_pro"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'ciru_pro'"

            create_Query = """CREATE TABLE `ciru_pro` (
                          `ID_Ciru_Pro` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                          `ID_Pace` int(10) NOT NULL,
                          `ID_Hosp` int(11) NOT NULL,
                          `ECG` tinyint(1) NOT NULL,
                          `LAB` tinyint(1) NOT NULL,
                          `RAD` tinyint(1) NOT NULL,
                          `VALA` tinyint(1) NOT NULL,
                          `VAMA` tinyint(1) NOT NULL,
                          `CON` tinyint(1) NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Seguimientos de Protocolos Quirurgicos.';
                    """
            consult_Query = "SELECT * FROM ciru_pro"
            consult_ids_Query = "SELECT ID_Pace FROM ciru_pro"
            consult_last_Query = "SELECT * FROM ciru_pro ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM ciru_pro WHERE ID_Ciru_Pro = "
            register_Query = "INSERT INTO `ciru_pro` (ID_Pace, ID_Hosp, ECG, LAB, RAD, VALA, VAMA, CON) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE ciru_pro " \
                              "SET ID_Ciru_Pro = %s, ID_Pace = %s, ID_Hosp = %s, ECG = %s, LAB = %s, RAD = %s, VALA = %s, VAMA = %s, CON = %s " \
                              "WHERE ID_Ciru_Pro = "
            delete_Query = "DELETE FROM ciru_pro WHERE ID_PACE_APP_CON = "
            truncate_table_Query = "TRUNCATE ciru_pro"
            drop_table_Query = "DROP TABLE ciru_pro"

        class Dispositivos:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE disp_pace;"
            show_columns = "SHOW columns FROM disp_pace"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'disp_pace'"

            create_Query = """CREATE TABLE `disp_pace` (
                      `ID_Disp` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(10) NOT NULL,
                      `ID_Hosp` int(11) NOT NULL,
                      `DRE` tinyint(1) NOT NULL,
                      `SoV` tinyint(1) NOT NULL,
                      `SNG` tinyint(1) NOT NULL,
                      `CVC` tinyint(1) NOT NULL,
                      `CVLP` tinyint(1) NOT NULL,
                      `CVP` tinyint(1) NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Dispositivos en Hospitalizacion.';
                """
            consult_Query = "SELECT * FROM disp_pace"
            consult_ids_Query = "SELECT ID_Pace FROM disp_pace"
            consult_last_Query = "SELECT * FROM disp_pace ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM disp_pace WHERE ID_Disp = "
            register_Query = "INSERT INTO `disp_pace` (ID_Pace, ID_Hosp, DRE, SoV, SNG, CVC, CVLP, CVP) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE disp_pace " \
                              "SET ID_Disp = %s,  ID_Pace = %s,  ID_Hosp = %s,  " \
                              "DRE = %s,  SoV = %s,  SNG = %s,  CVC = %s,  CVLP = %s,  CVP = %s " \
                              "WHERE ID_Disp = "
            delete_Query = "DELETE FROM disp_pace WHERE ID_PACE_APP_CON = "
            truncate_table_Query = "TRUNCATE disp_pace"
            drop_table_Query = "DROP TABLE disp_pace"

        class Expedientes:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE expe_pace;"
            show_columns = "SHOW columns FROM expe_pace"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'expe_pace'"

            create_Query = """CREATE TABLE `expe_pace` (
                  `ID_Expe` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(10) NOT NULL,
                  `ID_Hosp` int(11) NOT NULL,
                  `POR` tinyint(1) NOT NULL,
                  `HIS` tinyint(1) NOT NULL,
                  `ING` tinyint(1) NOT NULL,
                  `EVA` tinyint(1) NOT NULL,
                  `VAL` tinyint(1) NOT NULL,
                  `CON` tinyint(1) NOT NULL,
                  `ORD` tinyint(1) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Estado de Expediente Clinico.';
            """
            consult_Query = "SELECT * FROM expe_pace"
            consult_ids_Query = "SELECT ID_Pace FROM expe_pace"
            consult_last_Query = "SELECT * FROM expe_pace ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM expe_pace WHERE ID_Hosp = "
            register_Query = "INSERT INTO `expe_pace` (ID_Pace, ID_Hosp, " \
                             "POR, HIS, ING, EVA, VAL, CON, ORD) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE expe_pace " \
                              "SET ID_Expe = %s, ID_Pace = %s, ID_Hosp = %s, POR = %s, HIS = %s, ING = %s, " \
                              "EVA = %s, VAL = %s, CON = %s, ORD = %s " \
                              "WHERE ID_Expe = "
            delete_Query = "DELETE FROM expe_pace WHERE ID_Expe = "
            truncate_table_Query = "TRUNCATE expe_pace"
            drop_table_Query = "DROP TABLE expe_pace"

        class Configuraciones:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE hosp_config_bias;"
            show_columns = "SHOW columns FROM hosp_config_bias"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'hosp_config_bias'"

            create_Query = """CREATE TABLE `hosp_config_bias` (
                  `ID_hosp_config_bias` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `NombreHospital` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Institucion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Nacionalidad` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `NumeroCamas` int(11) NOT NULL,
                  `Foto_Hospital` longblob NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Hospitales.';
            """
            consult_Query = "SELECT * FROM hosp_config_bias"
            consult_ids_Query = "SELECT ID_Pace FROM hosp_config_bias"
            consult_last_Query = "SELECT * FROM hosp_config_bias ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM hosp_config_bias WHERE ID_hosp_config_bias = "
            register_Query = "INSERT INTO `hosp_config_bias` (NombreHospital,  Institucion,  " \
                             "Nacionalidad,  NumeroCamas,  Foto_Hospital) " \
                             "VALUES (%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE hosp_config_bias " \
                              "SET ID_hosp_config_bias = %s,  NombreHospital = %s,  Institucion = %s,  Nacionalidad = " \
                              "%s,  NumeroCamas = %s,  Foto_Hospital = %s " \
                              "WHERE ID_hosp_config_bias = "
            delete_Query = "DELETE FROM hosp_config_bias WHERE ID_hosp_config_bias = "
            truncate_table_Query = "TRUNCATE hosp_config_bias"
            drop_table_Query = "DROP TABLE hosp_config_bias"

        class Balances:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_bala;"
            show_columns = "SHOW columns FROM pace_bala"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_bala'"

            create_Query = """CREATE TABLE `pace_bala` (
                  `ID_Bala` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `Pace_bala_Fecha` date NOT NULL,
                  `Pace_bala_Time` time NOT NULL,
                  `Pace_bala_Oral` double NOT NULL,
                  `Pace_bala_Sonda` double NOT NULL,
                  `Pace_bala_Hemo` double NOT NULL,
                  `Pace_bala_NPT` double NOT NULL,
                  `Pace_bala_Sol` double NOT NULL,
                  `Pace_bala_Dil` double NOT NULL,
                  `Pace_bala_ING` double NOT NULL,
                  `Pace_bala_Uresis` double NOT NULL,
                  `Pace_bala_Evac` double NOT NULL,
                  `Pace_bala_Sangrado` double NOT NULL,
                  `Pace_bala_Succion` double NOT NULL,
                  `Pace_bala_Drenes` double NOT NULL,
                  `Pace_bala_PER` double NOT NULL,
                  `Pace_bala_ENG` double NOT NULL,
                  `Pace_bala_HOR` int NOT NULL 
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Líquidos en Pacientes Hospitalizados.';
            """
            consult_Query = "SELECT * FROM pace_bala"
            consult_ids_Query = "SELECT ID_Pace FROM pace_bala"
            consult_last_Query = "SELECT * FROM pace_bala ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_bala WHERE ID_Bala = "
            register_Query = "INSERT INTO pace_bala (ID_Pace, Pace_bala_Fecha, " \
                             "Pace_bala_Time, " \
                             "Pace_bala_Oral, Pace_bala_Sonda, Pace_bala_Hemo, " \
                             "Pace_bala_NPT, Pace_bala_Sol, " \
                             "Pace_bala_Dil, Pace_bala_ING, Pace_bala_Uresis, " \
                             "Pace_bala_Evac, Pace_bala_Sangrado, " \
                             "Pace_bala_Succion, Pace_bala_Drenes, Pace_bala_PER, " \
                             "Pace_bala_ENG, Pace_bala_HOR) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_bala " \
                              "SET ID_Bala = %s, ID_Pace = %s, Pace_bala_Fecha = %s, Pace_bala_Time = %s, " \
                              "Pace_bala_Oral = %s, Pace_bala_Sonda = %s, Pace_bala_Hemo = %s, Pace_bala_NPT = %s, " \
                              "Pace_bala_Sol = %s, Pace_bala_Dil = %s, Pace_bala_ING = %s, Pace_bala_Uresis = %s, " \
                              "Pace_bala_Evac = %s, Pace_bala_Sangrado = %s, Pace_bala_Succion = %s, Pace_bala_Drenes " \
                              "= %s, Pace_bala_PER = %s, Pace_bala_ENG = %s, Pace_bala_HOR = %s " \
                              "WHERE ID_Bala = "
            delete_Query = "DELETE FROM pace_bala WHERE ID_Bala = "
            truncate_table_Query = "TRUNCATE pace_bala"
            drop_table_Query = "DROP TABLE pace_bala"

        class Cirugias:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_ciru;"
            show_columns = "SHOW columns FROM pace_ciru"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_ciru'"

            create_Query = """CREATE TABLE `pace_ciru` (
              `ID_Ciru` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(10) NOT NULL,
              `ID_Hosp` int(11) NOT NULL,
              `Feca_PRO_Ciru` date NOT NULL,
              `Tipo_Cirugia` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              `Cirugia_Realizada` tinyint(1) NOT NULL,
              `Medi_Trat` varchar(300) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Registros de Cirugia.';
            """
            consult_Query = "SELECT * FROM pace_ciru"
            consult_ids_Query = "SELECT ID_Pace FROM pace_ciru"
            consult_last_Query = "SELECT * FROM pace_ciru ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_ciru WHERE ID_Ciru = "
            register_Query = "INSERT INTO `pace_ciru` (ID_Pace, " \
                             "ID_Hosp, Feca_PRO_Ciru, Tipo_Cirugia, Cirugia_Realizada, Medi_Trat) " \
                             "VALUES (%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_ciru " \
                              "SET ID_Ciru = %s,  ID_Pace = %s,  ID_Hosp = %s,  Feca_PRO_Ciru = %s,  Tipo_Cirugia = " \
                              "%s,  Cirugia_Realizada = %s,  Medi_Trat = %s " \
                              "WHERE ID_Ciru = "
            delete_Query = "DELETE FROM pace_ciru WHERE ID_Ciru = "
            truncate_table_Query = "TRUNCATE pace_ciru"
            drop_table_Query = "DROP TABLE pace_ciru"

        class Diagnosticos:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_dia;"
            show_columns = "SHOW columns FROM pace_dia"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_dia'"

            create_Query = """CREATE TABLE `pace_dia` (
              `ID_PACE_APP_DEG` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(11) NOT NULL,
              `ID_Hosp` int(11) NOT NULL,
              `Pace_APP_DEG_SINO` tinyint(1) NOT NULL,
              `Pace_APP_DEG` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_APP_DEG_com` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_APP_DEG_dia` int(200) NOT NULL,
              `Pace_APP_DEG_tra_SINO` tinyint(1) NOT NULL,
              `Pace_APP_DEG_tra` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_APP_DEG_sus_SINO` tinyint(1) NOT NULL,
              `Pace_APP_DEG_sus` varchar(200) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Diagnósticos Intrahospitalarios';
            """
            consult_Query = "SELECT * FROM pace_dia"
            consult_ids_Query = "SELECT ID_Pace FROM pace_dia"
            consult_last_Query = "SELECT * FROM pace_dia ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_dia WHERE ID_PACE_APP_DEG = "
            register_Query = "INSERT INTO `pace_dia` (ID_Pace, ID_Hosp, Pace_APP_DEG_SINO, " \
                             "Pace_APP_DEG, Pace_APP_DEG_com, Pace_APP_DEG_dia, Pace_APP_DEG_tra_SINO, " \
                             "Pace_APP_DEG_tra, Pace_APP_DEG_sus_SINO, Pace_APP_DEG_sus) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_dia " \
                              "SET ID_PACE_APP_DEG = %s,  ID_Pace = %s,  ID_Hosp = %s,  Pace_APP_DEG_SINO = %s,  " \
                              "Pace_APP_DEG = %s,  Pace_APP_DEG_com = %s,  Pace_APP_DEG_dia = %s,  " \
                              "Pace_APP_DEG_tra_SINO = %s,  Pace_APP_DEG_tra = %s,  Pace_APP_DEG_sus_SINO = %s,  " \
                              "Pace_APP_DEG_sus = %s " \
                              "WHERE ID_PACE_APP_DEG = "
            delete_Query = "DELETE FROM pace_dia WHERE ID_PACE_APP_DEG = "
            truncate_table_Query = "TRUNCATE pace_dia"
            drop_table_Query = "DROP TABLE pace_dia"

        class Hospitalarios:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_hosp;"
            show_columns = "SHOW columns FROM pace_hosp"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_hosp'"

            create_Query = """CREATE TABLE `pace_hosp` (
              `ID_Hosp` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(11) NOT NULL,
              `Feca_INI_Hosp` date NOT NULL,
              `Id_Cama` int(11) NOT NULL,
              `Dia_Estan` int(11) NOT NULL,
              `Medi_Trat` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              `Serve_Trat` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              `Serve_Trat_INI` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              `Feca_EGE_Hosp` date NOT NULL,
              `EGE_Motivo` varchar(100) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla Inicial para la Hospitalizacion de Pacientes.';
            """
            consult_Query = "SELECT * FROM pace_hosp"
            consult_Query_Hospitalizados = "SELECT ID_Pace FROM pace_hosp WHERE EGE_Motivo = 'Motivo de Egreso'"
            consult_ids_Query = "SELECT ID_Pace FROM pace_hosp"
            consult_last_Query = "SELECT * FROM pace_hosp ORDER BY ID_Pace DESC"
            consult_id_patient_Query = "SELECT * FROM pace_hosp WHERE ID_Pace = "
            consult_id_Query = "SELECT * FROM pace_hosp WHERE ID_Hosp = "
            register_Query = "INSERT INTO `pace_hosp` (ID_Pace, " \
                             "Feca_INI_Hosp, Id_Cama, Dia_Estan, Medi_Trat, Serve_Trat, Serve_Trat_INI, " \
                             "Feca_EGE_Hosp, EGE_Motivo) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_hosp " \
                              "SET ID_Hosp = %s,  ID_Pace = %s,  Feca_INI_Hosp = %s,  " \
                              "Id_Cama = %s,  Dia_Estan = %s,  Medi_Trat = %s,  Serve_Trat = %s,  Serve_Trat_INI" \
                              "Feca_EGE_Hosp = %s,  EGE_Motivo = %s " \
                              "WHERE ID_Hosp = "
            delete_Query = "DELETE FROM pace_hosp WHERE ID_Hosp = "
            truncate_table_Query = "TRUNCATE pace_hosp"
            drop_table_Query = "DROP TABLE pace_hosp"

        class Conflictos:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_hosp_confi;"
            show_columns = "SHOW columns FROM pace_hosp_confi"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_hosp_confi'"

            create_Query = """CREATE TABLE `pace_hosp_confi` (
              `ID_Hosp_Confi` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(10) NOT NULL,
              `Tip_Confi` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
              `Hosp_Confi` varchar(300) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Conflictos durante Hospitalizacion.';
            """
            consult_Query = "SELECT * FROM pace_hosp_confi"
            consult_ids_Query = "SELECT ID_Pace FROM pace_hosp_confi"
            consult_last_Query = "SELECT * FROM pace_hosp_confi ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_hosp_confi WHERE ID_Hosp_Confi = "
            register_Query = "INSERT INTO `pace_hosp_confi` (ID_Pace, Tip_Confi, Hosp_Confi) " \
                             "VALUES (%s,%s,%s)"
            update_id_Query = "UPDATE pace_hosp_confi " \
                              "SET ID_Hosp_Confi = %s,  ID_Pace = %s,  Tip_Confi = %s,  Hosp_Confi = %s " \
                              "WHERE ID_Hosp_Confi = "
            delete_Query = "DELETE FROM pace_hosp_confi WHERE ID_Hosp_Confi = "
            truncate_table_Query = "TRUNCATE pace_hosp_confi"
            drop_table_Query = "DROP TABLE pace_hosp_confi"

        class Movimientos:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_hosp_mova;"
            show_columns = "SHOW columns FROM pace_hosp_mova"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_hosp_mova'"

            create_Query = """CREATE TABLE `pace_hosp_mova` (
                  `ID_Movimientos` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `ID_Hosp` int(11) NOT NULL,
                  `FechaIngreso` date NOT NULL,
                  `FechaTraslado` date NOT NULL,
                  `ServicioAnterior` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
                  `ServicioActual` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
                  `Motivo` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Movimientos Intrahospitalarios del Pacien';
            """
            consult_Query = "SELECT * FROM pace_hosp_mova"
            consult_ids_Query = "SELECT ID_Pace FROM pace_hosp_mova"
            consult_last_Query = "SELECT * FROM pace_hosp_mova ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_hosp_mova WHERE ID_Movimientos = "
            register_Query = "INSERT INTO `pace_hosp_mova` (ID_Pace, ID_Hosp, FechaIngreso, FechaTraslado, " \
                             "ServicioAnterior, ServicioActual, Motivo) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_hosp_mova " \
                              "SET ID_Movimientos = %s,  ID_Pace = %s,  ID_Hosp = %s,  FechaIngreso = %s,  " \
                              "FechaTraslado = %s,  ServicioAnterior = %s,  ServicioActual = %s,  Motivo = %s " \
                              "WHERE ID_Movimientos = "
            delete_Query = "DELETE FROM pace_hosp_mova WHERE ID_Movimientos = "
            truncate_table_Query = "TRUNCATE pace_hosp_mova"
            drop_table_Query = "DROP TABLE pace_hosp_mova"

        class Reportes:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_hosp_repo;"
            show_columns = "SHOW columns FROM pace_hosp_repo"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_hosp_repo'"

            create_Query = """CREATE TABLE `pace_hosp_repo` (
              `ID_Compendio` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(11) NOT NULL,
              `ID_Hosp` int(11) NOT NULL,
              `FechaPadecimiento` date NOT NULL,
              `FechaRealizacion` date NOT NULL,
              `ServicioMedico` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              `Contexto` longtext COLLATE utf8_unicode_ci NOT NULL,
              `TipoAnalisis` varchar(150) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Almacenar Análisis por Reporte del Paciente.';
            """
            consult_Query = "SELECT * FROM pace_hosp_repo"
            consult_ids_Query = "SELECT ID_Pace FROM pace_hosp_repo"
            consult_last_Query = "SELECT * FROM pace_hosp_repo ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_hosp_repo WHERE ID_Compendio = "
            register_Query = "INSERT INTO `pace_hosp_repo` (ID_Pace, ID_Hosp, FechaPadecimiento, FechaRealizacion, " \
                             "ServicioMedico, Contexto, TipoAnalisis) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_hosp_repo " \
                              "SET ID_Compendio = %s,  ID_Pace = %s,  ID_Hosp = %s,  FechaPadecimiento = %s,  " \
                              "FechaRealizacion = %s,  ServicioMedico = %s,  Contexto = %s,  TipoAnalisis = %s " \
                              "WHERE ID_Compendio = "
            delete_Query = "DELETE FROM pace_hosp_repo WHERE ID_Compendio = "
            truncate_table_Query = "TRUNCATE pace_hosp_repo"
            drop_table_Query = "DROP TABLE pace_hosp_repo"

        class Pendientes:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_pen;"
            show_columns = "SHOW columns FROM pace_pen"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_pen'"

            create_Query = """CREATE TABLE `pace_pen` (
              `ID_Pace_Pen` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(11) NOT NULL,
              `ID_Hosp` int(11) NOT NULL,
              `Feca_PEN` date NOT NULL,
              `Pace_PEN` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_Desc_PEN` varchar(300) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Pendientes durante Hospitalización.';
            """
            consult_Query = "SELECT * FROM pace_pen"
            consult_ids_Query = "SELECT ID_Pace FROM pace_pen"
            consult_last_Query = "SELECT * FROM pace_pen ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_pen WHERE ID_Pace_Pen = "
            register_Query = "INSERT INTO `pace_pen` (ID_Pace, ID_Hosp, " \
                             "Feca_PEN, Pace_PEN, Pace_Desc_PEN) " \
                             "VALUES (%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_pen " \
                              "SET ID_Pace_Pen = %s,  ID_Pace = %s,  ID_Hosp = %s,  " \
                              "Feca_PEN = %s,  Pace_PEN = %s,  Pace_Desc_PEN = %s " \
                              "WHERE ID_Pace_Pen = "
            delete_Query = "DELETE FROM pace_pen WHERE ID_Pace_Pen = "
            truncate_table_Query = "TRUNCATE pace_pen"
            drop_table_Query = "DROP TABLE pace_pen"

        class Repositorios:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_repo;"
            show_columns = "SHOW columns FROM pace_repo"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_repo'"

            create_Query = """CREATE TABLE `pace_repo` (
              `ID_Pace_Repo` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(11) NOT NULL,
              `ID_Hosp` int(11) NOT NULL,
              `FechaReporte` date NOT NULL,
              `HoraReporte` time NOT NULL,
              `Reporte` longblob NOT NULL,
              `TipoReporte` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
              `NombreReporte` varchar(200) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Almacenar los Reportes Médicos de los Pacientes.';
            """
            consult_Query = "SELECT * FROM pace_repo"
            consult_ids_Query = "SELECT ID_Pace FROM pace_repo"
            consult_last_Query = "SELECT * FROM pace_repo ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_repo WHERE ID_Pace_Repo = "
            register_Query = "INSERT INTO pace_repo (ID_Pace, ID_Hosp, FechaReporte, " \
                             "HoraReporte, Reporte, TipoReporte, NombreReporte) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_repo " \
                              "SET ID_Pace_Repo = %s,  ID_Pace = %s,  ID_Hosp = %s, " \
                              "FechaReporte = %s,  HoraReporte = %s,  Reporte " \
                              "= %s,  TipoReporte = %s,  NombreReporte = %s " \
                              "WHERE ID_Pace_Repo = "
            delete_Query = "DELETE FROM pace_repo WHERE ID_Pace_Repo = "
            truncate_table_Query = "TRUNCATE pace_repo"
            drop_table_Query = "DROP TABLE pace_repo"

        class Subjetivos:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_su;"
            show_columns = "SHOW columns FROM pace_su"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_su'"

            create_Query = """CREATE TABLE `pace_su` (
              `ID_Pace_SU` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(11) NOT NULL,
              `ID_Hosp` int(11) NOT NULL,
              `Pace_SE_GEN` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_SE_VIA` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_SE_URE` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_SE_EXE` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_SE_REE` varchar(100) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
            """
            consult_Query = "SELECT * FROM pace_su"
            consult_ids_Query = "SELECT ID_Pace FROM pace_su"
            consult_last_Query = "SELECT * FROM pace_su ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_su WHERE ID_Pace_SU = "
            register_Query = "INSERT INTO `pace_su` (ID_Pace, ID_Hosp, " \
                             "Pace_SE_GEN, Pace_SE_VIA, " \
                             "Pace_SE_URE, Pace_SE_EXE, Pace_SE_REE) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_su " \
                              "SET ID_Pace_SU = %s,  ID_Pace = %s, ID_Hosp = %s, " \
                              "Pace_SE_GEN = %s,  Pace_SE_VIA = %s,  Pace_SE_URE = %s,  " \
                              "Pace_SE_EXE = %s,  Pace_SE_REE = %s " \
                              "WHERE ID_Pace_SU = "
            delete_Query = "DELETE FROM pace_su WHERE ID_Pace_SU = "
            truncate_table_Query = "TRUNCATE pace_su"
            drop_table_Query = "DROP TABLE pace_su"

        class Ventilaciones:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_vm;"
            show_columns = "SHOW columns FROM pace_vm"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_vm'"

            create_Query = """CREATE TABLE `pace_vm` (
                  `ID_Ventilacion` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `Feca_VEN` date NOT NULL,
                  `Pace_Vt` double NOT NULL,
                  `Pace_Fr` int(11) NOT NULL,
                  `Pace_Fio` int(11) NOT NULL,
                  `Pace_Peep` int(11) NOT NULL,
                  `Pace_Insp` int(11) NOT NULL,
                  `Pace_Espi` int(11) NOT NULL,
                  `Pace_Pc` int(11) NOT NULL,
                  `Pace_Pm` int(11) NOT NULL,
                  `Pace_V` int(11) NOT NULL,
                  `Pace_F` int(11) NOT NULL,
                  `Pace_Ps` int(11) NOT NULL,
                  `Pace_Pip` int(11) NOT NULL,
                  `Pace_Pmet` int(11) NOT NULL,
                  `VM_Mod` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Registro de Valores de Ventilación Mecánica';
            """
            consult_Query = "SELECT * FROM pace_vm"
            consult_ids_Query = "SELECT ID_Pace FROM pace_vm"
            consult_last_Query = "SELECT * FROM pace_vm ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_vm WHERE ID_Ventilacion = "
            register_Query = "INSERT INTO `pace_vm` (ID_Pace, " \
                             "Feca_VEN, Pace_Vt, Pace_Fr, Pace_Fio, Pace_Peep, Pace_Insp, " \
                             "Pace_Espi, Pace_Pc, Pace_Pm, Pace_V, Pace_F, Pace_Ps, Pace_Pip, " \
                             "Pace_Pmet, VM_Mod) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_vm " \
                              "SET ID_Ventilacion = %s,  ID_Pace = %s,  Feca_VEN = %s,  " \
                              "Pace_Vt = %s,  Pace_Fr = %s,  Pace_Fio = %s,  Pace_Peep = %s,  " \
                              "Pace_Insp = %s,  Pace_Espi = %s,  Pace_Pc = %s,  Pace_Pm = %s,  " \
                              "Pace_V = %s,  Pace_F = %s,  Pace_Ps = %s,  Pace_Pip = %s,  " \
                              "Pace_Pmet = %s,  VM_Mod = %s " \
                              "WHERE ID_Ventilacion = "
            delete_Query = "DELETE FROM pace_vm WHERE ID_Ventilacion = "
            truncate_table_Query = "TRUNCATE pace_vm"
            drop_table_Query = "DROP TABLE pace_vm"

        class Situaciones:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE siti_pace;"
            show_columns = "SHOW columns FROM siti_pace"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'siti_pace'"
            """"
            `ID_Pace` int(11) NOT NULL,
                              `ID_Hosp` int(11) NOT NULL,
                              `PN` tinyint(1) NOT NULL,
                              `MS` tinyint(1) NOT NULL,
                              `MR` tinyint(1) NOT NULL,
                              `CO` tinyint(1) NOT NULL,
                              `MA` tinyint(1) NOT NULL,
                              `CaO` tinyint(1) NOT NULL,
                              `CT` tinyint(1) NOT NULL,
                              `CL` tinyint(1) NOT NULL,
                              `PA` tinyint(1) NOT NULL,
                              `Al` tinyint(1) NOT NULL,
                              `EH` tinyint(1) NOT NULL,
                              `ING` tinyint(1) NOT NULL
                              
            """
            create_Query = """
                CREATE TABLE `siti_pace` (
                    `ID_Siti` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                    `ID_Pace` int(11) NOT NULL,
                    `ID_Hosp` int(11) NOT NULL,
                    `Hosp_Siti` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                    `Disp_Oxigen` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                    `CVP` tinyint(1) NOT NULL,
                    `CVLP` tinyint(1) NOT NULL,
                    `CVC` tinyint(1) NOT NULL,
                    `S_Foley` tinyint(1) NOT NULL,
                    `SNG` tinyint(1) NOT NULL,
                    `SOG` tinyint(1) NOT NULL,
                    `Drenaje` tinyint(1) NOT NULL,
                    `Pleuro_Vac` tinyint(1) NOT NULL,
                    `Colostomia` tinyint(1) NOT NULL,
                    `Gastrostomia` tinyint(4) NOT NULL,
                    `Dialisis_Peritoneal` tinyint(4) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla de Registro de Situacion Hospitalaria.';
            """
            consult_Query = "SELECT * FROM siti_pace"
            consult_ids_Query = "SELECT ID_Pace FROM siti_pace"
            consult_last_Query = "SELECT * FROM siti_pace ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM siti_pace WHERE ID_Siti = "
            register_Query = "INSERT INTO `siti_pace` (ID_Pace, ID_Hosp, " \
                             "Hosp_Siti, Disp_Oxigen, CVP, CVLP, CVC, " \
                             "S_Foley, SNG, SOG, Drenaje, Pleuro_Vac, " \
                             "Colostomia, Gastrostomia, Dialisis_Peritoneal) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE siti_pace " \
                              "SET ID_Siti = %s, ID_Pace = %s, ID_Hosp = %s, Hosp_Siti = %s, " \
                              "Disp_Oxigen = %s, CVP = %s, CVLP = %s, CVC = %s, S_Foley = %s, " \
                              "SNG = %s, SOG = %s, Drenaje = %s, Pleuro_Vac = %s, Colostomia = %s, " \
                              "Gastrostomia = %s, Dialisis_Peritoneal = %s " \
                              "WHERE ID_Siti = "
            delete_Query = "DELETE FROM siti_pace WHERE ID_Siti = "
            truncate_table_Query = "TRUNCATE siti_pace"
            drop_table_Query = "DROP TABLE siti_pace"

    class Laboratorios:
        # from Asistente.Actividades.Actividades import Pacientes

        create_database = "CREATE DATABASE IF NOT EXISTS bd_reglabo " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        drop_database = "DROP DATABASE bd_reglabo"

        # consult_Query = "SELECT Fecha_Registro, Tipo_Estudio " \
        #                 "FROM laboratorios " \
        #                 "WHERE ID_Pace = '" + str(Pacientes.ID) \
        #                 + "' GROUP BY Fecha_Registro, Tipo_Estudio ORDER BY Fecha_Registro DESC"

        def prosa(self, fecha_registro, tipo_estudio):
            data = Actividades.Consultar_Registro(
                self=self,
                Database=Credenciales.siteground_database_reggabo,
                query_consult="SELECT Estudio, Resultado, Unidad_Medida "
                              "FROM laboratorios "
                              "WHERE Fecha_Registro = '" + fecha_registro + "' "
                                                                            "AND Tipo_Estudio LIKE '" + tipo_estudio + "'"
            )

            Diccionario = dict()
            for elem in data:
                Diccionario[elem[0]] = [elem[1], elem[2]]

            try:
                prosa = ""
                aux = 1

                for keys in Diccionario:
                    if aux == len(Diccionario.keys()):
                        bax = ". \n"
                    else:
                        bax = ", "

                    prosa = prosa + "" \
                            + keys + " " + str(Diccionario.get(keys)[0]) + " " + str(Diccionario.get(keys)[1]) + bax
                    aux = aux + 1

                print(prosa)
            except Exception as ex:
                print(ex)

        prosa = "SELECT Estudio, Resultado, Unidad_Medida FROM Laboratorios " \
                "WHERE Fecha_Registro = '2022-02-27' AND Tipo_Estudio = "

        class Biometrias:
            Biometrias = ['ID_Biometrias', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                          'Variedad',
                          'PVP', 'Foto_Vino']
            cols_biometrias = ['ID Biometrias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                               'Crianza',
                               'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_bh;"
            show_columns = "SHOW columns FROM labo_bh"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_bh'"

            create_Query = """CREATE TABLE labo_bh (
                  ID_Pace_LAB_BH int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_LAB_BH_Feca date NOT NULL,
                  Pace_LAB_BH_er double NOT NULL,
                  Pace_LAB_BH_hb double NOT NULL,
                  Pace_LAB_BH_ht double NOT NULL,
                  Pace_LAB_BH_vcm double NOT NULL,
                  Pace_LAB_BH_hcm double NOT NULL,
                  Pace_LAB_BH_chc double NOT NULL,
                  Pace_LAB_BH_pla double NOT NULL,
                  Pace_LAB_BH_leu double NOT NULL,
                  Pace_LAB_BH_leu_NEU_a double NOT NULL,
                  Pace_LAB_BH_leu_NEU_b double NOT NULL,
                  Pace_LAB_BH_leu_LEU_a double NOT NULL,
                  Pace_LAB_BH_leu_LEU_b double NOT NULL,
                  Pace_LAB_BH_leu_MON_a double NOT NULL,
                  Pace_LAB_BH_leu_MON_b double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Biometria Hematica del Paciente.';
                """

            consult_Query = "SELECT * FROM labo_bh"
            consult_ids_Query = "SELECT ID_Pace_LAB_BH FROM labo_bh"
            consult_last_Query = "SELECT * FROM labo_bh ORDER BY Pace_LAB_BH_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_bh WHERE ID_Pace_LAB_BH = "
            consult_id_patient_Query = "SELECT * FROM labo_bh WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_bh WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_bh (ID_Pace, Pace_LAB_BH_Feca, Pace_LAB_BH_er, Pace_LAB_BH_hb, " \
                             "Pace_LAB_BH_ht, Pace_LAB_BH_vcm, Pace_LAB_BH_hcm, Pace_LAB_BH_chc, Pace_LAB_BH_pla, " \
                             "Pace_LAB_BH_leu, Pace_LAB_BH_leu_NEU_a, Pace_LAB_BH_leu_NEU_b, Pace_LAB_BH_leu_LEU_a, " \
                             "Pace_LAB_BH_leu_LEU_b, Pace_LAB_BH_leu_MON_a, Pace_LAB_BH_leu_MON_b, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_bh SET ID_Pace_LAB_BH = %s, ID_Pace = %s, Pace_LAB_BH_Feca = %s, " \
                              "Pace_LAB_BH_er = %s, Pace_LAB_BH_hb = %s, Pace_LAB_BH_ht = %s, Pace_LAB_BH_vcm = %s, " \
                              "Pace_LAB_BH_hcm = %s, Pace_LAB_BH_chc = %s, Pace_LAB_BH_pla = %s, Pace_LAB_BH_leu = " \
                              "%s, Pace_LAB_BH_leu_NEU_a = %s, Pace_LAB_BH_leu_NEU_b = %s, Pace_LAB_BH_leu_LEU_a = " \
                              "%s, Pace_LAB_BH_leu_LEU_b = %s, Pace_LAB_BH_leu_MON_a = %s, Pace_LAB_BH_leu_MON_b = " \
                              "%s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_BH = "
            delete_Query = "DELETE FROM labo_bh WHERE ID_Pace_LAB_BH = "
            truncate_table_Query = "TRUNCATE labo_bh"
            drop_table_Query = "DROP TABLE labo_bh"

        class Depuraciones:
            Depuraciones = ['ID_Depuraciones', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                            'Variedad',
                            'PVP', 'Foto_Vino']
            cols_Depuraciones = ['ID Depuraciones', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                                 'Crianza',
                                 'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_oh;"
            show_columns = "SHOW columns FROM labo_oh"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_oh'"

            create_Query = """
                CREATE TABLE labo_oh (
                  ID_Pace_LAB_OH int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_LAB_OH_Feca date NOT NULL,
                  Pace_LAB_OH_cre double NOT NULL,
                  Pace_LAB_OH_cru double NOT NULL,
                  Pace_LAB_OH_vul double NOT NULL,
                  Pace_LAB_OH_vum double NOT NULL,
                  Pace_LAB_OH_dec double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Orina de 24 Horas';            
            """

            consult_Query = "SELECT * FROM labo_oh"
            consult_ids_Query = "SELECT ID_Pace_LAB_OH FROM labo_oh"
            consult_last_Query = "SELECT * FROM labo_oh ORDER BY Pace_LAB_OH_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_oh WHERE ID_Pace_LAB_OH = "
            consult_id_patient_Query = "SELECT * FROM labo_oh WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_oh WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_oh (ID_Pace, Pace_LAB_OH_Feca, Pace_LAB_OH_cre, " \
                             "Pace_LAB_OH_cru, Pace_LAB_OH_vul, Pace_LAB_OH_vum, " \
                             "Pace_LAB_OH_dec, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_oh SET ID_Pace_LAB_OH = %s, ID_Pace = %s, Pace_LAB_OH_Feca = %s, " \
                              "Pace_LAB_OH_cre = %s, Pace_LAB_OH_cru = %s, Pace_LAB_OH_vul = %s, Pace_LAB_OH_vum = " \
                              "%s, Pace_LAB_OH_dec = %s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_OH = "
            delete_Query = "DELETE FROM labo_oh WHERE ID_Pace_LAB_OH = "
            truncate_table_Query = "TRUNCATE labo_oh"
            drop_table_Query = "DROP TABLE labo_oh"

        class Electrolitos:
            Electrolitos = ['ID_Electrolitos', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                            'Variedad',
                            'PVP', 'Foto_Vino']
            cols_Electrolitos = ['ID Electrolitos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                                 'Crianza',
                                 'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_es;"
            show_columns = "SHOW columns FROM labo_es"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_es'"

            create_Query = """
            CREATE TABLE labo_es (
              ID_Pace_LAB_ES int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              ID_Pace int(11) NOT NULL,
              Pace_LAB_ES_Feca date NOT NULL,
              Pace_LAB_ES_cal double NOT NULL,
              Pace_LAB_ES_fos double NOT NULL,
              Pace_LAB_ES_mag double NOT NULL,
              Pace_LAB_ES_sod double NOT NULL,
              Pace_LAB_ES_clo double NOT NULL,
              Pace_LAB_ES_pot double NOT NULL,
              Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 
            COLLATE=utf8_unicode_ci 
            COMMENT='Tabla para Electrolitos Sericos.';
            """

            consult_Query = "SELECT * FROM labo_es"
            consult_ids_Query = "SELECT ID_Pace_LAB_ES FROM labo_es"
            consult_last_Query = "SELECT * FROM labo_es ORDER BY Pace_LAB_ES_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_es WHERE ID_Pace_LAB_ES = "
            consult_id_patient_Query = "SELECT * FROM labo_es WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_es WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_es (ID_Pace, " \
                             "Pace_LAB_ES_Feca, Pace_LAB_ES_cal, Pace_LAB_ES_fos, " \
                             "Pace_LAB_ES_mag, Pace_LAB_ES_sod, Pace_LAB_ES_clo, " \
                             "Pace_LAB_ES_pot, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_es SET ID_Pace_LAB_ES = %s, " \
                              "ID_Pace = %s, Pace_LAB_ES_Feca = %s, Pace_LAB_ES_cal = %s, " \
                              "Pace_LAB_ES_fos = %s, Pace_LAB_ES_mag = %s, Pace_LAB_ES_sod = %s, " \
                              "Pace_LAB_ES_clo = %s, Pace_LAB_ES_pot = %s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_ES = "
            delete_Query = "DELETE FROM labo_es WHERE ID_Pace_LAB_ES = "
            truncate_table_Query = "TRUNCATE labo_es"
            drop_table_Query = "DROP TABLE labo_es"

        class Pancreaticos:
            Pancreaticos = ['ID_Pancreaticos', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                            'Variedad',
                            'PVP', 'Foto_Vino']
            cols_Pancreaticos = ['ID Pancreaticos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                                 'Crianza',
                                 'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_ep;"
            show_columns = "SHOW columns FROM labo_ep"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_ep'"

            create_Query = """
            CREATE TABLE labo_ep (
                  ID_Pace_LAB_EP int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_LAB_EP_Feca date NOT NULL,
                  Pace_LAB_EP_ami double NOT NULL,
                  Pace_LAB_EP_lip double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Enzimas Pancreaticas.';
            """

            consult_Query = "SELECT * FROM labo_ep"
            consult_ids_Query = "SELECT ID_Pace_LAB_EP FROM labo_ep"
            consult_last_Query = "SELECT * FROM labo_ep ORDER BY Pace_LAB_EP_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_ep WHERE ID_Pace_LAB_EP = "
            consult_id_patient_Query = "SELECT * FROM labo_ep WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_ep WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_ep (ID_Pace, " \
                             "Pace_LAB_EP_Feca, Pace_LAB_EP_ami, " \
                             "Pace_LAB_EP_lip, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_ep SET ID_Pace_LAB_EP = %s, ID_Pace = %s, " \
                              "Pace_LAB_EP_Feca = %s, " \
                              "Pace_LAB_EP_ami = %s, Pace_LAB_EP_lip = %s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_EP = "
            delete_Query = "DELETE FROM labo_ep WHERE ID_Pace_LAB_EP = "
            truncate_table_Query = "TRUNCATE labo_ep"
            drop_table_Query = "DROP TABLE labo_ep"

        class Reactantes:
            Reactantes = ['ID_Reactantes', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                          'Variedad',
                          'PVP', 'Foto_Vino']
            cols_Reactantes = ['ID Reactantes', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                               'Crianza',
                               'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_rf;"
            show_columns = "SHOW columns FROM labo_rf"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_rf'"

            create_Query = """
            CREATE TABLE labo_rf (
                  ID_Pace_LAB_RF int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_LAB_RF_Feca date NOT NULL,
                  Pace_LAB_RF_pro double NOT NULL,
                  Pace_LAB_RF_vel double NOT NULL,
                  Pace_LAB_RF_prc double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Reactantes de Fase Aguda del Paciente.';
            """

            consult_Query = "SELECT * FROM labo_rf"
            consult_ids_Query = "SELECT ID_Pace_LAB_RF FROM labo_rf"
            consult_last_Query = "SELECT * FROM labo_rf ORDER BY Pace_LAB_RF_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_rf WHERE ID_Pace_LAB_RF = "
            consult_id_patient_Query = "SELECT * FROM labo_rf WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_rf WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_rf (ID_Pace, Pace_LAB_RF_Feca, Pace_LAB_RF_pro, " \
                             "Pace_LAB_RF_vel, Pace_LAB_RF_prc, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_rf SET ID_Pace_LAB_RF = %s, ID_Pace = %s, Pace_LAB_RF_Feca = %s, " \
                              "Pace_LAB_RF_pro = %s, Pace_LAB_RF_vel = %s, Pace_LAB_RF_prc = %s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_RF = "
            delete_Query = "DELETE FROM labo_rf WHERE ID_Pace_LAB_RF = "
            truncate_table_Query = "TRUNCATE labo_rf"
            drop_table_Query = "DROP TABLE labo_rf"

        class Tiroideos:
            Tiroideos = ['ID_Tiroideos', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                         'Variedad',
                         'PVP', 'Foto_Vino']
            cols_Tiroideos = ['ID Tiroideos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_pt;"
            show_columns = "SHOW columns FROM labo_pt"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_pt'"

            create_Query = """
                CREATE TABLE labo_pt (
                  ID_Pace_LAB_PT int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(10) NOT NULL,
                  Pace_LAB_PT_Feca date NOT NULL,
                  Pace_LAB_PT_t3 double NOT NULL,
                  Pace_LAB_PT_t3l double NOT NULL,
                  Pace_LAB_PT_t4 double NOT NULL,
                  Pace_LAB_PT_t4l double NOT NULL,
                  Pace_LAB_PT_tsh double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Perfil Tiroideo.';            
            """

            consult_Query = "SELECT * FROM labo_pt"
            consult_ids_Query = "SELECT ID_Pace_LAB_PT FROM labo_pt"
            consult_last_Query = "SELECT * FROM labo_pt ORDER BY Pace_LAB_PT_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_pt WHERE ID_Pace_LAB_PT = "
            consult_id_patient_Query = "SELECT * FROM labo_pt WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_pt WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_pt (ID_Pace, Pace_LAB_PT_Feca, Pace_LAB_PT_t3, " \
                             "Pace_LAB_PT_t3l, Pace_LAB_PT_t4, Pace_LAB_PT_t4l, Pace_LAB_PT_tsh, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_pt SET ID_Pace_LAB_PT = %s, ID_Pace = %s, Pace_LAB_PT_Feca = %s, " \
                              "Pace_LAB_PT_t3 = %s, Pace_LAB_PT_t3l = %s, Pace_LAB_PT_t4 = %s, Pace_LAB_PT_t4l = %s, " \
                              "Pace_LAB_PT_tsh = %s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_PT = "
            delete_Query = "DELETE FROM labo_pt WHERE ID_Pace_LAB_PT = "
            truncate_table_Query = "TRUNCATE labo_pt"
            drop_table_Query = "DROP TABLE labo_pt"

        class Gasometrias:
            Gasometricos = ['ID_Gasometricos', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                            'Variedad',
                            'PVP', 'Foto_Vino']
            cols_Gasometricos = ['ID Gasometricos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                                 'Crianza',
                                 'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_gas;"
            show_columns = "SHOW columns FROM labo_gas"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_gas'"

            create_Query = """
                CREATE TABLE labo_gas (
                  ID_Labo_Pace_GAS int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(10) NOT NULL,
                  Pace_LAB_GAS_Feca date NOT NULL,
                  Labo_Pace_GAS_ph double NOT NULL,
                  Labo_Pace_GAS_pcoa double NOT NULL,
                  Labo_Pace_GAS_poa double NOT NULL,
                  Labo_Pace_GAS_hco double NOT NULL,
                  Labo_Pace_GAS_hcoS double NOT NULL,
                  Labo_Pace_GAS_eb double NOT NULL,
                  Labo_Pace_GAS_hb double NOT NULL,
                  Labo_Pace_GAS_hto double NOT NULL,
                  Labo_Pace_GAS_tco double NOT NULL,
                  Labo_Pace_GAS_soa double NOT NULL,
                  Labo_Pace_GAS_lac double NOT NULL,
                  Labo_Pace_GAS_tc double NOT NULL,
                  Labo_Pace_GAS_alb double NOT NULL,
                  Labo_Pace_GAS_fio double NOT NULL,
                  Labo_Pace_GAS_grad double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Datos de Gasometria.';
            """

            consult_Query = "SELECT * FROM labo_gas"
            consult_ids_Query = "SELECT ID_Labo_Pace_GAS FROM labo_gas"
            consult_last_Query = "SELECT * FROM labo_gas ORDER BY Pace_LAB_GAS_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_gas WHERE ID_Labo_Pace_GAS = "
            consult_id_patient_Query = "SELECT * FROM labo_gas WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_gas WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_gas (ID_Pace, Pace_LAB_GAS_Feca, Labo_Pace_GAS_ph, " \
                             "Labo_Pace_GAS_pcoa, Labo_Pace_GAS_poa, Labo_Pace_GAS_hco, Labo_Pace_GAS_hcoS, " \
                             "Labo_Pace_GAS_eb, Labo_Pace_GAS_hb, Labo_Pace_GAS_hto, Labo_Pace_GAS_tco, " \
                             "Labo_Pace_GAS_soa, Labo_Pace_GAS_lac, Labo_Pace_GAS_tc, Labo_Pace_GAS_alb, " \
                             "Labo_Pace_GAS_fio, Labo_Pace_GAS_grad, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_gas SET ID_Labo_Pace_GAS = %s, ID_Pace = %s, " \
                              "Pace_LAB_GAS_Feca = %s, Labo_Pace_GAS_ph = %s, " \
                              "Labo_Pace_GAS_pcoa = %s, Labo_Pace_GAS_poa = %s, " \
                              "Labo_Pace_GAS_hco = %s, Labo_Pace_GAS_hcoS = %s, " \
                              "Labo_Pace_GAS_eb = %s, Labo_Pace_GAS_hb = %s, " \
                              "Labo_Pace_GAS_hto = %s, Labo_Pace_GAS_tco = %s, " \
                              "Labo_Pace_GAS_soa = %s, Labo_Pace_GAS_lac = %s, " \
                              "Labo_Pace_GAS_tc = %s, Labo_Pace_GAS_alb = %s, " \
                              "Labo_Pace_GAS_fio = %s, Labo_Pace_GAS_grad = %s, " \
                              "Pace_LAB_Tee = %s " \
                              "WHERE ID_Labo_Pace_GAS = "
            delete_Query = "DELETE FROM labo_gas WHERE ID_Labo_Pace_GAS = "
            truncate_table_Query = "TRUNCATE labo_gas"
            drop_table_Query = "DROP TABLE labo_gas"

        class Iones:
            Iones = ['ID_Iones', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                     'Variedad',
                     'PVP', 'Foto_Vino']
            cols_Iones = ['ID Iones', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                          'Crianza',
                          'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_iu;"
            show_columns = "SHOW columns FROM labo_iu"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_iu'"

            create_Query = """
            CREATE TABLE labo_iu (
                  ID_Pace_LAB_IU int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_LAB_IU_Feca date NOT NULL,
                  Pace_LAB_IU_cal double NOT NULL,
                  Pace_LAB_IU_fos double NOT NULL,
                  Pace_LAB_IU_bic double NOT NULL,
                  Pace_LAB_IU_sod double NOT NULL,
                  Pace_LAB_IU_clo double NOT NULL,
                  Pace_LAB_IU_pot double NOT NULL,
                  Pace_LAB_IU_cre double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Electrolitos Sericos.';
            """

            consult_Query = "SELECT * FROM labo_iu"
            consult_ids_Query = "SELECT ID_Pace_LAB_IU FROM labo_iu"
            consult_last_Query = "SELECT * FROM labo_iu ORDER BY Pace_LAB_IU_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_iu WHERE ID_Pace_LAB_IU = "
            consult_id_patient_Query = "SELECT * FROM labo_iu WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_iu WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_iu (ID_Pace, Pace_LAB_IU_Feca, Pace_LAB_IU_cal, Pace_LAB_IU_fos, " \
                             "Pace_LAB_IU_bic, Pace_LAB_IU_sod, Pace_LAB_IU_clo, Pace_LAB_IU_pot, Pace_LAB_IU_cre, " \
                             "Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_iu SET ID_Pace_LAB_IU = %s, ID_Pace = %s, " \
                              "Pace_LAB_IU_Feca = %s, Pace_LAB_IU_cal = %s, " \
                              "Pace_LAB_IU_fos = %s, Pace_LAB_IU_bic = %s, " \
                              "Pace_LAB_IU_sod = %s, Pace_LAB_IU_clo = %s, " \
                              "Pace_LAB_IU_pot = %s, Pace_LAB_IU_cre = %s, " \
                              "Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_IU = "
            delete_Query = "DELETE FROM labo_iu WHERE ID_Pace_LAB_IU = "
            truncate_table_Query = "TRUNCATE labo_iu"
            drop_table_Query = "DROP TABLE labo_iu"

        class Cuantificaciones:
            Cuantificaciones = ['ID_Cuantificaciones', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza',
                                'Crianza',
                                'Variedad',
                                'PVP', 'Foto_Vino']
            cols_Cuantificaciones = ['ID Cuantificaciones', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen',
                                     'Zona Crianza',
                                     'Crianza',
                                     'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_cd;"
            show_columns = "SHOW columns FROM labo_cd"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_cd'"

            create_Query = """CREATE TABLE labo_cd (
                  ID_Pace_LAB_CD int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_LAB_CD_Feca date NOT NULL,
                  Pace_LAB_CD_cd double NOT NULL,
                  Pace_LAB_CD_ch double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Conteo de CD4 del Paciente.';
            """

            consult_Query = "SELECT * FROM labo_cd"
            consult_ids_Query = "SELECT ID_Pace_LAB_CD FROM labo_cd"
            consult_last_Query = "SELECT * FROM labo_cd ORDER BY Pace_LAB_CD_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_cd WHERE ID_Pace_LAB_CD = "
            consult_id_patient_Query = "SELECT * FROM labo_cd WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_cd WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_cd (ID_Pace, " \
                             "Pace_LAB_CD_Feca, Pace_LAB_CD_cd, " \
                             "Pace_LAB_CD_ch, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_cd SET ID_Pace_LAB_CD = %s, ID_Pace = %s, " \
                              "Pace_LAB_CD_Feca = %s, " \
                              "Pace_LAB_CD_cd = %s, Pace_LAB_CD_ch = %s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_CD = "
            delete_Query = "DELETE FROM labo_cd WHERE ID_Pace_LAB_CD = "
            truncate_table_Query = "TRUNCATE labo_cd"
            drop_table_Query = "DROP TABLE labo_cd"

        class Lipidicos:
            Lipidicos = ['ID_Lipidicos', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                         'Variedad',
                         'PVP', 'Foto_Vino']
            cols_Lipidicos = ['ID Lipidicos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_pl;"
            show_columns = "SHOW columns FROM labo_pl"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_pl'"

            create_Query = """
                CREATE TABLE labo_pl (
                  ID_Pace_LAB_PL int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_LAB_PL_Feca date NOT NULL,
                  Pace_LAB_PL_col double NOT NULL,
                  Pace_LAB_PL_cld double NOT NULL,
                  Pace_LAB_PL_chd double NOT NULL,
                  Pace_LAB_PL_cvd double NOT NULL,
                  Pace_LAB_PL_tri double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Perfil Lipidico de Paciente.';
            """

            consult_Query = "SELECT * FROM labo_pl"
            consult_ids_Query = "SELECT ID_Pace_LAB_PL FROM labo_pl"
            consult_last_Query = "SELECT * FROM labo_pl ORDER BY Pace_LAB_PL_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_pl WHERE ID_Pace_LAB_PL = "
            consult_id_patient_Query = "SELECT * FROM labo_pl WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_pl WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_pl (ID_Pace, Pace_LAB_PL_Feca, Pace_LAB_PL_col, " \
                             "Pace_LAB_PL_cld, Pace_LAB_PL_chd, Pace_LAB_PL_cvd, Pace_LAB_PL_tri, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_pl SET ID_Pace_LAB_PL = %s, ID_Pace = %s, Pace_LAB_PL_Feca = %s, " \
                              "Pace_LAB_PL_col = %s, Pace_LAB_PL_cld = %s, Pace_LAB_PL_chd = %s, Pace_LAB_PL_cvd = " \
                              "%s, Pace_LAB_PL_tri = %s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_PL = "
            delete_Query = "DELETE FROM labo_pl WHERE ID_Pace_LAB_PL = "
            truncate_table_Query = "TRUNCATE labo_pl"
            drop_table_Query = "DROP TABLE labo_pl"

        class Urinarios:
            Urinarios = ['ID_Urinarios', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                         'Variedad',
                         'PVP', 'Foto_Vino']
            cols_Urinarios = ['ID Urinarios', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_ego;"
            show_columns = "SHOW columns FROM labo_ego"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_ego'"

            create_Query = """CREATE TABLE labo_ego (
                  ID_Pace_LAB_EGO int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_LAB_EGO_Feca date NOT NULL,
                  Pace_LAB_EGO_col varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_asp varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_den double NOT NULL,
                  Pace_LAB_EGO_ph double NOT NULL,
                  Pace_LAB_EGO_leu double NOT NULL,
                  Pace_LAB_EGO_nit varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_pro varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_glu varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_cet varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_uro varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_bil varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_eri varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_asc varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_sed_LEU varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_sed_BAC varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_EGO_sed_MUC varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Datos de Examen General de Orina.';
            """

            consult_Query = "SELECT * FROM labo_ego"
            consult_ids_Query = "SELECT ID_Pace_LAB_EGO FROM labo_ego"
            consult_last_Query = "SELECT * FROM labo_ego ORDER BY Pace_LAB_EGO_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_ego WHERE ID_Pace_LAB_EGO = "
            consult_id_patient_Query = "SELECT * FROM labo_ego WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_ego WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_ego (ID_Pace, Pace_LAB_EGO_Feca, Pace_LAB_EGO_col, " \
                             "Pace_LAB_EGO_asp, Pace_LAB_EGO_den, Pace_LAB_EGO_ph, Pace_LAB_EGO_leu, " \
                             "Pace_LAB_EGO_nit, Pace_LAB_EGO_pro, Pace_LAB_EGO_glu, Pace_LAB_EGO_cet, " \
                             "Pace_LAB_EGO_uro, Pace_LAB_EGO_bil, Pace_LAB_EGO_eri, Pace_LAB_EGO_asc, " \
                             "Pace_LAB_EGO_sed_LEU, Pace_LAB_EGO_sed_BAC, Pace_LAB_EGO_sed_MUC, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_ego SET ID_Pace_LAB_EGO = %s, ID_Pace = %s, " \
                              "Pace_LAB_EGO_Feca = %s, Pace_LAB_EGO_col = %s, " \
                              "Pace_LAB_EGO_asp = %s, Pace_LAB_EGO_den = %s, " \
                              "Pace_LAB_EGO_ph = %s, Pace_LAB_EGO_leu = %s, " \
                              "Pace_LAB_EGO_nit = %s, Pace_LAB_EGO_pro = %s, " \
                              "Pace_LAB_EGO_glu = %s, Pace_LAB_EGO_cet = %s, " \
                              "Pace_LAB_EGO_uro = %s, Pace_LAB_EGO_bil = %s, " \
                              "Pace_LAB_EGO_eri = %s, Pace_LAB_EGO_asc = %s, " \
                              "Pace_LAB_EGO_sed_LEU = %s, Pace_LAB_EGO_sed_BAC = %s, " \
                              "Pace_LAB_EGO_sed_MUC = %s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_EGO = "
            delete_Query = "DELETE FROM labo_ego WHERE ID_Pace_LAB_EGO = "
            truncate_table_Query = "TRUNCATE labo_ego"
            drop_table_Query = "DROP TABLE labo_ego"

        class Hepaticos:
            Hepaticos = ['ID_Hepaticos', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                         'Variedad',
                         'PVP', 'Foto_Vino']
            cols_Hepaticos = ['ID Hepaticos', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_pfh;"
            show_columns = "SHOW columns FROM labo_pfh"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_pfh'"

            create_Query = """
            CREATE TABLE labo_pfh (
              ID_Pace_LAB_PFH int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              ID_Pace int(10) NOT NULL,
              Pace_LAB_PFH_Feca date NOT NULL,
              LAB_Pace_PFH_bt double NOT NULL,
              LAB_Pace_PFH_bd double NOT NULL,
              LAB_Pace_PFH_bi double NOT NULL,
              LAB_Pace_PFH_ast double NOT NULL,
              LAB_Pace_PFH_alt double NOT NULL,
              LAB_Pace_PFH_ggt double NOT NULL,
              LAB_Pace_PFH_fa double NOT NULL,
              LAB_Pace_PFH_dhl double NOT NULL,
              LAB_Pace_PFH_pt double NOT NULL,
              LAB_Pace_PFH_alb double NOT NULL,
              LAB_Pace_PFH_rap double NOT NULL,
              REM_pfh_INTO_ANA longtext COLLATE utf8_unicode_ci NOT NULL,
              Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 
            COLLATE=utf8_unicode_ci 
            COMMENT='Tabla para Agregar Laboratorios (Labo_Pace_pfh).';
            """

            consult_Query = "SELECT * FROM labo_pfh"
            consult_ids_Query = "SELECT ID_Pace_LAB_PFH FROM labo_pfh"
            consult_last_Query = "SELECT * FROM labo_pfh ORDER BY Pace_LAB_PFH_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_pfh WHERE ID_Pace_LAB_PFH = "
            consult_id_patient_Query = "SELECT * FROM labo_pfh WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_pfh WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_pfh (ID_Pace, Pace_LAB_PFH_Feca, LAB_Pace_PFH_bt, LAB_Pace_PFH_bd, " \
                             "LAB_Pace_PFH_bi, LAB_Pace_PFH_ast, LAB_Pace_PFH_alt, LAB_Pace_PFH_ggt, LAB_Pace_PFH_fa, " \
                             "LAB_Pace_PFH_dhl, LAB_Pace_PFH_pt, LAB_Pace_PFH_alb, LAB_Pace_PFH_rap, " \
                             "REM_pfh_INTO_ANA, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_pfh SET ID_Pace_LAB_PFH = %s, ID_Pace = %s, Pace_LAB_PFH_Feca = %s, " \
                              "LAB_Pace_PFH_bt = %s, LAB_Pace_PFH_bd = %s, LAB_Pace_PFH_bi = %s, LAB_Pace_PFH_ast = " \
                              "%s, LAB_Pace_PFH_alt = %s, LAB_Pace_PFH_ggt = %s, LAB_Pace_PFH_fa = %s, " \
                              "LAB_Pace_PFH_dhl = %s, LAB_Pace_PFH_pt = %s, LAB_Pace_PFH_alb = %s, LAB_Pace_PFH_rap = " \
                              "%s, REM_pfh_INTO_ANA = %s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_PFH = "
            delete_Query = "DELETE FROM labo_pfh WHERE ID_Pace_LAB_PFH = "
            truncate_table_Query = "TRUNCATE labo_pfh"
            drop_table_Query = "DROP TABLE labo_pfh"

        class Quimicas:
            Quimicas = ['ID_Quimicas', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                        'Variedad',
                        'PVP', 'Foto_Vino']
            cols_Quimicas = ['ID Quimicas', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                             'Crianza',
                             'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_qs;"
            show_columns = "SHOW columns FROM labo_qs"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_qs'"

            create_Query = """
                CREATE TABLE labo_qs (
                  ID_Pace_LAB_QS int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_LAB_QS_Feca date NOT NULL,
                  Pace_LAB_QS_glu double NOT NULL,
                  Pace_LAB_QS_ure double NOT NULL,
                  Pace_LAB_QS_cre double NOT NULL,
                  Pace_LAB_QS_bun double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Quimica Sanguinea.';            
            """

            consult_Query = "SELECT * FROM labo_qs"
            consult_ids_Query = "SELECT ID_Pace_LAB_QS FROM labo_qs"
            consult_last_Query = "SELECT * FROM labo_qs ORDER BY Pace_LAB_QS_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_qs WHERE ID_Pace_LAB_QS = "
            consult_id_patient_Query = "SELECT * FROM labo_qs WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_qs WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_qs (ID_Pace, Pace_LAB_QS_Feca, Pace_LAB_QS_glu, " \
                             "Pace_LAB_QS_ure, Pace_LAB_QS_cre, Pace_LAB_QS_bun, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_qs SET ID_Pace_LAB_QS = %s, ID_Pace = %s, Pace_LAB_QS_Feca = %s, " \
                              "Pace_LAB_QS_glu = %s, Pace_LAB_QS_ure = %s, Pace_LAB_QS_cre = %s, Pace_LAB_QS_bun = " \
                              "%s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_QS = "
            delete_Query = "DELETE FROM labo_qs WHERE ID_Pace_LAB_QS = "
            truncate_table_Query = "TRUNCATE labo_qs"
            drop_table_Query = "DROP TABLE labo_qs"

        class Virales:
            Virales = ['ID_Virales', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                       'Variedad',
                       'PVP', 'Foto_Vino']
            cols_Virales = ['ID Virales', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                            'Crianza',
                            'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_cv;"
            show_columns = "SHOW columns FROM labo_cv"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_cv'"

            create_Query = """
            CREATE TABLE labo_cv (
                  ID_Pace_LAB_CV int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(10) NOT NULL,
                  Pace_LAB_CV_Feca date NOT NULL,
                  LAB_Pace_CV_cv double NOT NULL,
                  LAB_Pace_CV_log double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Carga Viral';
            """

            consult_Query = "SELECT * FROM labo_cv"
            consult_ids_Query = "SELECT ID_Pace_LAB_CV FROM labo_cv"
            consult_last_Query = "SELECT * FROM labo_cv ORDER BY Pace_LAB_CV_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_cv WHERE ID_Pace_LAB_CV = "
            consult_id_patient_Query = "SELECT * FROM labo_cv WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_cv WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_cv (ID_Pace, " \
                             "Pace_LAB_CV_Feca, LAB_Pace_CV_cv, " \
                             "LAB_Pace_CV_log, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_cv SET ID_Pace_LAB_CV = %s, " \
                              "ID_Pace = %s, Pace_LAB_CV_Feca = %s, LAB_Pace_CV_cv = %s, " \
                              "LAB_Pace_CV_log = %s, Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_CV = "
            delete_Query = "DELETE FROM labo_cv WHERE ID_Pace_LAB_CV = "
            truncate_table_Query = "TRUNCATE labo_cv"
            drop_table_Query = "DROP TABLE labo_cv"

        class Coagulaciones:
            Coagulaciones = ['ID_Coagulaciones', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza',
                             'Crianza',
                             'Variedad',
                             'PVP', 'Foto_Vino']
            cols_Coagulaciones = ['ID Coagulaciones', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                                  'Crianza',
                                  'Variedad', 'PVP']

            describe_table = "DESCRIBE labo_ts;"
            show_columns = "SHOW columns FROM labo_ts"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'labo_ts'"

            create_Query = """
                CREATE TABLE labo_ts (
                  ID_Pace_LAB_TS int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  ID_Pace int(11) NOT NULL,
                  Pace_LAB_TS_Feca date NOT NULL,
                  Pace_LAB_TS_ts double NOT NULL,
                  Pace_LAB_TS_tp double NOT NULL,
                  Pace_LAB_TS_inr double NOT NULL,
                  Pace_LAB_TS_tpt double NOT NULL,
                  Pace_LAB_Tee varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Tiempos de Sangrado';            
            """

            consult_Query = "SELECT * FROM labo_ts"
            consult_ids_Query = "SELECT ID_Pace_LAB_TS FROM labo_ts"
            consult_last_Query = "SELECT * FROM labo_ts ORDER BY Pace_LAB_TS_Feca DESC"
            consult_id_Query = "SELECT * FROM labo_ts WHERE ID_Pace_LAB_TS = "
            consult_id_patient_Query = "SELECT * FROM labo_ts WHERE ID_Pace = "
            consult_name_Query = "SELECT * FROM labo_ts WHERE Pace_LAB_Tee LIKE '%"
            register_Query = "INSERT INTO labo_ts (ID_Pace, Pace_LAB_TS_Feca, Pace_LAB_TS_ts, " \
                             "Pace_LAB_TS_tp, Pace_LAB_TS_inr, Pace_LAB_TS_tpt, Pace_LAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE labo_ts SET ID_Pace_LAB_TS = %s, ID_Pace = %s, Pace_LAB_TS_Feca = %s, " \
                              "Pace_LAB_TS_ts = %s, Pace_LAB_TS_tp = %s, Pace_LAB_TS_inr = %s, Pace_LAB_TS_tpt = %s, " \
                              "Pace_LAB_Tee = %s " \
                              "WHERE ID_Pace_LAB_TS = "
            delete_Query = "DELETE FROM labo_ts WHERE ID_Pace_LAB_TS = "
            truncate_table_Query = "TRUNCATE labo_ts"
            drop_table_Query = "DROP TABLE labo_ts"

        class Laboratorios:
            # from Asistente.Actividades.Actividades import Pacientes

            Enologias = ['ID_Enologias', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                         'Variedad',
                         'PVP', 'Foto_Vino']
            cols_enologias = ['ID Enologias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            prosa = "SELECT Estudio, Resultado, Unidad_Medida FROM Laboratorios " \
                    "WHERE Fecha_Registro = CURDATE() AND Tipo_Estudio = '"

            describe_table = "DESCRIBE laboratorios;"
            show_columns = "SHOW columns FROM laboratorios"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'eno_iden'"

            create_Query = """
                CREATE TABLE `laboratorios` (
                  `ID_Laboratorio` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL, 
                  `ID_Pace` int(11) NOT NULL,
                  `Fecha_Registro` DATE NOT NULL, 
                  `Tipo_Estudio` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Estudio` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Resultado` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Unidad_Medida` varchar(50) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='En esta Tabla se agregan los laboratorios de los pacientes';
            """

            consult_Query = "SELECT * FROM laboratorios"
            consult_ids_Query = "SELECT ID_Laboratorio FROM laboratorios"
            consult_last_Query = "SELECT * FROM laboratorios ORDER BY ID_Laboratorio DESC"
            # consult_Query_ID = "SELECT Fecha_Registro, Tipo_Estudio " \
            #                    "FROM laboratorios " \
            #                    "WHERE ID_Pace = " + str(Pacientes.ID) + " group by Fecha_Registro AND Tipo_Estudio"

            consult_id_Query = "SELECT * FROM laboratorios WHERE ID_Laboratorio = "
            consult_name_Query = "SELECT * FROM laboratorios WHERE Tipo_Estudio LIKE '%"
            register_Query = "INSERT INTO laboratorios (ID_Laboratorio, ID_Pace, " \
                             "Fecha_Registro, Tipo_Estudio, Estudio, Resultado, Unidad_Medida) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE laboratorios SET ID_Laboratorio = %s, " \
                              "ID_Pace = %s, Fecha_Registro = %s, Tipo_Estudio = %s, " \
                              "Estudio = %s, Resultado = %s, Unidad_Medida = %s " \
                              "WHERE ID_Laboratorio = "
            delete_Query = "DELETE FROM laboratorios WHERE ID_Laboratorio = "
            truncate_table_Query = "TRUNCATE laboratorios"
            drop_table_Query = "DROP TABLE laboratorios"

    class Gabinetes:
        class Electrocardiogramas:
            Electrocardiogramas = ['ID_Pace_GAB_EC', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza',
                                   'Crianza',
                                   'Variedad',
                                   'PVP', 'Foto_Vino']
            cols_electrocardiogramas = ['ID Electrocardiogramas', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen',
                                        'Zona Crianza', 'Crianza',
                                        'Variedad', 'PVP']

            create_database = "CREATE DATABASE IF NOT EXISTS `bd_reggabo` " \
                              "DEFAULT CHARACTER SET utf8 " \
                              "COLLATE utf8_unicode_ci;"
            show_tables = "SHOW tables;"
            drop_database = "DROP DATABASE `bd_reggabo`"

            describe_table = "DESCRIBE gabo_ecg;"
            show_columns = "SHOW columns FROM gabo_ecg"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'gabo_ecg'"

            create_Query = """CREATE TABLE gabo_ecg (
              `ID_Pace_GAB_EC` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(11) NOT NULL,
              `Pace_GAB_EC_Feca` date NOT NULL,
              `Pace_EC_rit` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_EC_rr` int(50) NOT NULL,
              `Pace_EC_dop` double NOT NULL,
              `Pace_EC_aop` double NOT NULL,
              `Pace_EC_dpr` double NOT NULL,
              `Pace_EC_dqrs` double NOT NULL,
              `Pace_EC_aqrs` double NOT NULL,
              `Pace_EC_qrsi` double NOT NULL,
              `Pace_EC_qrsa` double NOT NULL,
              `Pace_QRS` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_EC_ast_` double NOT NULL,
              `Pace_EC_st` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_EC_dqt` double NOT NULL,
              `Pace_EC_dot` double NOT NULL,
              `Pace_EC_aot` double NOT NULL,
              `EC_rV1` double NOT NULL,
              `EC_sV6` double NOT NULL,
              `EC_sV1` double NOT NULL,
              `EC_rV6` double NOT NULL,
              `EC_rAVL` double NOT NULL,
              `EC_sV3` double NOT NULL,
              `PatronQRS` varchar(100) NOT NULL, 
              `DeflexionIntrinsecoide` int(10) NOT NULL, 
              `EC_rDI` int(10) NOT NULL, 
              `EC_sDI` int(10) NOT NULL, 
              `EC_rDIII` int(10) NOT NULL, 
              `EC_sDIII` int(10) NOT NULL,
              `Pace_EC_CON` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Pace_GAB_Tee` varchar(100) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
            COMMENT='Registro de los electrogramas de los pacientes registrados';"""
            consult_Query = "SELECT * FROM gabo_ecg"
            consult_ids_Query = "SELECT ID_Pace_GAB_EC FROM gabo_ecg"
            consult_last_Query = "SELECT * FROM gabo_ecg ORDER BY ID_Pace_GAB_EC DESC"
            consult_id_Query = "SELECT * FROM gabo_ecg WHERE ID_Pace_GAB_EC = "
            consult_id_patient_Query = "SELECT * FROM gabo_ecg WHERE ID_Pace = "
            consult_name_Query = "SELECT *  FROM gabo_ecg WHERE ID_Pace_GAB_EC LIKE '%"
            register_Query = "INSERT INTO gabo_ecg (ID_Pace, Pace_GAB_EC_Feca, Pace_EC_rit, Pace_EC_rr, Pace_EC_dop, " \
                             "Pace_EC_aop, Pace_EC_dpr, Pace_EC_dqrs, Pace_EC_aqrs, Pace_EC_qrsi, Pace_EC_qrsa, " \
                             "Pace_QRS, Pace_EC_ast_, Pace_EC_st, Pace_EC_dqt, Pace_EC_dot, Pace_EC_aot, EC_rV1, " \
                             "EC_sV6, EC_sV1, EC_rV6, EC_rAVL, EC_sV3, PatronQRS, DeflexionIntrinsecoide, EC_rDI, " \
                             "EC_sDI, EC_rDIII, EC_sDIII, Pace_EC_CON, Pace_GAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s)"
            update_id_Query = "UPDATE gabo_ecg SET ID_Pace_GAB_EC = %s, ID_Pace = %s, Pace_GAB_EC_Feca = %s, " \
                              "Pace_EC_rit = %s, Pace_EC_rr = %s, Pace_EC_dop = %s, Pace_EC_aop = %s, Pace_EC_dpr = " \
                              "%s, Pace_EC_dqrs = %s, Pace_EC_aqrs = %s, Pace_EC_qrsi = %s, Pace_EC_qrsa = %s, " \
                              "Pace_QRS = %s, Pace_EC_ast_ = %s, Pace_EC_st = %s, Pace_EC_dqt = %s, Pace_EC_dot = %s, " \
                              "Pace_EC_aot = %s, EC_rV1 = %s, EC_sV6 = %s, EC_sV1 = %s, EC_rV6 = %s, EC_rAVL = %s, " \
                              "EC_sV3 = %s, PatronQRS = %s, DeflexionIntrinsecoide = %s, EC_rDI = %s, EC_sDI = %s, " \
                              "EC_rDIII = %s, EC_sDIII = %s, Pace_EC_CON = %s, Pace_GAB_Tee = %s " \
                              "WHERE ID_Pace_GAB_EC = "
            delete_Query = "DELETE FROM gabo_ecg WHERE ID_Pace_GAB_EC = "
            truncate_table_Query = "TRUNCATE gabo_ecg"
            drop_table_Query = "DROP TABLE gabo_ecg"

        class Imagenologicos:
            Imagenologia = ['ID_Pace_GAB_EC', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza',
                            'Crianza',
                            'Variedad',
                            'PVP', 'Foto_Vino']
            cols_imagenologia = ['ID Imagenologia', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen',
                                 'Zona Crianza', 'Crianza',
                                 'Variedad', 'PVP']

            create_database = "CREATE DATABASE IF NOT EXISTS `bd_reggabo` " \
                              "DEFAULT CHARACTER SET utf8 " \
                              "COLLATE utf8_unicode_ci;"
            show_tables = "SHOW tables;"
            drop_database = "DROP DATABASE `bd_reggabo`"

            describe_table = "DESCRIBE gabo_rae;"
            show_columns = "SHOW columns FROM gabo_rae"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'gabo_rae'"

            create_Query = """CREATE TABLE gabo_rae (
                  `ID_Pace_GAB_RA` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `Pace_GAB_RA_Feca` date NOT NULL,
                  `Pace_GAB_RA_typ` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_GAB_RA_reg` longtext COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_GAB_RA_hal` longtext COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_GAB_RA_con` longtext COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_GAB_Tee` varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci 
                COMMENT='Registro de los Estudios de imagen realizados a los pacientes.';"""
            consult_Query = "SELECT * FROM gabo_rae"
            consult_ids_Query = "SELECT ID_Pace_GAB_EC FROM gabo_rae"
            consult_last_Query = "SELECT * FROM gabo_rae ORDER BY ID_Pace_GAB_RA DESC"
            consult_id_Query = "SELECT * FROM gabo_rae WHERE ID_Pace_GAB_RA = "
            consult_id_patient_Query = "SELECT * FROM gabo_rae WHERE ID_Pace = "
            consult_name_Query = "SELECT *  FROM gabo_rae WHERE ID_Pace_GAB_RA LIKE '%"
            register_Query = "INSERT INTO gabo_rae (ID_Pace, Pace_GAB_RA_Feca, " \
                             "Pace_GAB_RA_typ, Pace_GAB_RA_reg, Pace_GAB_RA_hal, " \
                             "Pace_GAB_RA_con, Pace_GAB_Tee) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE gabo_rae SET ID_Pace_GAB_RA = %s, ID_Pace = %s, " \
                              "Pace_GAB_RA_Feca = %s, Pace_GAB_RA_typ = %s, " \
                              "Pace_GAB_RA_reg = %s, Pace_GAB_RA_hal = %s, " \
                              "Pace_GAB_RA_con = %s, Pace_GAB_Tee = %s " \
                              "WHERE ID_Pace_GAB_RA = "
            delete_Query = "DELETE FROM gabo_rae WHERE ID_Pace_GAB_RA = "
            truncate_table_Query = "TRUNCATE gabo_rae"
            drop_table_Query = "DROP TABLE gabo_rae"

    class Pacientes:
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regpace` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        drop_database = "DROP DATABASE `bd_regpace`"

        class Identificaciones:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_iden_iden;"
            show_columns = "SHOW columns FROM pace_iden_iden"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_iden_iden'"

            create_Query = """CREATE TABLE `pace_iden_iden` (
                  `ID_Pace` int(10) NOT NULL,
                  `Pace_NSS` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_AGRE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Nome_PI` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Nome_SE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Ape_Pat` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Ape_Mat` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_FIAT` longblob NOT NULL, 
                  `Pace_UMF` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Hosp_Real` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Turo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Feca_Hace` date NOT NULL,
                  `Pace_Hora_Hace` time(6) NOT NULL,
                  `Pace_Tele` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Nace` date NOT NULL,
                  `Pace_Ses` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Hosp` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Curp` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_RFC` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Eda` int(11) NOT NULL,
                  `Pace_Stat` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Ocupa` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Edo_Civ` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Reli` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Esco` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Esco_COM` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Esco_ESPE` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Orig_Muni` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Orig_EntFed` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Resi_Loca` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Resi_Dur` int(11) NOT NULL,
                  `Pace_Domi` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Indi_Pace_SiNo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `IndiIdio_Pace_SiNo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `IndiIdio_Pace_Espe` varchar(50) COLLATE utf8_unicode_ci NOT NULL 
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla es para Agregar Datos Generales de los Pacientes';
            """
            create_Query_identificaciones = """CREATE TABLE `pace_iden_iden` (
                  `ID_Pace` int(10) NOT NULL,
                  `Pace_NSS` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_AGRE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Nome_PI` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Nome_SE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Ape_Pat` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Ape_Mat` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_FIAT` longblob NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla es para Agregar Datos Generales de los Pacientes';
            """
            create_Query_personales = """CREATE TABLE `pace_iden_pers` (
                  `ID_Pace` int(10) NOT NULL,
                  `Pace_UMF` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Hosp_Real` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Turo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Feca_Hace` date NOT NULL,
                  `Pace_Hora_Hace` time(6) NOT NULL,
                  `Pace_Tele` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Nace` date NOT NULL,
                  `Pace_Ses` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Hosp` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Curp` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_RFC` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Eda` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Stat` varchar(100) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla es para Agregar Datos Generales de los Pacientes';            
            """
            create_Query_generales = """CREATE TABLE `pace_iden_hosp` (
                  `ID_Pace` int(10) NOT NULL,
                  `Pace_Ocupa` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Edo_Civ` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Reli` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Esco` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Esco_COM` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Esco_ESPE` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Orig_Muni` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Orig_EntFed` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Resi_Loca` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Resi_Dur` int(11) NOT NULL,
                  `Pace_Domi` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Indi_Pace_SiNo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `IndiIdio_Pace_SiNo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `IndiIdio_Pace_Espe` varchar(50) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla es para Agregar Datos Generales de los Pacientes';
            """

            consult_Query = "SELECT * FROM pace_iden_iden"
            consult_ids_Query = "SELECT ID_Pace FROM pace_iden_iden"
            consult_partial_Query = "SELECT ID_Pace, Pace_NSS, Pace_AGRE, " \
                                    "Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, " \
                                    "Pace_Ape_Mat, " \
                                    "Pace_UMF, Pace_Hosp_Real, Pace_Turo, Pace_Feca_Hace, Pace_Hora_Hace, " \
                                    "Pace_Tele, Pace_Nace, Pace_Ses, Pace_Hosp, Pace_Curp, " \
                                    "Pace_RFC, Pace_Eda, Pace_Stat, " \
                                    "Pace_Ocupa, Pace_Edo_Civ, Pace_Reli, Pace_Esco, Pace_Esco_COM, Pace_Esco_ESPE, " \
                                    "Pace_Orig_Muni, Pace_Orig_EntFed, Pace_Resi_Loca, Pace_Resi_Dur, " \
                                    "Pace_Domi, Indi_Pace_SiNo, " \
                                    "IndiIdio_Pace_SiNo, IndiIdio_Pace_Espe FROM pace_iden_iden"
            consult_last_Query = "SELECT * FROM pace_iden_iden ORDER BY ID_Pace DESC"
            consult_last_partial_Query = "SELECT ID_Pace, Pace_NSS, Pace_AGRE, Pace_Nome_PI, " \
                                         "Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat " \
                                         "FROM pace_iden_iden ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT ID_Pace, Pace_NSS, Pace_AGRE, " \
                               "Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, " \
                               "Pace_Ape_Mat, " \
                               "Pace_UMF, Pace_Hosp_Real, Pace_Turo, Pace_Feca_Hace, Pace_Hora_Hace, " \
                               "Pace_Tele, Pace_Nace, Pace_Ses, Pace_Hosp, Pace_Curp, " \
                               "Pace_RFC, Pace_Eda, Pace_Stat, " \
                               "Pace_Ocupa, Pace_Edo_Civ, Pace_Reli, Pace_Esco, Pace_Esco_COM, Pace_Esco_ESPE, " \
                               "Pace_Orig_Muni, Pace_Orig_EntFed, Pace_Resi_Loca, Pace_Resi_Dur, " \
                               "Pace_Domi, Indi_Pace_SiNo, " \
                               "IndiIdio_Pace_SiNo, IndiIdio_Pace_Espe FROM pace_iden_iden " \
                               "WHERE ID_Pace = "
            consult_name_Query = "SELECT ID_Pace, Pace_NSS, Pace_AGRE, Pace_Nome_PI, " \
                                 "Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, Pace_FIAT " \
                                 "FROM pace_iden_iden WHERE Pace_Ape_Pat LIKE '%"
            consult_photo_Query = "SELECT Pace_FIAT FROM pace_iden_iden"
            consult_photo_id_Query = "SELECT Pace_FIAT FROM pace_iden_iden WHERE ID_Pace = "
            consult_photo_name_Query = "SELECT Pace_FIAT FROM pace_iden_iden WHERE ID_Cie_Dia LIKE '%"
            register_Query = "INSERT INTO pace_iden_iden (" \
                             "Pace_NSS, Pace_AGRE, " \
                             "Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, " \
                             "Pace_UMF, Pace_Hosp_Real, Pace_Turo, Pace_Feca_Hace, Pace_Hora_Hace, " \
                             "Pace_Tele, Pace_Nace, Pace_Ses, Pace_Hosp, Pace_Curp, " \
                             "Pace_RFC, Pace_Eda, Pace_Stat, " \
                             "Pace_Ocupa, Pace_Edo_Civ, Pace_Reli, Pace_Esco, Pace_Esco_COM, Pace_Esco_ESPE, " \
                             "Pace_Orig_Muni, Pace_Orig_EntFed, Pace_Resi_Loca, Pace_Resi_Dur, Pace_Domi, Indi_Pace_SiNo, " \
                             "IndiIdio_Pace_SiNo, IndiIdio_Pace_Espe) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s, " \
                             "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s, " \
                             "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s, " \
                             "%s,%s,%s)"
            register_Query_photo = "INSERT INTO `pace_iden_iden` (`Pace_NSS`, `Pace_AGRE`, " \
                                   "`Pace_Nome_PI`, `Pace_Nome_SE`, `Pace_Ape_Pat`, `Pace_Ape_Mat`, `Pace_FIAT`, " \
                                   "`Pace_UMF`, `Pace_Hosp_Real`, `Pace_Turo`, `Pace_Feca_Hace`, `Pace_Hora_Hace`, " \
                                   "`Pace_Tele`, `Pace_Nace`, `Pace_Ses`, `Pace_Hosp`, `Pace_Curp`, `Pace_RFC`, `Pace_Eda`, `Pace_Stat`, " \
                                   "`Pace_Ocupa`, `Pace_Edo_Civ`, `Pace_Reli`, `Pace_Esco`, `Pace_Esco_COM`, `Pace_Esco_ESPE`, " \
                                   "`Pace_Orig_Muni`, `Pace_Orig_EntFed`, `Pace_Resi_Loca`, `Pace_Resi_Dur`, `Pace_Domi`, `Indi_Pace_SiNo`, " \
                                   "`IndiIdio_Pace_SiNo`, `IndiIdio_Pace_Espe) " \
                                   "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)" \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            register_Query_identificaciones = "INSERT INTO `pace_iden_iden` (`ID_Pace`, `Pace_NSS`, `Pace_AGRE`, `Pace_Nome_PI`, `Pace_Nome_SE`, `Pace_Ape_Pat`, `Pace_Ape_Mat`, `Pace_FIAT`) " \
                                              "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            register_Query_personales = "INSERT INTO `pace_iden_pers` (`ID_Pace`, `Pace_UMF`, `Pace_Hosp_Real`, `Pace_Turo`, `Pace_Feca_Hace`, `Pace_Hora_Hace`, `Pace_Tele`, `Pace_Nace`, `Pace_Ses`, `Pace_Hosp`, `Pace_Curp`, `Pace_RFC`, `Pace_Eda`, `Pace_Stat`) " \
                                        "VALUES (%s, %s, %s, %s, %s, %s, %s)"
            register_Query_generales = "INSERT INTO `pace_iden_hosp` (`ID_Pace`, `Pace_Ocupa`, `Pace_Edo_Civ`, `Pace_Reli`, `Pace_Esco`, `Pace_Esco_COM`, `Pace_Esco_ESPE`, `Pace_Orig_Muni`, `Pace_Orig_EntFed`, `Pace_Resi_Loca`, `Pace_Resi_Dur`, `Pace_Domi`, `Indi_Pace_SiNo`, `IndiIdio_Pace_SiNo`, `IndiIdio_Pace_Espe`) " \
                                       "VALUES (%s, %s, %s, %s, %s, %s)"

            register_photo_Query = "INSERT INTO pace_iden_iden (ID_Pace, Pace_NSS, Pace_AGRE, Pace_Nome_PI, " \
                                   "Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, Pace_FIAT) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_iden_iden " \
                              "SET ID_Pace = %s, Pace_NSS = %s, Pace_AGRE = %s, " \
                              "Pace_Nome_PI = %s, Pace_Nome_SE = %s, Pace_Ape_Pat = %s, Pace_Ape_Mat = %s, " \
                              "Pace_UMF = %s, Pace_Hosp_Real = %s, Pace_Turo = %s, Pace_Feca_Hace = %s, Pace_Hora_Hace = %s, " \
                              "Pace_Tele = %s, Pace_Nace = %s, Pace_Ses = %s, Pace_Hosp = %s, Pace_Curp = %s, " \
                              "Pace_RFC = %s, Pace_Eda = %s, Pace_Stat = %s, " \
                              "Pace_Ocupa = %s, Pace_Edo_Civ = %s, Pace_Reli = %s, Pace_Esco = %s, Pace_Esco_COM = %s, Pace_Esco_ESPE = %s, " \
                              "Pace_Orig_Muni = %s, Pace_Orig_EntFed = %s, Pace_Resi_Loca = %s, Pace_Resi_Dur = %s, Pace_Domi = %s, Indi_Pace_SiNo = %s, " \
                              "IndiIdio_Pace_SiNo = %s, IndiIdio_Pace_Espe = %s " \
                              "WHERE ID_Pace = "
            update_id_photo_Query = "UPDATE pace_iden_iden " \
                                    "SET ID_Pace = %s, Pace_NSS = %s, Pace_AGRE = %s, Pace_Nome_PI = %s, " \
                                    "Pace_Nome_SE = %s, Pace_Ape_Pat = %s, Pace_Ape_Mat = %s, Pace_FIAT = %s " \
                                    "WHERE ID_Pace = "
            delete_Query = "DELETE FROM pace_iden_iden WHERE ID_Pace = "
            truncate_table_Query = "TRUNCATE pace_iden_iden"
            drop_table_Query = "DROP TABLE pace_iden_iden"

        class Heredofamiliares:
            pace_ahf = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_ahf = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_ahf;"
            show_columns = "SHOW columns FROM pace_ahf"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_ahf'"

            create_Query = """CREATE TABLE `pace_ahf` (
              `ID_MEFAM` int(10) NOT NULL,
              `ID_Pace` int(10) NOT NULL,
              `Pace_MEFAM` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `MEFAM_VFS` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `MEFAM_EdaL` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
              `AHF_INFO_APato` varchar(50) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla se Agregan los Registro de AHF_Pace';
            """
            consult_Query = "SELECT * FROM pace_ahf"
            consult_ids_Query = "SELECT ID_Pace FROM pace_ahf"
            consult_partial_Query = "SELECT ID_Pace, Pace_NSS, Pace_AGRE, Pace_Nome_PI, Pace_Nome_SE, Pace_Ape_Pat, " \
                                    "Pace_Ape_Mat FROM pace_ahf "
            consult_last_Query = "SELECT * FROM pace_ahf ORDER BY ID_Pace DESC"
            consult_last_partial_Query = "SELECT ID_Pace, Pace_NSS, Pace_AGRE, Pace_Nome_PI, " \
                                         "Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat " \
                                         "FROM pace_ahf ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT ID_Pace, Pace_NSS, Pace_AGRE, Pace_Nome_PI, " \
                               "Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, Pace_FIAT " \
                               "FROM pace_ahf WHERE ID_Pace = "
            consult_name_Query = "SELECT ID_Pace, Pace_NSS, Pace_AGRE, Pace_Nome_PI, " \
                                 "Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, Pace_FIAT " \
                                 "FROM pace_ahf WHERE ID_Cie_Dia LIKE '%"
            consult_photo_Query = "SELECT Pace_FIAT FROM pace_ahf"
            consult_photo_id_Query = "SELECT Pace_FIAT FROM pace_ahf WHERE ID_Pace = "
            consult_photo_name_Query = "SELECT Pace_FIAT FROM pace_ahf WHERE ID_Cie_Dia LIKE '%"
            register_Query = "INSERT INTO `pace_ahf` (`ID_MEFAM`, `ID_Pace`, `Pace_MEFAM`, `MEFAM_VFS`, `MEFAM_EdaL`, `AHF_INFO_APato`) " \
                             "VALUES (%s,%s,%s,%s,%s,%s)"
            register_photo_Query = "INSERT INTO pace_ahf (ID_Pace, Pace_NSS, Pace_AGRE, Pace_Nome_PI, " \
                                   "Pace_Nome_SE, Pace_Ape_Pat, Pace_Ape_Mat, Pace_FIAT) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_ahf " \
                              "SET ID_Pace = %s, Pace_NSS = %s, Pace_AGRE = %s, Pace_Nome_PI = %s, " \
                              "Pace_Nome_SE = %s, Pace_Ape_Pat = %s, Pace_Ape_Mat = %s " \
                              "WHERE ID_Pace = "
            update_id_photo_Query = "UPDATE pace_ahf " \
                                    "SET ID_Pace = %s, Pace_NSS = %s, Pace_AGRE = %s, Pace_Nome_PI = %s, " \
                                    "Pace_Nome_SE = %s, Pace_Ape_Pat = %s, Pace_Ape_Mat = %s, Pace_FIAT = %s " \
                                    "WHERE ID_Pace = "
            delete_Query = "DELETE FROM pace_ahf WHERE ID_Pace = "
            truncate_table_Query = "TRUNCATE pace_ahf"
            drop_table_Query = "DROP TABLE pace_ahf"

        class Perinatales:
            class Maternos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apn_apm;"
                show_columns = "SHOW columns FROM pace_apn_apm"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apn_apm'"

                create_Query = """
                    CREATE TABLE `pace_apn_apm` (
                      `ID_PACE_APN` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APN_apm_TAB` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_apm_IND` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_apm_INI` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_apm_INI_a` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_apm_ESC` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_apm_OCU` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_apm_CIV` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla de Antecedentes Perinatales de la Madre.';
                """
                consult_Query = "SELECT * FROM pace_apn_apm"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apn_apm"
                consult_partial_Query = "SELECT * FROM pace_apn_apm "
                consult_last_Query = "SELECT * FROM pace_apn_apm ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apn_apm WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apn_apm` (ID_Pace, Pace_APN_apm_TAB, " \
                                 "Pace_APN_apm_IND, Pace_APN_apm_INI, Pace_APN_apm_INI_a, " \
                                 "Pace_APN_apm_ESC, " \
                                 "Pace_APN_apm_OCU, Pace_APN_apm_CIV) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apn_apm " \
                                  "SET ID_PACE_APN = %s, ID_Pace = %s, Pace_APN_apm_TAB = %s, Pace_APN_apm_IND = %s, " \
                                  "Pace_APN_apm_INI = %s, Pace_APN_apm_INI_a = %s, Pace_APN_apm_ESC = %s, " \
                                  "Pace_APN_apm_OCU = %s, Pace_APN_apm_CIV = %s " \
                                  "WHERE ID_PACE_APN = "
                delete_Query = "DELETE FROM pace_apn_apm WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apn_apm"
                drop_table_Query = "DROP TABLE pace_apn_apm"

            class Gestacionales:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apn_amp;"
                show_columns = "SHOW columns FROM pace_apn_amp"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apn_amp'"

                create_Query = """CREATE TABLE `pace_apn_amp` (
                      `ID_PACE_APN_AMP` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APN_amp_GES` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_amp_PAR` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_amp_CES` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_amp_ABO` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_amp_NUH` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_amp_NAH` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_amp_VAH` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_amp_AMO` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_amp_AVA` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Perinatales de la Gestacion.';
                """
                consult_Query = "SELECT * FROM pace_apn_amp"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apn_amp"
                consult_last_Query = "SELECT * FROM pace_apn_amp ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apn_amp WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apn_amp` (ID_Pace, Pace_APN_amp_GES, " \
                                 "Pace_APN_amp_PAR, Pace_APN_amp_CES, " \
                                 "Pace_APN_amp_ABO, Pace_APN_amp_NUH, " \
                                 "Pace_APN_amp_NAH, Pace_APN_amp_VAH, " \
                                 "Pace_APN_amp_AMO, Pace_APN_amp_AVA) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apn_amp " \
                                  "SET ID_PACE_APN_AMP = %s, ID_Pace = %s, Pace_APN_amp_GES = %s, " \
                                  "Pace_APN_amp_PAR = %s, Pace_APN_amp_CES = %s, Pace_APN_amp_ABO = %s, " \
                                  "Pace_APN_amp_NUH = %s, Pace_APN_amp_NAH = %s, Pace_APN_amp_VAH = %s, " \
                                  "Pace_APN_amp_AMO = %s, Pace_APN_amp_AVA = %s " \
                                  "WHERE ID_PACE_APN_AMP = "
                delete_Query = "DELETE FROM pace_apn_amp WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apn_amp"
                drop_table_Query = "DROP TABLE pace_apn_amp"

            class Nacimiento:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apn_an;"
                show_columns = "SHOW columns FROM pace_apn_an"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apn_an'"

                create_Query = """CREATE TABLE `pace_apn_an` (
                      `ID_PACE_APN_AN` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APN_an_EUT` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_HEX` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_SUM` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_PEX` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_PUM` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_FEC` date NOT NULL,
                      `Pace_APN_an_SES` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_EDA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_TAL` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_PAN` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_FAC` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_FER` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_PEC` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_PET` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_PEA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_SEI` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_PIE` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_GAR` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_GAR_a` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_SIL` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_SIL_a` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Perinatales del Nacimiento.';
                """
                consult_Query = "SELECT * FROM pace_apn_an"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apn_an"
                consult_last_Query = "SELECT * FROM pace_apn_an ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apn_an WHERE ID_Pace = "
                register_Query = "INSERT INTO pace_apn_an (ID_Pace, Pace_APN_an_EUT, " \
                                 "Pace_APN_an_HEX, Pace_APN_an_SUM, Pace_APN_an_PEX, " \
                                 "Pace_APN_an_PUM, " \
                                 "Pace_APN_an_FEC, Pace_APN_an_SES, Pace_APN_an_EDA, " \
                                 "Pace_APN_an_TAL, " \
                                 "Pace_APN_an_PAN, Pace_APN_an_FAC, Pace_APN_an_FER, " \
                                 "Pace_APN_an_PEC, " \
                                 "Pace_APN_an_PET, Pace_APN_an_PEA, Pace_APN_an_SEI, " \
                                 "Pace_APN_an_PIE, " \
                                 "Pace_APN_an_GAR, Pace_APN_an_GAR_a, Pace_APN_an_SIL, " \
                                 "Pace_APN_an_SIL_a) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s, " \
                                 "%s,%s)"
                update_id_Query = "UPDATE pace_apn_an " \
                                  "SET ID_PACE_APN_AN = %s, ID_Pace = %s, Pace_APN_an_EUT = %s, Pace_APN_an_HEX = %s, " \
                                  "Pace_APN_an_SUM = %s, Pace_APN_an_PEX = %s, Pace_APN_an_PUM = %s, Pace_APN_an_FEC " \
                                  "= %s, Pace_APN_an_SES = %s, Pace_APN_an_EDA = %s, Pace_APN_an_TAL = %s, " \
                                  "Pace_APN_an_PAN = %s, Pace_APN_an_FAC = %s, Pace_APN_an_FER = %s, Pace_APN_an_PEC " \
                                  "= %s, Pace_APN_an_PET = %s, Pace_APN_an_PEA = %s, Pace_APN_an_SEI = %s, " \
                                  "Pace_APN_an_PIE = %s, Pace_APN_an_GAR = %s, Pace_APN_an_GAR_a = %s, " \
                                  "Pace_APN_an_SIL = %s, Pace_APN_an_SIL_a = %s " \
                                  "WHERE ID_PACE_APN_AN = "
                delete_Query = "DELETE FROM pace_apn_an WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apn_an"
                drop_table_Query = "DROP TABLE pace_apn_an"

            class Trabajos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apn_atp;"
                show_columns = "SHOW columns FROM pace_apn_atp"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apn_atp'"

                create_Query = """CREATE TABLE `pace_apn_atp` (
                      `ID_PACE_APN_ATP` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APN_atp_TTP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_atp_HTP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_atp_AYA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_atp_RRM` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_atp_HRM` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_atp_CLA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_atp_ALA` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Perinatales para Trabajo de Parto.';
                """
                consult_Query = "SELECT * FROM pace_apn_atp"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apn_atp"
                consult_last_Query = "SELECT * FROM pace_apn_atp ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apn_atp WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apn_atp` (ID_Pace, Pace_APN_atp_TTP, " \
                                 "Pace_APN_atp_HTP, Pace_APN_atp_AYA, " \
                                 "Pace_APN_atp_RRM, Pace_APN_atp_HRM, " \
                                 "Pace_APN_atp_CLA, Pace_APN_atp_ALA) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apn_atp " \
                                  "SET ID_PACE_APN_ATP = %s, ID_Pace = %s, Pace_APN_atp_TTP = %s, Pace_APN_atp_HTP = " \
                                  "%s, Pace_APN_atp_AYA = %s, Pace_APN_atp_RRM = %s, Pace_APN_atp_HRM = %s, " \
                                  "Pace_APN_atp_CLA = %s, Pace_APN_atp_ALA = %s " \
                                  "WHERE ID_PACE_APN_ATP = "
                delete_Query = "DELETE FROM pace_apn_atp WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apn_atp"
                drop_table_Query = "DROP TABLE pace_apn_atp"

            class Consultas:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apn_cg;"
                show_columns = "SHOW columns FROM pace_apn_cg"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apn_cg'"

                create_Query = """CREATE TABLE `pace_apn_cg` (
                      `ID_PACE_APN_CG` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APN_cg_CON` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_cg_CON_a` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_cg_VIH` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_cg_VDRL` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_cg_HEM` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_cg_VAC` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Perinatales de Consulta General.';
                """
                consult_Query = "SELECT * FROM pace_apn_cg"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apn_cg"
                consult_last_Query = "SELECT * FROM pace_apn_cg ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apn_cg WHERE ID_Pace = "
                register_Query = "INSERT INTO pace_apn_cg (ID_Pace, Pace_APN_cg_CON, " \
                                 "Pace_APN_cg_CON_a, Pace_APN_cg_VIH, Pace_APN_cg_VDRL, " \
                                 "Pace_APN_cg_HEM, " \
                                 "Pace_APN_cg_VAC) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apn_cg " \
                                  "SET ID_PACE_APN_CG = %s, ID_Pace = %s, Pace_APN_cg_CON = %s, Pace_APN_cg_CON_a = " \
                                  "%s, Pace_APN_cg_VIH = %s, Pace_APN_cg_VDRL = %s, Pace_APN_cg_HEM = %s, " \
                                  "Pace_APN_cg_VAC = %s " \
                                  "WHERE ID_PACE_APN_CG = "
                delete_Query = "DELETE FROM pace_apn_cg WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apn_cg"
                drop_table_Query = "DROP TABLE pace_apn_cg"

            class Pospartos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apn_dn;"
                show_columns = "SHOW columns FROM pace_apn_dn"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apn_dn'"

                create_Query = """CREATE TABLE `pace_apn_dn` (
                      `ID_PACE_APN_DN` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APN_dn_REM` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_MAN` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_APE` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_APA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_TAU` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_MAL` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_VIT` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_CLO` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_ENE` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_FUN` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_VID` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_PLA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_ALI` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_dn_EGE` date NOT NULL,
                      `Pace_APN_dn_INA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_PEA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_SEI` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_PIE` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_GAR` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_GAR_a` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_SIL` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_an_SIL_a` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla de Antecedentes Perinatales despues del Parto.';
                """
                consult_Query = "SELECT * FROM pace_apn_dn"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apn_dn"
                consult_last_Query = "SELECT * FROM pace_apn_dn ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apn_dn WHERE ID_Pace = "
                register_Query = "INSERT INTO pace_apn_dn (ID_Pace, Pace_APN_dn_REM, " \
                                 "Pace_APN_dn_MAN, " \
                                 "Pace_APN_dn_APE, Pace_APN_dn_APA, Pace_APN_dn_TAU, " \
                                 "Pace_APN_dn_MAL, " \
                                 "Pace_APN_dn_VIT, Pace_APN_dn_CLO, Pace_APN_dn_ENE, " \
                                 "Pace_APN_dn_FUN, " \
                                 "Pace_APN_dn_VID, Pace_APN_dn_PLA, Pace_APN_dn_ALI, " \
                                 "Pace_APN_dn_EGE, " \
                                 "Pace_APN_dn_INA, Pace_APN_an_PEA, Pace_APN_an_SEI, " \
                                 "Pace_APN_an_PIE, " \
                                 "Pace_APN_an_GAR, Pace_APN_an_GAR_a, Pace_APN_an_SIL, " \
                                 "Pace_APN_an_SIL_a) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s, " \
                                 "%s,%s,%s)"
                update_id_Query = "UPDATE pace_apn_dn " \
                                  "SET ID_PACE_APN_DN = %s, ID_Pace = %s, Pace_APN_dn_REM = %s, Pace_APN_dn_MAN = %s, " \
                                  "Pace_APN_dn_APE = %s, Pace_APN_dn_APA = %s, Pace_APN_dn_TAU = %s, Pace_APN_dn_MAL " \
                                  "= %s, Pace_APN_dn_VIT = %s, Pace_APN_dn_CLO = %s, Pace_APN_dn_ENE = %s, " \
                                  "Pace_APN_dn_FUN = %s, Pace_APN_dn_VID = %s, Pace_APN_dn_PLA = %s, Pace_APN_dn_ALI " \
                                  "= %s, Pace_APN_dn_EGE = %s, Pace_APN_dn_INA = %s, Pace_APN_an_PEA = %s, " \
                                  "Pace_APN_an_SEI = %s, Pace_APN_an_PIE = %s, Pace_APN_an_GAR = %s, " \
                                  "Pace_APN_an_GAR_a = %s, Pace_APN_an_SIL = %s, Pace_APN_an_SIL_a = %s " \
                                  "WHERE ID_PACE_APN_DN = "
                delete_Query = "DELETE FROM pace_apn_dn WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apn_dn"
                drop_table_Query = "DROP TABLE pace_apn_dn"

            class Previos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apn_rh;"
                show_columns = "SHOW columns FROM pace_apn_rh"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apn_rh'"

                create_Query = """CREATE TABLE pace_apn_rh (
                      `ID_PACE_APN_RH` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APN_rh_CAL` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_rh_COL` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_rh_COD` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_rh_LOC` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_rh_MUN` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APN_rh_EDO` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Perinatales Previos.';
                """
                consult_Query = "SELECT * FROM pace_apn_rh"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apn_rh"
                consult_last_Query = "SELECT * FROM pace_apn_rh ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apn_rh WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apn_rh` (ID_Pace, Pace_APN_rh_CAL, " \
                                 "Pace_APN_rh_COL, Pace_APN_rh_COD, Pace_APN_rh_LOC, " \
                                 "Pace_APN_rh_MUN, " \
                                 "Pace_APN_rh_EDO) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apn_rh " \
                                  "SET ID_PACE_APN_RH = %s, ID_Pace = %s, " \
                                  "Pace_APN_rh_CAL = %s, Pace_APN_rh_COL = %s, " \
                                  "Pace_APN_rh_COD = %s, Pace_APN_rh_LOC = %s, " \
                                  "Pace_APN_rh_MUN = %s, Pace_APN_rh_EDO = %s " \
                                  "WHERE ID_PACE_APN_RH = "
                delete_Query = "DELETE FROM pace_apn_rh WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apn_rh"
                drop_table_Query = "DROP TABLE pace_apn_rh"

        class Epidemiologicos:
            class Eticos:
                pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apnp_eym;"
                show_columns = "SHOW columns FROM pace_apnp_eym"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apnp_eym'"

                create_Query = """CREATE TABLE `pace_apnp_eym` (
                      `ID_PACE_EYM` int(11) PRIMARY_KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(10) NOT NULL,
                      `Pace_EYM_xise` tinyint(1) NOT NULL,
                      `Pace_EYM_xise_CREE` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_EYM_xise_VALO` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_EYM_xise_COSU` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_EYM_REDE` tinyint(1) NOT NULL,
                      `Pace_EYM_REDE_Ma` tinyint(1) NOT NULL,
                      `Pace_EYM_REDE_Pa` tinyint(1) NOT NULL,
                      `Pace_EYM_REDE_He` tinyint(1) NOT NULL,
                      `Pace_EYM_REDE_Hi` tinyint(1) NOT NULL
                    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar A.P.N.P.';
                """
                consult_Query = "SELECT * FROM pace_apnp_eym"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apnp_eym"
                consult_last_Query = "SELECT * FROM pace_apnp_eym ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apnp_eym WHERE ID_Pace = "
                register_Query = "INSERT INTO pace_apnp_eym " \
                                 "(ID_Pace, Pace_EYM_xise, Pace_EYM_xise_CREE, " \
                                 "Pace_EYM_xise_VALO, Pace_EYM_xise_COSU, Pace_EYM_REDE, Pace_EYM_REDE_Ma, " \
                                 "Pace_EYM_REDE_Pa, Pace_EYM_REDE_He, Pace_EYM_REDE_Hi) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apnp_eym " \
                                  "SET ID_PACE_EYM = %s, ID_Pace = %s, Pace_EYM_xise = %s, Pace_EYM_xise_CREE = %s, " \
                                  "Pace_EYM_xise_VALO = %s, Pace_EYM_xise_COSU = %s, Pace_EYM_REDE = %s, " \
                                  "Pace_EYM_REDE_Ma = %s, " \
                                  "Pace_EYM_REDE_Pa = %s, Pace_EYM_REDE_He = %s, Pace_EYM_REDE_Hi = %s " \
                                  "WHERE ID_PACE_EYM = "
                delete_Query = "DELETE FROM pace_apnp_eym WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apnp_eym"
                drop_table_Query = "DROP TABLE pace_apnp_eym"

            class Vivienda:
                pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apnp_hys;"
                show_columns = "SHOW columns FROM pace_apnp_hys"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apnp_hys'"

                create_Query = """CREATE TABLE `pace_apnp_hys` (
                      `ID_PACE_HYS` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APNP_HYS_Feca` date NOT NULL,
                      `Pace_APNP_HYS_Hab_` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HYS_Ser_ele` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Ser_agu` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Ser_alc` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Ser_dre` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Sed_len` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Sed_est` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Sed_tel` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Tes_pa` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Tes_ma` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Tes_ho` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Tes_hi` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Tes_ot` tinyint(1) NOT NULL,
                      `REGE_Pace_APNP_HYS_Tes_ot` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HYS_Coh_pis` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HYS_Coh_tec` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HYS_Coh_pad` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HYS_Coh_sal` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Coh_ban` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Coh_sac` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Coh_cua` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Coe_` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HYS_Coe_pad` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Coe_pat` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Coe_core` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_vac` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `REGE_Pace_APNP_HYS_vac` int(11) NOT NULL,
                      `Pace_APNP_HYS_ovi` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `REGE_Pace_APNP_HYS_ovi` int(11) NOT NULL,
                      `Pace_APNP_HYS_por` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `REGE_Pace_APNP_HYS_por` int(11) NOT NULL,
                      `Pace_APNP_HYS_avi` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `REGE_Pace_APNP_HYS_avi` int(11) NOT NULL,
                      `Pace_APNP_HYS_Coe_coma` tinyint(1) NOT NULL,
                      `Pace_APNP_HYS_Coe_can` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `REGE_Pace_APNP_HYS_Coe_can` int(11) NOT NULL,
                      `Pace_APNP_HYS_Coe_rep` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `REGE_Pace_APNP_HYS_Coe_rep` int(11) NOT NULL,
                      `Pace_APNP_HYS_Coe_fel` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `REGE_Pace_APNP_HYS_Coe_fel` int(11) NOT NULL,
                      `Pace_APNP_HYS_Coe_avi` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `REGE_Pace_APNP_HYS_Coe_avi` int(11) NOT NULL
                    ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla es para Agregar Datos de Vivienda';
                """
                consult_Query = "SELECT * FROM pace_apnp_hys"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apnp_hys"
                consult_last_Query = "SELECT * FROM pace_apnp_hys ORDER BY ID_PACE_HYS DESC"
                consult_id_Query = "SELECT * FROM pace_apnp_hys WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apnp_hys` (ID_Pace, Pace_APNP_HYS_Feca, " \
                                 "Pace_APNP_HYS_Hab_, Pace_APNP_HYS_Ser_ele, Pace_APNP_HYS_Ser_agu, " \
                                 "Pace_APNP_HYS_Ser_alc, Pace_APNP_HYS_Ser_dre, Pace_APNP_HYS_Sed_len, " \
                                 "Pace_APNP_HYS_Sed_est, Pace_APNP_HYS_Sed_tel, Pace_APNP_HYS_Tes_pa, " \
                                 "Pace_APNP_HYS_Tes_ma, Pace_APNP_HYS_Tes_ho, Pace_APNP_HYS_Tes_hi, " \
                                 "Pace_APNP_HYS_Tes_ot, REGE_Pace_APNP_HYS_Tes_ot, Pace_APNP_HYS_Coh_pis, " \
                                 "Pace_APNP_HYS_Coh_tec, Pace_APNP_HYS_Coh_pad, Pace_APNP_HYS_Coh_sal, " \
                                 "Pace_APNP_HYS_Coh_ban, Pace_APNP_HYS_Coh_sac, Pace_APNP_HYS_Coh_cua, " \
                                 "Pace_APNP_HYS_Coe_, Pace_APNP_HYS_Coe_pad, Pace_APNP_HYS_Coe_pat, " \
                                 "Pace_APNP_HYS_Coe_core, Pace_APNP_HYS_vac, REGE_Pace_APNP_HYS_vac, " \
                                 "Pace_APNP_HYS_ovi, REGE_Pace_APNP_HYS_ovi, Pace_APNP_HYS_por, " \
                                 "REGE_Pace_APNP_HYS_por, Pace_APNP_HYS_avi, REGE_Pace_APNP_HYS_avi, " \
                                 "Pace_APNP_HYS_Coe_coma, Pace_APNP_HYS_Coe_can, REGE_Pace_APNP_HYS_Coe_can, " \
                                 "Pace_APNP_HYS_Coe_rep, REGE_Pace_APNP_HYS_Coe_rep, Pace_APNP_HYS_Coe_fel, " \
                                 "REGE_Pace_APNP_HYS_Coe_fel, Pace_APNP_HYS_Coe_avi, REGE_Pace_APNP_HYS_Coe_avi) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apnp_hys " \
                                  "SET ID_PACE_HYS = %s, ID_Pace = %s, Pace_APNP_HYS_Feca = %s, Pace_APNP_HYS_Hab_ = " \
                                  "%s, Pace_APNP_HYS_Ser_ele = %s, Pace_APNP_HYS_Ser_agu = %s, Pace_APNP_HYS_Ser_alc " \
                                  "= %s, Pace_APNP_HYS_Ser_dre = %s, Pace_APNP_HYS_Sed_len = %s, " \
                                  "Pace_APNP_HYS_Sed_est = %s, Pace_APNP_HYS_Sed_tel = %s, Pace_APNP_HYS_Tes_pa = %s, " \
                                  "Pace_APNP_HYS_Tes_ma = %s, Pace_APNP_HYS_Tes_ho = %s, Pace_APNP_HYS_Tes_hi = %s, " \
                                  "Pace_APNP_HYS_Tes_ot = %s, REGE_Pace_APNP_HYS_Tes_ot = %s, Pace_APNP_HYS_Coh_pis = " \
                                  "%s, Pace_APNP_HYS_Coh_tec = %s, Pace_APNP_HYS_Coh_pad = %s, Pace_APNP_HYS_Coh_sal " \
                                  "= %s, Pace_APNP_HYS_Coh_ban = %s, Pace_APNP_HYS_Coh_sac = %s, " \
                                  "Pace_APNP_HYS_Coh_cua = %s, Pace_APNP_HYS_Coe_ = %s, Pace_APNP_HYS_Coe_pad = %s, " \
                                  "Pace_APNP_HYS_Coe_pat = %s, Pace_APNP_HYS_Coe_core = %s, Pace_APNP_HYS_vac = %s, " \
                                  "REGE_Pace_APNP_HYS_vac = %s, Pace_APNP_HYS_ovi = %s, REGE_Pace_APNP_HYS_ovi = %s, " \
                                  "Pace_APNP_HYS_por = %s, REGE_Pace_APNP_HYS_por = %s, Pace_APNP_HYS_avi = %s, " \
                                  "REGE_Pace_APNP_HYS_avi = %s, Pace_APNP_HYS_Coe_coma = %s, Pace_APNP_HYS_Coe_can = " \
                                  "%s, REGE_Pace_APNP_HYS_Coe_can = %s, Pace_APNP_HYS_Coe_rep = %s, " \
                                  "REGE_Pace_APNP_HYS_Coe_rep = %s, Pace_APNP_HYS_Coe_fel = %s, " \
                                  "REGE_Pace_APNP_HYS_Coe_fel = %s, Pace_APNP_HYS_Coe_avi = %s, " \
                                  "REGE_Pace_APNP_HYS_Coe_avi = %s " \
                                  "WHERE ID_PACE_HYS = "
                delete_Query = "DELETE FROM pace_apnp_hys WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apnp_hys"
                drop_table_Query = "DROP TABLE pace_apnp_hys"

            class Alimenticios:
                pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apnp_ali;"
                show_columns = "SHOW columns FROM pace_apnp_ali"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apnp_ali'"

                create_Query = """CREATE TABLE `pace_apnp_ali` (
                      `ID_PACE_APNP_ALI` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APNP_ALI_ali_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_ALI_ali` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_ALI_die_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_ALI_die` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_ALI_var_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_ALI_var` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_ALI_mas_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_ALI_mas` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_ALI_int_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_ALI_int` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_ALI_pes_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_ALI_pes` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla es para Agregar Datos de Habitos Alimentarios';
                """
                consult_Query = "SELECT * FROM pace_apnp_ali"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apnp_ali"
                consult_last_Query = "SELECT * FROM pace_apnp_ali ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apnp_ali WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apnp_ali` (ID_Pace, Pace_APNP_ALI_ali_SINO, " \
                                 "Pace_APNP_ALI_ali, Pace_APNP_ALI_die_SINO, Pace_APNP_ALI_die, " \
                                 "Pace_APNP_ALI_var_SINO, Pace_APNP_ALI_var, Pace_APNP_ALI_mas_SINO, " \
                                 "Pace_APNP_ALI_mas, Pace_APNP_ALI_int_SINO, Pace_APNP_ALI_int, " \
                                 "Pace_APNP_ALI_pes_SINO, Pace_APNP_ALI_pes) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s)"
                update_id_Query = "UPDATE pace_apnp_ali " \
                                  "SET ID_PACE_APNP_ALI = %s, ID_Pace = %s,Pace_APNP_ALI_ali_SINO = %s," \
                                  "Pace_APNP_ALI_ali = %s,Pace_APNP_ALI_die_SINO = %s,Pace_APNP_ALI_die = %s," \
                                  "Pace_APNP_ALI_var_SINO = %s,Pace_APNP_ALI_var = %s,Pace_APNP_ALI_mas_SINO = %s," \
                                  "Pace_APNP_ALI_mas = %s,Pace_APNP_ALI_int_SINO = %s,Pace_APNP_ALI_int = %s," \
                                  "Pace_APNP_ALI_pes_SINO = %s,Pace_APNP_ALI_pes = %s " \
                                  "WHERE ID_PACE_APNP_ALI = "
                delete_Query = "DELETE FROM pace_apnp_ali WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apnp_ali"
                drop_table_Query = "DROP TABLE pace_apnp_ali"

            class Diarios:
                pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apnp_had;"
                show_columns = "SHOW columns FROM pace_apnp_had"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apnp_had'"

                create_Query = """CREATE TABLE `pace_apnp_had` (
                      `ID_PACE_HAD` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APNP_HAD_pas` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HAD_dia` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HAD_sue` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HAD_via_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_HAD_via` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HAD_pof_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_HAD_pol_vif` tinyint(1) NOT NULL,
                      `Pace_APNP_HAD_pol_vit` tinyint(1) NOT NULL,
                      `Pace_APNP_HAD_pol` tinyint(1) NOT NULL,
                      `Pace_APNP_HAD_pol_est` tinyint(1) NOT NULL,
                      `Pace_APNP_HAD_pol_hos` tinyint(1) NOT NULL,
                      `Pace_APNP_HAD_pol_abu` tinyint(1) NOT NULL,
                      `Pace_APNP_HAD_pol_aco` tinyint(1) NOT NULL
                    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Datos de Habitos Diarios';
                """
                consult_Query = "SELECT * FROM pace_apnp_had"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apnp_had"
                consult_last_Query = "SELECT * FROM pace_apnp_had ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apnp_had WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apnp_had` (ID_Pace, Pace_APNP_HAD_pas, " \
                                 "Pace_APNP_HAD_dia, Pace_APNP_HAD_sue, Pace_APNP_HAD_via_SINO, Pace_APNP_HAD_via, " \
                                 "Pace_APNP_HAD_pof_SINO, Pace_APNP_HAD_pol_vif, Pace_APNP_HAD_pol_vit, " \
                                 "Pace_APNP_HAD_pol, Pace_APNP_HAD_pol_est, Pace_APNP_HAD_pol_hos, " \
                                 "Pace_APNP_HAD_pol_abu, Pace_APNP_HAD_pol_aco) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apnp_had " \
                                  "SET ID_PACE_HAD = %s,  ID_Pace = %s,  Pace_APNP_HAD_pas = %s,  Pace_APNP_HAD_dia = " \
                                  "%s,  Pace_APNP_HAD_sue = %s,  Pace_APNP_HAD_via_SINO = %s,  Pace_APNP_HAD_via = " \
                                  "%s,  Pace_APNP_HAD_pof_SINO = %s,  Pace_APNP_HAD_pol_vif = %s,  " \
                                  "Pace_APNP_HAD_pol_vit = %s,  Pace_APNP_HAD_pol = %s,  Pace_APNP_HAD_pol_est = %s,  " \
                                  "Pace_APNP_HAD_pol_hos = %s,  Pace_APNP_HAD_pol_abu = %s,  Pace_APNP_HAD_pol_aco = " \
                                  "%s WHERE ID_PACE_HAD = "
                delete_Query = "DELETE FROM pace_apnp_had WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apnp_had"
                drop_table_Query = "DROP TABLE pace_apnp_had"

            class Higiene:
                pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apnp_hig;"
                show_columns = "SHOW columns FROM pace_apnp_hig"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apnp_hig'"

                create_Query = """CREATE TABLE `pace_apnp_hig` (
                      `ID_PACE_APNP_HIG` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APNP_HIG_Feca` date NOT NULL,
                      `Pace_APNP_HIG_bac_SINO` tinyint(1) NOT NULL,
                      `REGE_Pace_APNP_HIG_bac` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HIG_man_SINO` tinyint(1) NOT NULL,
                      `REGE_Pace_APNP_HIG_man` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HIG_rop_SINO` tinyint(1) NOT NULL,
                      `REGE_Pace_APNP_HIG_rop` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_HIG_den_SINO` tinyint(1) NOT NULL,
                      `REGE_Pace_APNP_HIG_den` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Datos de Habitos Higienicos';
                """
                consult_Query = "SELECT * FROM pace_apnp_hig"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apnp_hig"
                consult_last_Query = "SELECT * FROM pace_apnp_hig ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apnp_hig WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apnp_hig` (ID_Pace, Pace_APNP_HIG_Feca, " \
                                 "Pace_APNP_HIG_bac_SINO, REGE_Pace_APNP_HIG_bac, Pace_APNP_HIG_man_SINO, " \
                                 "REGE_Pace_APNP_HIG_man, Pace_APNP_HIG_rop_SINO, REGE_Pace_APNP_HIG_rop, " \
                                 "Pace_APNP_HIG_den_SINO, REGE_Pace_APNP_HIG_den) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apnp_hig " \
                                  "SET ID_PACE_APNP_HIG = %s,  ID_Pace = %s,  Pace_APNP_HIG_Feca = %s,  " \
                                  "Pace_APNP_HIG_bac_SINO = %s,  REGE_Pace_APNP_HIG_bac = %s,  Pace_APNP_HIG_man_SINO " \
                                  "= %s,  REGE_Pace_APNP_HIG_man = %s,  Pace_APNP_HIG_rop_SINO = %s,  " \
                                  "REGE_Pace_APNP_HIG_rop = %s,  Pace_APNP_HIG_den_SINO = %s,  REGE_Pace_APNP_HIG_den = %s " \
                                  "WHERE ID_PACE_APNP_HIG = "
                delete_Query = "DELETE FROM pace_apnp_hig WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apnp_hig"
                drop_table_Query = "DROP TABLE pace_apnp_hig"

            class Limitaciones:
                pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apnp_lim;"
                show_columns = "SHOW columns FROM pace_apnp_lim"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apnp_lim'"

                create_Query = """CREATE TABLE `pace_apnp_lim` (
                  `ID_PACE_APNP_LIM` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `Pace_APNP_LIM_Feca` date NOT NULL,
                  `Pace_APNP_LIM_len_SINO` tinyint(1) NOT NULL,
                  `Pace_APNP_LIM_sor_SINO` tinyint(1) NOT NULL,
                  `Pace_APNP_LIM_ria_SINO` tinyint(1) NOT NULL,
                  `Pace_APNP_LIM_mar_SINO` tinyint(1) NOT NULL,
                  `Pace_APNP_LIM_dea_SINO` tinyint(1) NOT NULL,
                  `Pace_APNP_LIM_lim_SINO` tinyint(1) NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Datos de Limitación Física';
                """
                consult_Query = "SELECT * FROM pace_apnp_lim"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apnp_lim"
                consult_last_Query = "SELECT * FROM pace_apnp_lim ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apnp_lim WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apnp_lim` (ID_Pace, Pace_APNP_LIM_Feca, " \
                                 "Pace_APNP_LIM_len_SINO, Pace_APNP_LIM_sor_SINO, Pace_APNP_LIM_ria_SINO, " \
                                 "Pace_APNP_LIM_mar_SINO, Pace_APNP_LIM_dea_SINO, Pace_APNP_LIM_lim_SINO) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apnp_lim " \
                                  "SET ID_PACE_APNP_LIM = %s,  ID_Pace = %s,  Pace_APNP_LIM_Feca = %s,  " \
                                  "Pace_APNP_LIM_len_SINO = %s,  Pace_APNP_LIM_sor_SINO = %s,  Pace_APNP_LIM_ria_SINO = %s,  " \
                                  "Pace_APNP_LIM_mar_SINO = %s,  Pace_APNP_LIM_dea_SINO = %s,  " \
                                  "Pace_APNP_LIM_lim_SINO = %s " \
                                  "WHERE ID_PACE_APNP_LIM = "
                delete_Query = "DELETE FROM pace_apnp_lim WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apnp_lim"
                drop_table_Query = "DROP TABLE pace_apnp_lim"

            class Sustancias:
                pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apnp_sus;"
                show_columns = "SHOW columns FROM pace_apnp_sus"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apnp_sus'"

                create_Query = """CREATE TABLE `pace_apnp_sus` (
                      `ID_PACE_APNP_SUS` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APNP_SUS_Feca` date NOT NULL,
                      `Pace_APNP_SUS_len_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_SUS_qui_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_SUS_pes_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_SUS_met_SINO` tinyint(1) NOT NULL,
                      `Pace_APNP_SUS_psi_SINO` tinyint(1) NOT NULL
                    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Datos relacionados con Sustancias Toxicas';
                """
                consult_Query = "SELECT * FROM pace_apnp_sus"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apnp_sus"
                consult_last_Query = "SELECT * FROM pace_apnp_sus ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apnp_sus WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apnp_sus` (ID_Pace, Pace_APNP_SUS_Feca, " \
                                 "Pace_APNP_SUS_len_SINO, Pace_APNP_SUS_qui_SINO, Pace_APNP_SUS_pes_SINO, " \
                                 "Pace_APNP_SUS_met_SINO, Pace_APNP_SUS_psi_SINO) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apnp_sus " \
                                  "SET ID_PACE_APNP_SUS = %s,  ID_Pace = %s,  Pace_APNP_SUS_Feca = %s,  " \
                                  "Pace_APNP_SUS_len_SINO = %s,  Pace_APNP_SUS_qui_SINO = %s,  Pace_APNP_SUS_pes_SINO = %s, " \
                                  "Pace_APNP_SUS_met_SINO = %s,  Pace_APNP_SUS_psi_SINO = %s " \
                                  "WHERE ID_PACE_APNP_SUS = "
                delete_Query = "DELETE FROM pace_apnp_sus WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apnp_sus"
                drop_table_Query = "DROP TABLE pace_apnp_sus"

            class Toxicomanias:
                pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apnp_dro;"
                show_columns = "SHOW columns FROM pace_apnp_dro"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apnp_dro'"

                create_Query = """CREATE TABLE `pace_apnp_dro` (
                  `ID_PACE_APNP_DRO` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `Pace_APNP_DRO_Feca` date NOT NULL,
                  `Pace_APNP_DRO_alc_SINO` tinyint(1) NOT NULL,
                  `REGE_Pace_APNP_DRO_alc_INE` int(200) NOT NULL,
                  `REGE_Pace_APNP_DRO_alc_DUR` int(200) NOT NULL,
                  `REGE_Pace_APNP_DRO_alc_PER` int(200) NOT NULL,
                  `Pace_APNP_DRO_alc_DUR_PER_` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APNP_DRO_alc_SUS_SINO` tinyint(1) NOT NULL,
                  `REGE_Pace_APNP_DRO_alc_SUS` int(200) NOT NULL,
                  `Pace_APNP_DRO_alc_TIP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APNP_DRO_tab_SINO` tinyint(1) NOT NULL,
                  `REGE_Pace_APNP_DRO_tab_INE` int(200) NOT NULL,
                  `REGE_Pace_APNP_DRO_tab_DUR` int(200) NOT NULL,
                  `REGE_Pace_APNP_DRO_tab_PER` int(200) NOT NULL,
                  `Pace_APNP_DRO_tab_DUR_PER_` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APNP_DRO_tab_SUS_SINO` tinyint(1) NOT NULL,
                  `REGE_Pace_APNP_DRO_tab_SUS` int(200) NOT NULL,
                  `Pace_APNP_DRO_tab_TIP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APNP_DRO_tox_SINO` tinyint(1) NOT NULL,
                  `REGE_Pace_APNP_DRO_tox_INE` int(200) NOT NULL,
                  `REGE_Pace_APNP_DRO_tox_DUR` int(200) NOT NULL,
                  `REGE_Pace_APNP_DRO_tox_PER` int(200) NOT NULL,
                  `Pace_APNP_DRO_tox_DUR_PER_` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APNP_DRO_tox_SUS_SINO` tinyint(1) NOT NULL,
                  `REGE_Pace_APNP_DRO_tox_SUS` int(200) NOT NULL,
                  `Pace_APNP_DRO_tox_TIP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar antecedentes de Uso de Drogas Ilegales';
                """
                consult_Query = "SELECT * FROM pace_apnp_dro"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apnp_dro"
                consult_last_Query = "SELECT * FROM pace_apnp_dro ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apnp_dro WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apnp_dro` (ID_Pace, Pace_APNP_DRO_Feca, " \
                                 "Pace_APNP_DRO_alc_SINO, " \
                                 "REGE_Pace_APNP_DRO_alc_INE, REGE_Pace_APNP_DRO_alc_DUR, " \
                                 "REGE_Pace_APNP_DRO_alc_PER, Pace_APNP_DRO_alc_DUR_PER_, " \
                                 "Pace_APNP_DRO_alc_SUS_SINO, " \
                                 "REGE_Pace_APNP_DRO_alc_SUS, Pace_APNP_DRO_alc_TIP, " \
                                 "Pace_APNP_DRO_tab_SINO, " \
                                 "REGE_Pace_APNP_DRO_tab_INE, REGE_Pace_APNP_DRO_tab_DUR, " \
                                 "REGE_Pace_APNP_DRO_tab_PER, Pace_APNP_DRO_tab_DUR_PER_, " \
                                 "Pace_APNP_DRO_tab_SUS_SINO, " \
                                 "REGE_Pace_APNP_DRO_tab_SUS, Pace_APNP_DRO_tab_TIP, " \
                                 "Pace_APNP_DRO_tox_SINO, " \
                                 "REGE_Pace_APNP_DRO_tox_INE, REGE_Pace_APNP_DRO_tox_DUR, " \
                                 "REGE_Pace_APNP_DRO_tox_PER, Pace_APNP_DRO_tox_DUR_PER_, " \
                                 "Pace_APNP_DRO_tox_SUS_SINO, " \
                                 "REGE_Pace_APNP_DRO_tox_SUS, Pace_APNP_DRO_tox_TIP) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_apnp_dro " \
                                  "SET ID_PACE_APNP_DRO = %s,  ID_Pace = %s,  Pace_APNP_DRO_Feca = %s,  " \
                                  "Pace_APNP_DRO_alc_SINO = %s,  REGE_Pace_APNP_DRO_alc_INE = %s,  " \
                                  "REGE_Pace_APNP_DRO_alc_DUR = %s,  REGE_Pace_APNP_DRO_alc_PER = %s,  " \
                                  "Pace_APNP_DRO_alc_DUR_PER_ = %s,  Pace_APNP_DRO_alc_SUS_SINO = %s,  " \
                                  "REGE_Pace_APNP_DRO_alc_SUS = %s,  Pace_APNP_DRO_alc_TIP = %s,  " \
                                  "Pace_APNP_DRO_tab_SINO = %s,  REGE_Pace_APNP_DRO_tab_INE = %s,  " \
                                  "REGE_Pace_APNP_DRO_tab_DUR = %s,  REGE_Pace_APNP_DRO_tab_PER = %s,  " \
                                  "Pace_APNP_DRO_tab_DUR_PER_ = %s,  Pace_APNP_DRO_tab_SUS_SINO = %s,  " \
                                  "REGE_Pace_APNP_DRO_tab_SUS = %s,  Pace_APNP_DRO_tab_TIP = %s,  " \
                                  "Pace_APNP_DRO_tox_SINO = %s,  REGE_Pace_APNP_DRO_tox_INE = %s,  " \
                                  "REGE_Pace_APNP_DRO_tox_DUR = %s,  REGE_Pace_APNP_DRO_tox_PER = %s,  " \
                                  "Pace_APNP_DRO_tox_DUR_PER_ = %s,  Pace_APNP_DRO_tox_SUS_SINO = %s,  " \
                                  "REGE_Pace_APNP_DRO_tox_SUS = %s,  Pace_APNP_DRO_tox_TIP = %s " \
                                  "WHERE ID_Pace = "
                delete_Query = "DELETE FROM pace_apnp_dro WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apnp_dro"
                drop_table_Query = "DROP TABLE pace_apnp_dro"

            class Inmunizaciones:
                pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_apnp_ali = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_apnp_inu;"
                show_columns = "SHOW columns FROM pace_apnp_inu"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_apnp_inu'"

                create_Query = """CREATE TABLE `pace_apnp_inu` (
                      `ID_PACE_APNP_INU` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APNP_INU_inu_TIP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APNP_INU_Feca` date NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar antecedentes de Inmunizaciones';
                """
                consult_Query = "SELECT * FROM pace_apnp_inu"
                consult_ids_Query = "SELECT ID_Pace FROM pace_apnp_inu"
                consult_last_Query = "SELECT * FROM pace_apnp_inu ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_apnp_inu WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_apnp_inu` (ID_Pace, Pace_APNP_INU_inu_TIP, Pace_APNP_INU_Feca) " \
                                 "VALUES (%s,%s,%s)"
                update_id_Query = "UPDATE pace_apnp_inu " \
                                  "SET ID_PACE_APNP_INU = %s,  ID_Pace = %s, " \
                                  "Pace_APNP_INU_inu_TIP = %s,  Pace_APNP_INU_Feca = %s " \
                                  "WHERE ID_Pace = "
                delete_Query = "DELETE FROM pace_apnp_inu WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_apnp_inu"
                drop_table_Query = "DROP TABLE pace_apnp_inu"

        class Patologicos:
            class Alergicos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_app_ale;"
                show_columns = "SHOW columns FROM pace_app_ale"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_app_ale'"

                create_Query = """CREATE TABLE pace_app_ale (
                      `ID_PACE_APP_ALE` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_ALE_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_ALE` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_ALE_com` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_ALE_dia` int(200) NOT NULL,
                      `Pace_APP_ALE_tra_SINO` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_ALE_tra` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Alérgicos.';
                """
                consult_Query = "SELECT * FROM pace_app_ale"
                consult_ids_Query = "SELECT ID_Pace FROM pace_app_ale"
                consult_last_Query = "SELECT * FROM pace_app_ale ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_app_ale WHERE ID_PACE_APP_ALE = "
                register_Query = "INSERT INTO pace_app_ale (ID_Pace, " \
                                 "Pace_APP_ALE_SINO, Pace_APP_ALE, Pace_APP_ALE_dia, Pace_APP_ALE_com, " \
                                 "Pace_APP_ALE_tra_SINO, Pace_APP_ALE_tra) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_app_ale " \
                                  "SET ID_PACE_APP_ALE = %s, ID_Pace = %s, " \
                                  "Pace_APP_ALE_SINO = %s, Pace_APP_ALE = %s, " \
                                  "Pace_APP_ALE_com = %s, " \
                                  "Pace_APP_ALE_dia = %s, Pace_APP_ALE_tra_SINO = %s, " \
                                  "Pace_APP_ALE_tra = %s " \
                                  "WHERE ID_PACE_APP_ALE = "
                delete_Query = "DELETE FROM pace_app_ale WHERE ID_PACE_APP_ALE = "
                truncate_table_Query = "TRUNCATE pace_app_ale"
                drop_table_Query = "DROP TABLE pace_app_ale"

            class Congenitos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_app_con;"
                show_columns = "SHOW columns FROM pace_app_con"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_app_con'"

                create_Query = """CREATE TABLE pace_app_con (
                      `ID_PACE_APP_CON` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_CON_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_CON` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_CON_dia` int(200) NOT NULL,
                      `Pace_APP_CON_tra` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_CON_sus` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Congénitos.';
                """
                consult_Query = "SELECT * FROM pace_app_con"
                consult_ids_Query = "SELECT ID_Pace FROM pace_app_con"
                consult_last_Query = "SELECT * FROM pace_app_con ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_app_con WHERE ID_PACE_APP_CON = "
                register_Query = "INSERT INTO pace_app_con (ID_Pace, Pace_APP_CON_SINO, " \
                                 "Pace_APP_CON, Pace_APP_CON_dia, Pace_APP_CON_tra, Pace_APP_CON_sus) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_app_con " \
                                  "SET ID_PACE_APP_CON = %s, ID_Pace = %s, " \
                                  "Pace_APP_CON_SINO = %s, Pace_APP_CON = %s, " \
                                  "Pace_APP_CON_dia = %s, " \
                                  "Pace_APP_CON_tra = %s, Pace_APP_CON_sus = %s " \
                                  "WHERE ID_PACE_APP_CON = "
                delete_Query = "DELETE FROM pace_app_con WHERE ID_PACE_APP_CON = "
                truncate_table_Query = "TRUNCATE pace_app_con"
                drop_table_Query = "DROP TABLE pace_app_con"

            class Degenerativos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_app_deg;"
                show_columns = "SHOW columns FROM pace_app_deg"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_app_deg'"

                create_Query = """CREATE TABLE `pace_app_deg` (
                        `ID_PACE_APP_DEG` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                        `ID_Pace` int(11) NOT NULL,
                        `Pace_APP_DEG_SINO` tinyint(1) NOT NULL,
                        `Pace_APP_DEG` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        `Pace_APP_DEG_com` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                        `Pace_APP_DEG_dia` int(200) NOT NULL,
                        `Pace_APP_DEG_tra_SINO` tinyint(1) NOT NULL,
                        `Pace_APP_DEG_tra` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                        `Pace_APP_DEG_sus_SINO` tinyint(1) NOT NULL,
                        `Pace_APP_DEG_sus` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Cronico Degenerativos';
                """
                consult_Query = "SELECT * FROM pace_app_deg"
                consult_patient_Query = "SELECT * FROM pace_app_deg WHERE ID_Pace = "
                consult_ids_Query = "SELECT ID_Pace FROM pace_app_deg"
                consult_last_Query = "SELECT * FROM pace_app_deg ORDER BY ID_PACE_APP_DEG DESC"
                consult_id_Query = "SELECT * FROM pace_app_deg WHERE ID_PACE_APP_DEG = "
                register_Query = "INSERT INTO `pace_app_deg` (ID_Pace, Pace_APP_DEG_SINO, " \
                                 "Pace_APP_DEG, Pace_APP_DEG_com, " \
                                 "Pace_APP_DEG_dia, Pace_APP_DEG_tra_SINO, " \
                                 "Pace_APP_DEG_tra, Pace_APP_DEG_sus_SINO, " \
                                 "Pace_APP_DEG_sus) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_app_deg " \
                                  "SET ID_PACE_APP_DEG = %s,  ID_Pace = %s, " \
                                  "Pace_APP_DEG_SINO = %s, Pace_APP_DEG = %s, " \
                                  "Pace_APP_DEG_com = %s, Pace_APP_DEG_dia = %s, " \
                                  "Pace_APP_DEG_tra_SINO = %s,  " \
                                  "Pace_APP_DEG_tra = %s, Pace_APP_DEG_sus_SINO = %s, " \
                                  "Pace_APP_DEG_sus = %s " \
                                  "WHERE ID_PACE_APP_DEG = "
                delete_Query = "DELETE FROM pace_app_deg WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_app_deg"
                drop_table_Query = "DROP TABLE pace_app_deg"

            class Infantiles:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_app_inf;"
                show_columns = "SHOW columns FROM pace_app_inf"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_app_inf'"

                create_Query = """CREATE TABLE pace_app_inf (
                      `ID_PACE_APP_INF` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_INF_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_INF` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_INF_dia` int(11) NOT NULL,
                      `Pace_APP_INF_tra` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Enfermedades de la Infancia';
                """
                consult_Query = "SELECT * FROM pace_app_inf"
                consult_ids_Query = "SELECT ID_Pace FROM pace_app_inf"
                consult_last_Query = "SELECT * FROM pace_app_inf ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_app_inf WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_app_inf` (ID_PACE_APP_INF, ID_Pace, Pace_APP_INF_SINO, " \
                                 "Pace_APP_INF, Pace_APP_INF_dia, Pace_APP_INF_tra) " \
                                 "VALUES (%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_app_inf " \
                                  "SET ID_PACE_APP_INF = %s, ID_Pace = %s, Pace_APP_INF_SINO = %s, Pace_APP_INF = %s, " \
                                  "Pace_APP_INF_dia = %s, Pace_APP_INF_tra = %s " \
                                  "WHERE ID_PACE_APP_INF = "
                delete_Query = "DELETE FROM pace_app_inf WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_app_inf"
                drop_table_Query = "DROP TABLE pace_app_inf"

            class Quirurgicos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_app_qui;"
                show_columns = "SHOW columns FROM pace_app_qui"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_app_qui'"

                create_Query = """CREATE TABLE pace_app_qui (
                      `ID_PACE_APP_QUI` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_QUI_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_QUI` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_QUI_dia` int(200) NOT NULL,
                      `Pace_APP_QUI_com_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_QUI_com` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Quirurgicos.';
                """
                consult_Query = "SELECT * FROM pace_app_qui"
                consult_ids_Query = "SELECT ID_Pace FROM pace_app_qui"
                consult_last_Query = "SELECT * FROM pace_app_qui ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_app_qui WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_app_qui` (ID_Pace, Pace_APP_QUI_SINO, Pace_APP_QUI, " \
                                 "Pace_APP_QUI_dia, Pace_APP_QUI_com_SINO, Pace_APP_QUI_com) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_app_qui " \
                                  "SET ID_PACE_APP_QUI = %s, ID_Pace = %s, Pace_APP_QUI_SINO = %s, Pace_APP_QUI = %s, " \
                                  "Pace_APP_QUI_dia = %s, Pace_APP_QUI_com_SINO = %s, Pace_APP_QUI_com = %s " \
                                  "WHERE ID_PACE_APP_QUI = "
                delete_Query = "DELETE FROM pace_app_qui WHERE ID_Pace = "
                truncate_table_Query = "TRUNCATE pace_app_qui"
                drop_table_Query = "DROP TABLE pace_app_qui"

            class Transfusionales:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_app_tra;"
                show_columns = "SHOW columns FROM pace_app_tra"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_app_tra'"

                create_Query = """CREATE TABLE pace_app_tra (
                      `ID_PACE_APP_TRA` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_TRA_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_TRA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_TRA_dia` int(11) NOT NULL,
                      `Pace_APP_TRA_com_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_TRA_com` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Transfusionales.';
                """
                consult_Query = "SELECT * FROM pace_app_tra"
                consult_ids_Query = "SELECT ID_Pace FROM pace_app_tra"
                consult_last_Query = "SELECT * FROM pace_app_tra ORDER BY ID_PACE_APP_TRA DESC"
                consult_id_Query = "SELECT * FROM pace_app_tra WHERE ID_PACE_APP_TRA = "
                register_Query = "INSERT INTO `pace_app_tra` (ID_Pace, Pace_APP_TRA_SINO, " \
                                 "Pace_APP_TRA, Pace_APP_TRA_dia, Pace_APP_TRA_com_SINO, " \
                                 "Pace_APP_TRA_com) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_app_tra " \
                                  "SET ID_PACE_APP_TRA = %s, ID_Pace = %s, Pace_APP_TRA_SINO = %s, " \
                                  "Pace_APP_TRA = %s, Pace_APP_TRA_dia = %s, " \
                                  "Pace_APP_TRA_com_SINO = %s, Pace_APP_TRA_com = %s " \
                                  "WHERE ID_PACE_APP_TRA = "
                delete_Query = "DELETE FROM pace_app_tra WHERE ID_PACE_APP_TRA = "
                truncate_table_Query = "TRUNCATE pace_app_tra"
                drop_table_Query = "DROP TABLE pace_app_tra"

            class Transmisibles:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_app_tra;"
                show_columns = "SHOW columns FROM pace_app_tra"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_app_tra'"

                create_Query = """CREATE TABLE pace_app_tra (
                      `ID_PACE_APP_TRA` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_TRA_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_TRA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_TRA_dia` date NOT NULL,
                      `Pace_APP_TRA_com_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_TRA_com` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Transfusionales.';
                """
                consult_Query = "SELECT * FROM pace_app_tra"
                consult_ids_Query = "SELECT ID_Pace FROM pace_app_tra"
                consult_last_Query = "SELECT * FROM pace_app_tra ORDER BY ID_PACE_APP_TRA DESC"
                consult_id_Query = "SELECT * FROM pace_app_tra WHERE ID_PACE_APP_TRA = "
                register_Query = "INSERT INTO `pace_app_tra` (ID_PACE_APP_TRA, ID_Pace, Pace_APP_TRA_SINO, " \
                                 "Pace_APP_TRA, Pace_APP_TRA_dia, Pace_APP_TRA_com_SINO, Pace_APP_TRA_com) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_app_tra " \
                                  "SET ID_PACE_APP_TRA = %s, ID_Pace = %s, Pace_APP_TRA_SINO = %s, Pace_APP_TRA = %s, " \
                                  "Pace_APP_TRA_dia = %s, Pace_APP_TRA_com_SINO = %s, Pace_APP_TRA_com = %s " \
                                  "WHERE ID_PACE_APP_TRA = "
                delete_Query = "DELETE FROM pace_app_tra WHERE ID_PACE_APP_TRA = "
                truncate_table_Query = "TRUNCATE pace_app_tra"
                drop_table_Query = "DROP TABLE pace_app_tra"

            class Traumaticos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_app_tra;"
                show_columns = "SHOW columns FROM pace_app_tra"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_app_tra'"

                create_Query = """CREATE TABLE pace_app_tra (
                      `ID_PACE_APP_TRA` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `Pace_APP_TRA_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_TRA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APP_TRA_dia` date NOT NULL,
                      `Pace_APP_TRA_com_SINO` tinyint(1) NOT NULL,
                      `Pace_APP_TRA_com` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes Transfusionales.';
                """
                consult_Query = "SELECT * FROM pace_app_tra"
                consult_ids_Query = "SELECT ID_Pace FROM pace_app_tra"
                consult_last_Query = "SELECT * FROM pace_app_tra ORDER BY ID_PACE_APP_TRA DESC"
                consult_id_Query = "SELECT * FROM pace_app_tra WHERE ID_PACE_APP_TRA = "
                register_Query = "INSERT INTO `pace_app_tra` (ID_PACE_APP_TRA, ID_Pace, Pace_APP_TRA_SINO, " \
                                 "Pace_APP_TRA, Pace_APP_TRA_dia, Pace_APP_TRA_com_SINO, Pace_APP_TRA_com) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_app_tra " \
                                  "SET ID_PACE_APP_TRA = %s, ID_Pace = %s, Pace_APP_TRA_SINO = %s, Pace_APP_TRA = %s, " \
                                  "Pace_APP_TRA_dia = %s, Pace_APP_TRA_com_SINO = %s, Pace_APP_TRA_com = %s " \
                                  "WHERE ID_PACE_APP_TRA = "
                delete_Query = "DELETE FROM pace_app_tra WHERE ID_PACE_APP_TRA = "
                truncate_table_Query = "TRUNCATE pace_app_tra"
                drop_table_Query = "DROP TABLE pace_app_tra"

        class Sexuales:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_aps;"
            show_columns = "SHOW columns FROM pace_aps"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_aps'"

            create_Query = """CREATE TABLE `pace_aps` (
                  `ID_Pace_APS_ets_` int(11) NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `Pace_APS_ets_SINO` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets_DIA` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets_TRA_SINO` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets_TRA` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets_SUS_` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_APS_ets_SUS` varchar(300) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Antecedentes de Enf. de Transmision Sexual';
            """
            consult_Query = "SELECT * FROM pace_aps"
            consult_ids_Query = "SELECT ID_Pace FROM pace_aps"
            consult_last_Query = "SELECT * FROM pace_aps ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_iden_iden WHERE ID_Pace = "
            register_Query = "INSERT INTO `pace_aps` (ID_Pace, Pace_APS_ets_SINO, Pace_APS_ets, " \
                             "Pace_APS_ets_DIA, Pace_APS_ets_TRA_SINO, Pace_APS_ets_TRA, Pace_APS_ets_SUS_, " \
                             "Pace_APS_ets_SUS) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_aps " \
                              "SET ID_Pace_APS_ets_ = %s,  ID_Pace = %s,  Pace_APS_ets_SINO = %s,  Pace_APS_ets = " \
                              "%s,  Pace_APS_ets_DIA = %s,  Pace_APS_ets_TRA_SINO = %s,  Pace_APS_ets_TRA = %s,  " \
                              "Pace_APS_ets_SUS_ = %s,  Pace_APS_ets_SUS = %s " \
                              "WHERE ID_Pace = "
            delete_Query = "DELETE FROM pace_aps WHERE ID_Pace = "
            truncate_table_Query = "TRUNCATE pace_aps"
            drop_table_Query = "DROP TABLE pace_aps"

            class Femeninos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_aps_femi;"
                show_columns = "SHOW columns FROM pace_aps_femi"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_aps_femi'"

                create_Query = """CREATE TABLE `pace_aps_femi` (
                      `ID_PACE_APS` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `PACE_APS_Feca` date NOT NULL,
                      `Pace_APS_arc` tinyint(1) NOT NULL,
                      `REGE_Pace_APS_arc` int(11) NOT NULL,
                      `Pace_APS_cat_DIA` int(200) NOT NULL,
                      `Pace_APS_cat_CIC` int(200) NOT NULL,
                      `Pace_APS_pub_SINO` tinyint(1) NOT NULL,
                      `Pace_APS_pub` int(200) NOT NULL,
                      `Pace_APS_tel_SINO` tinyint(1) NOT NULL,
                      `REGE_Pace_APS_tel` int(200) NOT NULL,
                      `FEF_Pace_APS_fur` date NOT NULL,
                      `REGE_Pace_APS_ivs` int(200) NOT NULL,
                      `REGE_Pace_APS_pas` int(200) NOT NULL,
                      `Pace_APS_ise_` varchar(200) COLLATE utf8_unicode_520_ci NOT NULL,
                      `Pace_APS_mpf_` varchar(200) COLLATE utf8_unicode_520_ci NOT NULL,
                      `REGE_Pace_APS_ago_GES` int(200) NOT NULL,
                      `REGE_Pace_APS_ago_PAR` int(200) NOT NULL,
                      `REGE_Pace_APS_ago_CES` int(200) NOT NULL,
                      `REGE_Pace_APS_ago_ABO` int(200) NOT NULL,
                      `Pace_APS_ago_CLI_SINO` tinyint(1) NOT NULL,
                      `REGE_Pace_APS_ago_CLI` int(200) NOT NULL,
                      `Pace_APS_ago_MEN_` tinyint(1) NOT NULL,
                      `REGE_Pace_APS_ago_MEN` int(200) NOT NULL,
                      `Pace_APS_ago_PAP_` tinyint(1) NOT NULL,
                      `FEF_Pace_APS_ago_PAP` date NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci COMMENT='Tabla para Antecedentes Gineco - Obstetricos';
                """
                consult_Query = "SELECT * FROM pace_iden_iden"
                consult_ids_Query = "SELECT ID_Pace FROM pace_iden_iden"
                consult_last_Query = "SELECT * FROM pace_aps_femi ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_aps_femi WHERE ID_Pace = "
                register_Query = "INSERT INTO pace_aps_femi (ID_Pace, PACE_APS_Feca, Pace_APS_arc, " \
                                 "REGE_Pace_APS_arc, Pace_APS_cat_DIA, Pace_APS_cat_CIC, Pace_APS_pub_SINO, " \
                                 "Pace_APS_pub, Pace_APS_tel_SINO, REGE_Pace_APS_tel, FEF_Pace_APS_fur, " \
                                 "REGE_Pace_APS_ivs, REGE_Pace_APS_pas, Pace_APS_ise_, Pace_APS_mpf_, " \
                                 "REGE_Pace_APS_ago_GES, REGE_Pace_APS_ago_PAR, REGE_Pace_APS_ago_CES, " \
                                 "REGE_Pace_APS_ago_ABO, Pace_APS_ago_CLI_SINO, REGE_Pace_APS_ago_CLI, " \
                                 "Pace_APS_ago_MEN_, REGE_Pace_APS_ago_MEN, Pace_APS_ago_PAP_, " \
                                 "FEF_Pace_APS_ago_PAP)" \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_aps_femi " \
                                  "SET ID_PACE_APS = %s, ID_Pace = %s, PACE_APS_Feca = %s, Pace_APS_arc = %s, " \
                                  "REGE_Pace_APS_arc = %s, Pace_APS_cat_DIA = %s, Pace_APS_cat_CIC = %s, " \
                                  "Pace_APS_pub_SINO = %s, Pace_APS_pub = %s, Pace_APS_tel_SINO = %s, " \
                                  "REGE_Pace_APS_tel = %s, FEF_Pace_APS_fur = %s, REGE_Pace_APS_ivs = %s, " \
                                  "REGE_Pace_APS_pas = %s, Pace_APS_ise_ = %s, Pace_APS_mpf_ = %s, " \
                                  "REGE_Pace_APS_ago_GES = %s, REGE_Pace_APS_ago_PAR = %s, REGE_Pace_APS_ago_CES " \
                                  "= %s, REGE_Pace_APS_ago_ABO = %s, Pace_APS_ago_CLI_SINO = %s, " \
                                  "REGE_Pace_APS_ago_CLI = %s, Pace_APS_ago_MEN_ = %s, REGE_Pace_APS_ago_MEN = " \
                                  "%s, Pace_APS_ago_PAP_ = %s, FEF_Pace_APS_ago_PAP = %s " \
                                  "WHERE ID_PACE_APS = "
                delete_Query = "DELETE FROM pace_aps_femi WHERE ID_PACE_APS = "
                truncate_table_Query = "TRUNCATE pace_aps_femi"
                drop_table_Query = "DROP TABLE pace_aps_femi"

            class Masculinos:
                pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
                cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

                describe_table = "DESCRIBE pace_aps_masc;"
                show_columns = "SHOW columns FROM pace_aps_masc"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_aps_masc'"

                create_Query = """CREATE TABLE `pace_aps_masc` (
                      `ID_PACE_APS` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                      `ID_Pace` int(11) NOT NULL,
                      `PACE_APS_Feca` date NOT NULL,
                      `REGE_Pace_APS_cri_SINO` tinyint(1) NOT NULL,
                      `Pace_APS_cri` int(200) NOT NULL,
                      `REGE_Pace_APS_cir_SINO` tinyint(1) NOT NULL,
                      `Pace_APS_cir` int(200) NOT NULL,
                      `REGE_Pace_APS_ivs` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `REGE_Pace_APS_pas` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APS_ise_` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
                      `Pace_APS_mpf_` varchar(200) COLLATE utf8_unicode_ci NOT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla de Antecedentes Andrologicos';
                """
                consult_Query = "SELECT * FROM pace_aps_masc"
                consult_ids_Query = "SELECT ID_Pace FROM pace_aps_masc"
                consult_last_Query = "SELECT * FROM pace_aps_masc ORDER BY ID_Pace DESC"
                consult_id_Query = "SELECT * FROM pace_aps_masc WHERE ID_Pace = "
                register_Query = "INSERT INTO `pace_aps_masc` (ID_Pace, PACE_APS_Feca, " \
                                 "REGE_Pace_APS_cri_SINO, Pace_APS_cri, REGE_Pace_APS_cir_SINO, Pace_APS_cir, " \
                                 "REGE_Pace_APS_ivs, REGE_Pace_APS_pas, Pace_APS_ise_, Pace_APS_mpf_)" \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_aps_masc " \
                                  "SET ID_PACE_APS = %s, ID_Pace = %s, PACE_APS_Feca = %s, REGE_Pace_APS_cri_SINO " \
                                  "= %s, Pace_APS_cri = %s, REGE_Pace_APS_cir_SINO = %s, Pace_APS_cir = %s, " \
                                  "REGE_Pace_APS_ivs = %s, REGE_Pace_APS_pas = %s, Pace_APS_ise_ = %s, " \
                                  "Pace_APS_mpf_ = %s " \
                                  "WHERE ID_PACE_APS = "
                delete_Query = "DELETE FROM pace_aps_masc WHERE ID_PACE_APS = "
                truncate_table_Query = "TRUNCATE pace_aps_masc"
                drop_table_Query = "DROP TABLE pace_aps_masc"

        class Antirretrovirales:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_tar;"
            show_columns = "SHOW columns FROM pace_tar"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_tar'"

            create_Query = """CREATE TABLE pace_tar (
                  `ID_TAR` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(11) NOT NULL,
                  `TARactu` tinyint(1) NOT NULL,
                  `Pace_Fe_TAR` date NOT NULL,
                  `Pace_Ca_TAR` date NOT NULL,
                  `Pace_TAR` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Mov_TAR` varchar(300) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Datos de Antirretrovirales';
            """
            consult_Query = "SELECT * FROM pace_tar"
            consult_ids_Query = "SELECT ID_Pace FROM pace_tar"
            consult_last_Query = "SELECT * FROM pace_tar ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_tar WHERE ID_Pace = "
            register_Query = "INSERT INTO `pace_tar` (ID_Pace, TARactu, Pace_Fe_TAR, Pace_Ca_TAR, Pace_TAR, Pace_Mov_TAR) " \
                             "VALUES (%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_tar " \
                              "SET ID_TAR = %s, ID_Pace = %s, TARactu = %s, " \
                              "Pace_Fe_TAR = %s, Pace_Ca_TAR = %s, " \
                              "Pace_TAR = %s, Pace_Mov_TAR = %s " \
                              "WHERE ID_TAR = "
            delete_Query = "DELETE FROM pace_tar WHERE ID_Pace = "
            truncate_table_Query = "TRUNCATE pace_tar"
            drop_table_Query = "DROP TABLE pace_tar"

        class Vih:
            pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]
            cols_pace_iden_iden = ["ID_Dia", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_tar_vih;"
            show_columns = "SHOW columns FROM pace_tar_vih"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_tar_vih'"

            create_Query = """CREATE TABLE pace_tar_vih (
                  `ID_TARVIH` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(10) NOT NULL,
                  `Pace_DIA_VIH` date NOT NULL,
                  `Pace_CRIBAMO` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_CDC_DIA` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
                  `Pace_Fese_TAR` date NOT NULL,
                  `Pace_Fe_TAR` date NOT NULL,
                  `Rede_TAR_SINO` tinyint(1) NOT NULL,
                  `Pace_TAR_EMBA` tinyint(1) NOT NULL,
                  `Pace_No_TAR` int(10) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Datos de Retrovirosis';
            """
            consult_Query = "SELECT * FROM pace_tar_vih"
            consult_ids_Query = "SELECT ID_Pace FROM pace_tar_vih"
            consult_last_Query = "SELECT * FROM pace_tar_vih ORDER BY ID_Pace DESC"
            consult_id_Query = "SELECT * FROM pace_tar_vih WHERE ID_Pace = "
            register_Query = "INSERT INTO pace_tar_vih (`ID_Pace`, " \
                             "`Pace_DIA_VIH`, `Pace_CRIBAMO`, " \
                             "`Pace_CDC_DIA`, `Pace_Fese_TAR`, " \
                             "`Pace_Fe_TAR`, `Rede_TAR_SINO`, " \
                             "`Pace_TAR_EMBA`, `Pace_No_TAR`) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_tar_vih " \
                              "SET ID_TARVIH = %s, ID_Pace = %s, Pace_DIA_VIH = %s, " \
                              "Pace_CRIBAMO = %s, Pace_CDC_DIA = %s, " \
                              "Pace_Fese_TAR = %s, Pace_Fe_TAR = %s, " \
                              "Rede_TAR_SINO = %s, Pace_TAR_EMBA = %s, " \
                              "Pace_No_TAR = %s " \
                              "WHERE ID_TARVIH = "
            delete_Query = "DELETE FROM pace_tar_vih WHERE ID_Pace = "
            truncate_table_Query = "TRUNCATE pace_tar_vih"
            drop_table_Query = "DROP TABLE pace_tar_vih"

        class Embarazos:
            create_database = "CREATE DATABASE IF NOT EXISTS `bd_regpace` " \
                              "DEFAULT CHARACTER SET utf8 " \
                              "COLLATE utf8_unicode_ci;"
            show_tables = "SHOW tables;"
            drop_database = "DROP DATABASE `bd_regpace`"

            class Embarazos:
                Enologias = ['ID_Enologias', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                             'Variedad',
                             'PVP', 'Foto_Vino']
                cols_enologias = ['ID Enologias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                                  'Crianza',
                                  'Variedad', 'PVP']

                describe_table = "DESCRIBE pace_emba;"
                show_columns = "SHOW columns FROM pace_emba"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_emba'"

                create_Query = """CREATE TABLE `pace_emba` (
                  `ID_Pace_EMB` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(10) NOT NULL,
                  `ID_Gestacion` int(10) NOT NULL,
                  `Pace_Feca_EMB` date NOT NULL,
                  `Pace_Feca_FUR` date NOT NULL,
                  `Pace_EMB_fpp` varchar(20) NOT NULL,
                  `Pace_EMB_c_sit_fet` int(10) NOT NULL,
                  `Pace_EMB_afu` int(10) NOT NULL,
                  `Pace_EMB_pfe` double NOT NULL,
                  `Pace_EMB_c_johnson` double NOT NULL,
                  `Pace_EMB_fcf` int(10) NOT NULL,
                  `Pace_EMB_gmp` varchar(20) NOT NULL,
                  `Pace_EMB_dbp` double NOT NULL, 
                  `Pace_EMB_cc` double NOT NULL, 
                  `Pace_EMB_ca` double NOT NULL, 
                  `Pace_EMB_lfe` double NOT NULL, 
                  `Pace_EMB_phelan` double NOT NULL, 
                  `Pace_EMB_pfe_usg` double NOT NULL 
                ) ENGINE=InnoDB AUTO_INCREMENT=1 
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Registros de Embarazos del Paciente.';"""

                register_Query = "INSERT INTO pace_emba (ID_Pace, ID_Gestacion, " \
                                 "Pace_Feca_EMB, Pace_Feca_FUR, Pace_EMB_fpp, " \
                                 "Pace_EMB_c_sit_fet, " \
                                 "Pace_EMB_afu, Pace_EMB_pfe, Pace_EMB_c_johnson, " \
                                 "Pace_EMB_fcf, Pace_EMB_gmp, Pace_EMB_dbp, " \
                                 "Pace_EMB_cc, Pace_EMB_ca, " \
                                 "Pace_EMB_lfe, Pace_EMB_phelan, Pace_EMB_pfe_usg) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                 "%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_emba " \
                                  "SET ID_Pace_EMB = %s, ID_Pace = %s, ID_Gestacion = %s, " \
                                  "Pace_Feca_EMB = %s, Pace_Feca_FUR = %s, " \
                                  "Pace_EMB_fpp = %s, Pace_EMB_c_sit_fet = " \
                                  "%s, Pace_EMB_afu = %s, Pace_EMB_pfe = %s, " \
                                  "Pace_EMB_c_johnson = %s, Pace_EMB_fcf = %s, Pace_EMB_gmp = " \
                                  "%s, Pace_EMB_dbp = %s, " \
                                  "Pace_EMB_cc = %s, Pace_EMB_ca = %s, " \
                                  "Pace_EMB_lfe = %s, Pace_EMB_phelan = %s, Pace_EMB_pfe_usg = %s " \
                                  "WHERE ID_Pace_EMB  = "
                consult_Query = "SELECT * FROM pace_emba"
                consult_ids_Query = "SELECT ID_Pace_EMB FROM pace_emba"
                consult_last_Query = "SELECT * FROM pace_emba ORDER BY ID_Pace_EMB DESC"
                consult_id_Query = "SELECT * FROM pace_emba WHERE ID_Pace_EMB = "
                consult_id_Query_id = "SELECT * FROM pace_emba WHERE ID_Gestacion = "

                delete_Query = "DELETE FROM pace_emba WHERE ID_Pace_EMB  = "
                truncate_table_Query = "TRUNCATE pace_emba"
                drop_table_Query = "DROP TABLE pace_emba"

            class Gestaciones:
                Enologias = ['ID_Enologias', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                             'Variedad',
                             'PVP', 'Foto_Vino']
                cols_enologias = ['ID Enologias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                                  'Crianza',
                                  'Variedad', 'PVP']

                describe_table = "DESCRIBE pace_gesta;"
                show_columns = "SHOW columns FROM pace_gesta"
                show_information = "SELECT column_name, data_type, is_nullable, " \
                                   "column_default  " \
                                   "FROM information_schema.columns " \
                                   "WHERE table_name = 'pace_gesta'"

                create_Query = """CREATE TABLE `pace_gesta` (
                  `ID_Pace_GES` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(10) NOT NULL,
                  `Pace_Feca_GES` date NOT NULL,
                  `Pace_GES_Resolucion` varchar(100) NOT NULL,
                  `Pace_GES_No_Hijo` varchar(100) NOT NULL,
                  `Pace_GES_Vive` varchar(100) NOT NULL,
                  `Pace_GES_edad` int(10) NOT NULL,
                  `Pace_GES_peso_nacer` int(10) NOT NULL,
                  `Pace_GES_sdg` int(10) NOT NULL,
                  `Pace_GES_EAE` varchar(200) NOT NULL, 
                  'Pace_GES_com' varchar(200) NOT NULL
                ) ENGINE=InnoDB AUTO_INCREMENT=1 
                DEFAULT CHARSET=utf8 
                COLLATE=utf8_unicode_ci 
                COMMENT='Tabla para Agregar Registros de Productos Gestacionales del Paciente.';"""
                register_Query = "INSERT INTO pace_gesta (ID_Pace, " \
                                 "Pace_Feca_GES, " \
                                 "Pace_GES_Resolucion, Pace_GES_No_Hijo, Pace_GES_Vive, " \
                                 "Pace_GES_edad, Pace_GES_peso_nacer, " \
                                 "Pace_GES_sdg, Pace_GES_EAE, Pace_GES_com) " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
                update_id_Query = "UPDATE pace_gesta " \
                                  "SET ID_Pace_GES = %s, ID_Pace = %s, " \
                                  "Pace_Feca_GES = %s, " \
                                  "Pace_GES_Resolucion = %s, Pace_GES_No_Hijo = %s, Pace_GES_Vive = %s, " \
                                  "Pace_GES_edad = %s, Pace_GES_peso_nacer = %s, Pace_GES_sdg = %s, " \
                                  "Pace_GES_EAE = %s, Pace_GES_com = %s " \
                                  "WHERE ID_Pace_GES  = "
                consult_Query = "SELECT * FROM pace_gesta"
                consult_ids_Query = "SELECT ID_Pace_GES FROM pace_gesta"
                consult_last_Query = "SELECT * FROM pace_gesta ORDER BY ID_Pace_GES DESC"
                consult_id_Query = "SELECT * FROM pace_gesta WHERE ID_Pace_GES = "
                consult_id_Query_id = "SELECT * FROM pace_gesta WHERE ID_Pace = "

                delete_Query = "DELETE FROM pace_gesta WHERE ID_Pace_GES  = "
                truncate_table_Query = "TRUNCATE pace_gesta"
                drop_table_Query = "DROP TABLE pace_gesta"

    class Heredofamiliares:
        show_tables = "SHOW tables;"
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_mefam` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        drop_database = "DROP DATABASE `bd_mefam`"

        class Familiares:
            pace_ahf = ["ID_MEFAMgnóstico", "Clave", "Diagnostico"]
            cols_pace_ahf = ["ID_MEFAMgnóstico", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE pace_ahf;"
            show_columns = "SHOW columns FROM pace_ahf"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_ahf'"

            create_Query = """CREATE TABLE pace_ahf (
                  `ID_MEFAM` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_Pace` int(10) NOT NULL,
                  `Pace_MEFAM` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `MEFAM_VFS` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `MEFAM_EdaL` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `AHF_INFO_APato` varchar(50) COLLATE utf8_unicode_ci NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Esta Tabla se Agregan los Registro de AHF_Pace';"""

            consult_Query = "SELECT * FROM pace_ahf"
            consult_ids_Query = "SELECT ID_MEFAM FROM pace_ahf"
            consult_last_Query = "SELECT * FROM pace_ahf ORDER BY ID_MEFAM DESC"
            consult_id_Query = "SELECT ID_MEFAM, ID_Cie_Dia Us_Stat FROM pace_ahf WHERE ID_MEFAM = "
            consult_name_Query = "SELECT * FROM pace_ahf WHERE Pace_MEFAM LIKE '%"
            consult_photo_Query = "SELECT Us_Fiat FROM pace_ahf"
            consult_photo_id_Query = "SELECT Us_Fiat FROM pace_ahf WHERE ID_MEFAM = "
            consult_photo_name_Query = "SELECT Us_Fiat FROM pace_ahf WHERE ID_Cie_Dia LIKE '%"
            register_Query = "INSERT INTO `pace_ahf` (`ID_Pace`, `Pace_MEFAM`, " \
                             "`MEFAM_VFS`, `MEFAM_EdaL`, `AHF_INFO_APato`) " \
                             "VALUES (%s, %s, %s, %s, %s)"
            update_id_Query = "UPDATE pace_ahf SET ID_MEFAM = %s, ID_Pace = %s, " \
                              "Pace_MEFAM = %s, MEFAM_VFS = %s, MEFAM_EdaL = %s, " \
                              "AHF_INFO_APato = %s " \
                              "WHERE ID_MEFAM = "
            delete_Query = "DELETE FROM pace_ahf WHERE ID_MEFAM = "
            truncate_table_Query = "TRUNCATE pace_ahf"
            drop_table_Query = "DROP TABLE pace_ahf"

        class Alergias:
            pass

        class Quirurgicos:
            pass

        class Defunciones:
            pass

        class Patologicos:
            mefam_pato = ["ID_MEFAMgnóstico", "Clave", "Diagnostico"]
            cols_mefam_pato = ["ID_MEFAMgnóstico", "Clave", "Diagnóstico"]

            describe_table = "DESCRIBE mefam_pato;"
            show_columns = "SHOW columns FROM mefam_pato"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'mefam_pato'"

            create_Query = """CREATE TABLE `mefam_pato` (
                  `ID_MEFAM_APatol` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
                  `ID_MEFAM` int(10) NOT NULL,
                  `Pace_MEFAM` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `ID_Pace` int(10) NOT NULL,
                  `MEFAM_Diagno` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `MEFAM_Diagno_EdaL` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `MEFAM_Trat` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `MEFAM_Trat_Espe` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
                  `MEFAM_Susp` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
                  `MEFAM_Susp_Perio` varchar(50) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para agregar Diagnosticos de MEFAM_Pace';"""

            consult_Query = "SELECT * FROM mefam_pato"
            consult_ids_Query = "SELECT ID_MEFAM_APatol FROM mefam_pato"
            consult_last_Query = "SELECT * FROM mefam_pato ORDER BY ID_MEFAM_APatol DESC"
            consult_id_Query = "SELECT * FROM mefam_pato WHERE ID_MEFAM_APatol = "
            consult_id_Query_secondary = "SELECT * FROM mefam_pato WHERE ID_MEFAM = "
            consult_name_Query = "SELECT mefam_pato FROM mefam_pato " \
                                 "WHERE Pace_MEFAM LIKE '%"
            consult_photo_Query = ""
            register_Query = "INSERT INTO `mefam_pato` (ID_MEFAM, Pace_MEFAM, " \
                             "ID_Pace, MEFAM_Diagno, MEFAM_Diagno_EdaL, " \
                             "MEFAM_Trat, MEFAM_Trat_Espe, MEFAM_Susp, MEFAM_Susp_Perio) " \
                             "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
            update_id_Query = "UPDATE mefam_pato " \
                              "SET ID_MEFAM_APatol = %s, ID_MEFAM = %s, " \
                              "Pace_MEFAM = %s, ID_Pace = %s, " \
                              "MEFAM_Diagno = %s, " \
                              "MEFAM_Diagno_EdaL = %s, MEFAM_Trat = %s, MEFAM_Trat_Espe = %s, " \
                              "MEFAM_Susp = %s, MEFAM_Susp_Perio = %s " \
                              "WHERE ID_MEFAM_APatol = "
            delete_Query = "DELETE FROM mefam_pato WHERE ID_MEFAM_APatol = "
            truncate_table_Query = "TRUNCATE mefam_pato"
            drop_table_Query = "DROP TABLE mefam_pato"

    class Epidemiologicos:
        Enologias = ['ID_Enologias', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                     'Variedad',
                     'PVP', 'Foto_Vino']
        cols_enologias = ['ID Enologias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                          'Variedad', 'PVP']

        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regepi` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        drop_database = "DROP DATABASE `bd_regepi`"

        describe_table = "DESCRIBE eno_iden;"
        show_tables = "SHOW tables;"
        show_columns = "SHOW columns FROM eno_iden"
        show_information = "SELECT column_name, data_type, is_nullable, " \
                           "column_default  " \
                           "FROM information_schema.columns " \
                           "WHERE table_name = 'eno_iden'"

        create_Query = """CREATE TABLE `usuarios` (
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
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='En esta Tabla se agregan los sara_iden_iden que usan el Sistema';"""
        consult_Query = "SELECT * FROM eno_iden"
        consult_ids_Query = "SELECT ID_Enologias FROM eno_iden"
        consult_partial_Query = "SELECT ID_Enologias, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                "Crianza, Variedad, PVP FROM eno_iden "
        consult_last_Query = "SELECT * FROM eno_iden ORDER BY ID_Enologias DESC"
        consult_last_partial_Query = "SELECT ID_Enologias, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                                     "Sara_Ape_Mat " \
                                     "FROM eno_iden ORDER BY ID_Sara DESC"
        consult_id_Query = "SELECT ID_Enologias, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                           "Sara_Ape_Mat FROM eno_iden WHERE ID_Sara = "
        consult_name_Query = "SELECT ID_Enologias, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                             "Crianza, PVP Variedad FROM eno_iden WHERE VinoNombre LIKE '%"
        consult_photo_Query = "SELECT Foto_Vino FROM eno_iden"
        consult_photo_id_Query = "SELECT Foto_Vino FROM eno_iden WHERE ID_Enologias = "
        consult_photo_name_Query = "SELECT Foto_Vino FROM eno_iden WHERE Us_Nome LIKE '%"
        register_Query = "INSERT INTO eno_iden (ID_Enologias, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                         "Crianza, PVP) " \
                         "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
        register_photo_Query = "INSERT INTO eno_iden (ID_Enologias, VinoNombre," \
                               " MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                               "Crianza, PVP, Foto_Vino) " \
                               "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s"
        update_id_Query = "UPDATE eno_iden SET ID_Enologias = %s, " \
                          "ID_Enologias = %s, VinoNombre = %s, MarcaVino = %s, Bodega = %s, Volumen = %s, " \
                          "ZonaCrianza = %s, " \
                          "Crianza, PVP = %s WHERE ID_Sara = "
        delete_Query = "DELETE FROM eno_iden WHERE ID_Enologias = "
        truncate_table_Query = "TRUNCATE eno_iden"
        drop_table_Query = "DROP TABLE eno_iden"

    class Vitales:
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regsiva` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        drop_database = "DROP DATABASE `bd_regsiva`"

        class Bioconstantes:
            Enologias = ['ID_Enologias', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                         'Variedad',
                         'PVP', 'Foto_Vino']
            cols_enologias = ['ID Enologias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE pace_sv;"
            show_columns = "SHOW columns FROM pace_sv"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_sv'"

            create_Query = """CREATE TABLE `pace_sv` (
              `ID_Pace_SV` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(10) NOT NULL,
              `Pace_Feca_SV` date NOT NULL,
              `Pace_SV_tas` int(10) NOT NULL,
              `Pace_SV_tad` int(10) NOT NULL,
              `Pace_SV_fc` int(10) NOT NULL,
              `Pace_SV_fr` int(10) NOT NULL,
              `Pace_SV_tc` double NOT NULL,
              `Pace_SV_spo` int(10) NOT NULL,
              `Pace_SV_est` double NOT NULL,
              `Pace_SV_pct` double NOT NULL, 
              `Pace_SV_glu` double NOT NULL, 
              `Pace_SV_glu_ayu` double NOT NULL
            ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Signos Vitales del Paciente.';"""
            consult_Query = "SELECT * FROM pace_sv"
            consult_ids_Query = "SELECT ID_Pace_SV FROM pace_sv"
            consult_last_Query = "SELECT * FROM pace_sv ORDER BY ID_Pace_SV DESC"
            consult_id_Query = "SELECT * FROM pace_sv WHERE ID_Pace_SV = "
            consult_id_Query_id = "SELECT * FROM pace_sv WHERE ID_Pace = "
            register_Query = "INSERT INTO pace_sv (ID_Pace, Pace_Feca_SV, Pace_SV_tas, Pace_SV_tad, " \
                             "Pace_SV_fc, Pace_SV_fr, Pace_SV_tc, Pace_SV_spo, Pace_SV_est, Pace_SV_pct, " \
                             "Pace_SV_glu, Pace_SV_glu_ayu) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_sv " \
                              "SET ID_Pace_SV = %s, ID_Pace = %s, Pace_Feca_SV = %s, Pace_SV_tas = %s, Pace_SV_tad = " \
                              "%s, Pace_SV_fc = %s, Pace_SV_fr = %s, Pace_SV_tc = %s, Pace_SV_spo = %s, Pace_SV_est = " \
                              "%s, Pace_SV_pct = %s, " \
                              "Pace_SV_glu = %s, Pace_SV_glu_ayu = %s " \
                              "WHERE ID_Pace_SV  = "
            delete_Query = "DELETE FROM pace_sv WHERE ID_Pace_SV  = "
            truncate_table_Query = "TRUNCATE pace_sv"
            drop_table_Query = "DROP TABLE pace_sv"

        class Antropometricos:
            Enologias = ['ID_Enologias', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                         'Variedad',
                         'PVP', 'Foto_Vino']
            cols_enologias = ['ID Enologias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            describe_table = "DESCRIBE pace_antropo;"
            show_columns = "SHOW columns FROM pace_antropo"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'pace_antropo'"

            create_Query = """CREATE TABLE `pace_antropo` (
              `ID_Pace_SV` int(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
              `ID_Pace` int(10) NOT NULL,
              `Pace_Feca_SV` date NOT NULL,
              `Pace_SV_cue` double NOT NULL,
              `Pace_SV_cin` double NOT NULL,
              `Pace_SV_cad` double NOT NULL,
              `Pace_SV_cmb` double NOT NULL,
              `Pace_SV_pct` double NOT NULL,
              `Pace_SV_fa` double NOT NULL,
              `Pace_SV_fe` double NOT NULL,
              `Pace_SV_pcb` double NOT NULL,
              `Pace_SV_pse` double NOT NULL,
              `Pace_SV_psi` double NOT NULL,
              `Pace_SV_pst` double NOT NULL, 
              `Pace_SV_c_pect` double NOT NULL,
              `Pace_SV_c_fem_izq` double NOT NULL,
              `Pace_SV_c_fem_der` double NOT NULL,
              `Pace_SV_c_fem_izq`, double NOT NULL,
              `Pace_SV_c_suro_der` double NOT NULL
            ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla para Agregar Signos Vitales del Paciente.';"""
            consult_Query = "SELECT * FROM pace_antropo"
            consult_ids_Query = "SELECT ID_Pace_SV FROM pace_antropo"
            consult_last_Query = "SELECT * FROM pace_antropo ORDER BY ID_Pace_SV DESC"
            consult_id_Query = "SELECT * FROM pace_antropo WHERE ID_Pace_SV = "
            consult_id_Query_id = "SELECT * FROM pace_antropo WHERE ID_Pace = "
            register_Query = "INSERT INTO pace_antropo (ID_Pace, Pace_Feca_SV, Pace_SV_cue, " \
                             "Pace_SV_cin, " \
                             "Pace_SV_cad, Pace_SV_cmb, Pace_SV_pct, Pace_SV_fa, Pace_SV_fe, " \
                             "Pace_SV_pcb, " \
                             "Pace_SV_pse, Pace_SV_psi, Pace_SV_pst, " \
                             "Pace_SV_c_pect, " \
                             "Pace_SV_c_fem_der, Pace_SV_c_fem_izq, " \
                             "Pace_SV_c_suro_der, Pace_SV_c_suro_izq) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                             "%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE pace_antropo " \
                              "SET ID_Pace_SV = %s, ID_Pace = %s, Pace_Feca_SV = %s, " \
                              "Pace_SV_cue = %s, Pace_SV_cin = %s, Pace_SV_cad = %s, " \
                              "Pace_SV_cmb = %s, Pace_SV_pct = %s, Pace_SV_fa = %s, " \
                              "Pace_SV_fe = %s, Pace_SV_pcb = %s, Pace_SV_pse = %s, " \
                              "Pace_SV_psi = %s, Pace_SV_pst = %s, " \
                              "Pace_SV_c_pect = %s, " \
                              "Pace_SV_c_fem_der = %s, Pace_SV_c_fem_izq = %s, " \
                              "Pace_SV_c_suro_der = %s, Pace_SV_c_suro_izq = %s " \
                              "WHERE ID_Pace_SV = "
            delete_Query = "DELETE FROM pace_antropo WHERE ID_Pace_SV = "
            truncate_table_Query = "TRUNCATE pace_antropo"
            drop_table_Query = "DROP TABLE pace_antropo"

    class Redacciones:
        Enologias = ['ID_Enologias', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                     'Variedad',
                     'PVP', 'Foto_Vino']
        cols_enologias = ['ID Enologias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                          'Variedad', 'PVP']

        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regredad` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        drop_database = "DROP DATABASE `bd_regredad`"

        describe_table = "DESCRIBE eno_iden;"
        show_columns = "SHOW columns FROM eno_iden"
        show_information = "SELECT column_name, data_type, is_nullable, " \
                           "column_default  " \
                           "FROM information_schema.columns " \
                           "WHERE table_name = 'eno_iden'"

        create_Query = """CREATE TABLE `usuarios` (
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
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='En esta Tabla se agregan los sara_iden_iden que usan el Sistema';"""
        consult_Query = "SELECT * FROM eno_iden"
        consult_ids_Query = "SELECT ID_Enologias FROM eno_iden"
        consult_partial_Query = "SELECT ID_Enologias, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                "Crianza, Variedad, PVP FROM eno_iden "
        consult_last_Query = "SELECT * FROM eno_iden ORDER BY ID_Enologias DESC"
        consult_last_partial_Query = "SELECT ID_Enologias, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                                     "Sara_Ape_Mat " \
                                     "FROM eno_iden ORDER BY ID_Sara DESC"
        consult_id_Query = "SELECT ID_Enologias, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                           "Sara_Ape_Mat FROM eno_iden WHERE ID_Sara = "
        consult_name_Query = "SELECT ID_Enologias, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                             "Crianza, PVP Variedad FROM eno_iden WHERE VinoNombre LIKE '%"
        consult_photo_Query = "SELECT Foto_Vino FROM eno_iden"
        consult_photo_id_Query = "SELECT Foto_Vino FROM eno_iden WHERE ID_Enologias = "
        consult_photo_name_Query = "SELECT Foto_Vino FROM eno_iden WHERE Us_Nome LIKE '%"
        register_Query = "INSERT INTO eno_iden (ID_Enologias, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                         "Crianza, PVP) " \
                         "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
        register_photo_Query = "INSERT INTO eno_iden (ID_Enologias, VinoNombre," \
                               " MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                               "Crianza, PVP, Foto_Vino) " \
                               "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s"
        update_id_Query = "UPDATE eno_iden SET ID_Enologias = %s, " \
                          "ID_Enologias = %s, VinoNombre = %s, MarcaVino = %s, Bodega = %s, Volumen = %s, " \
                          "ZonaCrianza = %s, " \
                          "Crianza, PVP = %s WHERE ID_Sara = "
        delete_Query = "DELETE FROM eno_iden WHERE ID_Enologias = "
        truncate_table_Query = "TRUNCATE eno_iden"
        drop_table_Query = "DROP TABLE eno_iden"

    class Interacciones:
        Interacciones = ["ID_Interacciones, NSS_Interaccion", "Agregado_Interaccion",
                         "Primer_Nombre", "Segundo_Nombre", "Apellido_Paterno",
                         "Apellido_Materno"]
        cols_interacciones = ["ID Interacciones, NSS Interaccion", "Agregado Interaccion",
                              "Primer Nombre", "Segundo Nombre", "Apellido Paterno",
                              "Apellido Materno"]

        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regsara` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        drop_database = "DROP DATABASE `bd_regsara`"

        describe_table = "DESCRIBE sara_iden_iden;"
        show_columns = "SHOW columns FROM sara_iden_iden"
        show_information = "SELECT column_name, data_type, is_nullable, " \
                           "column_default  " \
                           "FROM information_schema.columns " \
                           "WHERE table_name = 'sara_iden_iden'"

        create_Query = """CREATE TABLE `usuarios` (
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
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='En esta Tabla se agregan los sara_iden_iden que usan el Sistema';"""
        consult_Query = "SELECT * FROM sara_iden_iden"
        consult_ids_Query = "SELECT ID_Sara FROM sara_iden_iden"
        consult_partial_Query = "SELECT ID_Sara, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                                "Sara_Ape_Mat FROM sara_iden_iden "
        consult_last_Query = "SELECT * FROM sara_iden_iden ORDER BY ID_Sara DESC"
        consult_last_partial_Query = "SELECT ID_Sara, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                                     "Sara_Ape_Mat " \
                                     "FROM sara_iden_iden ORDER BY ID_Sara DESC"
        consult_id_Query = "SELECT ID_Sara, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                           "Sara_Ape_Mat FROM sara_iden_iden WHERE ID_Sara = "
        consult_name_Query = "SELECT ID_Sara, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                             "Sara_Ape_Mat FROM sara_iden_iden WHERE Us_Nome LIKE '%"
        consult_photo_Query = "SELECT Sara_Fiat FROM sara_iden_iden"
        consult_photo_id_Query = "SELECT Sara_Fiat FROM sara_iden_iden WHERE ID_Sara = "
        consult_photo_name_Query = "SELECT Sara_Fiat FROM sara_iden_iden WHERE Us_Nome LIKE '%"
        register_Query = "INSERT INTO sara_iden_iden (Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                         "Sara_Ape_Mat) " \
                         "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        register_photo_Query = "INSERT INTO sara_iden_iden (ID_Sara, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, " \
                               "Sara_Ape_Pat, " \
                               "Sara_Ape_Mat, Sara_Fiat) " \
                               "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        update_id_Query = "UPDATE sara_iden_iden SET ID_Sara = %s, " \
                          "Sara_NSS = %s, Sara_AGRE = %s, Sara_Nome_PI = %s, Sara_Nome_SE = %s, Sara_Ape_Pat = %s, " \
                          "Sara_Ape_Mat = %s WHERE ID_Sara = "
        delete_Query = "DELETE FROM sara_iden_iden WHERE ID_Sara = "
        truncate_table_Query = "TRUNCATE sara_iden_iden"
        drop_table_Query = "DROP TABLE sara_iden_iden"

    class Usuarios:
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regusua` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        drop_database = "DROP DATABASE `bd_regusua`"

        class Identificaciones:
            usuarios = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                        "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                        "Area", "Estatus", "Anexado_por"]
            cols_usuarios = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                             "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                             "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE usuarios;"
            show_columns = "SHOW columns FROM usuarios"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'usuarios'"

            create_Query = """CREATE TABLE `usuarios` (
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
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='En esta Tabla se agregan los usuarios que usan el Sistema';"""
            create_complete_Query = """
                CREATE TABLE IF NOT EXISTS usuarios (
                  `ID_Usuario` INT(10) NOT NULL AUTO_INCREMENT,
                  `Us_Nome` VARCHAR(50) NOT NULL,
                  `Us_Ape_Pat` VARCHAR(50) NOT NULL,
                  `Us_Ape_Mat` VARCHAR(50) NOT NULL,
                  `Us_Usuario` VARCHAR(50) NOT NULL,
                  `Us_Passe` VARCHAR(50) NOT NULL,
                  `Us_Permi` VARCHAR(50) NOT NULL,
                  `Us_EspeL` VARCHAR(50) NOT NULL,
                  `Us_Area` VARCHAR(50) NOT NULL,
                  `Us_Stat` VARCHAR(50) NOT NULL,
                  `Us_Fiat` LONGBLOB NOT NULL,
                  `Usu_ADAM_AGE` VARCHAR(200) NOT NULL,
                  PRIMARY KEY (`ID_Usuario`))
                ENGINE = InnoDB
                AUTO_INCREMENT = 1
                DEFAULT CHARACTER SET = utf8
                COLLATE = utf8_unicode_ci
                COMMENT = 'En esta Tabla se agregan los usuarios que usan el Sistema';
                        """

            consult_Query = "SELECT * FROM usuarios"
            consult_ids_Query = "SELECT ID_Usuario FROM usuarios"
            consult_partial_Query = "SELECT ID_Usuario, Us_Nome, Us_Ape_Pat, Us_Ape_Mat, Us_Usuario, " \
                                    "Us_Passe, Us_Permi, Us_EspeL, Us_Area, Us_Stat, Usu_ADAM_AGE FROM usuarios"
            consult_last_Query = "SELECT * FROM usuarios ORDER BY ID_Usuario DESC"
            consult_last_partial_Query = "SELECT ID_Usuario, Us_Nome, Us_Ape_Pat, Us_Ape_Mat, Us_Usuario, " \
                                         "Us_Passe, Us_Permi, Us_EspeL, Us_Area, Us_Stat, Usu_ADAM_AGE " \
                                         "FROM usuarios ORDER BY ID_Usuario DESC"
            consult_id_Query = "SELECT ID_Usuario, Us_Nome, Us_Stat FROM usuarios WHERE ID_Usuario = "
            consult_name_Query = "SELECT ID_Usuario, Us_Nome, Us_Stat FROM usuarios WHERE Us_Nome LIKE '%"
            consult_photo_Query = "SELECT Us_Fiat FROM usuarios"
            consult_photo_id_Query = "SELECT Us_Fiat FROM usuarios WHERE ID_Usuario = "
            consult_photo_name_Query = "SELECT Us_Fiat FROM usuarios WHERE Us_Nome LIKE '%"
            register_Query = "INSERT INTO usuarios (Us_Nome, Us_Ape_Pat, Us_Ape_Mat, Us_Usuario, " \
                             "Us_Passe, Us_Permi, Us_EspeL, Us_Area, Us_Stat, Usu_ADAM_AGE) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            register_many_Query = "INSERT INTO usuarios (" \
                                  "ID_Usuario, Us_Nome, Us_Ape_Pat, Us_Ape_Mat, " \
                                  "Us_Usuario, Us_Passe, " \
                                  "Us_Permi, Us_EspeL, " \
                                  "Us_Area, Us_Stat, " \
                                  "Us_Fiat, " \
                                  "Usu_ADAM_AGE) " \
                                  "VALUES (" \
                                  "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                                  "%s,%s" \
                                  ")"
            register_photo_Query = "INSERT INTO usuarios (Us_Nome, Us_Ape_Pat, Us_Ape_Mat, Us_Usuario, " \
                                   "Us_Passe, Us_Permi, Us_EspeL, Us_Area, Us_Stat, Us_Fiat, Usu_ADAM_AGE) " \
                                   "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE usuarios SET ID_Usuario = %s, Us_Nome = %s, Us_Ape_Pat = %s, Us_Ape_Mat = %s, " \
                              "Us_Usuario = %s, Us_Passe = %s, Us_Permi = %s, Us_EspeL = %s, " \
                              "Us_Area = %s, Us_Stat = %s, " \
                              "Usu_ADAM_AGE = %s WHERE ID_Usuario = "
            update_photo_id_Query = "UPDATE usuarios SET ID_Usuario = %s, Us_Nome = %s, " \
                                    "Us_Ape_Pat = %s, Us_Ape_Mat = %s, Us_Usuario = %s, " \
                                    "Us_Passe = %s, Us_Permi = %s, Us_EspeL = %s, " \
                                    "Us_Area = %s, Us_Stat = %s, Us_Fiat  =%s, " \
                                    "Usu_ADAM_AGE = %s WHERE ID_Usuario = "
            delete_Query = "DELETE FROM usuarios WHERE ID_Usuario = "
            truncate_table_Query = "TRUNCATE usuarios"
            drop_table_Query = "DROP TABLE usuarios"

        class Generales:
            us_da = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                     "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                     "Area", "Estatus", "Anexado_por"]
            cols_usuarios = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                             "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                             "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE us_da;"
            show_columns = "SHOW columns FROM us_da"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'us_da'"

            create_Query = """CREATE TABLE IF NOT EXISTS `us_da` (
                  `ID_Usuario` INT(11) NOT NULL AUTO_INCREMENT,
                  `Us_Da_Ses` VARCHAR(200) NOT NULL,
                  `Us_Da_Pace` DATE NOT NULL,
                  `Us_Da_EdaL` VARCHAR(10) NOT NULL,
                  `Us_Da_Tele` VARCHAR(100) NOT NULL,
                  `Us_Da_Mail` VARCHAR(100) NOT NULL,
                  `Us_Da_CURP` VARCHAR(100) NOT NULL,
                  `Us_Da_RFC` VARCHAR(100) NOT NULL,
                  `Us_Da_Insta` VARCHAR(100) NOT NULL,
                  `Us_Da_Faceboo` VARCHAR(100) NOT NULL,
                  `Us_Da_Twiter` VARCHAR(100) NOT NULL,
                  PRIMARY KEY (`ID_Usuario`))
                ENGINE = InnoDB
                AUTO_INCREMENT = 55
                DEFAULT CHARACTER SET = utf8
                COLLATE = utf8_unicode_ci
                COMMENT = 'Tabla para Datos Personales del Usuario.';
            """

            consult_Query = "SELECT * FROM us_da"
            consult_ids_Query = "SELECT ID_Usuario FROM us_da"
            consult_id_Query = "SELECT * FROM us_da WHERE ID_Usuario = "

            register_Query = "INSERT INTO us_da (Us_Da_Ses, Us_Da_Pace, Us_Da_EdaL, Us_Da_Tele, Us_Da_Mail, " \
                             "Us_Da_CURP, Us_Da_RFC, Us_Da_Insta, Us_Da_Faceboo, Us_Da_Twiter) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            register_many_Query = "INSERT INTO us_da (ID_Usuario, " \
                                  "Us_Da_Ses, Us_Da_Pace, Us_Da_EdaL, Us_Da_Tele, " \
                                  "Us_Da_Mail, Us_Da_CURP, Us_Da_RFC, Us_Da_Insta, " \
                                  "Us_Da_Faceboo, Us_Da_Twiter) " \
                                  "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE us_da " \
                              "SET ID_Usuario= %s, Us_Da_Ses= %s, Us_Da_Pace= %s, Us_Da_EdaL= %s, Us_Da_Tele= %s, " \
                              "Us_Da_Mail= %s, Us_Da_CURP= %s, Us_Da_RFC= %s, Us_Da_Insta= %s, Us_Da_Faceboo= %s, " \
                              "Us_Da_Twiter= %s " \
                              "WHERE ID_Usuario = "
            delete_Query = "DELETE FROM us_da WHERE ID_Usuario = "
            truncate_table_Query = "TRUNCATE us_da"
            drop_table_Query = "DROP TABLE us_da"

        class Particulares:
            us_dac = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                      "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                      "Area", "Estatus", "Anexado_por"]
            cols_us_dac = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                           "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                           "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE us_dac;"
            show_columns = "SHOW columns FROM us_dac"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'us_dac'"

            create_Query = """
                CREATE TABLE IF NOT EXISTS `us_dac` (
                  `ID_Usuario` INT(11) NOT NULL AUTO_INCREMENT,
                  `Us_Ocupa` VARCHAR(100) NOT NULL,
                  `Us_Reli` VARCHAR(100) NOT NULL,
                  `Us_Edo_Civ` VARCHAR(300) NOT NULL,
                  `Us_Esco` VARCHAR(100) NOT NULL,
                  `Us_Esco_COM` VARCHAR(100) NOT NULL,
                  `Us_Esco_ESPE` VARCHAR(100) NOT NULL,
                  `Us_Orig_Mun` VARCHAR(100) NOT NULL,
                  `Us_Orig_Est` VARCHAR(100) NOT NULL,
                  `Us_Loca` VARCHAR(200) NOT NULL,
                  `Us_Loca_Dur` VARCHAR(100) NOT NULL,
                  `Us_Domi` VARCHAR(300) NOT NULL,
                  `Us_IdioL_Inde` VARCHAR(300) NOT NULL DEFAULT '',
                  `Us_IdioL_Inde_Len` VARCHAR(300) NOT NULL,
                  `Us_IdioL_Inde_Len_ESPE` VARCHAR(300) NOT NULL,
                  PRIMARY KEY (`ID_Usuario`))
                ENGINE = InnoDB
                AUTO_INCREMENT = 55
                DEFAULT CHARACTER SET = utf8
                COLLATE = utf8_unicode_ci
                COMMENT = 'Tabla para Datos Personales del Usuario.';
            """

            consult_Query = "SELECT * FROM us_dac"
            consult_ids_Query = "SELECT ID_Usuario FROM us_dac"
            consult_id_Query = "SELECT ID_UsuarioFROM us_dac WHERE ID_Usuario = "

            register_Query = "INSERT INTO us_dac (Us_Ocupa, Us_Reli, Us_Edo_Civ, Us_Esco, Us_Esco_COM, Us_Esco_ESPE, " \
                             "Us_Orig_Mun, Us_Orig_Est, Us_Loca, Us_Loca_Dur, Us_Domi, Us_IdioL_Inde, " \
                             "Us_IdioL_Inde_Len, Us_IdioL_Inde_Len_ESPE) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            register_many_Query = "INSERT INTO us_dac (ID_Usuario, Us_Ocupa, Us_Reli, Us_Edo_Civ, Us_Esco, " \
                                  "Us_Esco_COM, Us_Esco_ESPE, Us_Orig_Mun, Us_Orig_Est, Us_Loca, Us_Loca_Dur, " \
                                  "Us_Domi, Us_IdioL_Inde, Us_IdioL_Inde_Len, Us_IdioL_Inde_Len_ESPE) " \
                                  "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE us_dac SET ID_Usuario = %s, Us_Ocupa = %s, Us_Reli = %s, Us_Edo_Civ = %s, " \
                              "Us_Esco = %s, Us_Esco_COM = %s, Us_Esco_ESPE = %s, Us_Orig_Mun = %s, Us_Orig_Est = %s, " \
                              "Us_Loca = %s, Us_Loca_Dur = %s, Us_Domi = %s, Us_IdioL_Inde = %s, Us_IdioL_Inde_Len = " \
                              "%s, Us_IdioL_Inde_Len_ESPE = %s " \
                              "WHERE ID_Usuario = "

            delete_Query = "DELETE FROM us_dac WHERE ID_Usuario = "
            truncate_table_Query = "TRUNCATE us_dac"
            drop_table_Query = "DROP TABLE us_dac"

        class Academicos:
            us_esco = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                       "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                       "Area", "Estatus", "Anexado_por"]
            cols_us_esco = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                            "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                            "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE us_esco;"
            show_columns = "SHOW columns FROM us_esco"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'us_esco'"

            create_Query = """
                CREATE TABLE IF NOT EXISTS `us_esco` (
                  `ID_Us_Esco` INT(11) NOT NULL AUTO_INCREMENT,
                  `ID_Usuario` INT(11) NOT NULL,
                  `Us_Esco_Grad_AO` DATE NOT NULL,
                  `Us_Esco_Grad_CI` VARCHAR(300) NOT NULL,
                  `Us_Esco_Grad_PA` VARCHAR(300) NOT NULL,
                  `Us_Esco_Grad_Univ` VARCHAR(300) NOT NULL,
                  `Us_Esco_Grad_Tale` VARCHAR(300) NOT NULL,
                  PRIMARY KEY (`ID_Us_Esco`))
                ENGINE = InnoDB
                AUTO_INCREMENT = 2
                DEFAULT CHARACTER SET = utf8
                COLLATE = utf8_unicode_ci
                COMMENT = 'Tabla para Estudios Académicos de los us_esco.'
            """

            consult_Query = "SELECT * FROM us_esco"
            consult_ids_Query = "SELECT ID_Usuario FROM us_esco"
            consult_id_Query = "SELECT ID_Usuario, Us_Nome, Us_Stat FROM us_esco WHERE ID_Us_Esco = "

            register_Query = "INSERT INTO us_esco (ID_Usuario, Us_Esco_Grad_AO, Us_Esco_Grad_CI, Us_Esco_Grad_PA, " \
                             "Us_Esco_Grad_Univ, Us_Esco_Grad_Tale) " \
                             "VALUES (%s,%s,%s,%s,%s,%s)"
            register_many_Query = "INSERT INTO us_esco (ID_Us_Esco, ID_Usuario, Us_Esco_Grad_AO, Us_Esco_Grad_CI, " \
                                  "Us_Esco_Grad_PA, Us_Esco_Grad_Univ, Us_Esco_Grad_Tale) " \
                                  "VALUES (%s,%s,%s,%s,%s,%s,%s)"

            update_id_Query = "UPDATE us_esco SET ID_Usuario = %s, Us_Nome = %s, Us_Ape_Pat = %s, Us_Ape_Mat = %s, " \
                              "Us_Usuario = %s, Us_Passe = %s, Us_Permi = %s, Us_EspeL = %s, " \
                              "Us_Area = %s, Us_Stat = %s, " \
                              "Usu_ADAM_AGE = %s WHERE ID_Usuario = "
            update_photo_id_Query = "UPDATE us_esco SET ID_Us_Esco = %s, ID_Usuario = %s, Us_Esco_Grad_AO = %s, " \
                                    "Us_Esco_Grad_CI = %s, Us_Esco_Grad_PA = %s, Us_Esco_Grad_Univ = %s, " \
                                    "Us_Esco_Grad_Tale = %s " \
                                    "WHERE ID_Us_Esco = "
            delete_Query = "DELETE FROM us_esco WHERE ID_Us_Esco = "
            truncate_table_Query = "TRUNCATE us_esco"
            drop_table_Query = "DROP TABLE us_esco"

        class Formaciones:
            us_esco_exi = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                           "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                           "Area", "Estatus", "Anexado_por"]
            cols_us_esco_exi = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                                "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                                "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE us_esco_exi;"
            show_columns = "SHOW columns FROM us_esco_exi"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'us_esco_exi'"

            create_Query = """
                CREATE TABLE IF NOT EXISTS `us_esco_exi` (
                  `ID_Us_Esco_EXI` INT(11) NOT NULL AUTO_INCREMENT,
                  `ID_Usuario` INT(11) NOT NULL,
                  `Us_Esco_EXI_AO` DATE NOT NULL,
                  `Us_Esco_EXI_Tip` VARCHAR(300) NOT NULL,
                  `Us_Esco_EXI_Loge` VARCHAR(300) NOT NULL,
                  PRIMARY KEY (`ID_Us_Esco_EXI`))
                ENGINE = InnoDB
                AUTO_INCREMENT = 3
                DEFAULT CHARACTER SET = utf8
                COLLATE = utf8_unicode_ci
                COMMENT = 'Tabla para Datos de Formacion Academica de Usuario.'
            """

            consult_Query = "SELECT * FROM us_esco_exi"
            consult_ids_Query = "SELECT ID_Usuario FROM us_esco_exi"
            consult_id_Query = "SELECT ID_Usuario, Us_Nome, Us_Stat FROM us_esco_exi WHERE ID_Usuario = "

            register_Query = "INSERT INTO us_esco_exi (ID_Usuario, Us_Esco_EXI_AO, Us_Esco_EXI_Tip, Us_Esco_EXI_Loge) " \
                             "VALUES (%s,%s,%s,%s)"
            register_many_Query = "INSERT INTO us_esco_exi (ID_Us_Esco_EXI, ID_Usuario, Us_Esco_EXI_AO, " \
                                  "Us_Esco_EXI_Tip, Us_Esco_EXI_Loge) " \
                                  "VALUES (%s,%s,%s,%s,%s)"

            update_id_Query = "UPDATE us_esco_exi SET ID_Us_Esco_EXI = %s, ID_Usuario = %s, Us_Esco_EXI_AO = %s, " \
                              "Us_Esco_EXI_Tip = %s, Us_Esco_EXI_Loge = %s " \
                              "WHERE ID_Usuario = "
            delete_Query = "DELETE FROM us_esco_exi WHERE ID_Usuario = "
            truncate_table_Query = "TRUNCATE us_esco_exi"
            drop_table_Query = "DROP TABLE us_esco_exi"

        class Experiencias:
            us_expe = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                       "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                       "Area", "Estatus", "Anexado_por"]
            cols_us_expe = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                            "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                            "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE us_expe;"
            show_columns = "SHOW columns FROM us_expe"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'us_expe'"

            create_Query = """
                CREATE TABLE IF NOT EXISTS `us_expe` (
                  `ID_Us_Expe` INT(11) NOT NULL AUTO_INCREMENT,
                  `ID_Usuario` INT(11) NOT NULL,
                  `Us_Expe_AO` DATE NOT NULL,
                  `Us_Expe_CI` VARCHAR(300) NOT NULL,
                  `Us_Expe_PA` VARCHAR(300) NOT NULL,
                  `Us_Expe_Emper` VARCHAR(300) NOT NULL,
                  `Us_Expe_Cargo` VARCHAR(300) NOT NULL,
                  `Us_Expe_Fune` VARCHAR(300) NOT NULL,
                  PRIMARY KEY (`ID_Us_Expe`))
                ENGINE = InnoDB
                AUTO_INCREMENT = 3
                DEFAULT CHARACTER SET = utf8
                COLLATE = utf8_unicode_ci
                COMMENT = 'Tabla para Experiencia Profesional del Usuario.'
            """

            consult_Query = "SELECT * FROM us_expe"
            consult_ids_Query = "SELECT ID_Usuario FROM us_expe"
            consult_id_Query = "SELECT ID_Usuario, Us_Nome, Us_Stat FROM us_expe " \
                               "WHERE ID_Us_Expe = "

            register_Query = "INSERT INTO us_expe (ID_Usuario, " \
                             "Us_Expe_AO, Us_Expe_CI, Us_Expe_PA, Us_Expe_Emper, " \
                             "Us_Expe_Cargo, Us_Expe_Fune) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s)"
            register_many_Query = "INSERT INTO us_expe (ID_Us_Expe, ID_Usuario, " \
                                  "Us_Expe_AO, Us_Expe_CI, Us_Expe_PA, Us_Expe_Emper, " \
                                  "Us_Expe_Cargo, Us_Expe_Fune) " \
                                  "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"

            update_id_Query = "UPDATE us_expe SET ID_Us_Expe = %s, " \
                              "ID_Usuario = %s, Us_Expe_AO = %s, Us_Expe_CI = %s, " \
                              "Us_Expe_PA = %s, Us_Expe_Emper = %s, Us_Expe_Cargo = %s, " \
                              "Us_Expe_Fune = %s " \
                              "WHERE ID_Us_Expe = "
            delete_Query = "DELETE FROM us_expe WHERE ID_Us_Expe = "
            truncate_table_Query = "TRUNCATE us_expe"
            drop_table_Query = "DROP TABLE us_expe"

        class Manifiestos:
            us_iden = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                       "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                       "Area", "Estatus", "Anexado_por"]
            cols_us_iden = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                            "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                            "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE us_iden;"
            show_columns = "SHOW columns FROM us_iden"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'us_iden'"

            create_Query = """
                CREATE TABLE IF NOT EXISTS `us_iden` (
                  `ID_Iden` INT(11) NOT NULL AUTO_INCREMENT,
                  `ID_Usuario` INT(11) NOT NULL,
                  `Us_Iden` LONGTEXT NOT NULL,
                  PRIMARY KEY (`ID_Iden`))
                ENGINE = InnoDB
                AUTO_INCREMENT = 4
                DEFAULT CHARACTER SET = utf8
                COLLATE = utf8_unicode_ci
                COMMENT = 'Tabla de Manifiestos de los us_iden.'
            """

            consult_Query = "SELECT * FROM us_iden"
            consult_ids_Query = "SELECT ID_Usuario FROM us_iden"
            consult_id_Query = "SELECT ID_Usuario, Us_Nome, Us_Stat FROM us_iden WHERE ID_Usuario = "

            register_Query = "INSERT INTO us_iden (ID_Usuario, Us_Iden) " \
                             "VALUES (%s,%s)"
            register_many_Query = "INSERT INTO us_iden (ID_Iden, ID_Usuario, Us_Iden) " \
                                  "VALUES (%s,%s,%s)"

            update_id_Query = "UPDATE us_iden " \
                              "SET ID_Iden = %s, ID_Usuario = %s, Us_Iden = %s " \
                              "WHERE ID_Iden = "

            delete_Query = "DELETE FROM us_iden WHERE ID_Iden = "
            truncate_table_Query = "TRUNCATE us_iden"
            drop_table_Query = "DROP TABLE us_iden"

        class Referencias:
            us_refe = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                       "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                       "Area", "Estatus", "Anexado_por"]
            cols_us_refe = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                            "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                            "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE us_refe;"
            show_columns = "SHOW columns FROM us_refe"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'us_refe'"

            create_Query = """
                CREATE TABLE IF NOT EXISTS `us_refe` (
                  `ID_Us_Refe` INT(11) NOT NULL AUTO_INCREMENT,
                  `ID_Usuario` INT(11) NOT NULL,
                  `Us_Refe_Nome` VARCHAR(200) NOT NULL,
                  `Us_Refe_ApePat` VARCHAR(200) NOT NULL,
                  `Us_Refe_ApeMat` VARCHAR(200) NOT NULL,
                  `Us_Refe_Emper` VARCHAR(200) NOT NULL,
                  `Us_Refe_Cargo` VARCHAR(200) NOT NULL,
                  `Us_Refe_Tele` VARCHAR(200) NOT NULL,
                  `Us_Refe_Emal` VARCHAR(200) NOT NULL,
                  PRIMARY KEY (`ID_Us_Refe`))
                ENGINE = InnoDB
                DEFAULT CHARACTER SET = utf8
                COLLATE = utf8_unicode_ci
                COMMENT = 'Tabla para Registro de Referentes del Usuario.'
            """

            consult_Query = "SELECT * FROM us_refe"
            consult_ids_Query = "SELECT ID_Usuario FROM us_refe"
            consult_id_Query = "SELECT ID_Usuario, Us_Nome, Us_Stat FROM us_refe WHERE ID_Us_Refe = "

            register_Query = "INSERT INTO us_refe (ID_Us_Refe, ID_Usuario, " \
                             "Us_Refe_Nome, Us_Refe_ApePat, Us_Refe_ApeMat, " \
                             "Us_Refe_Emper, Us_Refe_Cargo, Us_Refe_Tele, Us_Refe_Emal) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
            register_many_Query = "INSERT INTO us_refe (ID_Us_Refe, ID_Usuario, " \
                                  "Us_Refe_Nome, Us_Refe_ApePat, Us_Refe_ApeMat, " \
                                  "Us_Refe_Emper, Us_Refe_Cargo, Us_Refe_Tele, Us_Refe_Emal) " \
                                  "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"

            update_id_Query = "UPDATE us_refe " \
                              "SET ID_Us_Refe = %s, ID_Usuario = %s, Us_Refe_Nome = %s, " \
                              "Us_Refe_ApePat = %s, Us_Refe_ApeMat = %s, Us_Refe_Emper = %s, " \
                              "Us_Refe_Cargo = %s, Us_Refe_Tele = %s, Us_Refe_Emal = %s " \
                              "WHERE ID_Us_Refe = "

            delete_Query = "DELETE FROM us_refe WHERE ID_Us_Refe = "
            truncate_table_Query = "TRUNCATE us_refe"
            drop_table_Query = "DROP TABLE us_refe"

        class Catalogos:
            usua_album = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                          "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                          "Area", "Estatus", "Anexado_por"]
            cols_usua_album = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                               "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                               "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE usua_album;"
            show_columns = "SHOW columns FROM usua_album"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'usua_album'"

            create_Query = """
                CREATE TABLE IF NOT EXISTS `usua_album` (
                  `ID_Usua_Fiat` INT(11) NOT NULL AUTO_INCREMENT,
                  `ID_Usuario` INT(11) NOT NULL,
                  `Nombre` VARCHAR(300) NOT NULL,
                  `Descripcion` VARCHAR(500) NOT NULL,
                  `Foto_Usuario` LONGBLOB NOT NULL,
                  PRIMARY KEY (`ID_Usua_Fiat`))
                ENGINE = InnoDB
                AUTO_INCREMENT = 10
                DEFAULT CHARACTER SET = utf8
                COLLATE = utf8_unicode_ci
                COMMENT = 'Tabla para Registro del Catálogo de Arma.'
            """

            consult_Query = "SELECT * FROM usua_album"
            consult_ids_Query = "SELECT ID_Usuario FROM usua_album"
            consult_id_Query = "SELECT ID_Usuario, Us_Nome, Us_Stat FROM usua_album WHERE ID_Usua_Fiat = "

            register_Query = "INSERT INTO usua_album (ID_Usuario, " \
                             "Nombre, Descripcion, Foto_Usuario) " \
                             "VALUES (%s,%s,%s,%s)"
            register_many_Query = "INSERT INTO usua_album (ID_Usua_Fiat, ID_Usuario, " \
                                  "Nombre, Descripcion, Foto_Usuario) " \
                                  "VALUES (%s,%s,%s,%s,%s)"

            update_id_Query = "UPDATE usua_album " \
                              "SET ID_Usua_Fiat = %s, ID_Usuario = %s, Nombre = %s, " \
                              "Descripcion = %s, Foto_Usuario = %s WHERE ID_Usua_Fiat = "

            delete_Query = "DELETE FROM usua_album WHERE ID_Usua_Fiat = "
            truncate_table_Query = "TRUNCATE usua_album"
            drop_table_Query = "DROP TABLE usua_album"

        class Imagenes:
            usua_eve_fiat = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                             "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                             "Area", "Estatus", "Anexado_por"]
            cols_usua_eve_fiat = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                                  "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                                  "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE usua_eve_fiat;"
            show_columns = "SHOW columns FROM usua_eve_fiat"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'usua_eve_fiat'"

            create_Query = """
                CREATE TABLE IF NOT EXISTS `usua_eve_fiat` (
                  `ID_Usua_Fiat` INT(11) NOT NULL AUTO_INCREMENT,
                  `ID_Usuario` INT(11) NOT NULL,
                  `Nombre` VARCHAR(300) NOT NULL,
                  `Descripcion` VARCHAR(500) NOT NULL,
                  `Foto_Usuario` LONGBLOB NOT NULL,
                  PRIMARY KEY (`ID_Usua_Fiat`))
                ENGINE = InnoDB
                AUTO_INCREMENT = 10
                DEFAULT CHARACTER SET = utf8
                COLLATE = utf8_unicode_ci
                COMMENT = 'Tabla para Registro del Catálogo de Arma.'
            """

            consult_Query = "SELECT * FROM usua_eve_fiat"
            consult_ids_Query = "SELECT ID_Usuario FROM usua_eve_fiat"
            consult_id_Query = "SELECT ID_Usuario, Us_Nome, Us_Stat FROM usua_eve_fiat WHERE ID_Usua_Fiat = "

            register_Query = "INSERT INTO usua_eve_fiat (ID_Usuario, " \
                             "Nombre, Descripcion, Foto_Usuario) " \
                             "VALUES (%s,%s,%s,%s)"
            register_many_Query = "INSERT INTO usua_eve_fiat (ID_Usua_Fiat, ID_Usuario, " \
                                  "Nombre, Descripcion, Foto_Usuario) " \
                                  "VALUES (%s,%s,%s,%s,%s)"

            update_id_Query = "UPDATE usua_eve_fiat " \
                              "SET ID_Usua_Fiat = %s, ID_Usuario = %s, Nombre = %s, " \
                              "Descripcion = %s, Foto_Usuario = %s " \
                              "WHERE ID_Usua_Fiat = "

            delete_Query = "DELETE FROM usua_eve_fiat WHERE ID_Usua_Fiat = "
            truncate_table_Query = "TRUNCATE usua_eve_fiat"
            drop_table_Query = "DROP TABLE usua_eve_fiat"

        class Reportes:
            usua_repo = ["ID_Usuario", "Nombre_Completo", "Apellido_Paterno",
                         "Apellido_Materno", "Usuario", "Contraseña", "Permisos", "Especialización",
                         "Area", "Estatus", "Anexado_por"]
            cols_usua_repo = ["ID Usuario", "Nombre Completo", "Apellido Paterno",
                              "Apellido Materno", "Usuario", "Contraseña", "Permiso(s)", "Especialización",
                              "Area", "Estatus", "Anexado Por"]

            describe_table = "DESCRIBE usua_repo;"
            show_columns = "SHOW columns FROM usua_repo"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'usua_repo'"

            create_Query = """
                CREATE TABLE IF NOT EXISTS `usua_repo` (
                      `ID_Usua_Repo` INT(11) NOT NULL AUTO_INCREMENT,
                      `ID_Usuario` INT(11) NOT NULL,
                      `FechaReporte` DATE NOT NULL,
                      `HoraReporte` TIME NOT NULL,
                      `Reporte` LONGBLOB NOT NULL,
                      `TipoReporte` VARCHAR(150) NOT NULL,
                      `NombreReporte` VARCHAR(200) NOT NULL,
                      PRIMARY KEY (`ID_Usua_Repo`))
                    ENGINE = InnoDB
                    AUTO_INCREMENT = 17
                    DEFAULT CHARACTER SET = utf8
                    COLLATE = utf8_unicode_ci
                    COMMENT = 'Tabla para Almacenar los Reportes Médicos de los Pacientes.'
            """

            consult_Query = "SELECT * FROM usua_repo"
            consult_ids_Query = "SELECT ID_Usuario FROM usua_repo"
            consult_id_Query = "SELECT ID_Usuario, Us_Nome, Us_Stat FROM usua_repo WHERE ID_Usua_Repo = "

            register_Query = "INSERT INTO usua_repo (ID_Usuario, " \
                             "FechaReporte, HoraReporte, Reporte, TipoReporte, NombreReporte) " \
                             "VALUES (%s,%s,%s,%s,%s,%s)"
            register_many_Query = "INSERT INTO usua_repo (ID_Usua_Repo, ID_Usuario, " \
                                  "FechaReporte, HoraReporte, Reporte, TipoReporte, NombreReporte) " \
                                  "VALUES (%s,%s,%s,%s,%s,%s,%s)"

            update_id_Query = "UPDATE usua_repo " \
                              "SET ID_Usua_Repo = %s, ID_Usuario = %s, " \
                              "FechaReporte = %s, HoraReporte = %s, " \
                              "Reporte = %s, TipoReporte = %s, NombreReporte = %s " \
                              "WHERE ID_Usua_Repo = "

            delete_Query = "DELETE FROM usua_repo WHERE ID_Usua_Repo = "
            truncate_table_Query = "TRUNCATE usua_repo"
            drop_table_Query = "DROP TABLE usua_repo"

    class Vocales:
        Enologias = ['ID_Vocal', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                     'Variedad',
                     'PVP', 'Foto_Vino']
        cols_enologias = ['ID Enologias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza', 'Crianza',
                          'Variedad', 'PVP']

        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regvocal` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        drop_database = "DROP DATABASE `bd_regvocal`"

        describe_table = "DESCRIBE voca_iden;"
        show_columns = "SHOW columns FROM voca_iden"
        show_information = "SELECT column_name, data_type, is_nullable, " \
                           "column_default  " \
                           "FROM information_schema.columns " \
                           "WHERE table_name = 'voca_iden'"

        create_Query = """CREATE TABLE `voca_iden` (
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
        """
        consult_Query = "SELECT * FROM voca_iden"
        consult_ids_Query = "SELECT ID_Vocal FROM voca_iden"
        consult_partial_Query = "SELECT ID_Vocal, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                                "Crianza, Variedad, PVP FROM voca_iden "
        consult_last_Query = "SELECT * FROM voca_iden ORDER BY ID_Vocal DESC"
        consult_last_partial_Query = "SELECT ID_Vocal, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                                     "Sara_Ape_Mat " \
                                     "FROM voca_iden ORDER BY ID_Sara DESC"
        consult_id_Query = "SELECT ID_Vocal, Sara_NSS, Sara_AGRE, Sara_Nome_PI, Sara_Nome_SE, Sara_Ape_Pat, " \
                           "Sara_Ape_Mat FROM voca_iden WHERE ID_Sara = "
        consult_name_Query = "SELECT ID_Vocal, VinoNombre, MarcaVino, Bodega, Volumen, ZonaCrianza, " \
                             "Crianza, PVP Variedad FROM voca_iden WHERE VinoNombre LIKE '%"
        consult_photo_Query = "SELECT Foto_Vino FROM voca_iden"
        consult_photo_id_Query = "SELECT Foto_Vino FROM voca_iden WHERE ID_Vocal = "
        consult_photo_name_Query = "SELECT Foto_Vino FROM voca_iden WHERE Us_Nome LIKE '%"
        register_Query = "INSERT INTO voca_iden (Tipo_Vocal, Subtipo_Vocal, Categoria_Vocal, Nominacion_Vocal, " \
                         "Trasliteracion, Fonematica)  VALUES (%s,%s,%s,%s,%s,%s)"
        register_photo_Query = "INSERT INTO voca_iden (Tipo_Vocal, Subtipo_Vocal, Categoria_Vocal, Nominacion_Vocal, " \
                               "Trasliteracion, Fonematica)  VALUES (%s,%s,%s,%s,%s,%s,%s)"
        update_id_Query = "UPDATE voca_iden SET " \
                          "ID_Vocal = %, Tipo_Vocal = %, Subtipo_Vocal = %, Categoria_Vocal = %, Nominacion_Vocal = " \
                          "%, Trasliteracion = %, Fonematica = % WHERE ID_Vocal = "
        delete_Query = "DELETE FROM voca_iden WHERE ID_Vocal = "
        truncate_table_Query = "TRUNCATE voca_iden"
        drop_table_Query = "DROP TABLE voca_iden"

    class Patologias:
        create_database = "CREATE DATABASE IF NOT EXISTS `bd_regpatolo` " \
                          "DEFAULT CHARACTER SET utf8 " \
                          "COLLATE utf8_unicode_ci;"
        show_tables = "SHOW tables;"
        drop_database = "DROP DATABASE `bd_regpatolo`"

        class Patologias:
            describe_table = "DESCRIBE patologias;"
            show_columns = "SHOW columns FROM patologias"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'patologias'"

            Enologias = ['ID_Enologias', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                         'Variedad',
                         'PVP', 'Foto_Vino']
            cols_enologias = ['ID Enologias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            create_Query = """CREATE TABLE `patologias` (
              `ID_Patol` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
              `Contemplacion_Patologica` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Clase_Patologia` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Sistema_Afectado` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Organo_Afectado` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Especialidad_Medica` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Nombre_Patologia` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Pseudonimo_Patologia` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Otros_Nombres` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Definicion` varchar(1000) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Se describen de manera general las siguientes patologías';"""

            consult_Query = "SELECT * FROM patologias"
            consult_ids_Query = "SELECT ID_Patol FROM patologias"
            consult_last_Query = "SELECT * FROM patologias ORDER BY ID_Patol DESC"
            consult_id_Query = "SELECT * FROM patologias WHERE ID_Patol = "
            consult_name_Query = "SELECT * FROM patologias WHERE VinoNombre LIKE '%"
            register_Query = "INSERT INTO patologias (ID_Patol, Contemplacion_Patologica, " \
                             "Clase_Patologia, Sistema_Afectado, Organo_Afectado, Especialidad_Medica, " \
                             "Nombre_Patologia, Pseudonimo_Patologia, Otros_Nombres, Definicion) " \
                             "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            update_id_Query = "UPDATE patologias SET ID_Patol = %s, Contemplacion_Patologica = %s, " \
                              "Clase_Patologia = %s, Sistema_Afectado = %s, Organo_Afectado = %s, " \
                              "Especialidad_Medica = %s, Nombre_Patologia = %s, Pseudonimo_Patologia = %s, " \
                              "Otros_Nombres = %s, Definicion = %s " \
                              "WHERE ID_Patol = "
            delete_Query = "DELETE FROM patologias WHERE ID_Patol = "
            truncate_table_Query = "TRUNCATE patologias"
            drop_table_Query = "DROP TABLE patologias"

        class Generalidades:
            describe_table = "DESCRIBE generalidades;"
            show_columns = "SHOW columns FROM generalidades"
            show_information = "SELECT column_name, data_type, is_nullable, " \
                               "column_default  " \
                               "FROM information_schema.columns " \
                               "WHERE table_name = 'generalidades'"

            Enologias = ['ID_Enologias', 'VinoNombre', 'MarcaVino', 'Bodega', 'Volumen', 'ZonaCrianza', 'Crianza',
                         'Variedad',
                         'PVP', 'Foto_Vino']
            cols_enologias = ['ID Enologias', 'VinoNombre', 'Marca Vino', 'Bodega', 'Volumen', 'Zona Crianza',
                              'Crianza',
                              'Variedad', 'PVP']

            create_Query = """CREATE TABLE `generalidades` (
              `ID_Informe` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
              `ID_Pato` int(10) NOT NULL,
              `Categoria` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
              `Descripcion` varchar(500) COLLATE utf8_unicode_ci NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Generalidades de las patologías';"""

            consult_Query = "SELECT * FROM generalidades"
            consult_ids_Query = "SELECT ID_Enologias FROM generalidades"
            consult_last_Query = "SELECT * FROM generalidades ORDER BY ID_Informe DESC"
            consult_id_Query = "SELECT * FROM generalidades WHERE ID_Informe = "
            consult_name_Query = "SELECT * FROM generalidades WHERE VinoNombre LIKE '%"
            register_Query = "INSERT INTO generalidades (ID_Informe, ID_Pato, Categoria, Descripcion) " \
                             "VALUES (%s,%s,%s,%s)"
            update_id_Query = "UPDATE generalidades SET " \
                              "ID_Informe = %s, ID_Pato = %s, Categoria = %s, Descripcion = %s " \
                              "WHERE ID_Informe = "
            delete_Query = "DELETE FROM generalidades WHERE ID_Informe = "
            truncate_table_Query = "TRUNCATE generalidades"
            drop_table_Query = "DROP TABLE generalidades"

