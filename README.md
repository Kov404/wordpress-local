# WordPress Local com Docker - Linux

Este projeto configura um ambiente WordPress local completo usando Docker, incluindo MySQL e phpMyAdmin.

## 📋 Pré-requisitos

- Linux (Ubuntu, Debian, CentOS, etc.)
- Docker Engine instalado
- Docker Compose instalado
- Usuário com permissões para executar Docker

### Instalação do Docker (Ubuntu/Debian)
```bash
# Atualizar pacotes
sudo apt update

# Instalar dependências
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release

# Adicionar chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Adicionar repositório
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Adicionar usuário ao grupo docker
sudo usermod -aG docker $USER
```

## 🚀 Instalação e Uso

### 1. Clonar/Criar o projeto
```bash
mkdir wordpress-docker
cd wordpress-docker
```

### 2. Criar o arquivo docker-compose.yml
Copie o conteúdo do arquivo `docker-compose.yml` fornecido.

### 3. Criar estrutura de diretórios
```bash
mkdir -p wp-content/{themes,plugins,uploads}
chmod -R 755 wp-content/
```

### 4. Executar o setup
```bash
# Tornar o script executável
chmod +x setup.sh

# Executar o script
./setup.sh
```

### 5. Ou executar manualmente
```bash
# Iniciar containers
docker-compose up -d

# Verificar status
docker-compose ps
```

## 🌐 Acessos

| Serviço | URL | Credenciais |
|---------|-----|-------------|
| **WordPress** | http://localhost:8080 | Configure durante a instalação |
| **phpMyAdmin** | http://localhost:8081 | root / root123 |
| **MySQL** | localhost:3306 | wordpress / wordpress123 |

## 📊 Configuração do WordPress

1. Acesse http://localhost:8080
2. Escolha o idioma
3. Configure a conexão com banco de dados:
   - **Nome do banco de dados:** wordpress
   - **Nome de usuário:** wordpress  
   - **Senha:** wordpress123
   - **Servidor do banco de dados:** db
   - **Prefixo da tabela:** wp_

4. Execute a instalação
5. Configure seu usuário administrador

## 🔧 Comandos Úteis

```bash
# Ver status dos containers
docker-compose ps

# Ver logs
docker-compose logs -f

# Parar containers
docker-compose down

# Reiniciar containers
docker-compose restart

# Atualizar imagens
docker-compose pull
docker-compose up -d

# Acessar terminal do WordPress
docker exec -it wordpress_site bash

# Acessar terminal do MySQL
docker exec -it wordpress_db mysql -u root -p

# Backup do banco de dados
docker exec wordpress_db mysqldump -u root -proot123 wordpress > backup.sql

# Restaurar backup
docker exec -i wordpress_db mysql -u root -proot123 wordpress < backup.sql
```

## 📁 Estrutura de Arquivos

```
wordpress-docker/
├── docker-compose.yml
├── setup.sh
├── wp-content/
│   ├── themes/
│   ├── plugins/
│   └── uploads/
└── README.md
```

## 🛠️ Personalização

### Mudando portas
Edite o arquivo `docker-compose.yml` e altere as portas:
```yaml
ports:
  - "8080:80"  # WordPress - mude 8080 para sua porta preferida
  - "8081:80"  # phpMyAdmin - mude 8081 para sua porta preferida
```

### Adicionando SSL/HTTPS
Para produção, considere usar um proxy reverso como Nginx ou Traefik.

### Themes e Plugins
Coloque seus themes em `wp-content/themes/` e plugins em `wp-content/plugins/`.

## 🔒 Segurança

**⚠️ IMPORTANTE:** Este setup é para desenvolvimento local. Para produção:

1. Mude todas as senhas padrão
2. Use senhas fortes
3. Configure SSL/HTTPS  
4. Restrinja acesso ao phpMyAdmin
5. Configure firewall adequadamente
6. Mantenha WordPress e plugins atualizados

## 🐛 Solução de Problemas

### Container não inicia
```bash
# Ver logs detalhados
docker-compose logs wordpress
docker-compose logs db
```

### Problema de permissões
```bash
# Corrigir permissões do wp-content
sudo chown -R www-data:www-data wp-content/
sudo chmod -R 755 wp-content/
```

### Limpar tudo e recomeçar
```bash
# Parar e remover containers
docker-compose down -v

# Remover volumes (CUIDADO: apaga dados!)
docker volume prune

# Reiniciar
docker-compose up -d
```

## 📞 Suporte

Para problemas específicos:
1. Verifique os logs: `docker-compose logs -f`
2. Verifique o status: `docker-compose ps`
3. Reinicie os serviços: `docker-compose restart`

## 📝 Notas

- Os dados do WordPress ficam persistidos no volume `wordpress_data`
- Os dados do MySQL ficam persistidos no volume `db_data`
- A pasta `wp-content` é mapeada para facilitar desenvolvimento
- O phpMyAdmin é opcional e pode ser removido se não necessário
