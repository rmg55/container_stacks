## data_science_im_rs&nbsp;&nbsp;&nbsp;&nbsp;

![](https://img.shields.io/docker/image-size/rowangaffney/data_science_im_rs/latest)
![](https://img.shields.io/docker/pulls/rowangaffney/data_science_im_rs)

  - Includes three geospatial environments, Python (py_geo and py_geo_gpu) and R (r_geo). Each contain a set of geospatial packages and parallel/distributed computing packages
  - Will include the IDL (with ENVI API) if correct folders are bind-mounted on container execution (not in example below) and the ENVI licensed in active / "checked-out".
  - Built with a proxy to **[RStudio](https://rstudio.com/products/rstudio/)**, **[VSCode](https://code.visualstudio.com/)**, and **[Panel](https://panel.holoviz.org/)** (will launch in seperate tabs).
  - Built from [Jupyter Minimal-notebook Stack](https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook)
  - [Docker Hub Link](https://hub.docker.com/r/rowangaffney/data_science_im_rs)
  - To build locally with singularity:
    ```shell
    singularity pull docker://rowangaffney/data_science_im_rs:latest
    ```
    or
    ```shell
    singularity pull docker://rowangaffney/data_science_im_rs:vX.X.X
    ```
  <img src="/readme_images/data_science_im_rs.png" width="600">
  
  To launch this container with singularity on the USDA ARS Ceres HPC and use Dask Distributed + [Dask Jobqueue](https://jobqueue.dask.org/en/latest/), you need to bind the following directories:
  ```shell
  --bind /etc/munge --bind /var/log/munge --bind /var/run/munge --bind /usr/bin/squeue --bind /usr/bin/scancel --bind /usr/bin/sbatch --bind /usr/bin/scontrol --bind /usr/bin/sinfo --bind /system/slurm:/etc/slurm --bind /run/munge --bind /usr/lib64/libslurm.so --bind /usr/lib64/libmunge.so.2 --bind /usr/lib64/slurm --bind /project --bind /lustre

  ```
  
