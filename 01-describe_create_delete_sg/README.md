# desafio_builders
Desafio técnico Builders
----------------------------------------------------

Trabalhando com grupos de segurança na Amazen EC2
----------------------------------------------------

Aqui vamos trabalhar com o Node.js e AWS SDK

- Como recuperar informaçãoes sobre seus grupos de segurança 

- Como criar um grupo de segurança para acessar uma instância do Amazon EC2

- Como deletar um grupo de segurança existente

O cenário 
------------------------------------

O grupo de segurança da Amazon EC2 atua como um firewall virtual que controla o tráfego para uma ou várias intâncias. Em cada grupo é adicionado as regras para permitir o tráfego de ou para suas intâncias associadas. 
Nesta API vc poderá aplicar as regras autmaticamente a todas a instâncias associadas ao grupo de segurança

Aqui vamos usar uma série de modulos Node.js ára executar várias operações envolvendo grupos de segurança, os módulos no Node.js vai utilizar o Amazon SD para JavaScript utilizando os métodos de classe de cliente do Amazon EC2:

- describeSecurityGroups

- createSecurityGroup

- deleteSecurityGroup

Pré requsiitos
-----------------------------------

Para configurar e executar conlclua os pré requisitos abaixo:

- Criar uma arquivo de configuração com as credenciais AWS 
- Buildar a imagem contendo o o Node.js

Você pode manter seus dados de credenciais da AWS em um arquivo compartilhado usado por SDKs e pela interface de linha de comando. Quando o SDK para JavaScript é carregado, ele pesquisa automaticamente o arquivo de credenciais compartilhado, denominado "credenciais". Onde você mantém o arquivo de credenciais compartilhadas depende do seu sistema operacional:

- O arquivo de credenciais compartilhadas no Linux, Unix e macOS: ~/.aws/credentials

Insira o usuário e a key no arquivo credentials. 


Para buildar a imagem da nossa API vamos executar o seguinte comando:

```ruby
$ docker run -t node-docker-img . 
```
Execute o container da imagem

```ruby
$ docker run -dit --name node-docker node-docker-img
```
Com o container rodando execute o comando para acessar o contânier da API e executar as ações necessárias:

----------------------------------------------------------
1 - describeSecurityGroups:
----------------------------------

Edite o arquivo ecs_describesecuritygroups.js, e inclua os IDs dos grupos de segurança que você deseja descrever. Depois chame odescribeSecurityGroupsMétodo do objeto de serviço do Amazon EC2.

```ruby
$ node ec2_describesecuritygroups.js
```
---------------------------------------------------------
2 - createSecurityGroup:
-----------------------------------------------

No arquivo ec2_createsecuritygroup altere os parâmetros que especificam o nome do grupo de segurança, uma descrição e o ID da VPC. Passe os parâmetros para o método createSecurityGroup e execute.

```ruby
$ node ec2_createsecuritygroup.js
```
-------------------------------------------------------------
3 - deleteSecurityGroup:
-----------------------------------------------

Altere os parâmetros no módulo JSON para especificar o nome do grupo de segurança a ser excluído. Depois, chame o método deleteSecurityGroup.

```ruby
$ node ec2_deletesecuritygroup.js
```

Criando um Bucket
---------------------------------------------

Crie um nome exclusivo que seja utilizado um bucket do Amazon S3 anexando , neste caso'node-sdk-sample-'. Você gera o ID exclusivo chamando o módulo uuid. Crie um nome para o parâmetro Key usado para fazer upload de um objeto no bucket e execute o comando.

```ruby
$ node bucket.js
```

Se a resposta for bem sucedida o Bucket foi criado.


