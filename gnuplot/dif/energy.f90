      integer nx,nz
      integer isnap
      integer nsnap
      real h2(256,256,100),v2(256,256,100)
      real h1(256,256,100),v1(256,256,100)
      real resi(5)
      character*128 filename
      character*4 isnap_char 
      nx=256
      nz=256
      nsnap=100
!cccccccccccccc Snap cccccccccccccccccccccc
      open(8,file='snap1.hor',access='direct',recl=4*nx*nz)
      open(9,file='snap1.ver',access='direct',recl=4*nx*nz)
      open(10,file='snap2.hor',access='direct',recl=4*nx*nz)
      open(11,file='snap2.ver',access='direct',recl=4*nx*nz)
      do isnap=1,nsnap
        read(8,rec=isnap) ((h1(i,j,isnap),i=1,nz), j=1,nx)
        read(9,rec=isnap) ((v1(i,j,isnap),i=1,nz), j=1,nx)
        read(10,rec=isnap) ((h2(i,j,isnap),i=1,nz), j=1,nx)
        read(11,rec=isnap) ((v2(i,j,isnap),i=1,nz), j=1,nx)
      enddo

      do isnap=1,nsnap
        resi(isnap)=0.0
        do i=1,nz
                do j=1,nx
                resi(isnap)=resi(isnap)+(h1(i,j,isnap)-h2(i,j,isnap))**2 &
                                      +(v1(i,j,isnap)-v2(i,j,isnap))**2
                enddo
        enddo
        print*, resi(isnap)
      enddo
      open(12,file='snap_resi.bin')
        do i=1,nsnap
                write(12,*) (resi(i))
        enddo

        return
        end
