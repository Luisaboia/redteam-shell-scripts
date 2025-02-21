#!/bin/bash
#
# Modo de usar o script:
#       bash catchInfoWebsite.sh <site_alvo>
#
# Argumentos:
#       <site_alvo>: O site que você deseja coletar informações
#
# Exemplo:
#       bash catchInfoWebsite.sh google.com
# 
# Coleta informações sobre um site específico, incluindo:
# - Endereço IP
# - Registros DNS
# - Informações WHOIS
# - Headers HTTP
# - Status de disponibilidade
#
# Requisitos:
# - host
# - dig
# - whois
# - curl

VERDE='\033[1;32m'
VERMELHO='\033[1;31m'
LARANJA='\033[1;33m'
NC='\033[0m'

if [ -z "$1" ]; then
    echo -e "${VERMELHO}Uso: bash catchInfoWebsite.sh <site_alvo>${NC}"
    exit 1
fi
TARGET_SITE="$1"

echo -e "${VERDE}Coletando informações de $TARGET_SITE...${NC}"
echo "----------------------------------------"

# Verificar comandos necessários
for cmd in host dig whois curl; do
        if ! command -v $cmd &> /dev/null; then
                echo -e "${VERMELHO}Erro: $cmd não está instalado${NC}"
                exit 1
        fi
done

# Pegar IP
echo -e "\n[IP] Endereço encontrado:"
host $TARGET_SITE && echo -e "${VERDE}[✓] IP encontrado${NC}" || echo -e "${LARANJA}[!] Não foi possível obter o endereço de IP${NC}"

# Pegar DNS
echo -e "\n[DNS] Registros encontrados:"
dig +short $TARGET_SITE && echo -e "${VERDE}[✓] DNS encontrado${NC}" || echo -e "${LARANJA}[!] Não foi possível obter o DNS${NC}"

# WHOIS
echo -e "\n[WHOIS] Informações da organização:"
whois $TARGET_SITE | grep -E "Organization|Country|State|City" | grep -v "#" && echo -e "${VERDE}[✓] Informações WHOIS encontradas${NC}" || echo -e "${LARANJA}[!] Não foi possível obter informações WHOIS${NC}"

# HTTP
echo -e "\n[HTTP] Headers do servidor:"
curl -I -m 5 $TARGET_SITE 2>/dev/null | grep -E "Server:|X-Powered-By:|Content-Type:" && echo -e "${VERDE}[✓] Headers obtidos${NC}" || echo -e "${LARANJA}[!] Não foi possível obter os headers HTTP${NC}"

# Website está online?
echo -e "\n[STATUS] Verificação de disponibilidade:"
if curl -s --head $TARGET_SITE > /dev/null; then
        echo -e "${VERDE}[✓] Website está online${NC}"
else
        echo -e "${VERMELHO}[✗] Website está offline${NC}"
fi
