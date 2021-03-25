FROM rowangaffney/data_science_im_rs

#Add Additional Image Labels
LABEL maintainer="Rowan Gaffney <rowan.gaffney@usda.gov>"
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/rmg55/container_stacks.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.description="Data science image built from the rowangaffney/data_science_im_rs. This image adds an additional env (py_geo_gpu) that includes the python, ipykernal, Rapids.ai packages, tensorflow, and keras"

#Install Python and R packages in the py_geo and r_geo environmets, respectively.
COPY py_geo_gpu.yml .

#RUN mamba env create -f py_geo_gpu.yml --quiet && \
#	mamba clean --all -afy && \
#	npm cache clean --force && \
#        rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
#        rm -rf /home/$NB_USER/.cache/yarn && \
#        rm -rf /home/$NB_USER/.node-gyp && \
#        fix-permissions /home/$NB_USER && \
#        fix-permissions $CONDA_DIR

RUN conda create -n py_geo_gpu -y
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults python=3.7 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults cudatoolkit=10.1 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults cudf=0.18 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults cuml=0.18 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults cugraph=0.18 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults cusignal=0.18 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults cuspatial=0.18 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults cuxfilter=0.18 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults tensorflow-gpu && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults keras && \
	mamba clean --all -afy && \
	npm cache clean --force && \
            rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
            rm -rf /home/$NB_USER/.cache/yarn && \
            rm -rf /home/$NB_USER/.node-gyp && \
            fix-permissions /home/$NB_USER && \
            fix-permissions $CONDA_DIR