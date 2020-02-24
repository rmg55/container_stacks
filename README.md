 This repository contains dockerfiles that are built on docker hub at: The are designed to run on the USDA ARS Ceres HPC system. Ceres uses Slurm for resource allocation. A brief overview of each image is below:

## Remote Sensing

1. **data_science_im_rs**
    - Includes two geospatial environments, Python (geo) and R (R_geo). Each contain a set of geospatial packages and parallel/distributed computing packages
    - Includes a conda environment (geo) that contains python geospatial packages
    - Will include the IDL (with ENVI API) if correct folders are bind-mounted on container execution (not in example below) and the ENVI licensed in active / "checked-out".
    - Built with a proxy to RStudio (you can launch RStudio from the launcher tab). The Shiny proxy/extension is not functional.
    - Built from [Jupyter Scipy Stack](https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook)
    - [Docker Hub Link](https://hub.docker.com/r/rowangaffney/data_science_im_rs)
    - To build with singularity:
    ```shell
    singularity pull docker://rowangaffney/data_science_im_rs:latest
    ```
    or
    ```shell
    singularity pull docker://rowangaffney/data_science_im_rs:vX.X.X
    ```
  <img src="/readme_images/data_science_im_rs_screenshot.png" width="600">
  
  To launch this container (and allow [Dask](https://distributed.dask.org/en/latest/) via [Dask-Jobque](https://jobqueue.dask.org/en/latest/)) to interface with the Slurm. Note this assumes that *o_port* and *serv_fold* environmental variables are defined.
  ```bash
  singularity exec --bind /etc/munge \
                   --bind /var/log/munge \
                   --bind /var/run/munge \
                   --bind /usr/bin/squeue \
                   --bind /usr/bin/scancel \
                   --bind /usr/bin/sbatch \
                   --bind /usr/bin/scontrol \
                   --bind /scinet01/gov/usda/ars/scinet/system/slurm:/etc/slurm \
                   --bind /run/munge \
                   --bind /usr/lib64 \
                   --bind /scinet01 \
                   --bind $HOME \
                   -H $HOME:/home/jovyan \
                   ~/data_science_im_rs_latest.sif /bin/bash -c 'unset XDG_RUNTIME_DIR && \
                                                                 start.sh jupyter lab --notebook-dir=$serv_fold \
                                                                                      --no-browser --ip=$(hostname -i) \
                                                                                      --port=$o_port'
```    
2. **data_science_im_rs_ucx**
    - EXPERIMENTAL - NOT CURRENTLY WORKING
    - Built from data_science_im_rs image but includes the ucx and ucx-py bindings
    - [Docker Hub Link](https://hub.docker.com/r/rowangaffney/data_science_im_rs)
    - To build with singularity:
    ```shell
    singularity pull docker://rowangaffney/data_science_im_rs_ucx

## Agent Based Modeling: Netlogo

1. **netlogo_im**
    - Includes the [Netlogo Agent Based Model](https://ccl.northwestern.edu/netlogo/)
    - Built from the [openjdk:8-jdk Stack](https://github.com/docker-library/docs/blob/master/openjdk/README.md#supported-tags-and-respective-dockerfile-links)
    - [Docker Hub Link](https://hub.docker.com/repository/docker/rowangaffney/netlogo_im)
    - To build with singularity:
    ```shell
    singularity pull docker://rowangaffney/netlogo_im
    ```
