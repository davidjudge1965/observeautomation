## Pull the latest Ubuntu 24.04.3 ISO into PVE's ISO store
To install the VM that will host my docker containers, I need an operating system uploaded into Proxmox as an ISO file.

While I can download the ISO onto my PC and the upload it to Proxmox's ISO store, I find it easier to ask Proxmox to perform the download.

First I need the URL for the ISO that I want.  This can be found in releases.ubuntu.com.  Here is the page for version 24.04.3:

![alt text](<assets/Ubuntu Releases page for 24.04.3.jpg>)

I have decided to go for the Server Install Image.  I capture the URL by right-clicking on on the link and select "Copy Link Address".

Now I can navigate back to Proxmox's UI and select the "local" store, then ISO Images and click on Download From Url where I can paste the URL I just copied:

![alt text](<assets/Download From URL.jpg>)

Click on the "Query URL button and the Filename Field gets appropriately set:

![alt text](<assets/Download From URL with Filename Completed.jpg>)

Lastly, click on Download to get Proxmox to retrieve the file from the Ubuntu servers.

![alt text](<assets/ISO Downloading part 1.jpg>)

Eventually you will see the last message "TASK OK" which confirms the download was successful:

![alt text](<assets/ISO _Download.jpg>)

You are now ready to create the VM.

## Create the VM and install the requisite packages for Docker
Again, there are many tutorials telling you how to create a VM on Proxmox - Indeed I have one to show you how to use CloudInit to create VMs.

The more specific part is installing Docker and the other bits I like to have installed on a system.

In true [Blue Peter](https://en.wikipedia.org/wiki/Blue_Peter) fashion, I'm going to go straight to the created VM... "*Here's one I made earlier*" as the Blue Peter presenters would say.


I will want to install in the VM a variety of tools/etc. other than the ones I need for docker.  Some of these are:
* vim
* net-tools
* htop
* qemu-guest-agent