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
NAME=ganow/keras

build:
	docker build -t $(NAME) --build-arg python_version=3.5 -f $(DOCKER_FILE) .

bash: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --env KERAS_BACKEND=$(BACKEND) $(NAME) bash

ipython: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --env KERAS_BACKEND=$(BACKEND) $(NAME) ipython

notebook: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --net=host --env KERAS_BACKEND=$(BACKEND) $(NAME)

test: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/home/keras/data -v $(ASSETS):/home/keras/assets --env KERAS_BACKEND=$(BACKEND) $(NAME) py.test $(TEST)

