# dev-machine

```bash
docker build . -t ${USERNAME}-dev:latest --build-arg USERNAME=${USERNAME} --build-arg UID=${UID} --build-arg GID=${GID} && docker run --rm -it ${USERNAME}-dev:latest -t all --ask-vault-password
```
