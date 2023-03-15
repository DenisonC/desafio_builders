# desafio_builders
Desafio técnico Builders

Trabalhando com grupos de segurança na Amazen EC2

Aqui vamos trabalhar com o Node.js

- Como recuperar informaçãoes sobre seus grupos de segurança 
- Como criar um grupo de segurança para acessar uma instância do Amazon EC2
- Como deletar um grupo de segurança existente

O cenário 

O grupo de segurança da Amazon EC2 atua como um firewall virtual que controla o tráfego para uma ou várias intâncias. Em cada grupo é adicionado as regras para permitir o tráfego de ou para suas intâncias associadas. 
Nesta API vc poderá aplicar as regras autmaticamente a todas a instâncias associadas ao grupo de segurança

Aqui vamos usar uma série de modulos Node.js ára executar várias operações envolvendo grupos de segurança, os módulos no Node.js vai utilizar o Amazon SD para JavaScript utilizando os métodos de classe de cliente do Amazon EC2:

- describeSecurityGroups

- authorizeSecurityGroupIngress

- createSecurityGroup

- describeVpcs

- deleteSecurityGroup