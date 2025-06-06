# JOS Dev Environment Template

This repository template contains a Dockerfile for developing the JOS educational operating system. The host needs to provide a volume or bind mount with the JOS source code, mounted at the `/src` mount point inside the container.

You can use it with a Docker Desktop installation, or even with the [Podman Container Template](https://github.com/bytes-that-rhyme/project-template-linux-build-container) to provide a fully-automated setup experience.

## What Does the Dockerfile Do?

The Dockerfile prepares build tools from a modern Ubuntu release, to work with the JOS code. MIT doesn't appear to support JOS anymore, since the last commit to their official repository at `https://pdos.csail.mit.edu/6.828/2018/jos.git` was on Sept 4, 2018. Therefore, their code relies on a lot of out-of-date software, including Python 2.7 and an old version of QEmu. To support this outdated software on a modern Ubuntu release, the `Dockerfile` will:

  - download, build, install, and test the last release of Python 2.7 (2.7.18), as that version is no longer supported by the Python Software Foundation as of 2020.
  - download and build a modified version of QEmu from `https://github.com/mit-pdos/6.828-qemu.git`, with a small patch file `qemu.patch` applied to make it compile on recent Ubuntu systems.
  - run GDB with support for `.gdbinit` file security.
  - download some extra Ubuntu packages like `mtools` and `dosfstools`, which were probably part of other packages back when the JOS directions were written.
  - delete package and build files to shrink the size of the final container.

## System Requirements

  - Docker (or compatible software like Podman)
  - At least 2 GB of space. The container image is about 1.22 GB in size, but you'll need extra space for your source code and built operating system files.

## License

Creative Commons Zero v1.0 license (which is basically public domain, no copyright). For full license text, see LICENSE file.

Note that this project may link to or download other projects that are subject to different copyright terms.

## Future Work

It's unlikely that this project will continue to receive maintenance, as JOS isn't maintained either. However, here's some future work:

  - Use a smaller base image. Ubuntu was chosen for convenience and to match the JOS setup directions.

## References

  - [JOS setup guide](https://deepwiki.com/woai3c/MIT6.828/1.1-installation-and-setup). Accessed 2025-06-06. This document appears to be an AI-generated English translation of [this Chinese installation guide](https://github.com/woai3c/MIT6.828/blob/4a51f62b/docs/install.md), updated 2020-02-20 and accessed 2025-06-06.
  - [Dockerfile from a student's solution code](https://github.com/phlalx/jos/blob/master/Dockerfile). Published 2018-08-01. Accessed 2025-06-06. This `Dockerfile` uses Ubuntu 14, which reached its end-of-life on [April 30, 2024](https://canonical.com/blog/ubuntu-14-04-and-16-04-lifecycle-extended-to-ten-years). Therefore, my `Dockerfile` is substantially different.
  - Francisco Jiménez Cabrera. [We reduced our Docker images by 60% with –no-install-recommends](https://ubuntu.com/blog/we-reduced-our-docker-images-by-60-with-no-install-recommends). Published 2019-11-15. Accessed 2025-06-06. I used this resource to shrink the size of the container image.
  - [How do I deal with certificates using curl when trying to access an HTTPS url?](https://stackoverflow.com/a/13400988). Stack Overflow. Answer published 2017-02-14. Accessed 2025-06-06. I used this resource to 

