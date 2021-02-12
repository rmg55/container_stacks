FROM jupyter/scipy-notebook
LABEL maintainer="Rowan Gaffney <rowan.gaffney@usda.gov>"

USER root

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
    	useradd -m -c "Munge" -d /var/lib/munge -u 398 -g munge -s /sbin/nologin munge

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
		'threddsclient' && \
	jupyter labextension install dask-labextension && \
	jupyter labextension install @pyviz/jupyterlab_pyviz && \
    	jupyter labextension update --all && \
    	pip install ipyleaflet && \
	pip install scikit-gstat && \
   	jupyter nbextension enable --py --sys-prefix ipyleaflet && \
   	jupyter labextension install jupyter-leaflet && \
	chmod -R 777 /opt/conda/lib/python3.7/site-packages && \
	conda clean --all -f -y && \
	npm cache clean --force && \
  	rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
  	rm -rf /home/$NB_USER/.cache/yarn && \
  	rm -rf /home/$NB_USER/.node-gyp && \
    	fix-permissions /home/$NB_USER && \
    	fix-permissions $CONDA_DIR
