# docker-selenium-chrome-ftp

For some tasks, such as file upload, or developing browser extensions, you need to have files available 
locally within the Selenium container. The best way to do that would be with shared volumes. This image 
exists to help solve this in some environments where that's not an option (e.g. Wercker, which automatically 
manages your containers, or environments where your containers are remote), where you can't easily share a volume
with your Selenium container.

It's based on the Selenium StandaloneChrome image, plus FTP setup and configuration.

This image provides:
* Google Chrome (with xvfb)
* Selenium
* An FTP server (to easily upload extensions with no shared filesystem)

To use it, run:

```
sudo docker pull pimterry/selenium-chrome-ftp
sudo docker run -p 4444:4444 -p 21:21 pimterry/selenium-chrome-ftp
```

You can then connect to the FTP server on port 21 locally, and Selenium on port 4444.

Files should be written into the /uploaded folder, which is available on the server at /var/ftp/uploaded.

Note that the FTP server allows full anonymous access for reading and uploading (within a chroot in the
container). This is fine for local development, but is a reasonable security risk otherwise. Do not expose
this to the internet!
