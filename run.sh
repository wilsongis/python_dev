
docker build -t python_dev -f config/Dockerfile .
docker run --privileged -ti -v ${PWD}:/usr/local/bin/python_dev -w /usr/local/bin/python_dev -p 8888:8888 python_dev zsh
