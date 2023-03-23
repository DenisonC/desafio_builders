Para criar uma aplicação que execute uma tarefa sempre que um Security Group é criado ou modificado na sua conta AWS, você pode usar os recursos de eventos da AWS. Isso é possível usando o serviço Amazon CloudWatch Events para monitorar eventos de criação e modificação do Security Group.

A seguir, descrevemos os passos necessários para criar essa aplicação:

Crie um novo bucket S3 no Amazon S3 Console e dê um nome para o bucket.

Crie uma nova função do AWS Lambda para processar os eventos do CloudWatch. Para isso, abra o console do AWS Lambda, selecione "Funções" no menu principal e clique em "Criar função".

Selecione a opção "Autor do zero" e escolha uma linguagem de programação compatível para sua aplicação. Em seguida, defina as permissões de execução para a função Lambda.

Copie e cole o código de exemplo abaixo para o editor de código da função Lambda:

#Código Lambda
import boto3
import json

def lambda_handler(event, context):
    # Extrai informações do evento
    message = event['Records'][0]['Sns']['Message']
    data = json.loads(message)
    event_name = data['detail']['eventName']
    group_id = data['detail']['requestParameters']['groupId']
    bucket_name = 'SEU_BUCKET_NAME'
    file_name = 'grupo_' + group_id + '.txt'
    
    # Cria o conteúdo do arquivo
    content = f'Evento: {event_name}\nID do Grupo: {group_id}'
    
    # Faz o upload do arquivo para o S3
    s3 = boto3.resource('s3')
    s3.Bucket(bucket_name).put_object(Key=file_name, Body=content)
    
    return 'Arquivo criado e carregado com sucesso'

Este código extrai informações do evento do CloudWatch e cria um arquivo de texto com essas informações. Em seguida, faz o upload do arquivo criado para o bucket S3 que você criou no passo 1.

Configure o CloudWatch Events para acionar a função Lambda sempre que um Security Group for criado ou modificado. No console do CloudWatch, selecione "Eventos" no menu principal e clique em "Criar regra".

Na tela de configuração de regras do CloudWatch, defina as condições para acionar a função Lambda. Por exemplo, para acionar a função sempre que um Security Group for criado, configure a regra para "Criar SecurityGroup". Em seguida, selecione a função Lambda que você criou no passo 3 como o destino da regra.

Salve a regra do CloudWatch e teste a aplicação. Crie ou modifique um Security Group em sua conta AWS e verifique se o arquivo de texto com as informações sobre o evento foi criado e carregado com sucesso para o bucket S3.
