#Gnu Plot
pgf90 -o separate.e separate.f num2char.f -g
cp /net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/dif/pv_s1201 ./snap.hor
cp /net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/dif/pv_s1101 ./snap.ver
./separate.e
gnuplot gnu_snapplot
rm snap_h_* snap_v_* snap.hor snap.ver
mv snap.eps snap_ps.eps
echo Snaps of Forward Extrapolation, Done!

