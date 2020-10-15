base:
	./bin/packer.sh build -var imageVersion="$(shell ./bin/config_version.sh .)" -var-file packer/base-ubuntu2004.vars.json packer/base-template.json

apache-base:
	./bin/packer.sh build -var imageVersion="$(shell ./bin/config_version.sh .)" -var-file packer/apache-base-ubuntu2004.vars.json packer/apache-template.json

php-fpm:
	./bin/packer.sh build -var imageVersion="$(shell ./bin/config_version.sh .)" -var-file packer/php-fpm-ubuntu2004.vars.json packer/php-fpm-template.json

mariadb-base:
	./bin/packer.sh build -var imageVersion="$(shell ./bin/config_version.sh .)" -var-file packer/mariadb-base-ubuntu2004.vars.json packer/mysql-template.json

demo-app1-apache:
	./bin/packer.sh build -var imageVersion="$(shell ./bin/config_version.sh .)" -var-file packer/demo-app1-apache.vars.json packer/apache-template.json

demo-db:
	./bin/packer.sh build -var imageVersion="$(shell ./bin/config_version.sh .)" -var-file packer/demo-db.vars.json packer/mysql-template.json

.PHONY: base apache-base php-fpm mariadb-base demo-app1-apache demo-db
