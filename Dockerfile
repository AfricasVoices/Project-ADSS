FROM python:3.6-slim

# Install Python tools (git + pipenv)
RUN apt-get update && apt-get install -y git
RUN pip install pipenv

# Install R tools (r-base + packrat)
RUN apt-get update && apt-get install -y gnupg
RUN apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
RUN echo "deb http://cloud.r-project.org/bin/linux/debian stretch-cran35/" >>/etc/apt/sources.list
RUN apt-get update && apt-get install -y r-base
RUN R --version
RUN printf '\nlocal({\nr <- getOption("repos")\nr["CRAN"] <- "https://cloud.r-project.org"\noptions(repos = r)\n})\n' >>/etc/R/Rprofile.site
RUN echo 'install.packages("packrat")' | R -q --no-save

# Install pyflame (for statistical profiling) if this script is run with PROFILE_CPU flag
ARG INSTALL_CPU_PROFILER="false"
RUN if [ "$INSTALL_CPU_PROFILER" = "true" ]; then \
        apt-get update && apt-get install -y autoconf automake autotools-dev g++ pkg-config python-dev python3-dev libtool make && \
        git clone https://github.com/uber/pyflame.git /pyflame && cd /pyflame && git checkout "v1.6.7" && \
        ./autogen.sh && ./configure && make && make install && \
        rm -rf /pyflame; \
    fi

# Make a directory for private credentials files
RUN mkdir /credentials

# Make a directory for intermediate data
RUN mkdir /data

# Install project dependencies.
ADD analysis/packrat/init.R /app/analysis/packrat/
ADD analysis/packrat/packrat.lock /app/analysis/packrat/
ADD analysis/packrat/packrat.opts /app/analysis/packrat/
ADD analysis/.Rprofile /app/analysis/
RUN cd analysis && echo 'packrat::restore()' | R -q --no-save

ADD Pipfile /app
ADD Pipfile.lock /app
RUN pipenv sync

# Copy the rest of the project
ADD code_schemes/*.json /app/code_schemes/
ADD src /app/src
ADD analysis/*.R /app/analysis/
ADD fetch_raw_data.py /app
ADD fetch_flow_definitions.py /app
ADD generate_outputs.py /app
