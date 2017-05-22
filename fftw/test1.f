        program main
        implicit none 
        include "fftw3.f"
c        include "f77funcs.h"
        integer n,i,j,iret
        complex w(100,100)
c        real w(100)
c       real w1(100)
        integer*8 plan1,plan2

        n=100
        do i=1,n
        do j=1,n
                w(i,j)=cmplx(i,j)
c                w(i)=cmplx(i,j)
c                print*,w(i,j)
c                w(i,j)=i+j
        enddo
        enddo
        call sfftw_init_threads(iret)
        print*,iret
        call sfftw_plan_with_nthreads(8)
        call sfftw_plan_dft_2d(plan1,n,n,w,w,FFTW_FORWARD,FFTW_ESTIMATE)
        call sfftw_execute(plan1,w,w)
c        do i=1,n
c        print*,w(i,1)/100/100,i
c        enddo
       call sfftw_plan_dft_2d(plan2,n,n,w,w,FFTW_BACKWARD,FFTW_ESTIMATE)
        call sfftw_execute(plan2,w,w)
        call sfftw_destroy_plan(plan1)
        call sfftw_destroy_plan(plan2)

c        print*, iret
        do i=1,n
        print*,w(i,1)/100/100
        enddo
        end
        
        
