gcloud compute instances create reddit-app4 \
--boot-disk-size=10GB \
--image-family=reddit-full \
--image-project=infra-193619 \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--zone=europe-west3-a \
--metadata "startup-script=cd /home/appuser/reddit && puma -d"
