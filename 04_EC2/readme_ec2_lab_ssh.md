# Script EC2 lab ssh
Para permitir acesso SSH a uma instância EC2 no LocalStack, você precisará adicionar uma regra de ingresso ao Security Group que permite o tráfego SSH na porta 22. Aqui está um exemplo de script bash para criar uma instância EC2 no LocalStack e permitir acesso SSH a ela:

```bash
#!/bin/bash

# Variáveis
NOME_INSTANCIA="MinhaInstanciaWeb"
TIPO_INSTANCIA="t2.micro"
NOME_CHAVE="MinhaChaveSSH"
GRUPO_SEGURANCA="MeuGrupoDeSeguranca"
AMI_ID="ami-xxxxxxxxxxxxxxxxx"  # Substitua pelo ID da AMI desejada (por exemplo, Amazon Linux 2)
LOCALSTACK_ENDPOINT="http://localhost:4566"

# Criar chave SSH
aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 create-key-pair --key-name $NOME_CHAVE --query 'KeyMaterial' --output text > $NOME_CHAVE.pem
chmod 400 $NOME_CHAVE.pem

# Criar Security Group com regras
GRUPO_SEGURANCA_ID=$(aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 create-security-group --group-name $GRUPO_SEGURANCA --description "Grupo de Segurança para Web Server" --vpc-id vpc-xxxxxxxx --query 'GroupId' --output text)

# Permitir tráfego na porta 8080
aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 authorize-security-group-ingress --group-id $GRUPO_SEGURANCA_ID --protocol tcp --port 8080 --cidr 0.0.0.0/0

# Permitir tráfego SSH na porta 22
aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 authorize-security-group-ingress --group-id $GRUPO_SEGURANCA_ID --protocol tcp --port 22 --cidr 0.0.0.0/0

# Criar instância EC2
INSTANCIA_ID=$(aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $TIPO_INSTANCIA \
  --key-name $NOME_CHAVE \
  --security-group-ids $GRUPO_SEGURANCA_ID \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$NOME_INSTANCIA}]" \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "Instância EC2 criada com ID: $INSTANCIA_ID"

# Aguardar até que a instância esteja em execução
aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 wait instance-running --instance-ids $INSTANCIA_ID

# Obter o endereço IP público da instância
IP_PUBLICO=$(aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 describe-instances --instance-ids $INSTANCIA_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

echo "Endereço IP público da instância: $IP_PUBLICO"

# Conectar-se à instância via SSH
echo "Aguardando a instância estar pronta para aceitar conexões SSH..."
aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 wait instance-status-ok --instance-ids $INSTANCIA_ID

echo "Conectando à instância via SSH..."
ssh -i $NOME_CHAVE.pem ec2-user@$IP_PUBLICO

echo "Conexão SSH bem-sucedida!"
```

Este script ajusta as regras de ingresso do Security Group para permitir tráfego SSH (porta 22) e também inclui os comandos para aguardar até que a instância esteja pronta para aceitar conexões SSH antes de tentar a conexão SSH. Certifique-se de substituir `vpc-xxxxxxxx` pelo ID da sua VPC no LocalStack.


# Script pela AWS
Se você deseja conectar-se à instância EC2 no LocalStack usando o AWS CLI, pode usar o seguinte script:

```bash
#!/bin/bash

# Variáveis
NOME_INSTANCIA="MinhaInstanciaWeb"
NOME_CHAVE="MinhaChaveSSH"
LOCALSTACK_ENDPOINT="http://localhost:4566"

# Obter o ID da instância
INSTANCIA_ID=$(aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 describe-instances \
  --filters "Name=tag:Name,Values=$NOME_INSTANCIA" \
  --query 'Reservations[0].Instances[0].InstanceId' \
  --output text)

# Obter o endereço IP público da instância
IP_PUBLICO=$(aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 describe-instances \
  --instance-ids $INSTANCIA_ID \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

echo "Conectando à instância via SSH..."
ssh -i $NOME_CHAVE.pem ec2-user@$IP_PUBLICO

echo "Conexão SSH bem-sucedida!"
```

Este script usa o AWS CLI para obter o ID da instância EC2 com base no nome que você atribuiu a ela (`MinhaInstanciaWeb` no exemplo). Em seguida, obtém o endereço IP público da instância e usa a chave SSH (`MinhaChaveSSH.pem`) para se conectar à instância via SSH.

Certifique-se de substituir `MinhaInstanciaWeb` e `MinhaChaveSSH.pem` pelos valores reais que você está usando. Este script assume que você já tem uma instância em execução no LocalStack com o nome especificado e a chave SSH correspondente.