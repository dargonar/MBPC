delete from tbl_evento WHERE viaje_id IN (SELECT id FROM tbl_viaje WHERE buque_id=_ID_BUQUE_);
delete from tbl_cargaetapa WHERE etapa_id IN (SELECT id FROM tbl_etapa WHERE viaje_id IN (SELECT id FROM tbl_viaje WHERE buque_id=_ID_BUQUE_));
delete from tbl_practicoviaje WHERE viaje_id IN (SELECT id FROM tbl_viaje WHERE buque_id=_ID_BUQUE_);
delete from tbl_etapa WHERE viaje_id IN (SELECT id FROM tbl_viaje WHERE buque_id=_ID_BUQUE_);
delete from tbl_pbip WHERE viaje_id IN (SELECT id FROM tbl_viaje WHERE buque_id=_ID_BUQUE_);
delete from tbl_viaje WHERE id IN (SELECT id FROM tbl_viaje WHERE buque_id=_ID_BUQUE_);
DELETE FROM tmp_buques WHERE id_buque=_ID_BUQUE_