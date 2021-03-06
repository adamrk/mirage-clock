This library implements portable support for an operating system timesource
that is compatible with the [MirageOS](https://mirage.io) library interfaces
found in: <https://github.com/mirage/mirage>

It implements an `MCLOCK` module that represents a monotonic timesource
since an arbitrary point, and `PCLOCK` which counts time since the Unix
epoch.

The following sources are used:

* The Unix version uses `gettimeofday` or `clock_gettime`, depending on
  which OS is in use (see [clock_stubs.c](https://github.com/mirage/mirage-clock/blob/master/unix/clock_stubs.c)).
* The freestanding version uses the paravirtual clock source from the hypervisor.
