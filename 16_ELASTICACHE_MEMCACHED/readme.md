ElastiCache para Memcached
Armazenamento em memória, compatível com Memcached, gerenciado. Latência de menos de 1 milissegundo para ativar aplicativos em tempo real.

O Amazon ElastiCache para Memcached é um serviço de armazenamento de valor-chave, em memória, compatível com Memcached que pode ser usado como cache ou datastore. Oferece a performance, a facilidade de uso e a simplicidade do Memcached. O ElastiCache para Memcached é rápido, totalmente gerenciado, escalável e seguro. Essas características fazem dele o candidato ideal para casos de uso em que dados acessados com frequência devem residir na memória. O serviço é uma escolha comum para casos de uso como web, aplicativos móveis, jogos, tecnologia de anúncios e comércio eletrônico.

Benefícios
PERFORMANCE EXTREMA
O Amazon ElastiCache for Memcached funciona como um datastore em memória e cache para dar suporte aos aplicativos mais exigentes do mercado que exigem tempos de resposta de menos de um milissegundo. Ao utilizar uma pilha otimizada e completa executada em nós dedicados do cliente, o Amazon ElastiCache disponibiliza uma performance segura e muito rápida.

 

SEGURO E PROTEGIDO
O Amazon ElastiCache para Memcached oferece suporte à Amazon VPC e permite que você isole o cluster nos intervalos IP escolhidos para os nós e use-os para conectar-se ao aplicativo. O ElastiCache monitora continuamente seus nós e aplica os patches necessários para manter seu ambiente seguro. O ElastiCache para Memcached oferece criptografia de dados em trânsito usando o Transport Layer Security (TLS) versão 1.2. Saiba mais »

 

COMPATÍVEL COM MEMCACHED
Memcached é um sistema de armazenamento de objetos em cache de memória largamente adotado. O ElastiCache apresenta compatibilidade com o Memcached; portanto, ferramentas populares que você usa hoje com ambientes Memcached existentes funcionarão perfeitamente com o serviço. Saiba mais sobre o Memcached de código aberto »

 

FACILMENTE ESCALÁVEL
O Amazon ElastiCache com Memcached inclui fragmentação para escalar o cache na memória com até 20 nós e 12,7 TiB por cluster. Saiba mais »

 

TOTALMENTE GERENCIADO
Não será mais necessário executar tarefas de gerenciamento, como provisionamento de hardware, patching de software, configuração, monitoramento e recuperação de falhas. O ElastiCache monitora continuamente os clusters para manter as cargas de trabalho em operação, o que permite que você se concentre no desenvolvimento dos aplicativos. Saiba mais »

 

DESCOBERTA AUTOMÁTICA
Cliente de cluster do ElastiCache para Memcached com Auto Discovery economiza tempo para você ao simplificar a maneira como um aplicativo conecta-se ao cluster do Memcached. O cliente conecta-se a um único endpoint de cluster e obtém informações de configuração de outros nós. Quando os nós são adicionados ou removidos, o cliente reconfigura-se para usar o maior conjunto atual de nós. Saiba mais »

Como ele funciona
Armazenamento em cache com ElastiCache para Memcached
Casos de uso
Armazenamento em cache
O Amazon ElastiCache for Memcached é uma excelente escolha para a implementação de um cache de memória para diminuir a latência de acesso, aumentar a taxa de transferência e facilitar a descarga do seu banco de dados relacional ou NoSQL. O Amazon ElastiCache pode atender a itens solicitados com frequência com um tempo de resposta de menos de um milissegundo, além de permitir que você escale facilmente para cargas mais elevadas sem aumentar a dispendiosa camada do banco de dados de back-end. O armazenamento em cache de resultados de consulta de banco de dados, de sessões persistentes e de páginas inteiras são exemplos conhecidos de armazenamento em cache usando o ElastiCache for Memcached.
 

Armazenamento de sessões
É fácil criar armazenamentos de sessão com o Amazon ElastiCache for Memcached. Basta usar a tabela de hash do Memcached, que pode ser distribuída em vários nós. Escalar o armazenamento da sessão é tão fácil quanto adicionar um nó e atualizar os clientes para aproveitar o novo nó.

Amazon ElastiCache para Memcached
Introdução
O Amazon ElastiCache para Memcached é um serviço de cache gerenciado totalmente compatível com o protocolo Memcached. Ele fornece um cache de objetos em memória de alto desempenho que pode melhorar significativamente o desempenho dos aplicativos que dependem de acesso rápido a dados.
Benefícios
Alta performance: O Memcached armazena dados na memória, o que oferece tempos de acesso extremamente rápidos.
Escalabilidade: O ElastiCache permite que você dimensione facilmente seus clusters de cache para atender às demandas crescentes.
Durabilidade: Os clusters do ElastiCache são replicados para garantir alta disponibilidade e perda de dados mínima.
Gerenciamento totalmente gerenciado: O ElastiCache lida com o provisionamento, gerenciamento e monitoramento do cluster, liberando você para se concentrar em seu aplicativo.
Como funciona
O ElastiCache para Memcached funciona como uma camada intermediária entre seu aplicativo e seu banco de dados. Ele armazena dados acessados com frequência na memória, reduzindo o número de chamadas ao banco de dados e melhorando o tempo de resposta.
Casos de uso
O ElastiCache para Memcached é ideal para aplicativos que exigem acesso rápido a dados, como:
Sistemas de gerenciamento de conteúdo (CMS)
Carrinhos de compras
Catálogos de produtos
Sessões de usuário
Recursos
Replicação: Os clusters do ElastiCache são replicados para alta disponibilidade e durabilidade.
Clusterização: Você pode criar vários clusters para separar cargas de trabalho diferentes.
Monitoramento: O ElastiCache fornece métricas detalhadas para monitorar o desempenho e a saúde do cluster.
Integrações: O ElastiCache se integra com outros serviços da AWS, como o Amazon DynamoDB e o Amazon Redshift.
Conclusão
O Amazon ElastiCache para Memcached é uma solução de cache poderosa e escalável que pode melhorar significativamente o desempenho dos aplicativos que dependem de acesso rápido a dados. Com seu alto desempenho, escalabilidade e gerenciamento totalmente gerenciado, o ElastiCache é uma ótima opção para aplicativos que exigem o máximo desempenho.