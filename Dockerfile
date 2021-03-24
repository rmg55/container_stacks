FROM rowangaffney/data_science_im_rs

USER $NB_UID
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
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults python=3.8 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults cudatoolkit=11.0 && \
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
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults tensorflow-gpu>=2 && \
	mamba clean --all -afy
RUN mamba install -n py_geo_gpu -c rapidsai -c nvidia -c conda-forge -c defaults keras>=2.4.0 && \
	mamba clean --all -afy