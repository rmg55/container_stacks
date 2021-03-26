FROM jupyter/minimal-notebook

#Add Additional Image Labels
LABEL maintainer="Rowan Gaffney <rowan.gaffney@usda.gov>"
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/rmg55/container_stacks.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.description="Data science image built from the rowangaffney/data_science_im_rs. This image adds an additional env (py_geo_gpu) that includes the python, ipykernal, Rapids.ai packages, tensorflow, and keras"

SHELL ["/bin/bash", "-c"]

#Install Python GPU environmet
COPY py_geo_gpu.yml .
#COPY spec-file.txt .
RUN conda config --set channel_priority strict && \
	conda install -c conda-forge --yes --quiet \
		'mamba>=0.7.6' \
		'jupyterlab<3.0' \
		'bokeh>=2.1.1' \
		'tornado' \
		'jupyter_client' \
		'jupyter-archive' \
		'widgetsnbextension' \
		'dask-labextension' \
		'jupyter-panel-proxy' \
		'jupyter-server-proxy' \
		'jupyter-vscode-proxy' \
		'jupyter-rsession-proxy' \
		'nb_conda_kernels' && \
	jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
	jupyter labextension install @jupyterlab/server-proxy --no-build && \
        jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
	jupyter labextension install dask-labextension --no-build && \
	jupyter labextension install @pyviz/jupyterlab_pyviz --no-build && \
	jupyter lab build && \
        jupyter labextension update --all && \
	conda clean --all -afy && \
	mamba clean --all -afy && \
	npm cache clean --force && \
        rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
        rm -rf /home/$NB_USER/.cache/yarn && \
        rm -rf /home/$NB_USER/.node-gyp && \
        fix-permissions /home/$NB_USER && \
        fix-permissions $CONDA_DIR

RUN mamba env create -f py_geo_gpu.yml --quiet && \
	mamba clean --all -afy && \
	npm cache clean --force && \
        rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
        rm -rf /home/$NB_USER/.cache/yarn && \
        rm -rf /home/$NB_USER/.node-gyp && \
        fix-permissions /home/$NB_USER && \
        fix-permissions $CONDA_DIR

#RUN conda create -n py_geo_gpu -y
#RUN mamba install --name py_geo_gpu --file spec-file.txt
#RUN conda create -n py_geo_gpu -y
#RUN conda install -n py_geo_gpu -c rapidsai -c conda-forge -c nvidia -c defaults keras && \
#	mamba clean --all -afy && \
#      conda clean --all -afy
#RUN mamba install -n py_geo_gpu -c conda-forge python=3.7.10=hffdb5ce_100_cpython && \
#	mamba clean --all -afy
#RUN mamba install -n py_geo_gpu -c nvidia -c conda-forge cudatoolkit=11.0.221=h6bb024c_0 && \
#	mamba clean --all -afy
#RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge cudf=0.18.1=cuda_11.0_py37_g999be56c80_0 && \
#	mamba clean --all -afy
#RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge -c nvidia cuml=0.18.0=cuda11.0_py37_gb5f59e005_0 && \
#	mamba clean --all -afy
#RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge cugraph=0.18.0=py37_g65ec965f_0 && \
#	mamba clean --all -afy
#RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge cusignal=0.18.0=py38_g42899d2_0 && \
#	mamba clean --all -afy
#RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge cuspatial=0.18.0=py37_gf4da460_0 && \
#	mamba clean --all -afy
#RUN mamba install -n py_geo_gpu -c rapidsai -c conda-forge cuxfilter=0.18.0=py37_gac6f488_0 && \
#	mamba clean --all -afy
#RUN mamba install -n py_geo_gpu -c defaults tensorflow-gpu=1.14.0=h0d30ee6_0 && \
#	mamba clean --all -afy && \
#	npm cache clean --force && \
#      rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
#      rm -rf /home/$NB_USER/.cache/yarn && \
#      rm -rf /home/$NB_USER/.node-gyp && \
#      fix-permissions /home/$NB_USER && \
#      fix-permissions $CONDA_DIR

#Prepare image to work on SLURM, build folder structure to be able to bind mount the IDL kernel, install Rstudio server and install VSCode server.
USER root
SHELL ["/bin/bash", "-c"]
RUN chmod -R 777 /home/jovyan && \
	mkdir /usr/share/jupyter && \
    	mkdir /usr/share/jupyter/kernels && \
    	mkdir /usr/share/jupyter/kernels/IDL && \
    	chmod -R 777 /usr/share/jupyter && \
    	chmod -R 777 /usr/share/jupyter/kernels && \
    	chmod -R 777 /usr/share/jupyter/kernels/IDL && \
    	chmod -R 777 /opt/conda/lib/python3.8/site-packages && \
    	ln -s /bin/tar /bin/gtar && \
    	groupadd -g 1000 slurm && \
    	useradd  -m -c "Slurm" -d /var/lib/slurm -u 401 -g slurm  -s /bin/bash slurm && \
    	groupadd -g 398 munge && \
    	useradd -m -c "Munge" -d /var/lib/munge -u 398 -g munge -s /sbin/nologin munge && \
        apt-get update && \
	apt-get install -y --no-install-recommends \
		libapparmor1 \
		libedit2 \
		lsb-release \
		psmisc \
		libclang-dev \
		systemd \
		gdebi-core \
		uuid && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
USER $NB_UID