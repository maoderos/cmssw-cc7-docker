ARG BASEIMAGE=gitlab-registry.cern.ch/linuxsupport/cc7-base:20220401-1.x86_64

FROM ${BASEIMAGE}

# Perform the installation as root
USER root 
WORKDIR /root

RUN     yum install -y libX11-devel libXext-devel mesa-libGLU-devel \
        mesa-libGL-devel libSM libXft libXext \
        pciutils glx-utils mesa-dri-drivers libX11 libXi libXrender \
				tcsh zsh tcl tk e2fsprogs perl-ExtUtils-Embed compat-libstdc++-33 libXmu e2fsprogs-libs libXpm bc libaio \
				tar patch krb5-devel perl-Data-Dumper gcc unzip zip perl-libwww-perl libXpm-devel libXft-devel openssl-devel svn cvs \
				gcc-c++ strace cern-wrappers krb5-workstation wget hostname readline-devel nano bzip2 perl-Switch perl-Storable \
				perl-Env packages perl-Thread-Queue CERN-CA-certs tk-devel tcl-devel which python-pip voms-clients-cpp \
				java-1.8.0-openjdk java-1.8.0-openjdk-devel popt libXcursor libXrandr libXinerama nspr nss nss-util file file-libs \
				readline bzip2-libs python-requests-kerberos libgfortran time python2-psutil python3 \
				HEP_OSlibs_CC7 git \
				yum-plugin-ovl openssl \
				glibc-devel.i686 glibc-devel \
				glibc-headers \
				sudo nano && \
        yum clean -y all

RUN     wget http://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo && \
        mv EGI-trustanchors.repo /etc/yum.repos.d/ && \
				wget http://repository.egi.eu/sw/production/cas/1/GPG-KEY-EUGridPMA-RPM-3 && \
				mv GPG-KEY-EUGridPMA-RPM-3 /etc/pki/rpm-gpg/ && \
				wget http://linuxsoft.cern.ch/wlcg/wlcg-centos7.repo && \
				mv wlcg-centos7.repo /etc/yum.repos.d/ && \
				wget http://linuxsoft.cern.ch/wlcg/RPM-GPG-KEY-wlcg && \
				mv RPM-GPG-KEY-wlcg /etc/pki/rpm-gpg/ && \
				yum install -y ca-policy-egi-core wlcg-repo.noarch wlcg-voms-cms && \
				yum clean -y all


RUN     groupadd -g 1000 cmsusr && adduser -u 1000 -g 1000 -G root cmsusr && \
        echo "cmsusr ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers && \
				groupadd -g 1001 cmsinst && adduser -u 1001 -g 1001 cmsinst && \
				install -d /opt && install -d -o cmsinst /opt/cms

#Add a couple of useful files to cmsusr account

WORKDIR /home/cmsusr     
USER cmsusr
ENV USER cmsusr
ENV HOME /home/cmsusr
		
RUN sudo chown -R cmsusr /home/cmsusr && \
    chmod 755 /home/cmsusr



