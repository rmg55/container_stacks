The docker files in this repository include:

## Remote Sensing

1. **data_science_im_rs_step1**
    - Initial container (recommend to install the data_science_im_rs container rather than this one).
    - Includes a conda environment (geo) that contains python geospatial packages
    - Built from the [Jupyter Scipy Stack](https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook)
    - [Docker Hub Link](https://hub.docker.com/r/rowangaffney/data_science_im_rs_step1)
    - To build with singularity:
    ```shell
    singularity pull docker://rowangaffney/data_science_im_rs_step1
    ```
2. **data_science_im_rs**
    - Includes the R environment (R_geo) that contains geospatial packages
    - Built with a proxy to RStudio (you can launch RStudio from the launcher tab)
    - Built from data_science_im_rs_step1
    - [Docker Hub Link](https://hub.docker.com/r/rowangaffney/data_science_im_rs)
    - To build with singularity:
    ```shell
    singularity pull docker://rowangaffney/data_science_im_rs
    
3. **data_science_im_rs_ucx**
    - EXPERIMENTAL - NOT CURRENTLY WORKING
    - Built from data_science_im_rs image but includes the ucx and ucx-py bindings
    - [Docker Hub Link](https://hub.docker.com/r/rowangaffney/data_science_im_rs)
    - To build with singularity:
    ```shell
    singularity pull docker://rowangaffney/data_science_im_rs_ucx

## Agent Based Modelling: Netlogo

1. **netlogo_im**
    - 
    - Built from the [openjdk:8-jdk Stack](https://github.com/docker-library/docs/blob/master/openjdk/README.md#supported-tags-and-respective-dockerfile-links)
    - [Docker Hub Link](https://hub.docker.com/repository/docker/rowangaffney/netlogo_im)
    - To build with singularity:
    ```shell
    singularity pull docker://rowangaffney/netlogo_im
    ```
