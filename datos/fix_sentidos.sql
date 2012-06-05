declare
  theid integer;
  cxz tbl_conexionpuntodecontrol%ROWTYPE;
begin

for etapa IN ( SELECT * FROM tbl_etapa WHERE actual_id IS NOT NULL AND destino_id IS NOT null )
loop
  
  begin
    select * into cxz from tbl_conexionpuntodecontrol cx where (cx.puntodecontrol1 = etapa.actual_id and cx.puntodecontrol2 = etapa.destino_id) OR (cx.puntodecontrol1 = etapa.destino_id and cx.puntodecontrol2 = etapa.actual_id);

      IF (cxz.puntodecontrol1 = etapa.actual_id) THEN
        etapa.sentido  := cxz.aguasarriba;             --sentido desde actual
        IF (cxz.aguasarriba2 = 0) THEN                --sentido desde destino
          etapa.sentido2 := 1;
        ELSE
          etapa.sentido2 := 0;
        END IF;
      ELSE
        etapa.sentido  := cxz.aguasarriba2;            --sentido desde actual
        IF (cxz.aguasarriba = 0) THEN                 --sentido desde destino
          etapa.sentido2 := 1;
        ELSE
          etapa.sentido2 := 0;
        END IF;
      END IF;

      UPDATE tbl_etapa SET sentido2=etapa.sentido2 WHERE id=etapa.id;

  exception when NO_DATA_FOUND THEN
    -- usuario no existe
    theid := 200;
  END;

  
end loop;

end;