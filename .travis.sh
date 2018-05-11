sudo: 'required'

services:
  - 'docker'

language:
  - 'bash'

env:
  global:
    - NODE_RED_HOMEKIT_VERSION=1.0
    - IMAGE=raymondmm/node-red-home-kit
    - QEMU_VERSION=v2.11.1

before_install:
  - ./.docker/docker.sh prepare

script:
  #- ./update.sh $NODE_RED_VERSION
  - ./.docker/docker.sh build
  - ./.docker/docker.sh test

after_success:
  - >
    if [ "$TRAVIS_BRANCH" == "master" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
      # Docker Login
      echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

      # Tag all images
      ./.docker/docker.sh tag

      # Push all images
      ./.docker/docker.sh push

      # Create and push manifest list
      ./.docker/docker.sh manifest-list

      # Docker Logout
      docker logout
    fi

# notify me when things fail
notifications:
    email: true
