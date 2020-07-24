#!/bin/bash

export domain_name=localhost
export account_id=300674751221
export region=us-west-1
export acs_repository_tag=1
export nginx_acs_tag=1

usage() {
    echo "Usage: $0 [-h] [-d NAM] [-i ACC] [-r REG] [-a TAG] [-n TAG] -- OPTS"
    echo "  -h      Print this usage message"
    echo "  -d NAM  DNS name pointing to the Alfresco service (default: $domain_name)"
    echo "            More precisely, it's the name pointing to the NGINX side-car proxy"
    echo "  -i ACC  AWS account id (default: $account_id)"
    echo "  -r REG  AWS region (default: $region)"
    echo "  -a TAG  Tag to use for the acs-repository Docker image (default: $acs_repository_tag)"
    echo "  -n TAG  Tag to use for the nginx-acs Docker image (default: $nginx_acs_tag)"
    echo "  --      Stop parsing options; necessary only if you have pre-command options"
    echo "  OPTS    Docker-compose options"
    echo
    echo "Example: $0 up --build"
}

finished_parsing=no
while [ $finished_parsing == no ]; do
    case "$1" in
        -h)
            usage
            exit 0
            ;;
        -i)
            shift
            account_id="$1"
            shift
            ;;
        -r)
            shift
            region="$1"
            shift
            ;;
        -a)
            shift
            acs_repository_tag="$1"
            shift
            ;;
        -n)
            shift
            nginx_acs_tag="$1"
            shift
            ;;
        --)
            shift
            finished_parsing=yes
            ;;
        *)
            finished_parsing=yes
            ;;
    esac
done

docker-compose $@