FROM rowangaffney/data_science_im_rs
LABEL maintainer="Rowan Gaffney <rowan.gaffney@ars.usda.gov>"

USER $NB_UID
RUN conda install -c conda-forge --quiet --yes ucx
RUN conda install -c tomaugspurger --quiet --yes ucx-py


USER root
RUN sudo apt install -y -libibverbs1

#RUN mkdir UCX_install
#RUN cd UCX_install
#  RUN wget https://github.com/openucx/ucx/releases/download/v1.6.0/ucx-1.6.0.tar.gz
#RUN tar xzf ucx-1.6.0.tar.gz
#RUN cd ucx-1.6.0/
#RUN ./contrib/configure-release --prefix=$PWD/install
#RUN make -j8
#RUN make install

#USER $NB_UID
