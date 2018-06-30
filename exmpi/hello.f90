program helloworld
  use mpi
  implicit none
  integer :: rc, rank, nprocs, comm

  call mpi_init(rc)
  call mpi_comm_rank(mpi_comm_world, rank, rc)
  call mpi_comm_size(mpi_comm_world, nprocs, rc)

  comm = mpi_comm_world
  
  if (rank .eq. 0) then 
    write (*,*) "Hello world from process ", rank, ", total of ", nprocs, " procs running"
  end if

  if (rank .ne. 0) then
    write (*,*) "Hello world from process ", rank
  end if

  call mpi_finalize(rc)

end program helloworld
