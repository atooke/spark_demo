FROM jupyter/pyspark-notebook


LABEL org.opencontainers.image.title="Spark Demo using Docker" \
      org.opencontainers.image.description="Spark Demo using Docker" \
      org.opencontainers.image.authors="andy.tooke@mckesson.com" 


# prevent python writing .pyc files to image
ENV PYTHONDONTWRITEBYTECODE 1
#Prevents Python from buffering stdout and stderr
#ENV PYTHONUNBUFFERED 1
ENV PYSPARK_DRIVER_PYTHON=jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS=notebook

# set python path to src directory
# ENV PYTHONPATH /APP

# user root to make updates
USER root


# create new dir on image:
RUN mkdir -p /app
RUN mkdir -p /app/notebooks

# copy datafile to container
COPY Vermont_Vendor_Payments.csv /app
COPY requirements.txt /app
COPY *.ipynb /app/notebooks
# set project as working dir:
WORKDIR /app

# install dependencies
RUN pip install --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org -r requirements.txt

EXPOSE 8000 8888


#switch user to non-root
#USER $NB_UID

# change jupyter permissions
#RUN sudo chown -R $NB_UID ~/.local/share/jupyter 


# run app:
CMD ["jupyter", "notebook", "--port=8888", "--ip=0.0.0.0", "--no-browser" , "--allow-root"]




