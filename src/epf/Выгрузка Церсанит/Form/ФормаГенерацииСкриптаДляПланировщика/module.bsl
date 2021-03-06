﻿
Процедура ЭлФайлСкриптаНачалоВыбора(Элемент, СтандартнаяОбработка)
	Перем ДиалогВыбора;
	
	ДиалогВыбора				= Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбора.Фильтр			= "CISLinkUnloader.cmd|CISLinkUnloader.cmd|Файлы (*.cmd)|*.cmd|Все файлы (*.*)|*.*";
	ДиалогВыбора.ПолноеИмяФайла	= "CISLinkUnloader.cmd";
	ДиалогВыбора.Расширение		= "*.cmd";
	
	Если ДиалогВыбора.Выбрать() Тогда
		Элемент.Значение = ДиалогВыбора.ПолноеИмяФайла;
	КонецЕсли;
КонецПроцедуры//ЭлФайлСкриптаНачалоВыбора()

Процедура ПриОткрытии()
	Перем ЮзерХ,СписокВыбораСпПользователей;
	
	СписокВыбора	= ЭлементыФормы.ЭлЮзер.СписокВыбора;
	СпПользователей	= ПользователиИнформационнойБазы.ПолучитьПользователей();
	Для Каждого ЮзерХ Из СпПользователей Цикл
		СписокВыбора.Добавить(ЮзерХ.Имя);
	КонецЦикла;
КонецПроцедуры//ПриОткрытии()

Процедура КнОКНажатие(Элемент)
	Перем ФайлТхт;
	
	ФайлТхт = Новый ЗаписьТекста(ФайлСкрипта,КодировкаТекста.OEM);
	ФайлИБ = СокрЛП(СтрЗаменить(СтрЗаменить(СтрокаСоединенияИнформационнойБазы(),"File=",""),";",""));
	Если Лев(ФайлИБ,1) <> """" Тогда
		ФайлИБ = """" + ФайлИБ;
	КонецЕсли;
	
	Если Прав(ФайлИБ,1) <> """" Тогда
		ФайлИБ = ФайлИБ + """";
	КонецЕсли;
	
	ФайлТхт.Записать(
			"""" + КаталогПрограммы() + "1cv8.exe"" Enterprise /F" + ФайлИБ
		+	" /N""" + Юзер + """"
		+	?(ПустаяСтрока(Пароль),"","/P""" + Пароль + """")
		+	" /Execute""" + ПутьКОбработке + """"
	);
	ФайлТхт.Закрыть();
	
	Сообщить(
		"Создан скрипт """ + ФайлСкрипта + """. Добавьте его в планировщик Windows для периодического запуска обработки !"
	,	СтатусСообщения.Информация
	);
	
	Если Вопрос("Запустить скрипт ?",РежимДиалогаВопрос.ДаНет,5) = КодВозвратаДиалога.Да Тогда
		ЗапуститьПриложение(ФайлСкрипта);
	КонецЕсли;
	
	ЭтаФорма.Закрыть();
КонецПроцедуры//КнОКНажатие()

Процедура ОбновлениеОтображения()
	Если ПустаяСтрока(ФайлСкрипта) или ПустаяСтрока(Юзер) Тогда
		ЭлементыФормы.КнОК.Доступность = Ложь;
	Иначе
		ЭлементыФормы.КнОК.Доступность = Истина;
	КонецЕсли;
КонецПроцедуры//ОбновлениеОтображения()
