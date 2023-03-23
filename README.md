Desafio Builders
--------

A seguir, descrevo os passos gerais que poderiam ser seguidos para implementar uma função lambda da AWS que monitora as modificações em um grupo de segurança e envia informações para um bucket criado por uma API, usando um contêiner em Node.js e escrita em Java e AWS SDK:

Configuração do ambiente:
----------------------
Primeiramente, é necessário configurar o ambiente de desenvolvimento. Isso inclui a instalação do AWS CLI (Command Line Interface), Terraform e a configuração de credenciais de acesso e a instalação do Docker com a imagem do  Node.js no ambiente.

Build do contêiner:
--------------------
O próximo passo é constuir o contêiner que será usado pela API que vai criar, deletar e verificas os grupos de segurança existentes. O contêiner foi criado com base na imagem do Node.js e contem as dependências necessárias para se comunicar com a AWS, como o AWS SDK. O código foi escrito em Java e empacotado no contêiner. 

Criação do Bucket:
-------------------
Em seguida, deve-se executar a API que será responsável por criar o bucket S3. Isso pode ser feito usando o os arquivos em java contidos no container confimre a docuemtnção. A API deve ser configurada para receber e evniar os dados via AWS SDK e criar o bucket S3 com base nessas informações.

Criação da função Lambda:
----------------------
O próximo passo é criar a função Lambda na AWS. Para isso, vamos utilizar o Terraform que esta descrito na documentação da etapa 02. A função deve ser criada em uma VPC e deve ter as permissões necessárias para acessar os recursos da AWS, como o grupo de segurança e o bucket S3. É importante lembrar que a função Lambda deve ter acesso à internet para se comunicar com a API que criará o bucket S3.

Escrita do código da função Lambda:
---------------------------
O código da função Lambda deve ser escrito em Java e deve usar o AWS SDK para monitorar as modificações no grupo de segurança e enviar as informações para a API que criará o bucket S3. Para isso, pode-se usar as classes do AWS SDK que permitem acessar o grupo de segurança e obter as informações necessárias.

Criação da infraestrutura como código:
-----------------------------
Por fim, a infraestrutura deve ser criada como código, usando o Terraform descrita na etapa 03. O código deve criar um cluster ECS para o deploy da imagem de container armazenada no ECR, além de criar as permissões necessárias para que esses recursos possam se comunicar entre si.

Concluindo, a implementação de uma lambda da AWS que monitora as modificações em um grupo de segurança e envia informações para um bucket criado por uma API, usando um contêiner em Node.js e escrita em Java e AWS SDK pode ser um processo complexo, mas é possível realizar com as ferramentas disponíveis na plataforma cloud da AWS.
