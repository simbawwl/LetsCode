        program main
        implicit none
        include "fftw3.f"
        integer ix,iz,rec_z,iret
        integer nx1,nz1,nx,nz,i,k,j
        parameter(nz1=1024,nx1=1024)
        parameter(nz=501,nx=801)
        real kx(nx1),kz(nz1),ak
        real kx_2(nz1,nx1),kz_2(nz1,nx1)
        real vx(nz,nx),vz(nz,nx)

      real  u1_temp(nz,nx)
      real  w1_temp(nz,nx)
      real  sw(nz,nx)
      real   aa(4)
      complex cu1(nz1,nx1),cw1(nz1,nx1)
      complex cu1_in(nz1,nx1),cw1_in(nz1,nx1)
      complex cu1_p(nz1,nx1),cw1_p(nz1,nx1)
      complex cu1_s(nz1,nx1),cw1_s(nz1,nx1)
      complex pwave1(nz1,nx1),pwave2(nz1,nx1)
      complex swave1(nz1,nx1),swave2(nz1,nx1)

      integer*8 plan1,plan2,plan3,plan4,plan5,plan6

        aa(1) = 1225. / 1024.  !8th-order
        aa(2) =  245. / 3072.
        aa(3) =   49. / 5120.
        aa(4) =    5. / 7168.
        

        rec_z=0
        do ix=1,nx1,1
                if (ix .le. (nx1/2)) then
                kx(ix)=(ix-1)*1.0/(nx1/2.0)
                else
                kx(ix)=(ix-nx1)*1.0/(nx1/2.0)
                endif 
        enddo

        do iz=1,nz1,1
                if (iz .le. (nz1/2)) then
                kz(iz)=(iz-1)*1.0/(nz1/2.0)
                else
                kz(iz)=(iz-nz1)*1.0/(nz1/2.0)
                endif 
        enddo

        do ix=1,nx1,1
        do iz=1,nz1,1
                ak=kx(ix)**2+kz(iz)**2
                kx_2(iz,ix)=kx(ix)/sqrt(ak)
                kz_2(iz,ix)=kz(iz)/sqrt(ak)
c                print*,kx_2(iz,ix)
                if (ak .lt. 1E-10) then
                kx_2(iz,ix)=0.0
                kz_2(iz,ix)=0.0
                endif 
        enddo
        enddo


        open(30,file='kx.bin',access='direct',form='unformatted',
     &   recl=nx1*nz1)
        write(30,rec=1) ((kx_2(iz,ix),iz=1,nz1),ix=1,nx1)
        close(30)
        open(31,file='kz.bin',access='direct',form='unformatted',
     &   recl=nx1*nz1)
        write(31,rec=1) ((kz_2(iz,ix),iz=1,nz1),ix=1,nx1)
        close(31)

        open(32,file="../data_demo/snap_p.hor",access='direct',
     &        form='unformatted',recl=nz*nx)        
         read(32,rec=4) ((vx(i,j), i=1,nz),j=1,nx)
        close(32)
        open(33,file="../data_demo/snap_p.ver",access='direct',
     &        form='unformatted',recl=nz*nx)       
         read(33,rec=4) ((vz(i,j), i=1,nz),j=1,nx)
        close(33)

        do iz=1,nz
        do ix=1,nx
                if (ix.eq.1) then
                u1_temp(iz,ix)=vx(iz,ix)
                else
                u1_temp(iz,ix)=(vx(iz,ix)+vx(iz,ix-1))*0.5
                endif
        enddo
        enddo
        do ix=1,nx
        do iz=1,nz
                if (iz.eq.1) then
                w1_temp(iz,ix)=vz(iz,ix)
                else
                w1_temp(iz,ix)=(vz(iz,ix)+vz(iz-1,ix))*0.5
                endif
        enddo
        enddo

      do i=5, nx-4
      do k=5, nz-4
        sw(k,i) = (aa(1)*(u1_temp(k+1,i)-u1_temp(k,i))+
     &            aa(2)*(u1_temp(k+2,i)-u1_temp(k-1,i))+
     &            aa(3)*(u1_temp(k+3,i)-u1_temp(k-2,i))+
     &            aa(4)*(u1_temp(k+4,i)-u1_temp(k-3,i))-
     &            aa(1)*(w1_temp(k,i+1)-w1_temp(k,i))-
     &            aa(2)*(w1_temp(k,i+2)-w1_temp(k,i-1))-
     &            aa(3)*(w1_temp(k,i+3)-w1_temp(k,i-2))-
     &            aa(4)*(w1_temp(k,i+4)-w1_temp(k,i-3)))
      enddo
      enddo

        open(34,file="../data_demo/curl.hor",access='direct',
     &        form='unformatted',recl=nz*nx)
         write(34,rec=1) ((real(sw(i,j)), i=1,nz),j=1,nx)
        close(34)

        do ix=1,nx1
                do iz=1,nz1
                cu1_in(iz,ix)=cmplx(0,0)
                cw1_in(iz,ix)=cmplx(0,0)
                enddo
        enddo

        do ix=1,nx1
                if (ix .le. nx) then
                do iz=1,nz1
                if (iz.gt.rec_z. and. iz .le. nz) then
                cu1_in(iz-rec_z,ix+111)=cmplx(u1_temp(iz,ix),0)
                cw1_in(iz-rec_z,ix+111)=cmplx(w1_temp(iz,ix),0)
                endif
                enddo
                endif
        enddo
        do ix=1,nx1
                do iz=nz1/2+1,nz1
                cu1_in(iz,ix)=-cu1_in(nz1-iz+1,ix)
                cw1_in(iz,ix)=-cw1_in(nz1-iz+1,ix)
                enddo
        enddo

c        do ix=300,700
c                do iz=1,nz1
c                cu1_in(iz,ix)=0.0
c                cw1_in(iz,ix)=0.0
c                enddo
c        enddo



        open(34,file="../data_demo/snap_s2.hor",access='direct',
     &        form='unformatted',recl=nz1*nx1)
         write(34,rec=1) ((real(cu1_in(i,j)), i=1,nz1),j=1,nx1)
c         write(34,rec=1) ((real(u1_temp(i,j)), i=1,nz),j=1,nx)
        close(34)
        open(35,file="../data_demo/snap_s2.ver",access='direct',
     &        form='unformatted',recl=nz1*nx1)
         write(35,rec=1) ((real(cw1_in(i,j)), i=1,nz1),j=1,nx1)
c         write(35,rec=1) ((real(w1_temp(i,j)), i=1,nz),j=1,nx)
        close(35)


        call sfftw_init_threads(iret)
        call sfftw_plan_with_nthreads(12)
        call sfftw_plan_dft_2d
     &           (plan1,nz1,nx1,cu1_in,cu1,FFTW_FORWARD,FFTW_ESTIMATE)
        call sfftw_execute(plan1,cu1_in,cu1)
        call sfftw_destroy_plan(plan1)

        call sfftw_plan_dft_2d
     &           (plan2,nz1,nx1,cw1_in,cw1,FFTW_FORWARD,FFTW_ESTIMATE)
        call sfftw_execute(plan2,cw1_in,cw1)
        call sfftw_destroy_plan(plan2)
        
        open(36,file="../data_demo/snap_kd_bf_r.hor",access='direct',
     &        form='unformatted',recl=nz1*nx1)
         write(36,rec=1) ((real(cu1(i,j)), i=1,nz1),j=1,nx1)
        close(36)
        open(37,file="../data_demo/snap_kd_bf_i.hor",access='direct',
     &        form='unformatted',recl=nz1*nx1)
         write(37,rec=1) ((imag(cw1(i,j)), i=1,nz1),j=1,nx1)
        close(37)

        do ix=1,nx1
             do iz=1,nz1
            cu1_p(iz,ix)=(kx_2(iz,ix)**2*cu1(iz,ix)
     &            +kx_2(iz,ix)*kz_2(iz,ix)*cw1(iz,ix))
            cw1_p(iz,ix)=(kz_2(iz,ix)**2*cw1(iz,ix)
     &            +kx_2(iz,ix)*kz_2(iz,ix)*cu1(iz,ix))
            cu1_s(iz,ix)=(kz_2(iz,ix)**2*cu1(iz,ix)
     &            -kx_2(iz,ix)*kz_2(iz,ix)*cw1(iz,ix))
            cw1_s(iz,ix)=(kx_2(iz,ix)**2*cw1(iz,ix)
     &           -kx_2(iz,ix)*kz_2(iz,ix)*cu1(iz,ix))
             enddo
        enddo

        open(36,file="../data_demo/snap_kd_af_r.hor",access='direct',
     &        form='unformatted',recl=nz1*nx1)
         write(36,rec=1) ((real(cu1_s(i,j)), i=1,nz1),j=1,nx1)
        close(36)
        open(37,file="../data_demo/snap_kd_af_i.hor",access='direct',
     &        form='unformatted',recl=nz1*nx1)
         write(37,rec=1) ((imag(cw1_s(i,j)), i=1,nz1),j=1,nx1)
        close(37)

        call sfftw_plan_dft_2d
     &          (plan3,nz1,nx1,cu1_p,pwave1,FFTW_BACKWARD,FFTW_ESTIMATE)
        call sfftw_execute(plan3,cu1_p,pwave1)
        call sfftw_destroy_plan(plan3)

        call sfftw_plan_dft_2d
     &          (plan4,nz1,nx1,cw1_p,pwave2,FFTW_BACKWARD,FFTW_ESTIMATE)
        call sfftw_execute(plan4,cw1_p,pwave2)
        call sfftw_destroy_plan(plan4)

        call sfftw_plan_dft_2d
     &          (plan5,nz1,nx1,cu1_s,swave1,FFTW_BACKWARD,FFTW_ESTIMATE)
        call sfftw_execute(plan5,cu1_s,swave1)
        call sfftw_destroy_plan(plan5)

        call sfftw_plan_dft_2d
     &          (plan6,nz1,nx1,cw1_s,swave2,FFTW_BACKWARD,FFTW_ESTIMATE)
        call sfftw_execute(plan6,cw1_s,swave2)
        call sfftw_destroy_plan(plan6)

        open(36,file="../data_demo/snap_p1_r.hor",access='direct',
     &        form='unformatted',recl=nz1*nx1)
c         write(36,rec=1) ((real(swave1(i,j)), i=1,nz),j=112,nx+111)
         write(36,rec=1) ((real(pwave1(i,j)), i=1,nz1),j=1,nx1)
        close(36)
c        open(37,file="../data_demo/snap_s1.ver",access='direct',
c     &        form='unformatted',recl=nz1*nx1)
cc         write(37,rec=1) ((real(swave2(i,j)), i=1,nz),j=112,nx+111)
c         write(37,rec=1) ((real(swave2(i,j)), i=1,nz1),j=1,nx1)
c        close(37)

        open(36,file="../data_demo/snap_p1_i.hor",access='direct',
     &        form='unformatted',recl=nz1*nx1)
         write(36,rec=1) ((imag(pwave1(i,j)), i=1,nz1),j=1,nx1)
        close(36)

        end



