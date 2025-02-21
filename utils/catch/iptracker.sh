#!/bin/bash

# Cores ANSI
VERMELHO='\033[0;31m'
VERDE='\033[0;32m'
AMARELO='\033[1;33m'
AZUL='\033[0;34m'
RESET='\033[0m'

# Banner
echo -e "${AMARELO}"
cat << "EOF"
    ___ ____    ______                _             
   |_ _|  _ \  |_   _| __ __ _  ____| | _____ _ __ 
    | || |_) |   | || '__/ _` |/ __| |/ / _ \ '__|
    | ||  __/    | || | | (_| | (__|   <  __/ |   
   |___|_|       |_||_|  \__,_|\___|_|\_\___|_|   
                                                    
   [+] Rastreador de IP
   [+] Desenvolvido por: Zira
EOF
echo -e "${RESET}"

# Verificar se foi fornecido um IP
if [ -z "$1" ]; then
    echo -e "${VERMELHO}[!] Erro: IP não fornecido${RESET}"
    echo -e "Uso: $0 <endereço_ip>"
    exit 1
fi

# Fazer a requisição à API
echo -e "${AZUL}[*] Consultando informações do IP: $1...${RESET}\n"
resultado=$(curl -s "http://ip-api.com/json/$1")

# Verificar se a requisição foi bem sucedida
if [ $? -ne 0 ]; then
    echo -e "${VERMELHO}[!] Erro ao consultar API${RESET}"
    exit 1
fi

# Extrair e exibir as informações usando jq
if ! command -v jq &> /dev/null; then
    echo -e "${VERMELHO}[!] Erro: jq não está instalado. Por favor, instale-o primeiro.${RESET}"
    exit 1
fi

echo -e "${VERDE}=== INFORMAÇÕES DO IP ===${RESET}\n"
echo -e "${AZUL}IP:${RESET} $(echo $resultado | jq -r .query)"
echo -e "${AZUL}País:${RESET} $(echo $resultado | jq -r .country) ($(echo $resultado | jq -r .countryCode))"
echo -e "${AZUL}Cidade:${RESET} $(echo $resultado | jq -r .city)"
echo -e "${AZUL}Região:${RESET} $(echo $resultado | jq -r .regionName)"
echo -e "${AZUL}Provedor:${RESET} $(echo $resultado | jq -r .isp)"
echo -e "${AZUL}Organização:${RESET} $(echo $resultado | jq -r .org)"
echo -e "${AZUL}Latitude:${RESET} $(echo $resultado | jq -r .lat)"
echo -e "${AZUL}Longitude:${RESET} $(echo $resultado | jq -r .lon)"
echo -e "${AZUL}Fuso Horário:${RESET} $(echo $resultado | jq -r .timezone)"
echo -e "${AZUL}AS:${RESET} $(echo $resultado | jq -r .as)"

echo -e "\n${VERDE}[✓] Consulta finalizada${RESET}"
