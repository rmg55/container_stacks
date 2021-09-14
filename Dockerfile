FROM continuumio/miniconda3

#Add Additional Image Labels
LABEL maintainer="Rowan Gaffney <rowan.gaffney@unavco.org>"
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/rmg55/container_stacks.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.description="Developmnet environment for working gpsflow development."

COPY dev_env.yml .

RUN conda config --set channel_priority strict && \
    conda install -c conda-forge --yes --quiet mamba>=0.15.3 && \
	mamba env create -f dev_env.yml --quiet && \
	conda clean --all -afy && \
	mamba clean --all -afy && \
    fix-permissions $CONDA_DIR