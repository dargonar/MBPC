alter table
   tbl_etapa 
modify
   (
    velocidad                       NUMBER(*,8),
    calado_proa                     NUMBER(*,8),
    calado_popa                     NUMBER(*,8),
    calado_maximo                   NUMBER(*,8),
    calado_informado                NUMBER(*,8),
    latitud                         NUMBER(*,8),
    longitud                        NUMBER(*,8),
    km                              NUMBER(*,8)
   );