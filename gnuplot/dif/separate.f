      integer nx,nz
      integer isnap
      real h(256,256,5),v(256,256,5)
      character*128 filename
      character*4 isnap_char 
      nx=256
      nz=256
ccccccccccccccc Snap cccccccccccccccccccccc
      open(8,file='snap.hor',access='direct',recl=4*nx*nz)
      open(9,file='snap.ver',access='direct',recl=4*nx*nz)
      do isnap=1,5
        read(8,rec=isnap) ((h(i,j,isnap),i=1,nz), j=1,nx)
        read(9,rec=isnap) ((v(i,j,isnap),i=1,nz), j=1,nx)
      enddo

      do isnap=1,5
        call ficnum(isnap,isnap_char)
        filename="snap_v_"//isnap_char
        open(isnap,file=filename,access='direct',recl=4*nx*nz)
        write(isnap,rec=1) ((h(i,j,isnap),i=1,nz), j=1,nx)
      enddo

      do isnap=1,5
        call ficnum(isnap,isnap_char)
        filename="snap_h_"//isnap_char
        open(isnap+10,file=filename,access='direct',recl=4*nx*nz)
        write(isnap+10,rec=1) ((v(i,j,isnap),i=1,nz), j=1,nx)
      enddo
        
        return
        end
