#1.	Получите справку о командлете справки

Get-Help Get-Help

#2.	Пункт 1, но детальную справку, затем только примеры

Get-Help Get-Help -Detailed
Get-Help Get-Help -Full
#2. Только примеры
Get-Help Get-Help -Examples

#3.	Получите справку о новых возможностях в PowerShell 4.0 (или выше)

Update-Help 

#Просмотр версии PowerShell

$PSVersionTable

#Просмотр справки о новых возможностях PowerShell
Get-Help about_Windows_PowerShell_5.0 

#4.	Получите все командлеты установки значений

Get-Command *Set*

#5.	Получить список команд работы с файлами

Get-Command *File*

#6.	Получить список команд работы с объектами

Get-Command *Object*

#7.	Получите список всех псевдонимов

Get-Alias 

#8.	Создайте свой псевдоним для любого командлета

Set-Alias -Name gtcmnd -Value Get-Command

#Проверка псевдонима
Get-Help gtcmnd

#9.	Просмотреть список методов и свойств объекта типа процесс

Get-Process | Get-Member | Out-Host

#Только Свойства
Get-Process | Get-Member -MemberType Properties

#Только Методы
Get-Process | Get-Member -MemberType Methods


#10. Просмотреть список методов и свойств объекта типа строка
#Поиск командлетов типа строка
Get-Command *string*

#Просмотрим список методов и свойств объекта типа строка

Out-String | Get-Member | Out-Host

#Только Свойства
Out-String | Get-Member -MemberType Properties

#Только Методы
Out-String | Get-Member -MemberType Methods

#11. Получить список запущенных процессов, данные об определённом процессе

Get-Process

#данные об определённом процессе

Get-Process svchost | Format-List *

#12. Получить список всех сервисов, данные об определённом сервисе

Get-Service

#данные об определённом сервисе

Get-Service wSearch
Get-Service wSearch | Format-List *

#13. Получить список обновлений системы

Get-HotFix

#Подробный список установленных обновлений - скрипт найден в сети Интернет. 
#Просмотрев список выдаваемый COM объектом Microsoft.Update.Session можно узнать обо всех установленных обновлениях.

$Session = New-Object -ComObject Microsoft.Update.Session
$Searcher = $Session.CreateUpdateSearcher()
$HistoryCount = $Searcher.GetTotalHistoryCount()
$Searcher.QueryHistory(1,$HistoryCount) | 
  Select-Object Date, Title, Description


#14. Узнайте, какой язык установлен для UI Windows

Get-UICulture

Get-WinUserLanguageList #Gets the language list for the current user account.

Get-WinUILanguageOverride   #This command gets and displays the UI language override setting for the current user account. 
                            #If the Windows UI language override is not set for the current user account, this command returns a null value.

#ожидаемый результат 
<#S C:\>Get-WinUILanguageOverride
    LCID             Name             DisplayName                                                                        
    
    ----             ----             -----------                                                                        
    
    1033             en-US            English (United States)#>

#Фактический результат
<#  PS C:\Users\Administrator> Get-WinUILanguageOverride

    PS C:\Users\Administrator>  #>

#15. Получите текущее время и дату

Get-Date

#16. Сгенерируйте случайное число (любым способом)

Get-Random

#можно ограничить диапазон и вывести несколько случайных чисел

Get-Random -InputObject (-1000000..1000000) -Count 3

#17. Выведите дату и время, когда был запущен процесс «explorer». Получите какой это день недели.

#вывод процесса explorer.exe
Get-Process explorer

#Вывод даты и времени, когда был запущен процесс «explorer»

(Get-Process -Name explorer).StartTime

#Вывод дня недели

(Get-Process -Name explorer).StartTime.DayOfWeek

#18. Откройте любой документ в MS Word (не важно как) и закройте его с помощью PowerShell

#Открытие документа Word через PowerShell

Invoke-Item 'C:\Test.docx'

#Закрытие открытого документа Word

#Close(WdSaveChanges, wdWordDocument, 'C:\Test.docx')

$wd = [Runtime.Interopservices.Marshal]::GetActiveObject('Word.Application')
$wd.Documents | ? { $_.Name -eq 'Test.docx'} | % {
    $_.Saved = $true
    $_.Close()
}

#19. Подсчитать значение выражения S= . N – изменяемый параметр. Каждый шаг выводить в виде строки. (Пример: На шаге 2 сумма S равна 9)

[int]$S = 0                                                      #объявляем целочисленную переменную S и присваеваем ей значение 0
[int]$N = Read-Host "Введите N (целочисленное значение): "       #Объявляем целочисленную переменную N. Она вводится пользователем
for($i = 1; $i -le $N; $i++)                                     #Задаём цикл для переменной i от 1 до N с увеличением i на 1 (i < N)
{
    $S = $S + $i * 3                                             #Рассчитываем сумму S на каждом шаге 
    Write-Output("На шаге $i Сумма S равна $S ")                 #Выводим значение S на каждом шаге как указано в задании
    }
     

#20. Напишите функцию для предыдущего задания. Запустите её на выполнение.

function sum                                                     #Объявляем функию sum
{
    [int]$S = 0                                                  #объявляем целочисленную переменную S и присваеваем ей значение 0
    [int]$N = Read-Host "Введите N (целочисленное значение): "   #Объявляем целочисленную переменную N. Она вводится пользователем
            for($i = 1; $i -le $N; $i++)                         #Задаём цикл для переменной i от 1 до N с увеличением i на 1 (i < N)
{
                $S = $S + $i * 3                                 #Рассчитываем сумму S на каждом шаге
                Write-Output("На шаге $i Сумма S равна $S ")     #Выводим значение S на каждом шаге как указано в задании
    }
    
}
sum                                                              #Выход из функции

