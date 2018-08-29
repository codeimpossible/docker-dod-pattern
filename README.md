# Docker Orchestrating Docker Pattern Example

This project is an example of how to share data between containers when using the "Docker Orchestrating Docker (DOD)" pattern.

This project is setup to mimic a build system where one container executes a process/flow by launching other containers to perform certain tasks.

## Container structure

This project defines 3 containers: Main, SubContainerOne, and SubContainerTwo. This project also creates 3 volumes that are shared between the containers:

- vol_out: used by the containers to store/share files during the process.
- vol_dockerfiles: contains the dockerfiles in the project
- vol_scripts: contains the scripts in the project

The containers are launched in a "heirarchy" (not really, but it helps to visualize it that way) which roughly looks like this:

```
- Main.dockerfile
 |_ SubContainerOne.dockerfile
   |_ SubContainerTwo.dockerfile
```

- Main: creates a file with "hello" in the output volume
- SubContainerOne: creates a file with "hello from SubContainerOne" in the output volume and displays the contents of the output volume
- SubContainerTwo: lists the contents of the scripts, dockerfiles and output volumes, then displays the contents of the two files generated by the other containers