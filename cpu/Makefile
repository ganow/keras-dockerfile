help:
	@cat Makefile

DATA?="${HOME}/data"
ASSETS?="${HOME}/assets"
GPU?=0
DOCKER_FILE=Dockerfile
DOCKER=docker
BACKEND=tensorflow
TEST=tests/
SRC=$(shell dirname `pwd`)
NAME=keras-cpu

build:
	docker build -t $(NAME) --build-arg python_version=3.5 -f $(DOCKER_FILE) .

bash: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data -v $(ASSETS):/assets --env KERAS_BACKEND=$(BACKEND) $(NAME) bash

ipython: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data -v $(ASSETS):/assets --env KERAS_BACKEND=$(BACKEND) $(NAME) ipython

notebook: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data -v $(ASSETS):/assets --net=host --env KERAS_BACKEND=$(BACKEND) $(NAME)

test: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data -v $(ASSETS):/assets --env KERAS_BACKEND=$(BACKEND) $(NAME) py.test $(TEST)

