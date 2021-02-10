# Memo

## Testing the image

* Create test image by calling `build-ubuntu-python3.sh`.
* Run python3 using test image: `docker run -it jennerwein/ubuntu-python3:test`.
* Run ubuntu inside container: comment out `CMD [ "python3" ]` in docker file.
