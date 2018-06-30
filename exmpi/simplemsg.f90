program simplemsg
  use mpi
  implicit none
  integer, parameter :: tag = 50
  integer :: rc, rank, nprocs, n
  integer, dimension(:), allocatable :: msg

  n = 100000
  allocate(msg(n))

  call mpi_init(rc)
  call mpi_comm_rank(mpi_comm_world, rank, rc)
  call mpi_comm_size(mpi_comm_world, nprocs, rc)

  msg = rank  
  
  if (rank .eq. 0) then
    call mpi_send(msg, n, mpi_integer, 1, tag, mpi_comm_world, rc) 
  end if

  if (rank .eq. 1) then
    call mpi_recv(msg, n, mpi_integer, 0, tag, mpi_comm_world, rc) 
    write (*,*) msg
  end if

  call mpi_finalize(rc)

end program simplemsg
