#build
docker build -t aospan/joker-vnc .

#start VNC server inside docker container
docker run -it --name vnc -p 5901:5901 -e VNCPASSWORD=secret aospan/joker-vnc

now you can connect from remote client to this VNC server using any VNC client. For example:
vncviewer 192.168.1.98:1

#start X GUI apps after running VNC server
appuser@935a560dc96c:/$ xeyes
