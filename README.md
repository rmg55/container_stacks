## Data science containers for geospatial analytics

**Abstract:** To facilitate reproducible research, a set of containerized computational environments are defined in this repository. Within each branch, are the scripts and definition files for building the pushing Docker images to [DockerHub]((https://hub.docker.com/u/rowangaffney)). When a branch is modified, a Github Action workflow is triggered to rebuild the image with the *:latest* tag, and is pushed to DockerHub (https://hub.docker.com/u/rowangaffney). When a new release in the Github repository is created, the Github Action workflow is triggered and a new image with the *:v<release_tagname>* tag is built and pushed to DockerHub.

---

**Release/Zenodo Nomenclature:** To document the release timeline for each branch we use the following nomenclature (starting in April of 2021).

\<branch abbr.>\_\<YYYY>\.\<MM>\.\<X>

branch abbr. = abbreviation of the branch targeted on the release<br>
YYYY = year<br>
MM = zero padded month<br>
X = version (starting with 1)<br>

Examples:<br>
*Branch*: data_science_im_rs; *Date*: May of 2020; *Version*: 0 = dsir_2020.04.1<br>
*Branch*: data_science_im_rs_gpu; *Date*: August of 2020; *Version*: 3 = dsirg_2020.08.3

---

**Details**: Additional information about each branch/container can be found within each branch, but a general description is below:
 
 1. **data_science_im_rs**: JupyterLab with geospatial packages in three environments, py_geo (python), py_geo_gpu (python-gpu), and r_geo (R). It also includes proxies RStudio, VSCode (via code-server), and Panel.<br>
 ![](https://img.shields.io/docker/image-size/rowangaffney/data_science_im_rs/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/data_science_im_rs)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/data_science_im_rs_latest?label=build%3A%20data_science_im_rs%3Alatest)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/data_science_im_rs_tag?label=build%3A%20data_science_im_rs%3Av%3Ctag%3E)
 <br>

 2. **data_science_im_rs_gpu**: Built from data_science_im_rs (see above), but also includes a py_gpu environment.<br>
 ![](https://img.shields.io/docker/image-size/rowangaffney/data_science_im_rs_gpu/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/data_science_im_rs_gpu)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/data_science_im_rs_gpu_latest?label=build%3A%20data_science_im_rs_gpu%3Alatest)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/data_science_im_rs_gpu_tag?label=build%3A%20data_science_im_rs_gpu%3Av%3Ctag%3E)
 <br>

 3. **netlogo_im**: In Progress/Coming soon<br>
 ![](https://img.shields.io/docker/image-size/rowangaffney/netlogo_im/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/netlogo_im)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/netlogo_im_latest?label=build%3A%20netlogo_im%3Alatest)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/netlogo_im_tag?label=build%3A%20netlogo_im%3A%3Ctag%3E)
 <br>

 4. **hls_grazing_dash**: Coming soon<br>
 ![](https://img.shields.io/docker/image-size/rowangaffney/hls_grazing_dash/latest)
 ![](https://img.shields.io/docker/pulls/rowangaffney/hls_grazing_dash)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/netlogo_im_latest?label=build%3A%20hls_grazing_dash%3Alatest)<br>
 ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rmg55/container_stacks/netlogo_im_tag?label=build%3A%20hls_grazing_dash%3A%3Ctag%3E)
 <br>

5. **master (Depreciated)**:This is the original branch where all the containers were located before they were split by branch. This will be kept around for an indefinite time.

Each active branch contains Github Actions (in `.github/workflows/`). The workflows will build the image when changes are pushed to the branch (with the *_latest* suffix), or when a new release is created (with the *_v\<tagName>* suffix).

---
**Github Release to Zenodo DOI to DockerHub Image Mapping** 

  | Branch | Github Release | Zenodo DOI | DockerHub Image |
  |--------|----------------|------------|-----------------|
  |data_science_im_rs| [![](https://img.shields.io/badge/release-dsir__2020.04.1-brightgreen)](https://github.com/rmg55/container_stacks/tree/dsir_2021.04.1)| [![](http://img.shields.io/badge/DOI-10.5281%20%2F%20zenodo.4718592-blue.svg)](https://doi.org/10.5281/zenodo.4718592) | [![](https://img.shields.io/docker/image-size/rowangaffney/data_science_im_rs/vdsir_2021.04.1)](https://hub.docker.com/layers/rowangaffney/data_science_im_rs/vdsir_2021.04.1/images/sha256-5c6ce2c79771dde19a0c7af242eb530ae2ccce83f7efceb2ab2a68cc5f7ea08f?context=explore)|
