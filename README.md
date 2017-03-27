
### Purpose

This repository presents a solution to deploy in production [Vapor](https://vapor.codes/) with OpenShift and S2I which allow to build from a git.  

### What you need installed ?

- Docker 
- S2I
- Swift / Docker

#### Create S2I image 

```shell 
  s2i create <imageName> <destination> 
```
#### Create the builder image
The following command will create a builder image named vapor_Image based on the Dockerfile that was created previously.
```
docker build -t vapor_Image .
```
The builder image can also be created by using the *make* command since a *Makefile* is included.

Once the image has finished building, the command *s2i usage vapor_Image* will print out the help info that was defined in the *usage* script.

#### Creating the application image
The application image combines the builder image with your applications source code, which is served using whatever application is installed via the *Dockerfile*, compiled using the *assemble* script, and run using the *run* script.
The following command will create the application image:
```
s2i build **file or git ** **dockerImage** **applicationImage** 
for proxy use -e to add environnement variable
---> Building and installing application from source...
```
Using the logic defined in the *assemble* script, s2i will now create an application image using the builder image as a base and including the source code from the test/test-app directory. 

#### Running the application image
Running the application image is as simple as invoking the docker run command:
```
docker run -it --rm **imageName** /bin/bash
```
