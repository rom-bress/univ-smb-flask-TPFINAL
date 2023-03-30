#!/bin/bash

# Secure root account
sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('passwordDbUniv01') WHERE User = 'root'"
# Create database
sudo mysql -e "CREATE DATABASE IF NOT EXISTS identity"
# Create database
sudo mysql -e "CREATE DATABASE IF NOT EXISTS config_generator"
# Create application account
sudo mysql -e "GRANT ALL ON *.* TO 'identity'@'localhost' IDENTIFIED BY 'passwordDbUniv01' WITH GRANT OPTION;"
# Create application account
sudo mysql -e "GRANT ALL ON *.* TO 'config_generator'@'localhost' IDENTIFIED BY 'passwordDbUniv01' WITH GRANT OPTION;"

#Création des tables dans identity

sudo mysql -e "CREATE identity.TABLE authentification (
                        id_a          INTEGRER       PRIMARY KEY,
                        username      VARCHAR(20)    not null,
                        password      VARCHAR(50)    not null
);"

sudo mysql -e "CREATE TABLE identity.profil (
                        id_p              INTEGRER       PRIMARY KEY,
                        Prénom            VARCHAR(20)    not null,
                        Nom               VARCHAR(20)    not null,
                        Date_Naissance    DATE           not null,
                        id_a              INTEGRER       not null,
                        FOREIGN KEY (id_a) REFERENCES CUSTOMERS (id_a)
);"


sudo mysql -e "CREATE TABLE config_generator.loadbalancer (
                        id_l              INTEGRER       PRIMARY KEY,
                        server            VARCHAR(100)   not null
);"

sudo mysql -e "CREATE TABLE config_generator.webserver (
                        id_w             INTEGRER        PRIMARY KEY,
                        server           VARCHAR(100)   not null,
                        id_l             INTEGRER       not null,
                        FOREIGN KEY (id_l) REFERENCES CUSTOMERS (id_l)
);"

sudo mysql -e "CREATE TABLE config_generator.reverseproxy (
                        id_l              INTEGRER       PRIMARY KEY,
                        server            VARCHAR(100)   not null
);"


# Make our changes take effect
sudo mysql -e "FLUSH PRIVILEGES"