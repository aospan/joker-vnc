#!/bin/bash

[ -z $VNCPASSWORD ] && { echo "specify -e VNCPASSWORD=secret"; exit 1;}

#cleanup tmp from previous run
rm -rf /tmp/.X*
rm -rf /tmp/.x*
rm -rf /tmp/ssh*

#set vncserver password
mkdir -p /home/appuser/.vnc 2>/dev/null
echo $VNCPASSWORD | vncpasswd -f > /home/appuser/.vnc/passwd 
chmod 0600 /home/appuser/.vnc/passwd

#vncserver startup script
cat >> /home/appuser/.vnc/xstartup  << 'EOF'
#!/bin/bash
xrdb /home/appuser/.Xresources
startxfce4 &
EOF
chmod +x /home/appuser/.vnc/xstartup

# suppress xfce panel message about first start
cp /etc/xdg/xfce4/panel/default.xml \
/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

echo "export DISPLAY=:1" > /home/appuser/.bashrc
chown -R appuser:appuser /home/appuser
#start vncserver with bigger resolution
su -c 'vncserver -geometry 1600x1200' appuser
su -c '/bin/bash' appuser
