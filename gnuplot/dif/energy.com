#!/bin/bash
pgf90 -o energy.e energy.f90 
cp /net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/dif/homo/s0101_p snap1.hor
cp /net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/dif/homo/s0201_p snap1.ver
#cp /net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/dif/homo/s1101_patten snap2.hor
#cp /net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/dif/homo/s1201_patten snap2.ver
cp /net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/dif/homo/s1101_dc snap2.hor
cp /net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/dif/homo/s1201_dc snap2.ver
./energy.e
echo DONE
cp snap_resi.bin snap_resi_dc.bin
rm energy.e snap1.hor snap1.ver snap2.hor snap2.ver snap_resi.bin
