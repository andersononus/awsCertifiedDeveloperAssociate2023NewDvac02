# README-04_EC2.md

## EC2

EC2 (Elastic Compute Cloud) é um serviço fundamental oferecido pela Amazon Web Services (AWS) que fornece capacidade computacional escalável na nuvem. EC2 permite que os usuários executem máquinas virtuais (também conhecidas como instâncias) em servidores físicos dedicados da AWS.

Instâncias EC2: São máquinas virtuais que você pode provisionar e executar na nuvem. As instâncias EC2 podem ser personalizadas com vários tipos de instância, que variam em termos de capacidade de CPU, memória, armazenamento e desempenho de rede.

Tipos de Instância: A AWS oferece uma variedade de tipos de instância otimizados para diferentes casos de uso, como computação de propósito geral, otimizada para CPU, otimizada para memória, armazenamento otimizado, entre outros.

Imagens AMI (Amazon Machine Image): Uma AMI é um pacote que contém uma imagem pré-configurada do sistema operacional e/ou do software que você deseja executar em suas instâncias EC2. Você pode usar AMIs padrão fornecidas pela AWS ou criar suas próprias AMIs personalizadas.

Regiões e Zonas de Disponibilidade: As instâncias EC2 podem ser implantadas em diferentes regiões da AWS, que são áreas geográficas isoladas, e em Zonas de Disponibilidade (AZs), que são data centers físicos separados dentro de uma região. Isso proporciona redundância e resiliência.

Elastic Load Balancing (ELB): O ELB é um serviço que distribui automaticamente o tráfego de entrada entre várias instâncias EC2 para melhorar a disponibilidade e a escalabilidade de aplicativos.

Auto Scaling: O Auto Scaling permite que você ajuste dinamicamente o número de instâncias EC2 em execução para atender às demandas do aplicativo, escalando automaticamente para cima ou para baixo com base em condições predefinidas.

Segurança e Redes: Você pode configurar grupos de segurança para controlar o tráfego de entrada e saída para suas instâncias, bem como configurar redes virtuais (VPCs) para isolar seus recursos na nuvem.

Elastic Block Store (EBS): É um serviço de armazenamento que fornece volumes de armazenamento persistente que podem ser anexados às instâncias EC2. EBS é frequentemente usado para armazenar dados que precisam persistir mesmo quando a instância é desligada.

EC2 é uma peça central para muitas soluções na AWS, permitindo que os usuários executem aplicativos, execute servidores web, hospede bancos de dados, realize análises de dados, e muito mais, de maneira flexível e escalável.

A Amazon EC2 oferece uma variedade de tipos de instância, cada um otimizado para diferentes casos de uso, proporcionando uma combinação única de capacidade de CPU, memória, armazenamento e desempenho de rede. Abaixo estão alguns dos tipos de instância mais comuns, categorizados com base em seus usos principais:

### https://aws.amazon.com/ec2/instance-types/

### 1. **Propósito Geral:**
   - **`t3`, `t4g`, `t3a`:** Instâncias de propósito geral com equilíbrio entre CPU, memória e armazenamento. Adequadas para uma variedade de cargas de trabalho.
   - **`m6g`, `m5`, `m5a`, `m5n`, `m5zn`:** Instâncias balanceadas para cargas de trabalho que exigem uma boa quantidade de memória.
   - **`a1`:** Baseada em ARM, oferece eficiência de custo para cargas de trabalho leves.

### 2. **Otimizado para CPU:**
   - **`c7g`, `c6g`, `c5`, `c5a`, `c5n`:** Instâncias otimizadas para cargas de trabalho intensivas em computação que requerem alta potência de CPU.
   - **`p4`, `p3`:** Instâncias com GPUs para cargas de trabalho de computação de alto desempenho (machine learning, processamento gráfico, etc.).
   - **`u6g`, `u6gd`, `u4g`:** Instâncias com ultrabook (u) otimizadas para armazenamento local de alta velocidade.

### 3. **Otimizado para Memória:**
   - **`x1e`, `x1`, `u-6tb1.metal`:** Instâncias otimizadas para memória, adequadas para bancos de dados em memória, análises de dados grandes, etc.
   - **`r7g`, `r6g`, `r5`, `r5a`, `r5n`, `r5zn`:** Instâncias otimizadas para memória, com uma boa relação entre CPU e memória.
   - **`z1d`:** Instâncias otimizadas para memória e armazenamento, ideais para bancos de dados em memória.

### 4. **Armazenamento Otimizado:**
   - **`i3`, `i3en`:** Instâncias otimizadas para I/O intensivo e armazenamento local de alta velocidade.
   - **`d3`, `h1`:** Instâncias otimizadas para armazenamento denso e cargas de trabalho de big data.

### 5. **Infraestrutura Local (Bare Metal):**
   - **`i3.metal`, `m5.metal`, `r5.metal`, `u-6tb1.metal`:** Oferece os recursos da instância física subjacente sem virtualização, adequado para cargas de trabalho que exigem acesso direto ao hardware.

Essa é apenas uma visão geral dos tipos de instância disponíveis na Amazon EC2. A AWS continua a lançar novos tipos de instância com o tempo para atender às necessidades específicas dos clientes. Ao escolher um tipo de instância, é importante considerar os requisitos de sua carga de trabalho, como CPU, memória, armazenamento, desempenho de rede e orçamento disponível.

# Comando

Certamente! Abaixo está um exemplo de um script em bash que utiliza o AWS CLI para criar uma instância EC2 e configurar um servidor web simples (Nginx) nela. Antes de executar o script, certifique-se de ter o AWS CLI instalado e configurado com as credenciais corretas.

```bash
#!/bin/bash

# Variáveis
NOME_INSTANCIA="MinhaInstanciaWeb"
TIPO_INSTANCIA="t2.micro"
NOME_CHAVE="MinhaChaveSSH"
GRUPO_SEGURANCA="MeuGrupoDeSeguranca"
AMI_ID="ami-xxxxxxxxxxxxxxxxx"  # Substitua pelo ID da AMI desejada (p. ex., Amazon Linux)

# Criar chave SSH
aws ec2 create-key-pair --key-name $NOME_CHAVE --query 'KeyMaterial' --output text > $NOME_CHAVE.pem
chmod 400 $NOME_CHAVE.pem

# Criar instância EC2
INSTANCIA_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $TIPO_INSTANCIA \
  --key-name $NOME_CHAVE \
  --security-groups $GRUPO_SEGURANCA \
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

echo "Servidor web Nginx instalado e configurado. Acesse http://$IP_PUBLICO/ para verificar."
```

Lembre-se de substituir os valores de `AMI_ID`, `GRUPO_SEGURANCA`, etc., pelos valores específicos do seu ambiente. Este script cria uma instância EC2, configura o servidor web Nginx nela e exibe o endereço IP público da instância. Certifique-se de que as portas apropriadas estejam abertas no grupo de segurança para permitir o acesso ao servidor web, se necessário.