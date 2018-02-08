#!/bin/bash
echo `echo "{";gcloud compute instances list  | grep -v "STATUS"| awk '{printf "\"%s\"\:\{\"hosts\"\:[\"%s\"]},", $1,  $5 }'| sed s'/.$//';echo "}"`
