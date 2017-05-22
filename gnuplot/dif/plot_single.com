#Gnu Plot
pgf90 -o separate.e separate.f num2char.f -g
cp /net/kong/li/1/wxw120130/2D_Acos_stg_cpml_tian/bin/snap_down.bin snap.hor
cp /net/kong/li/1/wxw120130/2D_Acos_stg_cpml_tian/bin/snap_down.bin snap.ver
./separate.e
gnuplot gnu_snap_acoustic
rm snap_h_* snap_v_* snap.hor snap.ver

