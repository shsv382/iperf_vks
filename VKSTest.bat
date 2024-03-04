@echo off
chcp 65001
:start
cls

set iperf=.\iperf\iperf3.exe
set port-client=5201
set mss-package=1400
set streams=8
set bandwidth=2

echo [Тестирование канала связи на соответствие требованиям видеоконференцсвязи (ВКС)]
echo Меню:
echo 1. Провести тестирование ICMP-трафика множественными Echo-запросами (ping) разной длины (сервер не нужен)
echo 2. Запустить сервер iperf3 на порту 5201 (по умолчанию)
echo 3. Запустить сервер iperf3 на другом порту
echo 4. Провести тестирование с помощью iperf3
echo 5. Разрешить порт в Сетевом экране (Запускать с правами Администратора)
echo 0. Выход

set /P num="Выберите пункт меню: "

if not defined num (cls & echo Неверный номер. Выберите пункт меню & pause & goto start)

if %num% equ 0 (exit 0)

if %num% equ 1 cls
if %num% equ 1 set /P ip-ping="Введите Ip-адрес для пинга: "
if %num% equ 1 start cmd /k ping %ip-ping% -l 200 -f -t
if %num% equ 1 start cmd /k ping %ip-ping% -l 400 -f -t
if %num% equ 1 start cmd /k ping %ip-ping% -l 600 -f -t
if %num% equ 1 start cmd /k ping %ip-ping% -l 800 -f -t
if %num% equ 1 start cmd /k ping %ip-ping% -l 1000 -f -t
if %num% equ 1 start cmd /k ping %ip-ping% -l 1200 -f -t
if %num% equ 1 start cmd /k ping %ip-ping% -l 1400 -f -t
if %num% equ 1 start cmd /k ping %ip-ping% -l 1470 -f -t
if %num% equ 1 goto start

if %num% equ 2 cls
if %num% equ 2 echo Адрес(а) сервера:
if %num% equ 2 ipconfig | find "IPv4 Address"
if %num% equ 2 (%iperf% -s , exit 0)
if %num% equ 2 pause

if %num% equ 3 cls
if %num% equ 3 echo [Тестирование канала связи на соответствие требованиям видеоконференцсвязи (ВКС)]
if %num% equ 3 echo Запустить сервер на другом порту
if %num% equ 3 set /P port-server="Введите номер порта: "
if %num% equ 3 cls
if %num% equ 3 echo Адрес(а) сервера:
if %num% equ 3 ipconfig | find "IPv4 Address"
if %num% equ 3 (%iperf% -s -p %port-server% , exit 0)

if %num% equ 5 cls
if %num% equ 5 echo [Тестирование канала связи на соответствие требованиям видеоконференцсвязи (ВКС)]
if %num% equ 5 echo Разрешить порт в Сетевом экране
if %num% equ 5 set /P port-fw="Введите номер порта или диапазон (по умолчанию: 5201): "
if %num% equ 5 netsh advfirewall firewall add rule name="%port-fw%-Iperf" dir=in action=allow localport=%port-fw% protocol=TCP enable=yes
if %num% equ 5 netsh advfirewall firewall show rule name="%port-fw%-Iperf"
if %num% equ 5 (pause & goto start)

if %num% equ 4 cls
if %num% equ 4 echo [Тестирование канала связи на соответствие требованиям видеоконференцсвязи (ВКС)]
if %num% equ 4 echo Провести тестирование с помощью iperf3
if %num% equ 4 set /P ip="Введите адрес сервера: "
if %num% equ 4 cls

:testing

rem if %num% equ 3 cls
if %num% equ 4 echo [Тестирование канала связи на соответствие требованиям видеоконференцсвязи (ВКС)]
if %num% equ 4 echo Тестировать сервер %ip% порт %port-client%
if %num% equ 4 echo Меню тестирования с помощью iperf3:
if %num% equ 4 echo 1. Изменить порт сервера (сейчас: %port-client%, по умолчанию: 5201)
if %num% equ 4 echo 2. Изменить размер максимального сегмента MSS (+ заголовки = MTU) (сейчас: %mss-package%, по умолчанию: 1400)
if %num% equ 4 echo 3. Изменить количесто потоков для нагрузочного тестирования (сейчас: %streams%, по умолчанию: 8)
if %num% equ 4 echo 4. Нагрузочное тестирование пропускной способности канала (TCP-трафик) в %streams% поток(а,ов)
if %num% equ 4 echo 5. Тестирование UDP-трафика (сетевой джиттер и потери пакетов)
if %num% equ 4 echo 6. Тестирование RTP-трафика (протокол передачи видео и аудио данных)
if %num% equ 4 echo 7. Изменить ширину генирируемого трафика (сейчас: %bandwidth% Мб/с, по умолчанию: 2 Мб/с)
if %num% equ 4 echo 8. Генерация ВКС трафика %bandwidth% Мб/с
if %num% equ 4 echo 9. Назад в основное меню
if %num% equ 4 echo 0. Выход

if %num% equ 4 set /P num2="Выберите пункт меню: "

if not defined num2 (cls & echo Неверный номер. Выберите пункт меню & pause & goto start)

if %num2% equ 0 exit 0

rem if %num2% equ 1 cls
if %num2% equ 1 echo [Тестирование канала связи на соответствие требованиям видеоконференцсвязи (ВКС)]
if %num2% equ 1 echo Тестировать сервер %ip% порт %port-client%
if %num2% equ 1 set /P port-client="Введите номер порта (сейчас: %port-client%, по умолчанию: 5201): "
if %num2% equ 1 goto testing

rem if %num2% equ 2 cls
if %num2% equ 2 echo [Тестирование канала связи на соответствие требованиям видеоконференцсвязи (ВКС)]
if %num2% equ 2 echo Тестировать сервер %ip% порт %port-client%
if %num2% equ 2 set /P mss-package="Введите размер максимального сегмента MSS (+ заголовки = MTU) (сейчас: %mss-package%, по умолчанию: 1400): "
if %num2% equ 2 goto testing

rem if %num2% equ 3 cls
if %num2% equ 3 echo [Тестирование канала связи на соответствие требованиям видеоконференцсвязи (ВКС)]
if %num2% equ 3 echo Тестировать сервер %ip% порт %port-client%
if %num2% equ 3 set /P streams="Введите количество потоков (сейчас: %streams%, по умолчанию: 8): "
if %num2% equ 3 goto testing

rem if %num2% equ 4 cls
if %num2% equ 4 echo Нагрузочное тестирование пропускной способности канала (TCP-трафик)
if %num2% equ 4 %iperf% -c %ip% -p %port-client% -P %streams% -w 32768 -M %mss-package% -t 10
if %num2% equ 4 echo Нагрузочное тестирование пропускной способности канала завершено!
if %num2% equ 4 echo Требования к каналу ВКС: 
if %num2% equ 4 echo Пропусная способность (Bandwidth): ^>=2 Mbits/sec 
if %num2% equ 4 echo Вариация задержки (Jitter): ^<30 ms
if %num2% equ 4 echo Потери пакетов (Lost): ^<0,5 %%
if %num2% equ 4 echo Задержка (Ping): ^<850 ms
if %num2% equ 4 pause & goto testing

rem if %num2% equ 5 cls
if %num2% equ 5 echo Нагрузочное тестирование UDP-трафика (сетевой джиттер и потери пакетов)
if %num2% equ 5 %iperf% -c %ip% -p %port-client% -u -M %mss-package% -t 30
if %num2% equ 5 echo Нагрузочное тестирование UDP-трафика завершено!
if %num2% equ 5 echo Требования к каналу ВКС: 
if %num2% equ 5 echo Пропусная способность (Bandwidth): ^>=2 Mbits/sec 
if %num2% equ 5 echo Вариация задержки (Jitter): ^<30 ms
if %num2% equ 5 echo Потери пакетов (Lost): ^<0,5 %%
if %num2% equ 5 echo Задержка (Ping): ^<850 ms
if %num2% equ 5 pause & goto testing

rem if %num2% equ 6 cls
if %num2% equ 6 echo Тестирование RTP-трафика (протокол передачи видео и аудио данных)
if %num2% equ 6 %iperf% -c %ip% -p %port-client% -u -S 0xC0 -M %mss-package% -i 1 -t 30
if %num2% equ 6 echo Тестирование RTP-трафика завершено!
if %num2% equ 6 echo Требования к каналу ВКС: 
if %num2% equ 6 echo Пропусная способность (Bandwidth): ^>=2 Mbits/sec 
if %num2% equ 6 echo Вариация задержки (Jitter): ^<30 ms
if %num2% equ 6 echo Потери пакетов (Lost): ^<0,5 %%
if %num2% equ 6 echo Задержка (Ping): ^<850 ms
if %num2% equ 6 pause & goto testing

rem if %num2% equ 7 cls
if %num2% equ 7 echo [Тестирование канала связи на соответствие требованиям видеоконференцсвязи (ВКС)]
if %num2% equ 7 echo Тестировать сервер %ip% порт %port-client%
if %num2% equ 7 set /P bandwidth="Введите ширину генирируемого трафика в Мб/с (сейчас: %bandwidth% Мб/с, по умолчанию: 2 Мб/с): "
if %num2% equ 7 goto testing

rem if %num2% equ 8 cls
if %num2% equ 8 echo Генерация трафика %bandwidth% Мб/с
if %num2% equ 8 %iperf% -c %ip% -p %port-client% -u -M %mss-package% -b %bandwidth%M -d -S 0xC0 -fk -i 1 -t 30
if %num2% equ 8 echo Генерация траффика %bandwidth% Мб/сек завершена!
if %num2% equ 8 echo Требования к каналу ВКС: 
if %num2% equ 8 echo Пропусная способность (Bandwidth): ^>=2 Mbits/sec 
if %num2% equ 8 echo Вариация задержки (Jitter): ^<30 ms
if %num2% equ 8 echo Потери пакетов (Lost): ^<0,5 %%
if %num2% equ 8 echo Задержка (Ping): ^<850 ms

if %num2% equ 8 pause & goto testing

if %num2% equ 9 goto start

rem cls 
echo Неверный номер. Выберите пункт меню
pause & goto testing