#!/bin/bash

# Defina as variáveis
REGION="sua-regiao-aqui"  # substitua pela sua região, como us-east-1
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
DEVICE="/dev/xvdh"  # dispositivo onde o volume será montado
VOLUME_SIZE=10  # tamanho do volume em GB

# Função para criar e anexar um volume
criar_anexar_volume() {
    # Crie um novo volume EBS
    local VOLUME_ID=$(aws ec2 create-volume --region $REGION --availability-zone ${REGION}a --size $VOLUME_SIZE --volume-type gp2 --output text --query 'VolumeId')

    # Aguarde até que o volume esteja disponível
    aws ec2 wait volume-available --region $REGION --volume-ids $VOLUME_ID

    # Anexe o volume à instância EC2
    aws ec2 attach-volume --region $REGION --volume-id $VOLUME_ID --instance-id $INSTANCE_ID --device $DEVICE

    # Aguarde até que o volume esteja anexado
    aws ec2 wait volume-in-use --region $REGION --volume-ids $VOLUME_ID

    echo "Volume $VOLUME_ID anexado à instância $INSTANCE_ID no dispositivo $DEVICE."
}

# Função para desanexar e excluir um volume
desanexar_excluir_volume() {
    # Obtenha o ID do volume anexado à instância
    local VOLUME_ID=$(aws ec2 describe-volumes --region $REGION --filters Name=attachment.instance-id,Values=$INSTANCE_ID --query 'Volumes[0].VolumeId' --output text)

    # Desanexe o volume da instância
    aws ec2 detach-volume --region $REGION --volume-id $VOLUME_ID

    # Aguarde até que o volume esteja desanexado
    aws ec2 wait volume-available --region $REGION --volume-ids $VOLUME_ID

    # Exclua o volume
    aws ec2 delete-volume --region $REGION --volume-id $VOLUME_ID

    echo "Volume $VOLUME_ID desanexado e excluído."
}

# Executar as funções
criar_anexar_volume

# Aguarde um pouco (simulando algum trabalho sendo feito com o volume anexado)

desanexar_excluir_volume
