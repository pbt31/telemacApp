FROM quay.io/rbaya31/telemac-base:v1.0.0

## SET ENVIRONMENT VARIABLES
ENV TZ=America/Montevideo
ENV DEP=dependencies
ENV TELEMAC_DIR=/home/telemac
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV VERSION=v7p2r0
ENV BUILD_CONFIG=gfortranHPC

## SET WORKING DIR INSIDE THE CONTAINER
WORKDIR $TELEMAC_DIR

## DOWNLOAD TELEMAC
RUN apt-get update && apt-get install -y subversion sudo nano
RUN svn co http://svn.opentelemac.org/svn/opentelemac/tags/$VERSION/builds $TELEMAC_DIR/app/builds --username=ot-svn-public --password=telemac1* && \
svn co http://svn.opentelemac.org/svn/opentelemac/tags/$VERSION/configs $TELEMAC_DIR/app/configs --username=ot-svn-public --password=telemac1* && \
svn co http://svn.opentelemac.org/svn/opentelemac/tags/$VERSION/examples/telemac2d/gouttedo $TELEMAC_DIR/app/example --username=ot-svn-public --password=telemac1* && \
svn co http://svn.opentelemac.org/svn/opentelemac/tags/$VERSION/scripts $TELEMAC_DIR/app/scripts --username=ot-svn-public --password=telemac1* && \
svn co http://svn.opentelemac.org/svn/opentelemac/tags/$VERSION/sources $TELEMAC_DIR/app/sources --username=ot-svn-public --password=telemac1* && \
rm -rf .svn

## COPY CONFIGS INTO IT
COPY pysource.sh app/configs
COPY systel.cfg  app/configs

## COMPILE TELEMAC
RUN ln -s /usr/bin/python2.7 /usr/bin/python
RUN . app/configs/pysource.sh && config.py && compileTELEMAC.py

## CONFIGURE TELEMAC USER
RUN useradd -m telemac && echo "telemac:telemac" | chpasswd && adduser telemac sudo
RUN cat app/configs/pysource.sh >> .bashrc 
RUN chown -R telemac .
USER telemac

## VERIFY TELEMAC BUILD
RUN . app/configs/pysource.sh && telemac2d.py app/example/t2d_gouttedo.cas --ncsize=4


CMD ["/bin/bash"]

