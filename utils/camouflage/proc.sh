#!/bin/bash
#
# Uso: ./proc.sh <nome_do_arquivo>
#
# Argumentos:
#   <nome_do_arquivo>: O arquivo que você deseja camuflar
#
# Exemplo:
#   ./proc.sh documento.txt
#   
# Saída:
#   - Cria uma cópia oculta do arquivo com nome aleatório
#   - Exibe o nome original e o novo nome camuflado
#
# Códigos de saída:
#   0 - Sucesso
#   1 - Erro (arquivo não encontrado ou nenhum arquivo especificado)

VERDE='\033[1;32m'
VERMELHO='\033[1;31m'
NEGRITO='\033[1m'
SC='\033[0m'

# verifica arquivo input
if [ $# -ne 1 ]; then
  echo -e "${VERMELHO}Erro: Por favor, forneça um arquivo para camuflar${SC}"
  echo -e "${NEGRITO}Uso: $0 <nome_do_arquivo>${SC}"
  exit 1
fi

arquivo="$1"

# verifica arquivo
if [ ! -f "$arquivo" ]; then
  echo -e "${VERMELHO}Erro: Arquivo '$arquivo' não encontrado${SC}"
  exit 1
fi

# criar cópia
nome_aleatorio=".$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)"
cp "$arquivo" "$nome_aleatorio"

if [ $? -eq 0 ]; then
  echo -e "${VERDE}Arquivo camuflado com sucesso como '$nome_aleatorio'${SC}"
  echo -e "${NEGRITO}Arquivo original: $arquivo${SC}"
  echo -e "${NEGRITO}Camuflado como: $nome_aleatorio${SC}"
else
  echo -e "${VERMELHO}Falha ao camuflar o arquivo${SC}"
  exit 1
fi
