﻿
Процедура ПередОткрытием(Отказ, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СхемаКомпоновкиДанных = ПолучитьМакет("РасшифровкаПоЗРС");
	
	Параметры = КомпоновщикНастроек.Настройки.ПараметрыДанных;
		
	Параметры.УстановитьЗначениеПараметра("НаДату", НаДату);
	Параметры.УстановитьЗначениеПараметра("ДоговорКонтрагента", ДоговорКонтрагента);
	
КонецПроцедуры

Процедура ПриОткрытии()
	

КонецПроцедуры


