program basic
  use mpi
  use iso_fortran_env, only : REAL64

  implicit none
  integer, parameter :: size = 10000000
  integer :: i, rc, myid, ntasks, dest, source, desttag, recvtag
  integer :: message(size)
  integer :: receiveBuffer(size)
  integer :: status(MPI_STATUS_SIZE)

  real(REAL64) :: t0, t1

  call mpi_init(rc)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, rc)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, rc)

  message = myid

  ! Start measuring the time spent in communication
  call mpi_barrier(mpi_comm_world, rc)
  t0 = mpi_wtime()


  if (myid .eq. ntasks-1) then
    dest = mpi_proc_null
    desttag = 0
  else
    dest = myid + 1
    desttag = myid +1
  end if

  if (myid .eq. 0) then
    source = mpi_proc_null
    recvtag = mpi_any_tag
  else
    source = myid - 1
    recvtag = myid
  end if

  write(*,'(A10,I3,A20,I8,A,I3,A,I3)') 'Sender: ', myid, &
        ' Sent elements: ',size, &
        '. Tag: ', desttag, '. Receiver: ', dest


  ! TODO: Send and receive as defined in the assignment
  call mpi_sendrecv(message, size, mpi_integer, dest, desttag, message, &
       size, mpi_integer, source, recvtag, mpi_comm_world, status, rc)

  write(*,'(A10,I3,A,I3,A,I)') 'Receiver: ', myid, &
        ' First element: ', receiveBuffer(1), ' Data received: ', status


  ! Finalize measuring the time and print it out
  t1 = mpi_wtime()
  call mpi_barrier(mpi_comm_world, rc)
  call flush(6)

  write(*, '(A20, I3, A, F6.3)') 'Time elapsed in rank', myid, ':', t1-t0

  call mpi_finalize(rc)

end program basic
