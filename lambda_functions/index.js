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
