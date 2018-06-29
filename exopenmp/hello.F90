program hello
  use omp_lib
  implicit none
  integer :: rank, nthreads

  print *, 'Hello world!'
  !$omp parallel private(rank) shared(nthreads)
  nthreads = omp_get_num_threads()
  rank = omp_get_thread_num()
  write (*,*) "Hello world from thread ", rank, "out of ", nthreads
  !$omp end parallel

end program hello
