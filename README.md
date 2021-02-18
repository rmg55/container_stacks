 
 
 This repository contains a set of branches that build docker containers/images that are pushed to [Docker Hub](https://hub.docker.com/u/rowangaffney). More details about each container can be found within each branch, but a gneral descriptions are below:
 
 1. **data_science_im_rs**: JupyterLab with geospatial packages in three environments, py_geo (python), py_geo_gpu (python-gpu), and r_geo (R). It also includes proxies RStudio, VSCode (via code-server), and Panel.<br>
 ![](https://img.shields.io/docker/image-size/rowangaffney/data_science_im_rs/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/data_science_im_rs)
 ![](https://github.com/rmg55/container_stacks/workflows/ci/badge.svg?branch=data_science_im_rs)
 
 <br>

 2. **netlogo**: Coming soon<br>
 ![](https://img.shields.io/docker/image-size/rowangaffney/netlogo_im/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/netlogo_im)
 ![ci](https://github.com/rmg55/container_stacks/workflows/ci/badge.svg?branch=netlogo)

 <br>

 3. **hls_grazing_dash**: Coming soon<br>
 ![](https://img.shields.io/docker/image-size/rowangaffney/hls_grazing_dash/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/hls_grazing_dash)
 ![](https://github.com/rmg55/container_stacks/workflows/data_science_im:latest/badge.svg?branch=hls_grazing_dash)

 <br>

4. **master**: Depreciated. This is the old branch where all the containers were in the same branch.
 
<br>

Each active branch contains github actions (in `.github/workflows/`) which will build the image when changes are pushed to the branch (with the _latest suffix), or when a new tag is applied to a commit (with the _tagName suffix).
