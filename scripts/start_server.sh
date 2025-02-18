#!/bin/bash

# Define a porta que o servidor usará
PORT=8080

# Verifica se há processos usando a porta 8080 e os mata
if lsof -t -i:$PORT > /dev/null; then
    echo "Matar processos que estão usando a porta $PORT..."
    kill -9 $(lsof -t -i:$PORT)
else
    echo "Nenhum processo encontrado na porta $PORT."
fi

# Aguarde um momento para garantir que o processo foi finalizado
sleep 2

# Inicie o servidor
echo "Iniciando o servidor na porta $PORT..."
cd /home/ec2-user/app/
java -jar output/*.jar > app.log 2>&1 &
if [ $? -eq 0 ]; then
    echo "Servidor iniciado. Verifique os logs em /home/ec2-user/app/app.log."
else
    echo "Falha ao iniciar o servidor. Verifique os logs em /home/ec2-user/app/app.log para mais detalhes."
fi
