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
VERSION=0.1
IMAGENAME=ganow/keras:$(VERSION)

build:
	docker build -t $(IMAGENAME) --build-arg python_version=3.5 -f $(DOCKER_FILE) .

pull:
	$(DOCKER) pull $(IMAGENAME)

push:
	$(DOCKER) push $(IMAGENAME)

bash:
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data -v $(ASSETS):/assets --env KERAS_BACKEND=$(BACKEND) $(IMAGENAME) bash

ipython:
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data -v $(ASSETS):/assets --env KERAS_BACKEND=$(BACKEND) $(IMAGENAME) ipython

notebook:
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data -v $(ASSETS):/assets --net=host --env KERAS_BACKEND=$(BACKEND) $(IMAGENAME)

tensorboard:
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data -v $(ASSETS):/assets --net=host --env KERAS_BACKEND=$(BACKEND) $(IMAGENAME) tensorboard --logdir=/assets

test:
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data -v $(ASSETS):/assets --env KERAS_BACKEND=$(BACKEND) $(IMAGENAME) py.test $(TEST)
