#!/bin/bash


<<task

Deploy Django app 
and handle the code for errors

task

code_clone(){
	echo "Cloning the Django app..."
	git clone https://github.com/LondheShubham153/django-notes-app.git
}

required_installments() {
	echo "Installing Dependencies.."
	sudo apt-get install docker.io nginx -y docker-compose

}

required_restarts() {
	sudo chown $USER /var/run/docker.sock 
	#sudo systemctl enable docker
	#sudo systemctl enable nginx
	sudo systemctl restart docker
}

deploy() {
	docker build -t notes-app .
	#docker-compose up -d
	docker run -d -p 8000:8000 notes-app:latest
}

echo "*************************DEPLOYMENT STARTED****************************"
if ! code_clone; then
	echo "The Code Directory already exists."
	cd django-notes-app
fi	
if ! required_installments; then
	echo"Installation Failed!!"
	exit 1
fi

if ! required_restarts; then
	echo " System fault identified"
	exit 1
fi	
if ! deploy; then
	echo "Deployment Failed, Mailing the Admin.."
	#send mail utility
	exit 1
fi

echo "***************************DEPLOYMENT DONE******************************"

