DROP TABLE VM_BUQUES_NAC;
CREATE TABLE VM_BUQUES_NAC (
  ID                                                 NUMBER,
  MATRICULA                                          VARCHAR2(10),
  NRO_OMI                                            NUMBER(7),
  NOMBRE                                             VARCHAR2(50),
  BANDERA                                            VARCHAR2(40),
  ANIO_CONSTRUCCION                                  NUMBER(4),
  NRO_ISMM                                           NUMBER(9),
  ASTILL_PARTIC                                      VARCHAR2(80),
  REGISTRO                                           VARCHAR2(10),
  TIPO_BUQUE                                         VARCHAR2(45),
  TIPO_SERVICIO                                      VARCHAR2(35),
  TIPO_EXPLOTACION                                   VARCHAR2(35),
  ARBOLADURA                                         VARCHAR2(50),
  SEAL_DISTINTIVA                                    VARCHAR2(7),
  VELOCIDAD                                          NUMBER(2),
  ESLORA                                             NUMBER(6,2),
  MANGA                                              NUMBER(5,2),
  PUNTAL                                             NUMBER(5,2),
  ARQUEO_TOTAL                                       NUMBER(8,2),
  CALADO_MAX                                         NUMBER(5,2),
  PUERTO_ASIENTO                                     VARCHAR2(4),
  MATERIAL                                           VARCHAR2(21),
  SOCIEDADCLASIF                                     CHAR(1),
  ARQUEO_NETO                                        NUMBER(8,2),
  DOTACION_MINIMA                                    NUMBER(5),
  TIPO                                               CHAR(8)
);

DROP TABLE VM_BUQUES_LRF;
CREATE TABLE VM_BUQUES_LRF (
 ID                                                 NUMBER,
 MATRICULA                                          CHAR(1),
 NRO_OMI                                            NCHAR(20) NOT NULL,
 NOMBRE                                             NCHAR(150),
 BANDERA                                            NVARCHAR2(50),
 ANIO_CONSTRUCCION                                  NVARCHAR2(4),
 NRO_ISMM                                           NCHAR(20),
 ASTILL_PARTIC                                      CHAR(1),
 REGISTRO                                           CHAR(1),
 TIPO_BUQUE                                         NVARCHAR2(255),
 TIPO_SERVICIO                                      CHAR(1),
 TIPO_EXPLOTACION                                   CHAR(1),
 ARBOLADURA_ID                                      CHAR(1),
 SDIST                                              NCHAR(30),
 VELOCIDAD                                          CHAR(1),
 ESLORA                                             CHAR(1),
 MANGA                                              CHAR(1),
 PUNTAL                                             CHAR(1),
 ARQUEO_TOTAL                                       CHAR(1),
 CALADO_MAX                                         CHAR(1),
 PUERTO_ASIENTO                                     CHAR(1),
 MATERIAL                                           CHAR(1),
 SOCIEDADCLASIF                                     NCHAR(40),
 ARQUEO_NETO                                        CHAR(1),
 DOTACIN_MINIMA                                     CHAR(1),
 TIPO                                               CHAR(3)
);

DROP TABLE VM_BUQUES_CIIE;
CREATE TABLE VM_BUQUES_CIIE (
  ID                                                 NUMBER,
  MATRICULA                                          VARCHAR2(16),
  NRO_OMI                                            NUMBER,
  NOMBRE                                             VARCHAR2(50) NOT NULL,
  BANDERA                                            VARCHAR2(50) NOT NULL,
  ANIOCONSTRUCCION                                   NUMBER(5) NOT NULL,
  NRO_ISMM                                           NUMBER,
  ASTILL_PARTIC                                      CHAR(1),
  REGISTRO                                           CHAR(1),
  TIPO_BUQUE                                         VARCHAR2(50) NOT NULL,
  TIPO_SERVICIO                                      CHAR(1),
  TIPO_EXPLOTACION                                   CHAR(1),
  ARBOLADURA                                         CHAR(1),
  SDIST                                              VARCHAR2(8),
  VELOCIDAD                                          CHAR(1),
  ESLORA                                             CHAR(1),
  MANGA                                              CHAR(1),
  PUNTAL                                             CHAR(1),
  ARQUEO_TOTAL                                       CHAR(1),
  CALADO_MAX                                         CHAR(1),
  PUERTO_ASIENTO                                     CHAR(1),
  MATERIAL                                           CHAR(1),
  SOC_CLASIF                                         VARCHAR2(80) NOT NULL,
  ARQUEO_NETO                                        CHAR(1),
  DOTACION_MINIMA                                    CHAR(1),
  TIPO                                               CHAR(10)
);


CREATE SYNONYM SN_BQ_NAC FOR VM_BUQUES_NAC;
CREATE SYNONYM SN_BQ_INTERN FOR VM_BUQUES_LRF;
CREATE SYNONYM SN_BQ_RIBER FOR VM_BUQUES_CIIE;

copy from MBPC/MBPC@192.168.50.89/PRODUCC to matu/248@127.0.0.1 INSERT SN_BQ_NAC USING SELECT * FROM SN_BQ_NAC;
copy from MBPC/MBPC@192.168.50.89/PRODUCC to matu/248@127.0.0.1 INSERT SN_BQ_INTERN USING SELECT * FROM SN_BQ_INTERN;
copy from MBPC/MBPC@192.168.50.89/PRODUCC to matu/248@127.0.0.1 INSERT SN_BQ_RIBER USING SELECT * FROM SN_BQ_RIBER;


PROMPT CREATE OR REPLACE VIEW buques_new
CREATE OR REPLACE VIEW buques_new (
  id,
  matricula,
  nro_omi,
  nombre,
  bandera,
  anio_construccion,
  nro_ismm,
  astill_partic,
  registro,
  tipo_buque,
  tipo_servicio,
  tipo_explotacion,
  arboladura,
  sdist,
  velocidad,
  eslora,
  manga,
  puntal,
  arqueo_total,
  calado_max,
  puerto_asiento,
  material,
  sociedadclasif,
  arqueo_neto,
  dotacion_minima,
  tipo
) AS
(
SELECT /*+ FIRST_ROWS(2) */
       TO_NUMBER(I.ID) ID,
	   TO_CHAR(I.MATRICULA) MATRICULA,
	   TO_NUMBER(I.NRO_OMI)NRO_OMI,
	   TO_CHAR(I.NOMBRE) NOMBRE,
	   TO_CHAR(I.BANDERA) BANDERA,
	   TO_NUMBER(I.ANIO_CONSTRUCCION) ANIO_CONSTRUCCION,
	   TO_NUMBER(I.NRO_ISMM) NRO_ISMM,
	   TO_CHAR(I.ASTILL_PARTIC) ASTILL_PARTIC,
	   TO_CHAR(I.REGISTRO) REGISTRO,
	   TO_CHAR(I.TIPO_BUQUE) TIPO_BUQUE,
	   TO_CHAR(I.TIPO_SERVICIO) TIPO_SERVICIO,
	   TO_CHAR(I.TIPO_EXPLOTACION) TIPO_EXPLOTACION,
	   TO_CHAR(I.ARBOLADURA_ID) ARBOLADURA,
	   TO_CHAR(I.SDIST) SDIST,
	   TO_CHAR(I.VELOCIDAD) VELOCIDAD,
	   TO_CHAR(I.ESLORA) ESLORA,
	   TO_CHAR(I.MANGA) MANGA,
	   TO_CHAR(I.PUNTAL) PUNTAL,
	   TO_CHAR(I.ARQUEO_TOTAL) ARQUEO_TOTAL,
	   TO_CHAR(I.CALADO_MAX) CALADO_MAX,
	   TO_CHAR(I.PUERTO_ASIENTO) PUERTO_ASIENTO,
	   TO_CHAR(I.MATERIAL) MATERIAL,
	   TO_CHAR(I.SOCIEDADCLASIF) SOCIEDADCLASIF,
	   TO_CHAR(I.ARQUEO_NETO) ARQUEO_NETO,
	   TO_CHAR(I.DOTACIN_MINIMA) DOTACION_MINIMA,
	   TO_CHAR(I.TIPO) TIPO
FROM SN_BQ_INTERN I
UNION ALL
SELECT /*+ FIRST_ROWS(2) */
	   TO_NUMBER(R.ID) ID,
	   TO_CHAR(R.MATRICULA) MATRICULA,
	   TO_NUMBER(R.NRO_OMI)NRO_OMI,
	   TO_CHAR(R.NOMBRE) NOMBRE,
	   TO_CHAR(R.BANDERA) BANDERA,
	   TO_NUMBER(R.ANIOCONSTRUCCION) ANIO_CONSTRUCCION,
	   TO_NUMBER(R.NRO_ISMM) NRO_ISMM,
	   TO_CHAR(R.ASTILL_PARTIC) ASTILL_PARTIC,
	   TO_CHAR(R.REGISTRO) REGISTRO,
	   TO_CHAR(R.TIPO_BUQUE) TIPO_BUQUE,
	   TO_CHAR(R.TIPO_SERVICIO) TIPO_SERVICIO,
	   TO_CHAR(R.TIPO_EXPLOTACION) TIPO_EXPLOTACION,
	   TO_CHAR(R.ARBOLADURA) ARBOLADURA,
	   TO_CHAR(R.SDIST) SDIST,
	   TO_CHAR(R.VELOCIDAD) VELOCIDAD,
	   TO_CHAR(R.ESLORA) ESLORA,
	   TO_CHAR(R.MANGA) MANGA,
	   TO_CHAR(R.PUNTAL) PUNTAL,
	   TO_CHAR(R.ARQUEO_TOTAL) ARQUEO_TOTAL,
	   TO_CHAR(R.CALADO_MAX) CALADO_MAX,
	   TO_CHAR(R.PUERTO_ASIENTO) PUERTO_ASIENTO,
	   TO_CHAR(R.MATERIAL) MATERIAL,
	   TO_CHAR(R.SOC_CLASIF) SOCIEDADCLASIF,
	   TO_CHAR(R.ARQUEO_NETO) ARQUEO_NETO,
	   TO_CHAR(R.DOTACION_MINIMA) DOTACION_MINIMA,
	   TO_CHAR(R.TIPO) TIPO
FROM SN_BQ_RIBER R
UNION ALL
SELECT /*+ FIRST_ROWS(2) */
	   TO_NUMBER(N.ID) ID,
	   TO_CHAR(N.MATRICULA) MATRICULA,
	   TO_NUMBER(N.NRO_OMI)NRO_OMI,
	   TO_CHAR(N.NOMBRE) NOMBRE,
	   TO_CHAR(N.BANDERA) BANDERA,
	   TO_NUMBER(N.ANIO_CONSTRUCCION) ANIO_CONSTRUCCION,
	   TO_NUMBER(N.NRO_ISMM) NRO_ISMM,
	   TO_CHAR(N.ASTILL_PARTIC) ASTILL_PARTIC,
	   TO_CHAR(N.REGISTRO) REGISTRO,
	   TO_CHAR(N.TIPO_BUQUE) TIPO_BUQUE,
	   TO_CHAR(N.TIPO_SERVICIO) TIPO_SERVICIO,
	   TO_CHAR(N.TIPO_EXPLOTACION) TIPO_EXPLOTACION,
	   TO_CHAR(N.ARBOLADURA) ARBOLADURA,
	   TO_CHAR(N.SEAL_DISTINTIVA) SDIST,
	   TO_CHAR(N.VELOCIDAD) VELOCIDAD,
	   TO_CHAR(N.ESLORA) ESLORA,
	   TO_CHAR(N.MANGA) MANGA,
	   TO_CHAR(N.PUNTAL) PUNTAL,
	   TO_CHAR(N.ARQUEO_TOTAL) ARQUEO_TOTAL,
	   TO_CHAR(N.CALADO_MAX) CALADO_MAX,
	   TO_CHAR(N.PUERTO_ASIENTO) PUERTO_ASIENTO,
	   TO_CHAR(N.MATERIAL) MATERIAL,
	   TO_CHAR(N.SOCIEDADCLASIF) SOCIEDADCLASIF,
	   TO_CHAR(N.ARQUEO_NETO) ARQUEO_NETO,
	   TO_CHAR(N.DOTACION_MINIMA) DOTACION_MINIMA,
	   TO_CHAR(N.TIPO) TIPO
FROM SN_BQ_NAC N)
/


