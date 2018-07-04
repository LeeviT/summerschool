program hello
   use mpi
   use omp_lib
   implicit none

   integer :: rank, thread, ierr

   call mpi_init(ierr)
   call mpi_comm_rank(mpi_comm_world, rank, ierr)

  !$omp parallel private(thread)
  thread = omp_get_thread_num()
  write (*,*) "hello from proc", rank, " thread", thread
  !$omp end parallel

  call mpi_finalize(ierr)

end program hello
