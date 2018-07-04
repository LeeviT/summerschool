program pario
  use mpi
  use, intrinsic :: iso_fortran_env, only : error_unit, output_unit
  implicit none

  integer, parameter :: datasize = 64, writer_id = 0
  integer :: rc, my_id, ntasks, localsize, i
  integer, dimension(:), allocatable :: localvector
  integer, dimension(datasize) :: fullvector

  call mpi_init(rc)
  call mpi_comm_size(mpi_comm_world, ntasks, rc)
  call mpi_comm_rank(mpi_comm_world, my_id, rc)

  if (ntasks > 64) then
     write(error_unit, *) 'Maximum number of tasks is 64!'
     call mpi_abort(MPI_COMM_WORLD, -1, rc)
  end if

  if (mod(datasize, ntasks) /= 0) then
     write(error_unit,*) 'Datasize (64) should be divisible by number of tasks'
     call mpi_abort(MPI_COMM_WORLD, -1, rc)
  end if

  localsize = datasize / ntasks
  allocate(localvector(localsize))

  localvector = [(i + my_id * localsize, i=1,localsize)]

  call single_writer(localsize, datasize, rc, fullvector, localvector)

  deallocate(localvector)
  call mpi_finalize(rc)

contains

  subroutine single_writer(localsize, datasize, rc, fullvector, localvector)
    use mpi
    implicit none
    integer :: localsize, datasize, rc
    integer, dimension(datasize) :: fullvector
    integer, dimension(localsize) :: localvector
    integer :: rank, file, dsize
    integer(kind=mpi_offset_kind) :: offset

    call mpi_type_size(mpi_integer, dsize, rc)
    call mpi_comm_rank(mpi_comm_world, rank, rc)

    offset = rank*localsize*dsize    

    call mpi_file_open(mpi_comm_world, "spokesmpi.dat", mpi_mode_create+ &
                       mpi_mode_wronly, mpi_info_null, file, rc)
    call mpi_file_write_at_all(file, offset, localvector, localsize, mpi_integer, &
                            mpi_status_ignore, rc)
    ! TODO: Implement a function that writers the whole array of elements
    !       to a file so that single process is responsible for the file io
    ! call mpi_gather(localvector, localsize, mpi_integer, fullvector, datasize, &
    !                mpi_integer, 0, mpi_comm_world, rc)
    ! if (rank .eq. 0) then
    !    open(12, file="spokesio.dat")
    !    write(12, *) fullvector
    !    close(12)
    ! end if
    call mpi_file_close(file, rc)

  end subroutine single_writer

end program pario
