FROM rowangaffney/data_science_im_rs

USER $NB_UID
#Install Python and R packages in the py_geo and r_geo environmets, respectively.
COPY py_geo_gpu.yml .
COPY r_geo.yml .

RUN mamba env create -f py_geo_gpu.yml --quiet && \
	mamba clean --all -afy && \
	npm cache clean --force && \
        rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
        rm -rf /home/$NB_USER/.cache/yarn && \
        rm -rf /home/$NB_USER/.node-gyp && \
        fix-permissions /home/$NB_USER && \
        fix-permissions $CONDA_DIR