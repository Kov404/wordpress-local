#!/bin/bash
echo "==================================="
echo "WordPress Docker Setup - Linux"
echo "==================================="


if ! command -v docker &> /dev/null; then
    echo " Docker não está instalado!"
    echo "Instale o Docker primeiro: https://docs.docker.com/engine/install/"
    exit 1
fi

# Verificar se Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    echo " Docker Compose não está instalado!"
    echo "Instale o Docker Compose primeiro"
    exit 1
fi

echo "Docker e Docker Compose encontrados!"

echo "Criando estrutura de diretórios..."
mkdir -p wordpress-docker/wp-content/{themes,plugins,uploads}
cd wordpress-docker

echo " Configurando permissões..."
chmod -R 755 wp-content/
chown -R $USER:$USER wp-content/

echo ""
echo " Iniciando containers..."
docker-compose up -d

echo ""
echo "Aguardando serviços iniciarem..."
sleep 10

echo ""
echo " WordPress Docker configurado com sucesso!"
echo ""
echo " Acesse seus serviços:"
echo "   WordPress: http://localhost:8080"
echo "   phpMyAdmin: http://localhost:8081"
echo ""
echo " Credenciais do banco de dados:"
echo "   Servidor: db"
echo "   Banco: wordpress"
echo "   Usuário: wordpress"
echo "   Senha: wordpress123"
echo ""
echo " Comandos úteis:"
echo "   Parar containers: docker-compose down"
echo "   Ver logs: docker-compose logs -f"
echo "   Reiniciar: docker-compose restart"
echo "   Atualizar: docker-compose pull && docker-compose up -d"
echo ""
echo " Para acessar o phpMyAdmin:"
echo "   Usuário: root"
echo "   Senha: root123"
echo ""
