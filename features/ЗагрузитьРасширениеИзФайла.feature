# language: ru

Функционал: Выгрузка расширений конфигурации
    Как разработчик
    Я хочу иметь возможность выгрузить расширения конфигурации в файл
    Чтобы выполнять коллективную разработку проекта 1С

Контекст:
    Допустим я подготовил репозиторий и рабочий каталог проекта
    И я подготовил рабочую базу проекта "./build/ib" по умолчанию
    Допустим Я копирую файл "Extension1.cfe" из каталога "tests/fixtures" проекта в рабочий каталог
    И Я очищаю параметры команды "oscript" в контексте
    
Сценарий: Загрузка одного расширения из файла с обновлением БД
    И Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os loadext --file Extension1.cfe --extension РасширениеНовое1 --updatedb --ibconnection /F./build/ib"
    И Я показываю вывод команды
    И Я очищаю параметры команды "oscript" в контексте
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os unloadext ./РасширениеНовое1.cfe РасширениеНовое1 --ibconnection /F./build/ib"
    И Я показываю вывод команды
    И Файл "./РасширениеНовое1.cfe" существует
    Тогда Код возврата равен 0
    
Сценарий: Загрузка одного расширения из файла без обновления БД
    И Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os loadext --file Extension1.cfe --extension РасширениеНовое1 --ibconnection /F./build/ib"
    И Я показываю вывод команды
    И Я очищаю параметры команды "oscript" в контексте
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os unloadext ./РасширениеНовое1.cfe РасширениеНовое1 --ibconnection /F./build/ib"
    И Я показываю вывод команды
    И Файл "./РасширениеНовое1.cfe" существует
    Тогда Код возврата равен 0

# TODO Сценарий: Разборка нескольких расширений с явно заданной базой
