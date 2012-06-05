PROMPT CREATE OR REPLACE TRIGGER etapa_sentido_update
CREATE OR REPLACE TRIGGER etapa_sentido_update
before update of destino_id on tbl_etapa
for each row
declare
cxz tbl_conexionpuntodecontrol%ROWTYPE;
begin
  select * into cxz from tbl_conexionpuntodecontrol cx where (cx.puntodecontrol1 = :new.actual_id and cx.puntodecontrol2 = :new.destino_id) OR (cx.puntodecontrol1 = :new.destino_id and cx.puntodecontrol2 = :new.actual_id);

  IF (cxz.puntodecontrol1 = :new.actual_id) THEN
    :new.sentido  := cxz.aguasarriba;             --sentido desde actual
    IF (cxz.aguasarriba2 = 0) THEN                --sentido desde destino
      :new.sentido2 := 1;
    ELSE
      :new.sentido2 := 0;
    END IF;
  ELSE
    :new.sentido  := cxz.aguasarriba2;            --sentido desde actual
    IF (cxz.aguasarriba = 0) THEN                 --sentido desde destino
      :new.sentido2 := 1;
    ELSE
      :new.sentido2 := 0;
    END IF;
  END IF;

end etapa_sentido_update;
/
