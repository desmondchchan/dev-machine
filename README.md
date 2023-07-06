# dev-machine

## Install Ansible
```bash
sudo apt update
sudo apt install -y software-properties-common git
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
```

## Local
```bash
ANSIBLE_ASK_VAULT_PASS=True ansible-pull -U https://github.com/desmondchchan/dev-machine.git ansible/playbook.yml
```

## Docker
```bash
docker build . -t ${USERNAME}-dev:latest --build-arg USERNAME=${USERNAME} --build-arg UID=${UID} --build-arg GID=${GID} && docker run --rm -it ${USERNAME}-dev:latest -t all --ask-vault-password
```
