## Data science containers for geospatial analytics

**Abstract:** To facilitate reproducible research, a set of containerized computational environments are defined in this repository. Within each branch, are the scripts and definition files for building the pushing Docker images to [DockerHub]((https://hub.docker.com/u/rowangaffney)). When a branch is modified, a Github Action workflow is triggered to rebuild the image with the *:latest* tag, and is pushed to DockerHub (https://hub.docker.com/u/rowangaffney). When a new release in the Github repository is created, the Github Action workflow is triggered and a new image with the *:v<release_tagname>* tag is built and pushed to DockerHub.

---

**Details**: Additional information about each branch/container can be found within each branch, but a general description is below:
 
 1. **data_science_im_rs**: JupyterLab with geospatial packages in three environments, py_geo (python), py_geo_gpu (python-gpu), and r_geo (R). It also includes proxies RStudio, VSCode (via code-server), and Panel.<br>
 ![](https://img.shields.io/docker/image-size/rowangaffney/data_science_im_rs/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/data_science_im_rs)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/data_science_im_rs_latest?label=build%3A%20data_science_im_rs%3Alatest)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/data_science_im_rs_tag?label=build%3A%20data_science_im_rs%3Av%3Ctag%3E)
 <br>

 2. **netlogo_im**: In Progress/Coming soon<br>
 ![](https://img.shields.io/docker/image-size/rowangaffney/netlogo_im/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/netlogo_im)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/netlogo_im_latest?label=build%3A%20netlogo_im%3Alatest)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/netlogo_im_tag?label=build%3A%20netlogo_im%3A%3Ctag%3E)
 <br>

 3. **hls_grazing_dash**: Coming soon<br>
 ![](https://img.shields.io/docker/image-size/rowangaffney/hls_grazing_dash/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/hls_grazing_dash)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/netlogo_im_latest?label=build%3A%20hls_grazing_dash%3Alatest)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/netlogo_im_tag?label=build%3A%20hls_grazing_dash%3A%3Ctag%3E)
 <br>

4. **master (Depreciated)**:This is the original branch where all the containers were located before they were split by branch. This will be kept around for an indefinite time.

Each active branch contains Github Actions (in `.github/workflows/`). The workflows will build the image when changes are pushed to the branch (with the *_latest* suffix), or when a new release is created (with the *_v\<tagName>* suffix).
