# Remote Sensing Images

The docker files in this repository include:

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
