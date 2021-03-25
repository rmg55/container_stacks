FROM rowangaffney/data_science_im_rs

#Add Additional Image Labels
LABEL maintainer="Rowan Gaffney <rowan.gaffney@usda.gov>"
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/rmg55/container_stacks.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.description="Data science image built from the jupyter stacks minimal-notebook image. Includes JupyterLab with a server-proxy to RStudio server, VSCode server, and Panel. Includes kernels for Python, R, and possible IDL (if present in the host machine in specific folders). Software packages/modules are focused on spatial data analytics, remote sensing, and machine learning."

#Install Python and R packages in the py_geo and r_geo environmets, respectively.
COPY py_geo_gpu.yml .

RUN mamba env create -f py_geo_gpu.yml --quiet && \
	mamba clean --all -afy && \
	npm cache clean --force && \
        rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
        rm -rf /home/$NB_USER/.cache/yarn && \
        rm -rf /home/$NB_USER/.node-gyp && \
        fix-permissions /home/$NB_USER && \
        fix-permissions $CONDA_DIR