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
#COPY py_geo_gpu.yml .
#COPY spec-file.txt .

#RUN mamba env create -f py_geo_gpu.yml --quiet && \
#	mamba clean --all -afy && \
#	npm cache clean --force && \
#        rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
#        rm -rf /home/$NB_USER/.cache/yarn && \
#        rm -rf /home/$NB_USER/.node-gyp && \
#        fix-permissions /home/$NB_USER && \
#        fix-permissions $CONDA_DIR

#RUN conda create -n py_geo_gpu -y
#RUN mamba install --name py_geo_gpu --file spec-file.txt

RUN conda create -n py_geo_gpu -y
RUN mamba install -n py_geo_gpu -c conda-forge python=3.7.10=hffdb5ce_100_cpython && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c nvidia -c conda-forge cudatoolkit=11.0.221=h6bb024c_0 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge cudf=0.18.1=cuda_11.0_py37_g999be56c80_0 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge -c nvidia cuml=0.18.0=cuda11.0_py37_gb5f59e005_0 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge cugraph=0.18.0=py37_g65ec965f_0 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge cusignal=0.18.0=py38_g42899d2_0 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge cuspatial=0.18.0=py37_gf4da460_0 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge cuxfilter=0.18.0=py37_gac6f488_0 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c defaults tensorflow-gpu=1.14.0=h0d30ee6_0 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c conda-forge keras=2.3.1=py37_0 && \
	mamba clean --all -afy && \
	npm cache clean --force && \
            rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
            rm -rf /home/$NB_USER/.cache/yarn && \
            rm -rf /home/$NB_USER/.node-gyp && \
            fix-permissions /home/$NB_USER && \
            fix-permissions $CONDA_DIR