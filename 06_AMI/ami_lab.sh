#Exemplo básico de como você pode criar uma instância EC2 usando a AWS CLI, lançar um servidor HTTP (Nginx, neste caso) e, em seguida, criar uma AMI a partir dessa instância.

### Passo 1: Criar uma Instância EC2 com servidor HTTP (Nginx)

```bash
# Criar uma instância EC2 usando a AMI do Amazon Linux
aws ec2 run-instances \
  --image-id ami-xxxxxxxxxxxxxxxxx \  # Substituir pelo ID da AMI do Amazon Linux
  --instance-type t2.micro \
  --key-name SuaChaveSSH \
  --security-group-ids SeuGrupoDeSeguranca \
  --user-data "#!/bin/bash
              yum update -y
              yum install -y nginx
              service nginx start
              chkconfig nginx on"

# Aguarde a instância estar em execução antes de prosseguir
aws ec2 wait instance-running
```

### Passo 2: Acesse a Instância e Verifique o Nginx

```bash
# Obter o ID da instância
INSTANCE_ID=$(aws ec2 describe-instances --query 'Reservations[0].Instances[0].InstanceId' --output text)

# Obter o endereço IP público da instância
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

# Conectar-se à instância via SSH
ssh -i SuaChaveSSH.pem ec2-user@$PUBLIC_IP

# Dentro da instância, verifique se o Nginx está em execução
sudo service nginx status
```

### Passo 3: Criar uma AMI a partir da Instância

```bash
# Criar uma AMI a partir da instância
aws ec2 create-image \
  --instance-id $INSTANCE_ID \
  --name "MyNginxServer-AMI" \
  --description "AMI with Nginx Server" \
  --no-reboot

# Aguarde a criação da AMI
aws ec2 wait image-available --image-ids SeuIDdaAMI

# Limpeza: Terminar a instância (opcional, dependendo dos seus requisitos)
aws ec2 terminate-instances --instance-ids $INSTANCE_ID
```

Este script utiliza a opção `user-data` para executar um script de inicialização na instância, que instala e inicia o servidor Nginx. Lembre-se de substituir `ami-xxxxxxxxxxxxxxxxx`, `SuaChaveSSH` e `SeuGrupoDeSeguranca` pelos valores reais correspondentes à sua configuração.

Certifique-se de entender as implicações de segurança ao usar `user-data` e ajuste conforme necessário para atender aos seus requisitos específicos.