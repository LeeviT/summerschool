program vectorsum
  use omp_lib
  use iso_fortran_env, only: int64
  implicit none
  integer, parameter :: ik = int64
  integer(kind=ik), parameter :: nx = 102400_ik

  integer(kind=ik), dimension(nx) :: vecA
  integer(kind=ik) :: sum, psum, sumex
  integer(kind=ik) :: i

  ! Initialization of vector
  do i = 1, nx
     vecA(i) = i
  end do

  sumex = nx*(nx+1_ik)/2_ik
  write(*,*) 'Arithmetic sum formula (exact):                  ', sumex

  sum = 0
  ! TODO: Parallelize the computation
  !$omp parallel do shared(vecA) private(i) reduction(+:sum)
  do i = 1, nx
     sum = sum + vecA(i)
  end do
  !$omp end parallel do
  write(*,*) 'reduction clause sum: ', sum

  sum = 0
  psum = 0
  ! TODO: Parallelize the computation
  !$omp parallel shared(vecA, sum) private(i, psum)
  psum = 0.d0
  !$omp do
  do i = 1, nx
     psum = psum + vecA(i)
  end do
  !$omp end do
  !$omp critical(dosum)
  sum = sum + psum
  !$omp end critical(dosum)
  !$omp end parallel
  write(*,*) 'critical clause sum: ', sum

end program vectorsum
