alter table
   tbl_etapa 
add
   (
    velocidad          NUMBER(3,1)       NULL,
    rumbo              NUMBER(3,0)   NULL
   );


/* ---  */

alter table
   tbl_evento
drop
   (
    velocidad          
   );
   
 alter table
   tbl_evento
add
   (
    velocidad          NUMBER(3,1)       NULL
   );

/* ---  */   
 alter table
   tbl_cargaetapa 
add
   (
    cantidad_inicial         INTEGER NOT NULL, /* preseteado */
    cantidad_entrada         INTEGER default 0 NOT NULL , /* updetea user */
    cantidad_salida          INTEGER default 0 NOT NULL,  /* updetea user */
    en_transito              INTEGER default 0 NOT NULL 
    /* cantidad inicia con cantidad_inicial, se calcula al modificarse in/out */
    /* dentro de form editar_carga -> nueva carga, encima de "Esta en barcaza" */
   );
   
/*
  En sp pasar_barco agregar los tres campos.
  En sp insertar_carga agregar cantidad_inicial = cantidad, in/out=0, add field en_transito.
  En sp modificar_carga solo modificar IN/OUT, y recalcvular cantidad.
*/

