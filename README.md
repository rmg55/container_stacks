## Data science containers for geospatial analytics

### Container: data_science_im_rs

![](https://img.shields.io/docker/image-size/rowangaffney/data_science_im_rs/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/data_science_im_rs)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/data_science_im_rs_latest?label=build%3A%20data_science_im_rs%3Alatest)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/data_science_im_rs_tag?label=build%3A%20data_science_im_rs%3A%3Ctag%3E)

  - Includes two geospatial environments, Python (py_geo) and R (r_geo). Each contain a set of geospatial and parallel/distributed computing packages.
  - Includes proxies to **[RStudio](https://rstudio.com/products/rstudio/)**, **[VSCode](https://code.visualstudio.com/)**, and **[Panel](https://panel.holoviz.org/)** (will launch in seperate tabs).
  - Built from [Jupyter minimal-notebook](https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook) stack.
  - Docker Hub Link: [https://hub.docker.com/r/rowangaffney/data_science_im_rs](https://hub.docker.com/r/rowangaffney/data_science_im_rs)
  - Will include the IDL (with ENVI API) if correct folders are bind-mounted on container execution (not in example below) and the ENVI licensed in active / "checked-out".
  - To build with singularity:
    ```shell
    singularity pull docker://rowangaffney/data_science_im_rs:latest
    ```
    or
    ```shell
    singularity pull docker://rowangaffney/data_science_im_rs:<tag>
    ```
  To launch this container with singularity on the USDA ARS Ceres HPC and use Dask Distributed + [Dask Jobqueue](https://jobqueue.dask.org/en/latest/), you need to bind the following directories:
  ```shell
    --bind /etc/munge --bind /var/log/munge --bind /var/run/munge --bind /usr/bin/squeue --bind /usr/bin/scancel --bind /usr/bin/sbatch --bind /usr/bin/scontrol --bind /usr/bin/sinfo --bind /system/slurm:/etc/slurm --bind /run/munge --bind /usr/lib64/libslurm.so --bind /usr/lib64/libmunge.so.2 --bind /usr/lib64/slurm --bind /project --bind /lustre
  ```
  
