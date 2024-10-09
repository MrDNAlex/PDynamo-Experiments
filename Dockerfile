# Install Ubuntu
FROM mrdnalex/orca:latest

# Switch to Root User
USER root

# Make the Working Directory the Root
WORKDIR /

# Downlaods all the required packages
RUN apt-get update && apt-get install -y \
    python3 \
    sudo \
    nano \
    curl \
    git \
    software-properties-common \
    python3-pip \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-setuptools \
    python3-venv \
    python3-wheel \
    && apt-get clean

# Clones the PDynamo3 repository
RUN git clone https://github.com/pdynamo/pDynamo3.git

# Installs C Python
RUN python3 -m pip install Cython

#Add All Python Paths
ENV PYTHONPATH="/pDynamo3"
ENV PDYNAMO3_HOME="${PYTHONPATH}"
ENV PDYNAMO3_PARAMETERS="${PDYNAMO3_HOME}/parameters"
ENV PDYNAMO3_PYTHONCOMMAND="python3"
ENV PDYNAMO3_SCRATCH="${PDYNAMO3_HOME}/scratch"
ENV PDYNAMO3_ORCACOMMAND="/Orca/orca"

# Sets the Work Directory tp PDynamo3 Installation folder
WORKDIR ${PDYNAMO3_HOME}/installation

# Runs the Install.py file
RUN python3 Install.py -f

# Modifies the Environment_Bash file to make it executable
RUN chmod +x ${PDYNAMO3_HOME}/installation/shellScripts/environment_bash.com

# Moves the Work Directory to the ShellScripts folder
WORKDIR ${PDYNAMO3_HOME}/installation/shellScripts

# Runs the Environment_Bash file
RUN ./environment_bash.com

# Installs PyYAML
RUN pip install pyyaml

RUN python3 ${PDYNAMO3_HOME}/installation/RunExamples.py book