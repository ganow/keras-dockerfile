help:
	@cat Makefile

DATA?="${HOME}/data"
ASSETS?="${HOME}/assets"
GPU?=0
DOCKER_FILE=Dockerfile
DOCKER=GPU=$(GPU) nvidia-docker
BACKEND=tensorflow
TEST=tests/
SRC=$(shell dirname `pwd`)

build:
	docker build -t keras --build-arg python_version=3.5 -f $(DOCKER_FILE) .

bash: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --env KERAS_BACKEND=$(BACKEND) keras bash

ipython: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --env KERAS_BACKEND=$(BACKEND) keras ipython

notebook: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --net=host --env KERAS_BACKEND=$(BACKEND) keras

test: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --env KERAS_BACKEND=$(BACKEND) keras py.test $(TEST)

