#!/bin/sh

set -e
set -u

# Allow removing any certificate to any client
sed -i 's~name: "puppetlabs deny all"~\0\n        },\n        {\n            match-request: {\n                path: "/puppet-ca/v1/certificate_status"\n                type: path\n            }\n            allow-unauthenticated: true\n            sort-order: 400\n            name: "remove certificates"~' /etc/puppetlabs/puppetserver/conf.d/auth.conf
