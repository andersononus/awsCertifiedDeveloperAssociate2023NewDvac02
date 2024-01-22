#!/bin/bash

# Configurações iniciais
REGION="sua-regiao-aqui"  # substitua pela sua região, como us-east-1
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
DEVICE="/dev/xvdf"  # dispositivo onde o volume será montado
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

# Função para copiar o volume para outra AZ
copiar_volume_outra_az() {
    # Crie um snapshot do volume atual
    local SNAPSHOT_ID=$(aws ec2 create-snapshot --region $REGION --volume-id $VOLUME_ID --output text --query 'SnapshotId')

    # Aguarde até que o snapshot esteja disponível
    aws ec2 wait snapshot-completed --region $REGION --snapshot-ids $SNAPSHOT_ID

    # Crie um novo volume a partir do snapshot em outra AZ
    local NEW_VOLUME_ID=$(aws ec2 create-volume --region $REGION --availability-zone ${REGION}b --snapshot-id $SNAPSHOT_ID --output text --query 'VolumeId')

    # Aguarde até que o novo volume esteja disponível
    aws ec2 wait volume-available --region $REGION --volume-ids $NEW_VOLUME_ID

    echo "Volume copiado para outra AZ: $NEW_VOLUME_ID"
}

# Função para excluir um volume
excluir_volume() {
    # Desanexe o volume da instância
    aws ec2 detach-volume --region $REGION --volume-id $VOLUME_ID

    # Aguarde até que o volume esteja desanexado
    aws ec2 wait volume-available --region $REGION --volume-ids $VOLUME_ID

    # Exclua o volume
    aws ec2 delete-volume --region $REGION --volume-id $VOLUME_ID

    echo "Volume $VOLUME_ID excluído."
}

# Função para recuperar um volume a partir do snapshot
recuperar_volume() {
    # Crie um novo volume a partir do snapshot
    local RESTORED_VOLUME_ID=$(aws ec2 create-volume --region $REGION --availability-zone ${REGION}a --snapshot-id $SNAPSHOT_ID --output text --query 'VolumeId')

    # Aguarde até que o volume restaurado esteja disponível
    aws ec2 wait volume-available --region $REGION --volume-ids $RESTORED_VOLUME_ID

    echo "Volume restaurado a partir do snapshot: $RESTORED_VOLUME_ID"
}

# Executar as funções
criar_anexar_volume
copiar_volume_outra_az
excluir_volume
recuperar_volume
