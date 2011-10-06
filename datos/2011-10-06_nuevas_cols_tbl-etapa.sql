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

   
   