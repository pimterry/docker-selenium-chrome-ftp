# docker-chrome-extension
Docker image for developing, building and testing Chrome extensions

This image provides:
* A Node.js environment (from the official Node docker box)
* Google Chrome (with xvfb)
* Selenium

Once running the image, run `start-selenium &` to start Chrome and the selenium server in an xvfb instance.
