# spring-docker

Projeto spring boot com postgres rodando em docker

Para o rodar o projeto usar o comando:

```
docker compose up
```

Para o montar uma imagem do projeto usar o comando:

```
docker build -t spring-postgres:latest .
```

Para gerar a infra na AWS

1. Criar um AMI na AWS
2. Instalar o AWS CLI
3. Configurar o provider

```
aws configure --profile seu_profile
```

4.Instalar o Terraform
5.Subir a infra na AWS com o Terraform

```
cd ./deploy/terraform
terraform apply --auto-approve
```
