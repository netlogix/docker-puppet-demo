Demo for building docker images with puppet and packer
======================================================

The aim of this demo is to show how building docker images from puppet code can
be achieved in a simple and reliable way.

What it does
------------

The demo uses some simple puppet code to provision the docker images to run a
simple demo php application.

The `Makefile` just wraps some longer commands to make them easier to use.

The `bin/packer.sh` script uses `docker-compose` to start a puppet server and
puppetdb (as dependencies in `docker-compose.yml`) and then runs packer in a
docker container.

Packer starts a docker container from an image defined in the template and vars
file and for the base image installs puppet into the container. Afterwards,
puppet is run against the puppet server started earlier. The puppet ssl
certificates need to be removed as the containers have different hostnames on
every run. After packer finished running puppet an image is created from the
container.

Requirements
------------

* docker
* docker-compose
* r10k (because it doesn't run well in docker)

Running the demo
----------------

1. Install required puppet modules
   ```shell script
   r10k puppetfile install
   ```
2. Create the base docker image containing puppet and basic adjustments
   ```shell script
   make base
   ```
3. Create the other docker images which depend on the base image
   ```shell script
   make apache-base php-fpm mariadb-base
   ```
4. Create the docker images for the demo
   ```shell script
   make demo-app1-apache demo-db
   ```
5. Run the demo application
   ```shell script
   cd demo-app
   docker-compose up
   curl localhost:8080
   ```

Future possible improvements
----------------------------

### Running tests on the created image

After tagging the image a `shell-local` provisioner step can be added to run a
testsuite using `serverspec`. After successful test run the image can be tagged
`latest` and pushed to the registry. This is currently broken as of packer 1.6.4
but should be fixed in packer 1.6.5.

### Installing puppet in a temporary volume instead of in the image

It should be possible to mount a volume to `/opt/puppetlabs` into which puppet
is installed so the puppet executables are not part of the finished image.
