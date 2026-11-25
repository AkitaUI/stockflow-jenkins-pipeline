#!/bin/sh
set -eu

FILE="${1:-build/index.html}"

if [ ! -f "$FILE" ]; then
    echo "FAIL: файл сборки не найден: $FILE"
    exit 1
fi

check_contains() {
    text="$1"
    description="$2"
    if grep -Fq "$text" "$FILE"; then
        echo "PASS: $description"
    else
        echo "FAIL: $description"
        exit 1
    fi
}

check_contains "StockFlow" "заголовок проекта найден"
check_contains "Складские остатки" "раздел складских остатков найден"
check_contains "SKU-1001" "контрольный товар SKU-1001 найден"
check_contains "Доступно" "поле доступного количества найдено"

echo "All StockFlow tests passed."
