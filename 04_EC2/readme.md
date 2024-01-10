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

# EC2 Intances Purchasing Options

Amazon EC2 (Elastic Compute Cloud) oferece várias opções de compra para instâncias, permitindo que os usuários escolham o modelo de precificação mais adequado às suas necessidades e orçamento. Aqui estão as principais opções de compra de instâncias EC2:

### 1. **On-Demand Instances:**
   - **Descrição:** Instâncias sob demanda permitem que você pague por capacidade computacional sem compromisso de longo prazo.
   - **Ideal para:** Cargas de trabalho com uso imprevisível ou curtos períodos de atividade.

   On-Demand Instances são instâncias EC2 (Elastic Compute Cloud) que são provisionadas e cobradas com base na demanda, sem a necessidade de compromissos de longo prazo ou contratos. Essas instâncias oferecem uma opção flexível e escalável, onde você paga apenas pelo tempo que a instância estiver em execução.

Aqui estão algumas características-chave das On-Demand Instances:

1. **Sem Compromisso a Longo Prazo:**
   - As On-Demand Instances não requerem nenhum compromisso de uso a longo prazo ou contrato. Você pode iniciar e encerrar as instâncias conforme necessário, pagando apenas pelo tempo em que estão em execução.

2. **Escalabilidade Instantânea:**
   - As instâncias podem ser provisionadas instantaneamente e escaladas para cima ou para baixo de acordo com a demanda da carga de trabalho.

3. **Preços Por Hora ou Por Segundo:**
   - As On-Demand Instances são geralmente faturadas por hora, mas algumas instâncias permitem uma opção de faturamento por segundo após os primeiros minutos.

4. **Diversidade de Tipos de Instância:**
   - Você pode escolher entre uma ampla variedade de tipos de instância para atender às necessidades específicas da sua carga de trabalho, incluindo instâncias otimizadas para CPU, memória, armazenamento e outros requisitos.

5. **Flexibilidade de Plataforma e Sistema Operacional:**
   - On-Demand Instances suportam uma variedade de sistemas operacionais e plataformas, permitindo que você execute diferentes tipos de aplicativos e serviços.

6. **Sob Demanda e Sob Demanda Spot:**
   - Ao usar instâncias sob demanda, você tem a flexibilidade de utilizar On-Demand Instances ou Spot Instances, dependendo das suas necessidades e preferências.

7. **Ideal para Cargas de Trabalho Variáveis ou Intermitentes:**
   - On-Demand Instances são ideais para cargas de trabalho com padrões de uso variáveis, intermitentes ou imprevisíveis, onde a flexibilidade de pagar conforme o uso é vantajosa.

8. **Pagamento Pós Uso:**
   - A cobrança das On-Demand Instances é realizada após o uso, com base no tempo de execução das instâncias.

Essas instâncias são recomendadas para cargas de trabalho que não podem prever ou planejar antecipadamente a capacidade necessária. No entanto, para cargas de trabalho mais consistentes e previsíveis, outras opções de compra, como Reserved Instances ou Savings Plans, podem oferecer economias significativas.

### 2. **Reserved Instances (RIs):**
   - **Descrição:** Reservas de capacidade por um período de 1 ou 3 anos, oferecendo significativos descontos em comparação com instâncias sob demanda.
   - **Ideal para:** Aplicações com uso consistente e previsível que podem se comprometer com um contrato de longo prazo.
   Reserved Instances (RIs) na Amazon Web Services (AWS) são uma opção de compra de instâncias EC2 (Elastic Compute Cloud) que oferece descontos substanciais em comparação com instâncias On-Demand, em troca de um compromisso de longo prazo. Ao comprar RIs, você compromete-se a um contrato de 1 ou 3 anos para utilizar uma capacidade específica em uma ou mais zonas de disponibilidade.

Aqui estão algumas características-chave das Reserved Instances:

1. **Descontos Significativos:**
   - As RIs oferecem descontos significativos em relação às instâncias On-Demand. Quanto maior o compromisso de tempo (1 ou 3 anos), maior o desconto.

2. **Termos de Pagamento:**
   - RIs podem ser pagas upfront (um pagamento único) ou com termos de pagamento mensais (mais caro ao longo do tempo, mas menos capital inicial). O pagamento upfront resulta em descontos maiores.

3. **Flexibilidade de Configuração:**
   - RIs oferecem flexibilidade em termos de configuração, permitindo que você escolha o tipo de instância, a família, a plataforma (Linux/Windows), a zona de disponibilidade e o prazo de compromisso.

4. **Reservas Padrão e Convertíveis:**
   - Existem dois tipos de RIs: Padrão e Convertíveis. As Padrão oferecem os maiores descontos, mas não podem ser alteradas durante o período de compromisso. As Convertíveis oferecem flexibilidade para alterar a família de instâncias, o sistema operacional, a zona de disponibilidade ou o tipo de pagamento.

5. **Acesso Garantido à Capacidade:**
   - Ao adquirir RIs, você garante acesso à capacidade reservada, o que é útil em cenários em que a capacidade pode ser limitada.

6. **Aplicável a Várias Instâncias:**
   - RIs podem ser aplicadas a várias instâncias dentro da mesma família de instâncias e na mesma região, oferecendo uma maneira eficiente de economizar em instâncias semelhantes.

7. **Automática Aplicação de Descontos:**
   - Ao lançar instâncias que correspondem às características da RI, a AWS automaticamente aplica os descontos da RI, reduzindo os custos associados.

8. **Ideal para Cargas de Trabalho Consistentes:**
   - RIs são ideais para cargas de trabalho com uso consistente e previsível, onde o compromisso de longo prazo resulta em economias significativas.

9. **Possibilidade de Venda no Mercado de Reservas (RI Marketplace):**
   - Caso você não precise mais de uma RI, é possível vender RIs não utilizadas no mercado de Reservas da AWS.

A escolha entre RIs e outras opções de compra, como On-Demand Instances ou Spot Instances, depende das características e requisitos específicos da sua carga de trabalho e orçamento.

### 3. **Spot Instances:**
   - **Descrição:** Permitem que você compre capacidade de instância não utilizada com descontos significativos em relação às instâncias sob demanda. No entanto, podem ser encerradas se a capacidade for necessária para instâncias sob demanda.
   - **Ideal para:** Cargas de trabalho tolerantes a interrupções e que podem ser executadas durante períodos de capacidade excedente.

### 4. **Dedicated Hosts:**
   - **Descrição:** Fornecem instâncias em um servidor físico dedicado, o que pode ser necessário para conformidade ou licenciamento.
   - **Ideal para:** Cargas de trabalho que exigem controle total sobre o ambiente de hardware.
   Dedicated Hosts na Amazon Web Services (AWS) são servidores físicos dedicados que são totalmente dedicados a uma única conta da AWS. Isso significa que você tem controle total sobre o ambiente de hardware da instância, incluindo a capacidade de escolher a família do processador, o tipo de instância e a zona de disponibilidade na qual o host está localizado.

Aqui estão algumas características-chave dos Dedicated Hosts:

1. **Isolamento de Hardware:**
   - Dedicated Hosts fornecem um nível mais alto de isolamento de hardware em comparação com instâncias em um ambiente compartilhado. Você tem controle total sobre o hardware subjacente.

2. **Escolha de Família de Processador:**
   - Ao usar Dedicated Hosts, você pode escolher a família de processadores específica que atende aos requisitos da sua carga de trabalho.

3. **Escolha de Tipo de Instância:**
   - Você tem a flexibilidade de escolher o tipo de instância que será executado no Dedicated Host, permitindo atender a requisitos específicos de CPU, memória e armazenamento.

4. **Controle de Licenciamento:**
   - Para cargas de trabalho que requerem licenciamento específico de software (por exemplo, licenciamento por soquete), Dedicated Hosts oferecem maior controle sobre o licenciamento.

5. **Zonas de Disponibilidade e Reservas:**
   - Você pode reservar Dedicated Hosts em uma zona de disponibilidade específica, proporcionando consistência na localização física.

6. **Ideal para Requisitos de Segurança e Conformidade:**
   - Dedicated Hosts são frequentemente escolhidos por clientes com requisitos rigorosos de segurança e conformidade, que precisam garantir isolamento de hardware dedicado.

7. **Controle Total sobre o Uso de Recursos:**
   - Com Dedicated Hosts, você tem controle total sobre como os recursos do host são usados. Você pode decidir quais instâncias são colocadas em um host específico.

8. **Economias Potenciais:**
   - Para cargas de trabalho que são constantes e previsíveis, Dedicated Hosts podem oferecer economias em comparação com instâncias sob demanda padrão.

9. **Visibilidade de Uso e Alocação:**
   - A AWS fornece visibilidade sobre o uso e a alocação de recursos nos Dedicated Hosts, permitindo monitoramento detalhado.

É importante notar que o uso de Dedicated Hosts pode envolver custos adicionais em comparação com instâncias padrão sob demanda. Essa opção é mais adequada para casos de uso específicos nos quais o controle total sobre o ambiente de hardware é fundamental.

### 5. **Dedicated Instances:**
   - **Descrição:** Similar aos Dedicated Hosts, mas oferece instâncias em hardware dedicado sem o controle direto sobre a alocação de hosts.
   - **Ideal para:** Cargas de trabalho que exigem isolamento de hardware, mas não exigem controle total.
   As Dedicated Instances são uma opção de compra de instâncias EC2 na Amazon Web Services (AWS) que fornecem um nível mais alto de isolamento físico em comparação com instâncias padrão sob demanda. Essa opção é destinada a clientes que precisam de isolamento adicional para atender a requisitos de segurança e conformidade, mas não necessariamente exigem um host dedicado exclusivo.

Aqui estão algumas características-chave das Dedicated Instances:

1. **Isolamento de Hardware:**
   - As Dedicated Instances fornecem isolamento físico de outras instâncias em um ambiente compartilhado, garantindo que apenas as instâncias do mesmo proprietário compartilhem o hardware subjacente.

2. **Escolha de Tipo de Instância:**
   - Você tem a flexibilidade de escolher o tipo de instância que atende aos requisitos específicos da sua carga de trabalho.

3. **Zonas de Disponibilidade:**
   - Assim como as instâncias padrão, as Dedicated Instances podem ser lançadas em qualquer zona de disponibilidade suportada pela região.

4. **Controle sobre o Licenciamento:**
   - Para cargas de trabalho que requerem licenciamento específico de software, as Dedicated Instances oferecem maior controle sobre o licenciamento.

5. **Requisitos de Segurança e Conformidade:**
   - As Dedicated Instances são frequentemente escolhidas por organizações que têm requisitos rigorosos de segurança e conformidade, fornecendo um nível adicional de isolamento.

6. **Visibilidade e Controle de Recursos:**
   - Embora as Dedicated Instances compartilhem hardware com outras instâncias do mesmo proprietário, você tem visibilidade e controle sobre quais instâncias compartilham o hardware.

7. **Economias Potenciais:**
   - Em alguns casos, dependendo dos requisitos de segurança e do uso, as Dedicated Instances podem oferecer economias em comparação com outras opções de isolamento físico mais granular.

É importante notar que, diferentemente dos Dedicated Hosts, que oferecem um host físico dedicado exclusivo, as Dedicated Instances compartilham o hardware com outras instâncias do mesmo proprietário. Isso proporciona um nível mais alto de isolamento do que as instâncias padrão, mas não tanto quanto um host dedicado exclusivo. A escolha entre Dedicated Instances, Dedicated Hosts e outras opções de compra depende dos requisitos específicos de segurança, conformidade e desempenho da sua carga de trabalho.

### 6. **Capacity Reservations:**
   - **Descrição:** Reserva capacidade para instâncias em uma zona de disponibilidade específica, garantindo que você sempre tenha a capacidade necessária.
   - **Ideal para:** Cargas de trabalho que exigem capacidade dedicada em uma zona de disponibilidade específica.
   Capacity Reservations na Amazon Web Services (AWS) são uma opção que permite que você reserve capacidade em instâncias EC2 em uma zona de disponibilidade específica. Isso garante que você sempre terá a capacidade necessária para atender aos requisitos da sua carga de trabalho, mesmo em períodos de alta demanda.

Aqui estão algumas características-chave das Capacity Reservations:

1. **Reserva de Capacidade Específica:**
   - Ao criar uma Capacity Reservation, você está reservando uma capacidade específica para instâncias EC2 em uma zona de disponibilidade designada.

2. **Flexibilidade de Tipo de Instância:**
   - Você pode escolher o tipo de instância e a família que melhor atende aos requisitos da sua carga de trabalho ao criar uma Capacity Reservation.

3. **Reservas Padrão e Convertíveis:**
   - Similar às Reserved Instances (RIs), existem dois tipos de Capacity Reservations: Padrão e Convertíveis. As Padrão oferecem descontos maiores, mas não podem ser alteradas durante o período de compromisso. As Convertíveis oferecem flexibilidade para alterar a família de instâncias, o sistema operacional ou a zona de disponibilidade.

4. **Acesso Garantido à Capacidade:**
   - A Capacity Reservation garante acesso à capacidade reservada em momentos de alta demanda, evitando a possibilidade de falta de capacidade.

5. **Compatibilidade com On-Demand e RIs:**
   - As instâncias lançadas em uma Capacity Reservation podem ser cobradas de acordo com a tabela de preços On-Demand ou beneficiar-se de descontos associados a Reserved Instances, dependendo da sua configuração e utilização.

6. **Distribuição de Reservas:**
   - É possível distribuir uma Capacity Reservation em várias instâncias para atender a diferentes requisitos de carga de trabalho.

7. **Aplicação Manual ou Automática:**
   - As Capacity Reservations podem ser aplicadas manualmente ou automaticamente por meio de grupos de Auto Scaling para garantir que novas instâncias sejam lançadas em capacidade reservada.

8. **Monitoramento e Visibilidade:**
   - A AWS fornece visibilidade em tempo real do uso de Capacity Reservations por meio de métricas e dashboards.

As Capacity Reservations são adequadas para cargas de trabalho que têm requisitos de capacidade específicos e previsíveis em determinadas zonas de disponibilidade. Essa opção oferece flexibilidade e controle, permitindo que você adapte a reserva de capacidade às necessidades dinâmicas da sua carga de trabalho.


### 7. **Savings Plans:**
   - **Descrição:** Oferece economias significativas em comparação com instâncias sob demanda, em troca de um compromisso de uso consistente em dólares por hora (USD/h) por um período de 1 ou 3 anos.
   - **Ideal para:** Cargas de trabalho com uso consistente, mas com padrões de uso variáveis.
   Savings Plans na Amazon Web Services (AWS) são uma opção de compra flexível que oferece descontos significativos em comparação com instâncias sob demanda padrão, em troca de um compromisso de uso consistente em dólares por hora (USD/h). Os Savings Plans fornecem uma maneira simplificada de economizar em custos de computação, permitindo flexibilidade em termos de instâncias e regiões.

Aqui estão algumas características-chave dos Savings Plans:

1. **Descontos Flexíveis:**
   - Os Savings Plans oferecem descontos significativos em relação às instâncias sob demanda. Os descontos são aplicados em dólares por hora (USD/h) e dependem do compromisso de uso.

2. **Modelo de Precificação Simples:**
   - Ao contrário de Reserved Instances (RIs), que exigem decisões complexas sobre tipo de instância, família e zona de disponibilidade, os Savings Plans são mais simples, exigindo apenas que você escolha entre Compute Savings Plans (para instâncias EC2) ou EC2 Instance Savings Plans (para instâncias específicas).

3. **Flexibilidade de Instâncias e Regiões:**
   - Com Savings Plans, você tem flexibilidade para usar instâncias em qualquer família, tamanho, zona de disponibilidade ou região, proporcionando maior liberdade em comparação com Reserved Instances.

4. **Escolha entre Compute Savings Plans e EC2 Instance Savings Plans:**
   - Compute Savings Plans oferecem descontos automáticos em qualquer instância EC2 em uma região, enquanto EC2 Instance Savings Plans oferecem descontos em instâncias específicas dentro de uma família de instâncias.

5. **Ajustes Automáticos:**
   - Os Savings Plans se ajustam automaticamente às mudanças no seu uso, proporcionando flexibilidade para lidar com variações na carga de trabalho.

6. **Uso em Diversos Serviços:**
   - Savings Plans não se limitam apenas a instâncias EC2. Eles também podem ser aplicados a outros serviços, como AWS Lambda e AWS Fargate.

7. **Compatibilidade com Contas e Famílias de Instâncias:**
   - Savings Plans oferecem suporte para compartilhamento entre contas da AWS e podem cobrir uma ampla variedade de famílias de instâncias.

8. **Faturamento Simpificado:**
   - O faturamento é feito automaticamente, simplificando a gestão e evitando a necessidade de previsões complexas.

Savings Plans são ideais para cargas de trabalho com uso consistente e previsível, oferecendo uma opção simplificada de descontos em comparação com Reserved Instances. Eles proporcionam maior flexibilidade e são uma opção eficaz para otimizar custos em diversos cenários de uso.

### 8. **Instances Purchased on the AWS Marketplace:**
   - **Descrição:** Oferece a opção de comprar instâncias diretamente de vendedores de software independentes através do AWS Marketplace.
   - **Ideal para:** Cargas de trabalho que requerem software específico ou soluções de terceiros.

Ao escolher a opção de compra de instância, é importante considerar a natureza da carga de trabalho, o orçamento disponível e os requisitos específicos de desempenho, flexibilidade e controle.

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