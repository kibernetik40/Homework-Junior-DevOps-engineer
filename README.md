# Junior DevOps engineer

### Написать скрипт на bash для мониторинга процесса test в среде linux. 
### Скрипт должен отвечать следующим требованиям:
-----------------------------------------------------------
1. Запускаться при запуске системы (предпочтительно написать юнит systemd в дополнение к скрипту)
2. Отрабатывать каждую минуту
3. Если процесс запущен, то стучаться(по https) наhttps://test.com/monitoring/test/api
4. Если процесс был перезапущен, писать в лог /var/log/monitoring.log 
5. Если сервер мониторинга не доступен, так же писать в лог. 

-----------------------------------------------------------
# <div align="center">Для выполнения всех поставленных задач, нам нужно создать два компонента:</div>

Bash-скрипт, который будет мониторить процесс, отправлять запросы и логировать события.
Systemd unit, который будет запускать этот скрипт при старте системы и периодически выполнять его.
 1. Создание bash-скрипта (***<u>script.sh</u>***) . Скрипт будет проверять наличие процесса test, отправлять запросы и логировать события.
 2. Создание systemd юнита
  Юнит должен запускать скрипт каждую минуту. Для этого создадим два файла:
     - 2.1. Сервисный юнит (/etc/systemd/system/test-monitoring.service)
     - 2.2. Таймер для запуска каждую минуту (/etc/systemd/system/test-monitoring.timer)
 3. Установка и активация юнитов
    - 3.1. Скопируйте bash-скрипт в подходящую директорию, например, /usr/local/bin/test-monitoring.sh.
           Сделайте скрипт исполнимым:
      >       chmod +x /usr/local/bin/test-monitoring.sh
    - 3.2. Создайте systemd юнит-файлы:
           Скопируйте содержимое в файлы test-monitoring.service и test-monitoring.timer в соответствующие каталоги:
      >       sudo cp test-monitoring.service /etc/systemd/system/
      >       sudo cp test-monitoring.timer /etc/systemd/system/
    - 3.3. Перезагрузите systemd и активируйте таймер:
      >       sudo systemctl daemon-reload
      >       sudo systemctl enable test-monitoring.timer
      >       sudo systemctl start test-monitoring.timer
    - 3.4. Проверьте статус таймера:
           Чтобы убедиться, что таймер работает корректно, выполните:
      >      sudo systemctl status test-monitoring.timer

      Это покажет информацию о текущем статусе таймера и когда он будет выполнен в следующий раз.
 4. Разрешения на запись в лог
    Убедитесь, что файл /var/log/monitoring.log существует и доступен для записи пользователю root. Если его нет, создайте его и задайте права:
   >  sudo touch /var/log/monitoring.log
   >  sudo chown root:root /var/log/monitoring.log
   >  sudo chmod 644 /var/log/monitoring.log

   Теперь скрипт будет запускаться каждую минуту через systemd, мониторить процесс, отправлять данные на сервер и логировать события в /var/log/monitoring.log.
