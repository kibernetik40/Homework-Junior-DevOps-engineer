#!/bin/bash

# Имя процесса, который мы мониторим
PROCESS_NAME="test"

# URL для отправки запросов
MONITORING_URL="https://test.com/monitoring/test/api"

# Лог-файл для записи событий
LOG_FILE="/var/log/monitoring.log"

# Функция для логирования событий
log_event() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> $LOG_FILE
}

# Проверка наличия процесса
if pgrep -x "$PROCESS_NAME" > /dev/null; then
    # Процесс запущен, отправляем запрос
    if curl -s --head --request GET "$MONITORING_URL" | grep "200 OK" > /dev/null; then
        log_event "Process '$PROCESS_NAME' is running. Monitoring data sent to $MONITORING_URL."
    else
        log_event "Error: Monitoring server $MONITORING_URL is not reachable."
    fi
else
    # Процесс не найден, записываем перезапуск
    log_event "Process '$PROCESS_NAME' is not running. Possibly restarted."
fi
