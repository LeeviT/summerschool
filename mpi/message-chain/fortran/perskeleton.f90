program basic
  use mpi
  use iso_fortran_env, only : REAL64

  implicit none
  integer, parameter :: size = 10000000
  integer :: rc, myid, ntasks, dest, src, count
  integer :: message(size)
  integer :: receiveBuffer(size)
  integer :: req(2)
  integer :: status(MPI_STATUS_SIZE,2)

  real(REAL64) :: t0, t1

  call mpi_init(rc)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, rc)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, rc)

  message = myid

  ! TODO: Send and receive as defined in the assignment
  if ( myid < ntasks-1 ) then
     dest = myid + 1
  else
     dest = MPI_PROC_NULL
  end if

  if ( myid > 0 ) then
     src = myid - 1
  else
     src = MPI_PROC_NULL
  end if

  ! Start measuring the time spent in communication
  call mpi_barrier(mpi_comm_world, rc)
  t0 = mpi_wtime()


  call mpi_irecv(receiveBuffer, size, mpi_integer, src, mpi_any_tag, mpi_comm_world, &
                 req(1), rc)
  call mpi_isend(message, size, mpi_integer, dest, myid+1, mpi_comm_world, &
                 req(2), rc)

  call mpi_waitall(2, req, status, rc)

  call mpi_get_count(status(:,1), mpi_integer, count, rc)
  write(*,'(A10,I3,A,I3)') 'Receiver: ', myid, ' First element: ', receiveBuffer(1)
  write(*,'(A10,I3,A20,I8,A,I3,A,I3)') 'Sender: ', myid, ' Sent elements: ' ,size, &
        '. Tag: ', myid+1, '. Receiver: ', myid+1
  ! Finalize measuring the time and print it out
  t1 = mpi_wtime()
  call mpi_barrier(mpi_comm_world, rc)
  call flush(6)

  write(*, '(A20, I3, A, F6.3)') 'Time elapsed in rank', myid, ':', t1-t0

  call mpi_finalize(rc)

end program basic