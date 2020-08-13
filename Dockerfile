ARG PY_VERSION=3.7

FROM continuumio/miniconda3:4.8.2-alpine AS builder

ARG PY_VERSION

EXPOSE 8888

RUN echo $PY_VERSION

LABEL maintainer.name="umesh timalsina"\
      maintainer.url="https://umesh-timalsina.github.io"

ENV PATH /opt/conda/bin:$PATH

USER root

ADD . /template-python-package

WORKDIR /template-python-package

RUN conda update conda -yq && \
	conda config --set always_yes yes --set changeps1 no && \
	conda config --add channels conda-forge && \
	. /opt/conda/etc/profile.d/conda.sh && \
	conda create -n template-python-package-docker python=$PY_VERSION nomkl --file requirements-dev.txt && \
	conda activate template-python-package-docker && \
    python setup.py install && \
	echo "source activate template-python-package-docker" >> \
	/home/anaconda/.profile && \
	conda clean -afy && \
	mkdir /home/anaconda/template-python-package-notebooks && \
	chown -R anaconda:anaconda /template-python-package && \
	chown -R anaconda:anaconda /opt && \
	chown -R anaconda:anaconda /home/anaconda


WORKDIR /home/anaconda

CMD /bin/su anaconda -s /bin/sh -l
