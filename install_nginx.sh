#!/bin/bash
yum install nginx -y && service nginx start && sed -i "78iline <h1> WebServer - Terraform</h1>" /usr/share/nginx/html/index.html
chkconfig nginx on