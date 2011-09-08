alter table
   tbl_etapa
add
   (
    acompanante_id VARCHAR2(10) 
   );
      
alter table tbl_etapa
ADD CONSTRAINT fk_buque
FOREIGN KEY (acompanante_id)
REFERENCES tbl_bq_buques(matricula)


alter table
   tbl_evento
add
   (
    acompanante_id VARCHAR2(10) 
   );
      


alter table
   tbl_viaje
add
   (
    viaje_padre NUMBER(*,0) 
   );
      


insert into tbl_tipoevento VALUES (13, 'Agrega acompanante');

insert into tbl_tipoevento VALUES (14, 'Quita acompanante');

insert into tbl_tipoevento VALUES (15, 'Separar Convoy');



create or replace trigger etapa_sentido_insert
before insert on tbl_etapa
for each row
declare
cxz tbl_conexionpuntodecontrol%ROWTYPE;
etp number;
begin

  --CASO DE INSERT EN PRIMERA ETAPA COMO ORIGEN ES NULL SE TOMA COMO UPDATE (buscando el sentido del trayecto de la etapa actual al primer destino)
  if :new.sentido is NULL then
    if :new.origen_id IS NULL then
        --ETAPA INICIAL
        :new.nro_etapa := 0;
        --COPIA EL SENTIDO DEL TRAYECTO DE LA MATRIZ A LA ETAPA
        select * into cxz from tbl_conexionpuntodecontrol cx where (cx.puntodecontrol1 = :new.actual_id and cx.puntodecontrol2 = :new.destino_id) OR (cx.puntodecontrol1 = :new.destino_id and cx.puntodecontrol2 = :new.actual_id);

        IF (cxz.puntodecontrol1 = :new.actual_id) THEN
          :new.sentido := cxz.aguasarriba;
        ELSE 
          IF (cxz.aguasarriba = 0) THEN
            :new.sentido := 1;
          ELSE
            :new.sentido := 0;
          END IF;
        END IF;
    else
      --ETAPA SIGUIENTE
      select MAX(nro_etapa) + 1 into etp from tbl_etapa where viaje_id = :new.viaje_id;
      :new.nro_etapa := etp;
      UPDATE tbl_viaje SET etapa_actual = etp where id = :new.viaje_id;
      
      --COPIA EL SENTIDO DEL TRAYECTO DE LA MATRIZ A LA ETAPA 
      select * into cxz from tbl_conexionpuntodecontrol cx where (cx.puntodecontrol1 = :new.origen_id and cx.puntodecontrol2 = :new.actual_id) OR (cx.puntodecontrol1 = :new.actual_id and cx.puntodecontrol2 = :new.origen_id);
      
      IF (cxz.puntodecontrol1 = :new.origen_id) THEN
        :new.sentido := cxz.aguasarriba;
      ELSE 
        IF (cxz.aguasarriba = 0) THEN
          :new.sentido := 1;
        ELSE
          :new.sentido := 0;
        END IF;
      END IF;
    end if;
  end if;
  
  
  
  
end etapa_sentido_insert;





