#!/bin/bash
# Verifica se o lcov está instalado
if ! command -v lcov &> /dev/null; then
  echo "lcov command not found. Instale o lcov e tente novamente."
  exit 1
fi

COVERAGE_FILE="coverage/lcov.info"
if [ ! -r "$COVERAGE_FILE" ]; then
  echo "Arquivo '$COVERAGE_FILE' não encontrado ou não legível."
  echo "Certifique-se de executar 'flutter test --coverage' para gerar o arquivo corretamente."
  exit 1
fi

# Calcula a cobertura de testes ignorando erros de arquivos faltantes
COVERAGE=$(lcov --ignore-errors missing --summary "$COVERAGE_FILE" | grep "lines......:" | awk '{print $2}' | sed 's/%//')

if [ -z "$COVERAGE" ]; then
  COVERAGE=0
fi
echo "Cobertura atual: ${COVERAGE}%"

result=$(echo "$COVERAGE < 70" | bc -l)
if [ "$result" -eq 1 ]; then
  echo "Cobertura abaixo de 70."
  exit 1
else
  echo "Cobertura adequada."
fi
