@echo off
chcp 65001
:start
cls

set port-client=5201
set iperf=.\iperf\iperf3.exe

echo Меню:
echo 1. Запустить сервер на порту 5201 (по умолчанию)
echo 2. Запустить сервер на нестандартном порту
echo 3. Провести тестирование
echo 4. Открыть порт в Firewall (Run as administrator)

set /P num="Введите пункт меню: "

if not defined num (cls & echo Не выбран пункт меню, введите номер & pause & goto start)

if %num% equ 1 cls
if %num% equ 1 echo Адрес(а) сервера:
if %num% equ 1 ipconfig | find "IPv4 Address"
if %num% equ 1 (%iperf% -s , exit 0)

if %num% equ 2 set /P port-server="Введите номер порта: "
if %num% equ 2 cls
if %num% equ 2 echo Адрес(а) сервера:
if %num% equ 2 ipconfig | find "IPv4 Address"
if %num% equ 2 (%iperf% -s -p %port-server% , exit 0)

if %num% equ 4 cls
if %num% equ 4 set /P port-fw="Введите номер порта или диапазон (по умолчанию: 5201): "
if %num% equ 4 netsh advfirewall firewall add rule name="%port-fw%-Iperf" dir=in action=allow localport=%port-fw% protocol=TCP enable=yes
if %num% equ 4 netsh advfirewall firewall show rule name="%port-fw%-Iperf"
if %num% equ 4 (pause & goto start)


if %num% equ 3 cls
if %num% equ 3 set /P ip="Введите адрес сервера: "

:testing

if %num% equ 3 cls
if %num% equ 3 echo Подключение к серверу: %ip% порт %port-client%
if %num% equ 3 echo 1. Изменить порт сервера (по умолчанию: 5201)
if %num% equ 3 echo 2. Нагрузочное тестирование
if %num% equ 3 echo 3. Стресс-тест джиттера и потери пакетов сети
if %num% equ 3 echo 4. Тест джиттера и потери пакетов RTP-потока
if %num% equ 3 echo 5. Эмуляция траффика 1 Мб/сек
if %num% equ 3 echo 6. Эмуляция траффика 2 Мб/сек
if %num% equ 3 echo 7. Назад

if %num% equ 3 set /P num2="Выберите действие из списка: "

if not defined num2 (cls & echo Не выбран пункт меню, введите номер & pause & goto start)

if %num2% equ 1 cls
if %num2% equ 1 set /P port-client="Введите номер порта (по умолчанию: 5201): "
if %num2% equ 1 goto testing

if %num2% equ 2 cls
if %num2% equ 2 %iperf% -c %ip% -p %port-client% -P 8 -w 32768
if %num2% equ 2 pause & goto testing

if %num2% equ 3 cls
if %num2% equ 3 %iperf% -c %ip% -p %port-client% -u -b 1000M
if %num2% equ 3 pause & goto testing

if %num2% equ 4 cls
if %num2% equ 4 %iperf% -c %ip% -p %port-client% -u -S 0xC0 -l 1500
if %num2% equ 4 pause & goto testing

if %num2% equ 5 cls
if %num2% equ 5 %iperf% -c %ip% -p %port-client% -u -l 1500 -b 1M -d -S 0xC0 -fk -i 5
if %num2% equ 5 pause & goto testing

if %num2% equ 6 cls
if %num2% equ 6 %iperf% -c %ip% -p %port-client% -u -l 1500 -b 2M -d -S 0xC0 -fk -i 5
if %num2% equ 6 pause & goto testing

if %num2% equ 7 goto start

cls 
echo Пункт меню отсутствует в списке 
pause & goto testing