# Script

### Script Localstack
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

# Negar tráfego nas portas 80 e 443
aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 revoke-security-group-ingress --group-id $GRUPO_SEGURANCA_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 revoke-security-group-ingress --group-id $GRUPO_SEGURANCA_ID --protocol tcp --port 443 --cidr 0.0.0.0/0

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

# Conectar-se à instância e instalar o servidor web (Nginx)
echo "Aguardando a instância estar pronta para aceitar conexões SSH..."
aws --endpoint-url=$LOCALSTACK_ENDPOINT ec2 wait instance-status-ok --instance-ids $INSTANCIA_ID

echo "Conectando à instância e configurando o servidor web..."
ssh -i $NOME_CHAVE.pem ec2-user@$IP_PUBLICO <<EOF
sudo yum update -y
sudo amazon-linux-extras install -y nginx1.12
sudo systemctl start nginx
sudo systemctl enable nginx
EOF

echo "Servidor web Nginx instalado e configurado. Acesse http://$IP_PUBLICO:8080/ para verificar."

### 

# Script pela AWS
#!/bin/bash

# Variáveis
NOME_INSTANCIA="MinhaInstanciaWeb"
TIPO_INSTANCIA="t2.micro"
NOME_CHAVE="MinhaChaveSSH"
GRUPO_SEGURANCA="MeuGrupoDeSeguranca"
AMI_ID="ami-xxxxxxxxxxxxxxxxx"  # Substitua pelo ID da AMI desejada (por exemplo, Amazon Linux 2)

# Criar chave SSH
aws ec2 create-key-pair --key-name $NOME_CHAVE --query 'KeyMaterial' --output text > $NOME_CHAVE.pem
chmod 400 $NOME_CHAVE.pem

# Criar Security Group com regras
GRUPO_SEGURANCA_ID=$(aws ec2 create-security-group --group-name $GRUPO_SEGURANCA --description "Grupo de Segurança para Web Server" --vpc-id vpc-xxxxxxxx --query 'GroupId' --output text)

# Permitir tráfego na porta 8080
aws ec2 authorize-security-group-ingress --group-id $GRUPO_SEGURANCA_ID --protocol tcp --port 8080 --cidr 0.0.0.0/0

# Negar tráfego nas portas 80 e 443
aws ec2 revoke-security-group-ingress --group-id $GRUPO_SEGURANCA_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 revoke-security-group-ingress --group-id $GRUPO_SEGURANCA_ID --protocol tcp --port 443 --cidr 0.0.0.0/0

# Criar instância EC2
INSTANCIA_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $TIPO_INSTANCIA \
  --key-name $NOME_CHAVE \
  --security-group-ids $GRUPO_SEGURANCA_ID \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$NOME_INSTANCIA}]" \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "Instância EC2 criada com ID: $INSTANCIA_ID"

# Aguardar até que a instância esteja em execução
aws ec2 wait instance-running --instance-ids $INSTANCIA_ID

# Obter o endereço IP público da instância
IP_PUBLICO=$(aws ec2 describe-instances --instance-ids $INSTANCIA_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

echo "Endereço IP público da instância: $IP_PUBLICO"

# Conectar-se à instância e instalar o servidor web (Nginx)
echo "Aguardando a instância estar pronta para aceitar conexões SSH..."
aws ec2 wait instance-status-ok --instance-ids $INSTANCIA_ID

echo "Conectando à instância e configurando o servidor web..."
ssh -i $NOME_CHAVE.pem ec2-user@$IP_PUBLICO <<EOF
sudo yum update -y
sudo amazon-linux-extras install -y nginx1.12
sudo systemctl start nginx
sudo systemctl enable nginx
EOF

echo "Servidor web Nginx instalado e configurado. Acesse http://$IP_PUBLICO:8080/ para verificar."
