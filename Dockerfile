FROM rocker/shiny:4.3.1
ENV RENV_CONFIG_REPOS_OVERRIDE https://packagemanager.rstudio.com/cran/latest

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  libcairo2-dev \
  libcurl4-openssl-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libharfbuzz-dev \
  libicu-dev \
  libjpeg-dev \
  libpng-dev \
  libsodium-dev \
  libssl-dev \
  libtiff-dev \
  libxml2-dev \
  make \
  pandoc \
  unixodbc-dev \
  zlib1g-dev \
  && apt-get clean
COPY shiny_renv.lock renv.lock
RUN Rscript -e "install.packages('renv')"
RUN Rscript -e "renv::restore()"
WORKDIR /home/shinyusr
COPY app.R app.R
COPY renv renv
COPY cata.R cata.R
COPY catalogue.R catalogue.R
COPY product.R product.R
COPY db.sqlite db.sqlite
COPY www www
COPY TradeCatalogue.Rproj TradeCatalogue.Rproj

#COPY ./D/Github/ESCABOT/R /srv/shiny-server/
EXPOSE 8080
#CMD ["/usr/bin/shiny-server"]

#CMD Rscript app.R

CMD ["R", "-e", "shiny::runApp('/home/shinyusr', host='0.0.0.0', port=8080)"]

#CMD ["R", "-e", "shiny::runApp('/home/shinyusr')"]
