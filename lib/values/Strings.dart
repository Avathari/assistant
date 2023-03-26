class Sentences {
  static const String regresar = "Regresar";

  static const String app_bar_tittle = "";
  static const String app_usuarios_tittle = "Gestor de Usuarios";
  static const String app_pacientes_tittle = "Gestor de Pacientes";
  static const String add_usuario = "Agregar nuevo usuario";
  static const String find_usuario = "Buscar usuario por Apellido";
  static const String reload = "Recargar búsqueda";

  static const String app_bar_usuarios = "Gestión del Usuario";

  static const String add_vitales = "Agregar signos vitales";

  static const String app_bar_reportes = "Auxiliar de reportes médicos";

  static String capitalize(String value) {
    if (value.isNotEmpty) {
      var result = value[0].toUpperCase();
      bool cap = true;
      for (int i = 1; i < value.length; i++) {
        if (value[i - 1] == " " && cap == true) {
          result = result + value[i].toUpperCase();
        } else {
          result = result + value[i];
          cap = false;
        }
      }
      return result;
    } else {
      return value;
    }
  }

  static String capitalizeAllWord(String value) {
    print("value ${value[0]}");
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    print("result $result");
    return result;
  }
}

class listados {
  static const List users = [
    {
      "ID_Usuario": 1,
      "Us_Nome": "Luis",
      "Us_Ape_Pat": "Romero",
      "Us_Ape_Mat": "Pantoja",
      "Us_Usuario": "Luis",
      "Us_Passe": "123456",
      "Us_Permi": "Administrador",
      "Us_EspeL": "Medicina General",
      "Us_Area": "Medicina General",
      "Us_Stat": "Activo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 2,
      "Us_Nome": "Ariana",
      "Us_Ape_Pat": "Dominguez",
      "Us_Ape_Mat": "Suarez",
      "Us_Usuario": "Ariana",
      "Us_Passe": "954637",
      "Us_Permi": "Médico Especialista",
      "Us_EspeL": "Médico Especialista",
      "Us_Area": "Medicina Interna",
      "Us_Stat": "Inactivo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 3,
      "Us_Nome": "Laurana Isabel",
      "Us_Ape_Pat": "Silvana",
      "Us_Ape_Mat": "Loeza",
      "Us_Usuario": "LauranaIsabel",
      "Us_Passe": "892413",
      "Us_Permi": "Enfermería General",
      "Us_EspeL": "Enfermería General",
      "Us_Area": "Técnico(a) en Enfermería General",
      "Us_Stat": "Activo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 4,
      "Us_Nome": "Isadora",
      "Us_Ape_Pat": "Jimenez",
      "Us_Ape_Mat": "Barrera",
      "Us_Usuario": "Isadora",
      "Us_Passe": "k",
      "Us_Permi": "Médico Especialista",
      "Us_EspeL": "Médico Especialista",
      "Us_Area": "Medicina Interna",
      "Us_Stat": "Inactivo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 5,
      "Us_Nome": "Estafania",
      "Us_Ape_Pat": "Cabrera",
      "Us_Ape_Mat": "Reyes",
      "Us_Usuario": "Estefania",
      "Us_Passe": "y",
      "Us_Permi": "Administrador",
      "Us_EspeL": "Médico Especialista",
      "Us_Area": "Cirugía General",
      "Us_Stat": "Activo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 6,
      "Us_Nome": "Angelica",
      "Us_Ape_Pat": "Sandoval",
      "Us_Ape_Mat": "Martinez",
      "Us_Usuario": "Angelica",
      "Us_Passe": "9",
      "Us_Permi": "Médico Especialista",
      "Us_EspeL": "Médico Especialista",
      "Us_Area": "Anestesiología",
      "Us_Stat": "Activo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 7,
      "Us_Nome": "Monica",
      "Us_Ape_Pat": "Echeverria",
      "Us_Ape_Mat": "Beltrán",
      "Us_Usuario": "Monica",
      "Us_Passe": "7",
      "Us_Permi": "Enfermería Especialista",
      "Us_EspeL": "Enfermería Especialista",
      "Us_Area": "Enfermería Quirúrgica",
      "Us_Stat": "Activo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 8,
      "Us_Nome": "Laura",
      "Us_Ape_Pat": "Arroyo",
      "Us_Ape_Mat": "Santana",
      "Us_Usuario": "Laura",
      "Us_Passe": "6",
      "Us_Permi": "Enfermería General",
      "Us_EspeL": "Enfermería General",
      "Us_Area": "Enfermería General",
      "Us_Stat": "Activo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 9,
      "Us_Nome": "Andrea",
      "Us_Ape_Pat": "Rodriguez",
      "Us_Ape_Mat": "Cruz",
      "Us_Usuario": "Andrea",
      "Us_Passe": "7",
      "Us_Permi": "Administrador",
      "Us_EspeL": "Medicina General",
      "Us_Area": "Enfermería General",
      "Us_Stat": "Activo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 10,
      "Us_Nome": "Audrey",
      "Us_Ape_Pat": "Valdivieso",
      "Us_Ape_Mat": "Aeternam",
      "Us_Usuario": "Audrey",
      "Us_Passe": "999999",
      "Us_Permi": "Administrador",
      "Us_EspeL": "Medicina General",
      "Us_Area": "Enfermería General",
      "Us_Stat": "Activo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 47,
      "Us_Nome": "Lexi",
      "Us_Ape_Pat": "Luna",
      "Us_Ape_Mat": "Luna",
      "Us_Usuario": "Lexi",
      "Us_Passe": "522181",
      "Us_Permi": "Administrador",
      "Us_EspeL": "Médico Interno de Pregrado",
      "Us_Area": "Cirugía General",
      "Us_Stat": "Activo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    },
    {
      "ID_Usuario": 48,
      "Us_Nome": "Laurana",
      "Us_Ape_Pat": "Laurana",
      "Us_Ape_Mat": "Laurana",
      "Us_Usuario": "Laurana",
      "Us_Passe": "522181",
      "Us_Permi": "Administrador",
      "Us_EspeL": "Médico Interno de Pregrado",
      "Us_Area": "Cirugía General",
      "Us_Stat": "Activo",
      "Usu_ADAM_AGE": "Romero Pantoja Luis (Administrador)."
    }
  ];
}

class Phrases {
  static const String demoTittle = "Leyes del Poder";
  static const String demoPhrase =
      "LEY NO 32. JUEGUE CON LAS FANTASÍAS DE LA GENTE. pAG 325\n"
      "LEY NO 33. DESCUBRA EL TALÓN DE AQUILES DE LOS DEMÁS. Pag 334\n"
      "LEY NO 34. ACTUE COMO UN REY PARA SER TRATADO COMO TAL Pag 347\n"
      "LEY NO 35. DOMINE EL ARTE DE LA OPORTUNIDAD Pag 357\n"
      "LEY NO 36. MENOSPRECIE LAS COSAS QUE NO PUEDE OBTENER: IGNORARLAS ES LA MEJOR DE LAS VENGANZAS Pag. 367\n"
      "LEY NO 37. ARME ESPECTÁCULOS IMPONENTES. Pag 377\n"
      "LEY NO 38. PIENSE COMO QUIERA, PERO COMPÓRTESE COMO LOS DEMÁS. pAG 386\n"
      "LEY NO 39. REVUELVA LAS AGUAS PARA ASEGURARSE UNA BUENA PESCA. pAG. 396\n"
      "LAY NO 40 MENOSPRECIE LO QUE ES GRATUITO Pag. 405\n"
      "LEY NO 41. EVITE IMITAR A LOS GRANDES HOMBRES. Pag. 422\n"
      "LEY NO 42. MUERTO EL PERRO, SE ACABÓ LA RABIA. Pag. 435\n"
      "LEY NO 43. TRABAJE SOBRE LA MENTE Y EL CORAZÓN DE LOS DEMÁS. pAG 445\n"
      "LEY NO 44. DESARME Y ENFUREZCA CON EL EFECTO ESPEJO. Pag 455\n"
      "LEY NO 45. PREDIQUE LA NECESIDAD DE INTRODUCIR CAMBIOS, PERO NUNCA MODIFIQUE DEMASIADO A LA VEZ. pAG 474\n"
      "LEY NO 46. NUNCA SE MUESTRE DEMASIADO PERFECTO. pAG. 484\n"
      "LEY NO 47. NO VAYA MÁS ALLÁ DE SU OBJETIVO ORIGINAL; AL TRIUNFAR, APRENDA CUÁNDO DETENERSE. pAG. 496\n"
      "LEY NO 48. SEA CAMBIANTE EN SU FORMA. Pag 506\n";
}
