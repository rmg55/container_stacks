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
	conda install -c conda-forge --yes \
		'jupyterlab' \
		'jupyter_client' \
		'jupyter-archive' \
		'widgetsnbextension' \
		'dask-labextension' \
		'jupyter-server-proxy' \
		'jupyter-panel-proxy' \
		'jupyter-rsession-proxy' \
		'nb_conda_kernels' && \
	conda clean --all -afy && \
	conda create -n py_geo --yes && \
	conda install -n py_geo -c conda-forge --yes \
		'ipykernel' \
		'scikit-learn' \
		'dask' \
		'openmpi' \
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
		'threddsclient' && \
	conda clean --all -afy && \
	chmod -R 777 /opt/conda/lib/python3.7/site-packages && \
	conda create -n r_geo --yes && \ 
	conda install -n r_geo -c conda-forge --yes \
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
		'r-rslurm' \
  		'r-sp' && \
	jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    	jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
	jupyter labextension install dask-labextension --no-build && \
	jupyter labextension install @pyviz/jupyterlab_pyviz --no-build && \
	jupyter labextension install @jupyterlab/server-proxy --no-build && \
	jupyter lab build && \
    	jupyter labextension update --all && \
	conda clean --all -afy && \
	npm cache clean --force && \
  	rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
  	rm -rf /home/$NB_USER/.cache/yarn && \
  	rm -rf /home/$NB_USER/.node-gyp && \
    	fix-permissions /home/$NB_USER && \
    	fix-permissions $CONDA_DIR

ENV PATH="/opt/conda/envs/r_geo/bin:${PATH}:/usr/lib/rstudio-server/bin"

ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server:/opt/conda/envs/r_geo/lib/R/lib"

USER root

RUN echo 'rsession-which-r=/opt/conda/envs/r_geo/bin/R' >> /etc/rstudio/rserver.conf && \
	mkdir ~/.config/dask && \
	echo 'distributed.dashboard.link: "/user/{JUPYTERHUB_USER}/proxy/{port}/status"' > ~/.config/dask/distributed.yaml

USER $NB_UID

RUN conda init bash && exec bash
