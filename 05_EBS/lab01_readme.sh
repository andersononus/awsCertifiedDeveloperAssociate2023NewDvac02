#!/bin/bash

# Defina as variáveis
REGION="sua-regiao-aqui"  # substitua pela sua região, como us-east-1
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
VOLUME_SIZE=10  # tamanho do volume em GB
DEVICE="/dev/xvdf"  # dispositivo onde o volume será montado

# Crie um novo volume EBS
VOLUME_ID=$(aws ec2 create-volume --region $REGION --availability-zone ${REGION}a --size $VOLUME_SIZE --volume-type gp2 --output text --query 'VolumeId')

# Aguarde até que o volume esteja disponível
aws ec2 wait volume-available --region $REGION --volume-ids $VOLUME_ID

# Anexe o volume à instância EC2
aws ec2 attach-volume --region $REGION --volume-id $VOLUME_ID --instance-id $INSTANCE_ID --device $DEVICE

# Aguarde até que o volume esteja anexado
aws ec2 wait volume-in-use --region $REGION --volume-ids $VOLUME_ID

# Crie um sistema de arquivos (ext4 neste exemplo) no volume
sudo mkfs -t ext4 $DEVICE

# Crie um diretório para montar o volume
sudo mkdir /mnt/myvolume

# Monte o volume no diretório criado
sudo mount $DEVICE /mnt/myvolume
