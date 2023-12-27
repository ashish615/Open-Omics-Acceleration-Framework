ARG FROM_IMAGE=ubuntu:20.04
ARG VERSION=1.0.0
FROM ${FROM_IMAGE} as builder


# Install Base miiiconda image
#ARG BASE_IMAGE=continuumio/miniconda3
#FROM ${BASE_IMAGE}
#RUN git clone --recursive https://github.com/IntelLabs/Open-Omics-Acceleration-Framework.git
COPY . /Open-Omics-Acceleration-Framework/
WORKDIR /Open-Omics-Acceleration-Framework/pipelines/deepvariant-based-germline-variant-calling-fq2vcf/scripts/aws/
#RUN apt update
RUN chmod +x /Open-Omics-Acceleration-Framework/pipelines/deepvariant-based-germline-variant-calling-fq2vcf/scripts/aws/basic_setup.sh
RUN apt-get update && \
      apt-get -y install sudo
#RUN apt-get install "${APT_ARGS[@]}" sudo > /dev/null
RUN ./basic_setup.sh && ./build_tools.sh

#RUN conda env create -f /tmp/environment.yml
#ENV name=$(head -1 /tmp/environment.yml | cut -d' ' -f2)
#RUN echo "source activate $(head -1 /tmp/environment.yml | cut -d' ' -f2)" > ~/.bashrc
#CMD source ~/.bashrc
#ENV PATH "/opt/conda/envs/new_env/bin:$PATH"
#RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
#    git build-essential cmake wget tzdata gcc curl gnupg gnupg2 gnupg1 sudo kalign autoconf numactl time vim \
#    && rm -rf /var/lib/apt/lists/* \
#    && apt-get autoremove -y \
#    && apt-get clean
#WORKDIR /tmp
#iUN echo "hostname > hostfile"
#CMD hostname > hostfile && mpiexec.hydra -n 4 -f hostfile python mpi.py
CMD ./run_pipeline_ec2.sh
