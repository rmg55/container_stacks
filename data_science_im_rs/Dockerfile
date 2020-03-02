FROM jupyter/minimal-notebook
LABEL maintainer="Rowan Gaffney <rowan.gaffney@usda.gov>"

SHELL ["/bin/bash", "-c"]

USER root

SHELL ["/bin/bash", "-c"]

RUN chmod -R 777 /home/jovyan && \
	mkdir /usr/share/jupyter && \
    	mkdir /usr/share/jupyter/kernels && \
    	mkdir /usr/share/jupyter/kernels/IDL && \
    	chmod -R 777 /usr/share/jupyter && \
    	chmod -R 777 /usr/share/jupyter/kernels && \
    	chmod -R 777 /usr/share/jupyter/kernels/IDL && \
    	chmod -R 777 /opt/conda/lib/python3.7/site-packages && \
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
		uuid \
		libssl1.0.0 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	RSTUDIO_PKG=rstudio-server-1.2.5019-amd64.deb && \
  		wget -q https://download2.rstudio.org/server/trusty/amd64/${RSTUDIO_PKG} && \
  		dpkg -i ${RSTUDIO_PKG} && \
  		rm ${RSTUDIO_PKG} && \
  	apt-get clean && \
  	rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN conda config --set channel_priority strict && \
	conda install -c conda-forge --quiet --yes 'jupyter-server-proxy' \
		'jupyter-archive' \
		'nb_conda_kernels' && \
	conda create -n geo --yes && \
	conda install -n geo -c conda-forge --quiet --yes \
		'dask' \
		'openmpi'\
		'dask-ml' \
		'dask-xgboost' \
		'bokeh' \
		'mpi4py' \
		'gdal' \
		'git' \
		'pip' \
		'ncurses' \
		'netCDF4' \
		'tqdm' \
		'bottleneck' \
		'zarr' \
		'numcodecs' \
		'xarray' \
		'h5py' \
		'python-graphviz' \
		'geopandas' \
		'simplegeneric' \
		'rasterio[s3]' \
		'fiona' \
		'spectral' \
		'shapely' \
		'pyshp' \
		'joblib' \
		'psycopg2' \
		'openpyxl' \
		'oauth2client' \
		'PyDrive' \
		'dask-jobqueue' \
		'xgboost' \
		'earthengine-api' \
		'r' \
		'rpy2' \
		'poppler' \
		'intake' \
		'pydap' \
		'holoviews[all]' \
		'geoviews' \
		'panel' \
		'datashader' \
		'streamz' \
		'rasterstats' \
		'pyarrow' \
		's3fs' \
		'gcsfs' \
		'intake-xarray' \
		'intake-esm' \
		'intake-parquet' \
		'intake-sql' \
		'streamz' \
		'hvplot' \
		'selenium ' \
		'h5netcdf' \
		'rioxarray' \
		'xgeo' \
		'xrviz' \
		'pysal' \
		'pyhdf' \
		'rioxarray' \
		'intake-stac' \
		'phantomjs' \
                'ipywidgets' \
		'widgetsnbextension' \
		'threddsclient' && \
	jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    	# Also activate ipywidgets extension for JupyterLab
    	# Check this URL for most recent compatibilities
    	# https://github.com/jupyter-widgets/ipywidgets/tree/master/packages/jupyterlab-manager
    	jupyter labextension install @jupyter-widgets/jupyterlab-manager@^1.0.1 --no-build && \
    	jupyter labextension install jupyterlab_bokeh@1.0.0 --no-build && \
	jupyter labextension install dask-labextension --no-build && \
	jupyter labextension install @pyviz/jupyterlab_pyviz --no-build && \
	jupyter labextension install @jupyterlab/server-proxy --no-build && \
	jupyter lab build && \
    	jupyter labextension update --all && \
	chmod -R 777 /opt/conda/lib/python3.7/site-packages && \
	conda create -n R_geo --yes && \ 
	conda install -n R_geo -c conda-forge --quiet --yes \
  		'r-irkernel' \
  		'r-rgdal' \
  		'r-gdalutils' \
		'r-raster' \
		'r-snow' \
  		'r-sf' \
  		'r-gstat' \
  		'r-maptools' \
  		'r-rgeos' \
  		'r-irkernel' \
  		'r-reticulate' \
  		'r-shiny' \
  		'r-sp' && \
  	conda install -c conda-forge jupyter-server-proxy && \
  	conda run pip install git+https://github.com/jupyterhub/jupyter-rsession-proxy && \
	conda clean --all -f -y && \
	npm cache clean --force && \
  	rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
  	rm -rf /home/$NB_USER/.cache/yarn && \
  	rm -rf /home/$NB_USER/.node-gyp && \
    	fix-permissions /home/$NB_USER && \
    	fix-permissions $CONDA_DIR

ENV PATH="/opt/conda/envs/R_geo/bin:${PATH}:/usr/lib/rstudio-server/bin"

ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server:/opt/conda/envs/R_geo/lib/R/lib"

USER root

RUN echo 'rsession-which-r=/opt/conda/envs/R_geo/bin/R' >> /etc/rstudio/rserver.conf

USER $NB_UID

RUN conda init bash && exec bash
