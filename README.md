# Node.js Weight Tracker with <img height="40px" src="https://user-images.githubusercontent.com/83014719/141646019-0eefacfd-8315-4fde-a667-6d7aa3aa12e1.PNG"> & <img height="50px" src="https://www.vectorlogo.zone/logos/docker/docker-ar21.svg">

[![Build Status](https://dev.azure.com/parennut/Weight-Tracker-CICD/_apis/build/status/renatts.WeightTracker-Docker?branchName=master)](https://dev.azure.com/parennut/Weight-Tracker-CICD/_build/latest?definitionId=4&branchName=master)

##  Infrastructure requirements
<img width="550" alt="docker-cicd" src="https://user-images.githubusercontent.com/83014719/141643377-fd22a44c-e852-45a5-b4d5-7a2380c4f6a9.png">

### Create the environments infrastructure using ![Terraform Repository](https://github.com/renatts/Terraform-Multiple-Environments)

###  Install Docker to all virtual machines using this commands
* `sudo apt-get update`
* `sudo apt-get upgrade`
* `sudo apt install docker.io`
* `systemctl start docker`
* `systemctl enable docker`
* `docker --version` - for checking docker version on virtual machine

### Give docker necessary permissions
* `sudo usermod -a -G docker $USER`
* `sudo reboot`

---
##  CI/CD pipeline requirements
<img width="550" alt="docker-cicd" src="https://user-images.githubusercontent.com/83014719/141643375-c23675c0-72ac-4eb4-94c5-9703763a38f9.png">

### Part I
* Create `azure-pipelines.yaml` file
* Create stages: `Build, Deploy to Staging, Deploy to Production` 
* On stage `Build` add `Push` task for pushing the build to [ACR](https://azure.microsoft.com/en-us/services/container-registry/#overview) (Azure Container Registry) repository.
* On Deploy stages add `Pull` task for pulling the latest pushed image from [ACR](https://azure.microsoft.com/en-us/services/container-registry/#overview) repository.
* Create variables group for each environment in Library.
* Run the containers by using `docker run -d --restart=always --name weighttracker -p 8080:8080 -e <your-environment-variables> $(containerRegistry)/$(imageRepository):$(tag)`

### Part II
* In your `azure-pipelines.yaml` file add a condition for triggering the Deploy stages only from `master` branch.
* Create branch with `feature/` prefix.
* Unlike `master` branch, the `feature` branch must trigger only the CI (Build and Push).
* Create branch policy to not be able to push changes into the `master` branch.
* Run your pipeline on `feature/*` branch.
* Check your pipeline (must skip the deployment stages).
* Create pull request from `feature/*` branch to `master`, and approve the request after it.
* Check your CI/CD pipeline (must be triggered after accepting the pull request).
* Check if your pipeline has succeeded.

<img width="550" alt="docker-cicd" src="https://user-images.githubusercontent.com/83014719/141645085-6063daa6-8e25-46d0-96d8-46ecda3fa2de.png">
