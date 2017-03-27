
# vapor_Image
FROM swift

MAINTAINER Loic LE PENN <loic.lepenn@gmail.com>

ENV BUILDER_VERSION 1.0


LABEL io.k8s.description="Image to generate a vapor project" \
      io.k8s.display-name="Vapor generator" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,Swift,Vapor"

RUN curl -sL toolbox.vapor.sh | bash 

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image 
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["usage"]
