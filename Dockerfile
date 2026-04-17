FROM condaforge/miniforge3:latest

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY environment.yml .

RUN mamba env create -n drop_env -f environment.yml && \
    mamba clean -a -y

COPY . .

RUN /opt/conda/envs/drop_env/bin/pip install .

RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate drop_env" >> ~/.bashrc

ENV PATH="/opt/conda/envs/drop_env/bin:$PATH"

CMD ["drop", "--help"]
