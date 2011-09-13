SELECT 'INSERT INTO tbl_kstm_puertos(COD,PUERTO,CPAIS,LAT,LON,PAIS,AGRUP) VALUES ('
         || '''' || TRIM(COD) || ''', '
         || '''' || TRIM(PUERTO) || ''', '
         || '''' || TRIM(CPAIS) || ''', '
         || '''' || TRIM(LAT) || ''', '
         || '''' || TRIM(LON) || ''', '
         || '''' || TRIM(PAIS) || ''', '
         || '''' || TRIM(AGRUP) || '''); '
    FROM tbl_kstm_puertos where rownum < 100