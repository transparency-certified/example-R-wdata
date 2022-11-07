FROM rocker/verse:4.1.0

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
         locales \
         libncurses5 \
         csvkit \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

COPY --chown=rstudio:rstudio . /home/rstudio/
WORKDIR /home/rstudio
USER rstudio
RUN Rscript setup.R
