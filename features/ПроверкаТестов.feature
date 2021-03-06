# language: ru

Функционал: Проверка запуска и работы xunit-тестов через Ванесса-АДД
	Как Разработчик/Инженер по тестированию
	Я Хочу иметь возможность автоматической проверки запуска тестов через Ванесса-АДД
    Чтобы удостовериться в качестве подготовленной конфигурации

Контекст:
    Допустим я подготовил репозиторий и рабочий каталог проекта
    И я подготовил рабочую базу проекта "./build/ib" по умолчанию

    И Я копирую каталог "xdd_test" из каталога "tests/fixtures" проекта в подкаталог "build" рабочего каталога
    И Я копирую каталог "feature" из каталога "tests/fixtures" проекта в подкаталог "build" рабочего каталога
    И Я копирую файл "xUnitParams.json" из каталога "tests/fixtures" проекта в подкаталог "build" рабочего каталога

Сценарий: Запуск тестирования xunit

    Дано файл "build/xdd_test.epf" не существует
    Дано Я очищаю параметры команды "oscript" в контексте
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os compileepf build/xdd_test build"
    И Я очищаю параметры команды "oscript" в контексте
    Дано файл "build/xdd_test.epf" существует

    Когда Я добавляю параметр "<КаталогПроекта>/src/main.os xunit" для команды "oscript"
    И Я добавляю параметр "build/xdd_test.epf" для команды "oscript"
    И Я добавляю параметр "--ibconnection /Fbuild/ib" для команды "oscript"
    И Я добавляю параметр "--workspace ./build" для команды "oscript"
    И Я добавляю параметр "--xddConfig build/xUnitParams.json" для команды "oscript"
    И Я добавляю параметр "--xddExitCodePath ./build/xddExitCodePath.txt" для команды "oscript"
    Когда Я выполняю команду "oscript"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" содержит
    | Выполняю тесты  с помощью фреймворка Vanessa-ADD (Vanessa Automation Driven Development) |
    | -->> тест ТестДолжен_ЧтоТоСделать |
    | ИНФОРМАЦИЯ - Все тесты выполнены! |
    | Выполнение тестов завершено |

    И Код возврата команды "oscript" равен 0

Сценарий: Падающий тест xunit

    Тогда Файл "build/xdd_test/xdd_test/Ext/ObjectModule.bsl" содержит
    """
        Перем КонтекстЯдра;
        Перем Ожидаем;
        Перем Утверждения;
    """

    Дано Я создаю файл "build/xdd_test/xdd_test/Ext/ObjectModule.bsl" с текстом
    """
        Перем КонтекстЯдра;

        Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
            КонтекстЯдра = КонтекстЯдраПараметр;
        КонецПроцедуры

        Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
            НаборТестов.Добавить("ТестДолжен_Упасть");
        КонецПроцедуры

        Процедура ТестДолжен_Упасть() Экспорт
            ВызватьИсключение "Падаю внутри теста ТестДолжен_Упасть";
        КонецПроцедуры

    """
    И файл "build/xdd_test.epf" не существует
    Дано Я очищаю параметры команды "oscript" в контексте
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os compileepf build/xdd_test build"
    И файл "build/xdd_test.epf" существует
    И Код возврата команды "oscript" равен 0
    И Я очищаю параметры команды "oscript" в контексте

    Когда Я добавляю параметр "<КаталогПроекта>/src/main.os xunit" для команды "oscript"
    И Я добавляю параметр "build/xdd_test.epf" для команды "oscript"
    И Я добавляю параметр "--ibconnection /Fbuild/ib" для команды "oscript"
    И Я добавляю параметр "--workspace ./build" для команды "oscript"
    И Я добавляю параметр "--xddConfig build/xUnitParams.json" для команды "oscript"
    И Я добавляю параметр "--xddExitCodePath ./build/xddExitCodePath.txt" для команды "oscript"
    Когда Я выполняю команду "oscript"
    Тогда Вывод команды "oscript" содержит
    | -->> тест ТестДолжен_Упасть |
    | Выполняю тесты  с помощью фреймворка Vanessa-ADD (Vanessa Automation Driven Development) |
    | ОШИБКА - Часть тестов упала! |

    И Код возврата команды "oscript" равен 1

Сценарий: Отсутствующий тест xunit

    Тогда Файл "build/xdd_test/xdd_test/Ext/ObjectModule.bsl" содержит
    """
        Перем КонтекстЯдра;
        Перем Ожидаем;
        Перем Утверждения;
    """

    Дано Я создаю файл "build/xdd_test/xdd_test/Ext/ObjectModule.bsl" с текстом
    """
        Перем КонтекстЯдра;

        Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
            КонтекстЯдра = КонтекстЯдраПараметр;
        КонецПроцедуры

        Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
            НаборТестов.Добавить("ТестДолжен_БытьПропущен");
        КонецПроцедуры

        Процедура ТестДолжен_БытьПропущен() //Экспорт специально отключен
        КонецПроцедуры

    """
    И файл "build/xdd_test.epf" не существует
    Дано Я очищаю параметры команды "oscript" в контексте
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os compileepf build/xdd_test build"
    И файл "build/xdd_test.epf" существует
    И Код возврата команды "oscript" равен 0
    И Я очищаю параметры команды "oscript" в контексте

    Когда Я добавляю параметр "<КаталогПроекта>/src/main.os xunit" для команды "oscript"
    И Я добавляю параметр "build/xdd_test.epf" для команды "oscript"
    И Я добавляю параметр "--ibconnection /Fbuild/ib" для команды "oscript"
    И Я добавляю параметр "--workspace ./build" для команды "oscript"
    И Я добавляю параметр "--xddConfig build/xUnitParams.json" для команды "oscript"
    И Я добавляю параметр "--xddExitCodePath ./build/xddExitCodePath.txt" для команды "oscript"
    Когда Я выполняю команду "oscript"
    Тогда Вывод команды "oscript" содержит
    | -->> тест ТестДолжен_БытьПропущен |
    | Выполняю тесты  с помощью фреймворка Vanessa-ADD (Vanessa Automation Driven Development) |
    | ИНФОРМАЦИЯ - Все тесты выполнены! |
    | Выполнение тестов завершено |
    # | ПРЕДУПРЕЖДЕНИЕ - Ошибок при тестировании не найдено, но часть тестов еще не реализована! |

    И Код возврата команды "oscript" равен 0
    # И Код возврата команды "oscript" равен 2
