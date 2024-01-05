# Security group
Um Security Group (Grupo de Segurança) na Amazon Web Services (AWS) é um mecanismo fundamental para controlar o tráfego de entrada e saída de instâncias EC2 (Elastic Compute Cloud) em uma Virtual Private Cloud (VPC). É uma forma virtual de um firewall que determina quais tráfegos são permitidos ou negados para instâncias associadas a ele.

Principais características de um Security Group:

1. **Regras de Tráfego:** Um Security Group consiste em regras de tráfego que especificam o tipo de tráfego permitido. Cada regra define um intervalo de endereços IP de origem ou destino, um protocolo (por exemplo, TCP, UDP, ICMP) e uma porta ou intervalo de portas.

2. **Estado das Conexões:** As regras do Security Group são sempre "stateful", o que significa que, se você permitir o tráfego de entrada para uma porta específica, o tráfego de saída associado a essa comunicação é automaticamente permitido. O inverso também é verdadeiro.

3. **Padrão de Negar Tudo:** Por padrão, um Security Group nega todo o tráfego de entrada e permite todo o tráfego de saída. Isso implica que, se você quiser permitir que tráfego específico entre em suas instâncias EC2, precisará criar regras de entrada específicas para esses casos.

4. **Associação com Instâncias:** Os Security Groups são associados a instâncias EC2. Uma instância pode ter vários Security Groups associados a ela, e as regras dos diferentes Security Groups são cumulativas.

5. **Alterações Dinâmicas:** Você pode modificar as regras do Security Group a qualquer momento. As alterações são aplicadas quase que instantaneamente às instâncias associadas ao grupo.

6. **Sem Bloqueio de Saída:** As regras de saída de um Security Group são opcionais, e por padrão, todo o tráfego de saída é permitido. Isso significa que, a menos que você especifique regras de saída, todas as instâncias associadas ao Security Group podem se comunicar livremente com qualquer destino.

Security Groups fornecem uma camada crítica de segurança ao controlar o acesso de rede a instâncias EC2 na AWS. Ao configurar regras específicas, você pode restringir o tráfego apenas ao necessário, seguindo o princípio do menor privilégio, o que é uma prática recomendada em segurança.

Certamente, vou abordar alguns aspectos mais avançados relacionados aos Security Groups (Grupos de Segurança) na AWS:

## Adtional

### 1. **Referências para Outros Security Groups:**
Você pode referenciar outros Security Groups como origem ou destino em regras. Isso permite criar uma arquitetura mais dinâmica, onde as instâncias podem ser adicionadas ou removidas de um Security Group e as regras são automaticamente aplicadas.

Exemplo de uma regra de entrada permitindo tráfego de um Security Group específico:
```json
{
  "IpProtocol": "-1",
  "SourceSecurityGroupId": "sg-12345678",
  "GroupId": "sg-87654321"
}
```

### 2. **Security Groups na VPC Peering:**
Em cenários de Virtual Private Cloud (VPC) peering, você pode referenciar Security Groups de uma VPC em outra. Isso permite controlar o tráfego entre VPCs, garantindo que apenas o tráfego autorizado seja permitido.

### 3. **Elastic Load Balancer (ELB):**
Security Groups podem ser associados a Load Balancers (ELBs). Isso permite controlar o tráfego entre clientes e o Load Balancer, bem como entre o Load Balancer e as instâncias associadas.

### 4. **Limitações por Protocolo:**
Embora a maioria das instâncias EC2 use protocolos comuns como TCP, UDP, e ICMP, você também pode criar regras de Security Groups para outros protocolos específicos ou até mesmo para todos os protocolos (usando `-1` como número de protocolo).

Exemplo permitindo tráfego específico para um protocolo personalizado:
```json
{
  "IpProtocol": "50",
  "CidrIp": "0.0.0.0/0",
  "GroupId": "sg-12345678"
}
```

### 5. **Security Groups e Network ACLs (NACLs):**
Os Security Groups operam no nível da instância, enquanto as Network ACLs operam no nível da sub-rede. Ao criar regras em ambos, você pode implementar uma defesa em camadas para fortalecer a segurança da sua VPC.

### 6. **Regras Stateless:**
Embora as regras de Security Groups sejam normalmente stateful, você pode criar regras stateless usando a opção `--source-prefix-list` e especificando uma lista de prefixos de IP.

### 7. **Logging:**
Você pode habilitar o logging de tráfego dos Security Groups, o que registra informações detalhadas sobre as comunicações de rede. Os logs são enviados para o Amazon CloudWatch Logs, fornecendo uma trilha de auditoria para análise de segurança.

### 8. **Vínculo a Sub-redes e Instâncias EC2:**
Os Security Groups são vinculados a sub-redes e instâncias EC2. Quando você cria uma instância EC2 em uma sub-rede específica, ela herda automaticamente os Security Groups associados a essa sub-rede.

Esses aspectos avançados fornecem maior flexibilidade e controle sobre a segurança da sua infraestrutura na AWS, permitindo a implementação de estratégias avançadas de segurança e conectividade.

### Script

Certamente! Abaixo está um exemplo de script em bash que cria uma instância EC2 na AWS, configura um servidor web (Nginx) nela, e aplica regras de Security Group permitindo tráfego na porta 8080 e negando tráfego nas portas 80 e 443. Antes de executar o script, certifique-se de ter o AWS CLI instalado e configurado com as credenciais adequadas.

```bash
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
```

Este script cria um Security Group com regras permitindo tráfego na porta 8080 e negando tráfego nas portas 80 e 443. Em seguida, ele cria uma instância EC2 associada a esse grupo de segurança, instala o servidor web Nginx e exibe o endereço IP público da instância. Certifique-se de substituir os valores de `AMI_ID`, `vpc-xxxxxxxx`, etc., pelos valores apropriados para o seu ambiente.

### EC2 - SECURITY GROUP - COM LOCALSTACK ***

Para usar o LocalStack, um ambiente que simula serviços da AWS localmente, você precisará ajustar o script para usar o endpoint específico do LocalStack e algumas configurações adicionais. Aqui está um exemplo ajustado para funcionar com o LocalStack:

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
```

Certifique-se de substituir `vpc-xxxxxxxx` pelo ID da sua VPC no LocalStack. Este script usa o endpoint do LocalStack e ajusta os comandos para funcionar com a simulação local dos serviços da AWS. Certifique-se de que o LocalStack esteja em execução antes de executar este script.