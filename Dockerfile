FROM jupyter/minimal-notebook

#Add Additional Image Labels
LABEL maintainer="Rowan Gaffney <rowan.gaffney@usda.gov>"
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/rmg55/container_stacks.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.description="Data science image built from the jupyter stacks minimal-notebook image. Includes JupyterLab with a server-proxy to RStudio server, VSCode server, and Panel. Includes kernels for Python, R, and possible IDL (if present in the host machine in specific folders). Software packages/modules are focused on spatial data analytics, remote sensing, and machine learning."

SHELL ["/bin/bash", "-c"]
USER root
SHELL ["/bin/bash", "-c"]

ADD settings.json /home/coder/.local/share/code-server/User/settings.json

#Prepare image to work on SLURM, build folder structure to be able to bind mount the IDL kernel, install Rstudio server and install VSCode server.
RUN chmod -R 777 /home/jovyan && \
	mkdir /usr/share/jupyter && \
    	mkdir /usr/share/jupyter/kernels && \
    	mkdir /usr/share/jupyter/kernels/IDL && \
    	chmod -R 777 /usr/share/jupyter && \
    	chmod -R 777 /usr/share/jupyter/kernels && \
    	chmod -R 777 /usr/share/jupyter/kernels/IDL && \
    	chmod -R 777 /opt/conda/lib/python3.9/site-packages && \
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
		r-cran-rodbc \
		libclang-dev \
		systemd \
		gdebi-core \
		uuid && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
  	wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.5042-amd64.deb && \
		gdebi -n rstudio-server-1.2.5042-amd64.deb && \
		rm rstudio-server-1.2.5042-amd64.deb && \
	cd /opt && \
        	mkdir /opt/code-server && \
        	cd /opt/code-server && \
        	wget -qO- https://github.com/cdr/code-server/releases/download/v3.5.0/code-server-3.5.0-linux-amd64.tar.gz | tar zxvf - --strip-components=1 && \
		/opt/code-server/code-server --install-extension ms-python.python && \
		/opt/code-server/code-server --install-extension github.vscode-pull-request-github && \
		/opt/code-server/code-server --install-extension redhat.vscode-yaml && \
  	apt-get clean && \
  	rm -rf /var/lib/apt/lists/*


USER $NB_UID
ENV PIP_NO_CACHE_DIR=1
#Install Python and R packages in the py_geo and r_geo environmets, respectively.
COPY py_geo.yml .
COPY r_geo.yml .

RUN pip install --upgrade pip && \
	conda config --set channel_priority strict && \
	conda install -c conda-forge --yes --quiet \
		'mamba>=0.7.6' \
		'jupyterlab>=3.0' \
		'bokeh>=2.1.1' \
		'tornado' \
		'jupyter_client' \
		'jupyter-archive' \
		'jupyterlab_widgets' \
		'dask-labextension' \
		'jupyter-panel-proxy' \
		'jupyter-server-proxy' \
		'jupyter-vscode-proxy' \
		'jupyter-rsession-proxy' \
		'nbgitpuller>=0.9.0' \
		'pyviz_comms>=2.0.0' \
		'nb_conda_kernels' && \
	/opt/conda/bin/pip install --no-cache-dir batchspawner && \
	conda config --set channel_priority false && \ 
	conda config --set channel_priority strict && \
	mamba env create -f py_geo.yml --quiet && \
	mamba env create -f r_geo.yml --quiet && \
	conda clean --all -afy && \
	mamba clean --all -afy && \
	npm cache clean --force && \
        rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
        rm -rf /home/$NB_USER/.cache/yarn && \
        rm -rf /home/$NB_USER/.node-gyp && \
        fix-permissions /home/$NB_USER && \
        fix-permissions $CONDA_DIR

#Setup and install RStudio Server to work with jupyter-server-proxy from Jupyter
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
ENV PATH="/opt/code-server:${PATH}"
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server:/opt/conda/envs/r_geo/lib/R/lib"
USER root
RUN echo 'rsession-which-r=/opt/conda/envs/r_geo/bin/R' >> /etc/rstudio/rserver.conf && \
	mkdir ~/.config/dask && echo -e 'distributed:\n  dashboard:\n    link: "/user/{JUPYTERHUB_USER}/proxy/{port}/status"' > ~/.config/dask/distributed.yaml
USER $NB_UID
