 This repository contains a set of branches that will build docker containers/images that are built on [Docker Hub](https://hub.docker.com/u/rowangaffney). More details can be found in each branch, but a gneral description of each are below:
 
 1. data_science_im_rs: JupyterLab with geospatial packages in three environments, py_geo (python), py_geo_gpu (python-gpu), and r_geo (R). It also includes proxies RStudio, VSCode (via code-server), and Panel.

 2. netlogo: Coming soon

 3. hls_grazing_dash: Coming soon
 
Each branch contains github actions (in `.github/workflows/`), which will build the containers when changes are pushed to the branches (with the _latest suffix), or a new tag is applied to a commit (with the suffix of _tagName).
