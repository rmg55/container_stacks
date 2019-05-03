# Containers for: Remote Sensing and Spatial RDMS

The docker files in this repo include:

1. data_science_im_rs_step1 <br>
    - Most of the python libraries
    - Built from the [Jupyter Scipy Stack](https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook))
2. data_science_im_rs
    - Includes the R environment
    - Built from data_science_im_rs_step1)
3. data_science_im_db
    - Includes Postgresql and PostGIS install and setup
    - Built from data_science_im_rs)
