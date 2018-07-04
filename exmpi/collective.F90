program coll_exer
  use mpi
  implicit none

  integer, parameter :: n_mpi_tasks = 4

  integer :: ntasks, rank, ierr, i, color, sub_comm, subrank
  integer, dimension(2*n_mpi_tasks) :: sendbuf, recvbuf
  integer, dimension(2*n_mpi_tasks**2) :: printbuf
  integer, dimension(4) :: sendcount

  call mpi_init(ierr)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, ierr)
  call mpi_comm_rank(MPI_COMM_WORLD, rank, ierr)

  sendcount = [1, 1, 2, 4]

  if (ntasks /= n_mpi_tasks) then
     if (rank == 0) then
        print *, "Run this program with ", n_mpi_tasks, " tasks."
     end if
     call mpi_abort(MPI_COMM_WORLD, -1, ierr)
  end if

  ! Form MPI subgroups
  if (rank < 2) then
     color = 1
  else
     color = 2
  end if

  call mpi_comm_split(MPI_COMM_WORLD, color, rank, sub_comm, ierr)
  call mpi_comm_rank(sub_comm, subrank, ierr)

  ! Initialize message buffers
  call init_buffers

  ! Print data that will be sent
  call print_buffers(sendbuf)

  ! TODO: use a single collective communication call (and maybe prepare
  !       some parameters for the call)
  ! call mpi_bcast(sendbuf, size(sendbuf), MPI_INTEGER, 0, MPI_COMM_WORLD, ierr) 
  ! call mpi_scatter(sendbuf, 2, MPI_INTEGER, recvbuf, 2, MPI_INTEGER, 0, &
  !                 MPI_COMM_WORLD, ierr)
  !call mpi_gatherv(sendbuf, sendcount(rank+1), MPI_INTEGER, recvbuf, [1,1,2,4], &
  !                 [0,1,2,4], MPI_INTEGER, 1, MPI_COMM_WORLD, ierr)
  !call mpi_alltoall(sendbuf, 2, MPI_INTEGER, recvbuf, 2, MPI_INTEGER, &
  !                  MPI_COMM_WORLD, ierr)
  call mpi_reduce(sendbuf, recvbuf, 8, MPI_INTEGER, MPI_SUM, 0, sub_comm, ierr)
  ! Print data that was received
  ! TODO: add correct buffer
  call print_buffers(recvbuf)

  call mpi_finalize(ierr)

contains

  subroutine init_buffers
    implicit none
    integer :: i

    do i = 1, 2*n_mpi_tasks
       recvbuf(i) = -1
       sendbuf(i) = i + 2*n_mpi_tasks * rank - 1
    end do
  end subroutine init_buffers


  subroutine print_buffers(buffer)
    implicit none
    integer, dimension(:), intent(in) :: buffer
    integer, parameter :: bufsize = 2*n_mpi_tasks
    integer :: i
    character(len=40) :: pformat

    write(pformat,'(A,I3,A)') '(A4,I2,":",', bufsize, 'I3)'

    call mpi_gather(buffer, bufsize, MPI_INTEGER, &
         & printbuf, bufsize, MPI_INTEGER, &
         & 0, MPI_COMM_WORLD, ierr)

    if (rank == 0) then
       do i = 1, ntasks
          write(*,pformat) 'Task', i - 1, printbuf((i-1)*bufsize+1:i*bufsize)
       end do
       print *
    end if
  end subroutine print_buffers

end program coll_exer
