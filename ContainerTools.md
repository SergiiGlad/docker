What many people don't know is that the container disconnects from the parent process. This is done so that the running containers don't die when the engine exits (Podman doesn't run as a daemon) or is restarted (CRI-O daemon, Docker Engine). There is utility that runs between podman and runc called conmon (Container Monitor). The connmon utility disconnects the container from the engine by doing a double fork(). That means, the execution chain looks something like this with Podman:
```
bash -> podman -> conmon -> conmon -> runc -> bash
```
Or like this with CRI-O:
```
systemd -> crio -> conmon -> conmon -> runc -> bash
```
Or like this with Docker engine:
```
systemd -> dockerd -> containerd -> docker-shim -> runc -> bash
```
The conmon utility and docker-shim both serve the same purpose. When the first conmon finishes calling the second, it exits. This disconnects the second conmon and all of its child processes from the container engine, podman. The secondary conmon is then inherited by init (systemd), the first process running on when the system boots. This simplified, daemonless model with podman can be quite useufl when wiring it into other larger systems, like CI/CD, scripts, etc.
