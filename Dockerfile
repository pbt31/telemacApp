FROM quay.io/rbaya31/telemac-base:v1.0.0

## SET ENVIRONMENT VARIABLES
ENV TZ=America/Montevideo
ENV DEP=dependencies
ENV TELEMAC_DIR=/home/telemac
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV VERSION=v7p2r0

## SET WORKING DIR INSIDE THE CONTAINER
WORKDIR $TELEMAC_DIR

## DOWNLOAD TELEMAC
RUN apt-get install -y subversion
RUN svn co http://svn.opentelemac.org/svn/opentelemac/tags/$VERSION $TELEMAC_DIR/app --username=ot-svn-public --password=telemac1*
#COPY v7p2r0 app/

## COPY CONFIGS INTO IT
COPY pysource.sh app/configs
COPY systel.cfg  app/configs

## COMPILE TELEMAC
RUN ln -s /usr/bin/python2.7 /usr/bin/python
RUN . app/configs/pysource.sh && config.py && compileTELEMAC.py

RUN useradd telemac
RUN chown -R telemac app/
RUN chown -R telemac dependencies/
USER telemac


CMD ["/bin/bash"]

