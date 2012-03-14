alter table 
        tbl_reporte_param
      MODIFY 
         ( 
          indice     INTEGER      NULL,
          tipo_dato  INTEGER      NULL,
          nombre     VARCHAR2(56) NULL
      );
      
      alter table tbl_reporte_param
      add
       (
        tipo      VARCHAR2(56) NULL,
        entity    VARCHAR2(56) NULL,
        xml_id    VARCHAR2(56) NULL,
        operador  VARCHAR2(56) NULL,
        valor     VARCHAR2(256) NULL,
        orden     integer,
        is_param integer
       );
       
  /*     INSERT INTO tbl_reporte_param( reporte_id, tipo, entity, xml_id, operador, valor, orden, is_param) 
        VALUES ({0}, '{1}', '{2}', '{3}', '{4}', '{5}', {6}, {7}) ;
        
        
        
  select a.reporte_id, a.tipo, a.entity, a.xml_id, a.operador, a.valor, a.orden, a.is_param,
       b.reporte_id, b.tipo, b.entity, b.xml_id, b.operador, b.valor, b.orden, b.is_param 
    from tbl_reporte_param a left join tbl_reporte_param b on a.reporte_id = b.reporte_id
    where a.nombre is null
    order by a.orden asc, b.orden asc
*/