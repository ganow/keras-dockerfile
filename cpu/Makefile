help:
	@cat Makefile

NAME?=""
DATA?="${HOME}/data"
ASSETS?="${HOME}/assets"
DOCKER_FILE=Dockerfile
DOCKER=docker
BACKEND=tensorflow
TEST=tests/
SRC=$(shell dirname `pwd`)
IMAGENAME=ganow/keras-cpu

build:
	docker build -t $(IMAGENAME) -f $(DOCKER_FILE) .

bash: build
	$(DOCKER) run --name $(NAME) -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --env KERAS_BACKEND=$(BACKEND) $(IMAGENAME) bash

ipython: build
	$(DOCKER) run --name $(NAME) -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --env KERAS_BACKEND=$(BACKEND) $(IMAGENAME) ipython

notebook: build
	$(DOCKER) run --name $(NAME) -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --net=host --env KERAS_BACKEND=$(BACKEND) $(IMAGENAME)

test: build
	$(DOCKER) run --name $(NAME) -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --env KERAS_BACKEND=$(BACKEND) $(IMAGENAME) py.test $(TEST)

