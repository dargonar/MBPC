--------------------------------------------------------
--  File created - Monday-June-27-2011   
--------------------------------------------------------
-- Unable to render VIEW DDL for object BUQUES.VW_BUQUES_MBPC with DBMS_METADATA attempting internal generator.
CREATE VIEW BUQUES.VW_BUQUES_MBPC AS SELECT a.buque_id,a.registro,replace(replace(replace(a.matricula,'REY',''),'M',''),'F','') matricula,
       a.nombre, a.nro_ismm,
       b.tipo, c.servicio,d.explotacion
 FROM tbl_bq_buques a,tbl_bq_codtipobuque b,tbl_bq_codtiposervicio c,
        tbl_bq_codtipoexplotacion d
  where a.eliminacion is null and substr(a.matricula,1,1)='0'
  and a.tipo_buque = b.cod
  and a.tipo_servicio = c.cod
  and a.tipo_explotacion = d.cod
