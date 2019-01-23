# -*- coding: utf-8 -
from iso8601 import parse_date
from robot.libraries.BuiltIn import BuiltIn
from datetime import datetime, timedelta
from pytz import timezone
import os
import urllib

js = '''$("{}").eq({}).attr('value', {})'''

def extract_file_name_from_path(fullFilePath):
    return os.path.split(fullFilePath)

def get_items_from_lot(items, lot_id):
    lot_items = []
    for item in items:
        if item['relatedLot'] == lot_id:
            lot_items.append(item)
    return lot_items

def get_webdriver():
    se2lib = BuiltIn().get_library_instance('Selenium2Library')
    return se2lib._current_browser()

def string_lower(string):
    return string.lower()

def string_studly(string):
    decodeString = string.decode('utf-8');
    tempString = decodeString[0].upper()+decodeString[1:];
    return tempString.encode('utf-8')

def convert_date_for_compare(datestr):
    datestr = datetime.strptime(datestr, "%d.%m.%Y %H:%M").strftime("%Y-%m-%d %H:%M")
    date_obj = datetime.strptime(datestr, "%Y-%m-%d %H:%M")
    time_zone = timezone('Europe/Kiev')
    localized_date = time_zone.localize(date_obj)
    return localized_date.strftime('%Y-%m-%d %H:%M:%S.%f%z')

def get_contract_end_date():
    newTime =  datetime.now() + timedelta(days=1)
    return newTime.strftime("%Y-%m-%d") + ' 23:59'

def convert_datetime_for_delivery(isodate):
    iso_dt = parse_date(isodate)
    date_string = iso_dt.strftime("%d-%m-%Y")
    return date_string

def convert_date_for_delivery(date):
    return datetime.strptime(date, '%d.%m.%Y').strftime('%d.%m.%Y %H:%M')

def convert_datetime_for_input(isodate):
    iso_dt = parse_date(isodate)
    date_string = iso_dt.strftime("%d-%m-%Y %H:%M")
    return date_string

def test_documentType_to_option_type(string):
    return {
        u"qualification_documents": 'qualificationDocuments',
        u"eligibility_documents": 'eligibilityDocuments',
        u"financial_documents": 'financialDocuments'
    }.get(string,string)

def convert_method_type_to_controller(string):
    return {
        u"belowThreshold": 'below-threshold',
        u"aboveThresholdUa": 'above-threshold-ua',
        u"aboveThresholdEu": 'above-threshold-eu',
        u"competitiveDialogueEu": "competitive-dialogue-eu",
        u"competitiveDialogueUa": "competitive-dialogue-ua",
        u"aboveThresholdUaDefense": "above-threshold-ua-defense",
    }.get(string, string)

def convert_avi_string_to_common_string(key, reverse = False):
    list = {
        u"ст. 35 п. 2 абз. 1": u"artContestIP" ,
        u"ст. 35 п. 2 абз. 2": u"noCompetition" ,
        u"ст. 35 п. 2 абз. 3": u"quick" ,
        u"ст. 35 п. 2 абз. 4": u"twiceUnsuccessful" ,
        u"ст. 35 п. 2 абз. 5": u"additionalPurchase" ,
        u"ст. 35 п. 2 абз. 6": u"additionalConstruction" ,
        u"ст. 35 п. 2 абз. 7": u"stateLegalServices" ,
        u"artContestIP": u"ст. 35 п. 2 абз. 1" ,
        u"noCompetition": u"ст. 35 п. 2 абз. 2" ,
        u"quick": u"ст. 35 п. 2 абз. 3" ,
        u"twiceUnsuccessful": u"ст. 35 п. 2 абз. 4" ,
        u"additionalPurchase": u"ст. 35 п. 2 абз. 5" ,
        u"additionalConstruction": u"ст. 35 п. 2 абз. 6" ,
        u"stateLegalServices": u"ст. 35 п. 2 абз. 7" ,
        u"Очікує рішення": u"active" ,
        u"Підписаний": u"active" ,
        u"Очікує підписання": u"pending" ,
        u"Кваліфіковано": u"active" ,
        u"Відмінена": u"cancelled" ,
        u"Відмова": u"unsuccessful" ,
        u"Кваліфікація": u"active.qualification" ,
        u"КВАЛІФІКАЦІЯ": u"active.qualification",
        u"Період уточнень": u"active.enquiries" ,
        u"ПЕРІОД УТОЧНЕНЬ": u"active.enquiries" ,
        u"Прийом заявок": u"active.tendering" ,
        u"ПРИЙОМ ПРОПОЗИЦІЙ": u"active.tendering",
        u"ПРЕКВАЛІФІКАЦІЯ": u'active.pre-qualification',
        u"Аукціон": u"active.auction" ,
        u"АУКЦІОН": u"active.auction" ,
        u"пар": u"PR" ,
        u"літр" : u"LTR",
        u"набір" : u"SET",
        u"пачка" : u"RM",
        u"упаковка" :u"PK",
        u"пачок" : u"NMP",
        u"метри" : u"MTR",
        u"ящик" : u"BX",
        u"метри кубічні" : u"MTQ",
        u"рейс" : u"E54",
        u"тони" : u"TNE",
        u"метри квадратні" : u"MTK",
        u"кілометри" : u"KMT",
        u"штуки" : u"H87",
        u"місяць" : u"MON",
        u"лот" : u"LO",
        u"блок" : u"D64",
        u"гектар" : u"HAR",
        u"кілограми" : u"KGM",
        u"кг.": u"KGM",
        u"кг": u"KGM",
        u"Код классификатора ДК 021:2015": u"ДК021",
        u"Код классификатора ДК 016:2010": u"ДКПП",
        u"з ПДВ": True,
        u"aboveThresholdUA.defense": 'aboveThresholdUaDefense',
        u"aboveThresholdUA": 'aboveThresholdUa',
        u"aboveThresholdEU": 'aboveThresholdEu',
        u"competitiveDialogueEU" : "competitiveDialogueEu",
        u"competitiveDialogueUA": "competitiveDialogueUa",
        u"Лотом": 'lot',
        u"Тендером": 'tenderer',
        u"Предметом закупівлі": 'item',
        u"Недійсна пропозиція": 'invalid',
        u"очікує на кваліфікацію": u"pending",
        u"ПРЕКВАЛІФІКАЦІЯ (ПЕРІОД ОСКАРЖЕНЬ)" :u'active.pre-qualification.stand-still',
        u"Вимога": u"claim",
        u"Флакон" : u"VI",
        u"флакон" : u"VI",
        u"VI": u"Флакон",
        u"resolved": True, 
        u"declined": False,
        u"resolution_resolved": u"Задоволено",
        u"resolution_declined": u"Не задоволено",
        u"resolution_invalid":  u"Відхилено",
        u"budget": u"Cпівфінансування з бюджетних коштів",
        u"other":  u"Фінансування виключно за рахунок Учасника",
        u"ОЧІКУЄ ДРУГИЙ ЕТАП": "active.stage2.pending",
        u"ЗАВЕРШЕНА": "complete",
        u"ВИЗНАЧЕННЯ ПЕРЕМОЖЦЯ": "active.qualification",
    }

    if reverse:
         list = {val:key for (key, val) in list.items()}
    return  list.get(key, key)

def procurement_method_types(method, reverse = False):
    list = {
        u"aboveThresholdUA":             u"Відкриті торги",
        u"aboveThresholdEU":             u"Відкриті торги з публікацією англ.мовою",
        u"closeFrameworkAgreementUA":    u"Укладання рамкової угоди",
        u"negotiation":                  u"Переговорна процедура",
        u"negotiation.quick":            u"Переговорна процедура скорочена",
        u"aboveThresholdUA.defense":     u"Переговорна процедура для потреб оборони",
        u"competitiveDialogueUA":        u"Конкурентний діалог",
        u"competitiveDialogueEU":        u"Конкурентний діалог з публікацією англ.мовою",
        u"belowThreshold":               u"Допорогові закупівлі",
        u"reporting":                    u"Звіт про укладений договір",
        u"withoutUsingElectronicSystem": u"Без застосування електронної системи",
        u"esco":                         u"Відкриті торги для закупівлі енергосервісу",
    }

    if reverse:
         list = {val:key for (key, val) in list.items()}

    return  list.get(method)

def currency_types(currency, reverse = False):
    list = {
        u"UAH": u"Гривня",
        u"EUR": u"ЄВРО",
        u"GBP": u"Анг. фунт стерлінгів",
        u"USD": u"Долар США",
        u"RUB": u"Рос. рубль",
    }

    if reverse:
         list = {val:key for (key, val) in list.items()}

    return  list.get(currency)

def main_procurement_category_types(category, reverse = False):
    list = {
        u"goods":    u"Товари",
        u"services": u"Послуги",
        u"works":    u"Роботи",
    }

    if reverse:
         list = {val:key for (key, val) in list.items()}

    return  list.get(category)

def prepare_test_data(tender_data, isComplaints):
    tender_data.data.procuringEntity['name']                    = u'ТОВ 4k-soft'
    tender_data.data.procuringEntity['identifier']['id']        = u'12345678'
    tender_data.data.procuringEntity['identifier']['legalName'] = u'ТОВ 4k-soft'

    if tender_data.data.has_key('budget'):
        tender_data.data['budget']['id'] = tender_data.data.procuringEntity['identifier']['id'] + "-" + tender_data.data['classification']['id']
        tender_data.data['budget']['project']['id']   = ""
        tender_data.data['budget']['project']['name'] = ""
        return tender_data

    if tender_data.data.has_key('funders'):
        if tender_data.data.funders[0]['identifier']['legalName'] == 'Global Fund to Fight AIDS, Tuberculosis and Malaria':
            tender_data.data.funders[0]['identifier']['legalName'] = u'Глобальний Фонд для боротьби зі СНІДом, туберкульозом і малярією'

    tender_data.data.procuringEntity['address']['streetAddress'] = u'Хрещатик, 1'
    tender_data.data.procuringEntity['address']['region']        = u'місто Київ'
    tender_data.data.procuringEntity['address']['locality']      = u'Київ'
    tender_data.data.procuringEntity['address']['postalCode']    = u'12345'

    tender_data.data.procuringEntity['contactPoint']['name']      = u'Чередниченко Олена Юріївна'
    tender_data.data.procuringEntity['contactPoint']['telephone'] = u'+380958956060'
    tender_data.data.procuringEntity['contactPoint']['faxNumber'] = u'+380945454054'
    tender_data.data.procuringEntity['contactPoint']['email']     = u'kmkshvl@ukr.net'
    tender_data.data.procuringEntity['contactPoint']['url']       = u'http://skinmedic.com.ua'

    if tender_data.data.has_key('procurementMethodType') and tender_data.data['procurementMethodType'] == 'competitiveDialogueUA':
        tender_data['data']['tenderPeriod']['endDate'] = subtract_min_from_date(
                    tender_data['data']['tenderPeriod']['endDate'], 20)
  
    # belowThreshold complaints
    if isComplaints and not tender_data.data.has_key('procurementMethodType'):
        if tender_data.data['submissionMethodDetails'] == 'quick':
            tender_data['data']['enquiryPeriod']['endDate'] = add_min_to_date(
                    tender_data['data']['enquiryPeriod']['endDate'], 25) 
            tender_data['data']['tenderPeriod']['startDate'] = add_min_to_date(
                    tender_data['data']['tenderPeriod']['startDate'], 25)  
            tender_data['data']['tenderPeriod']['endDate'] = add_min_to_date(
                    tender_data['data']['tenderPeriod']['endDate'], 10)  

        if tender_data.data['submissionMethodDetails'] == 'quick(mode:fast-forward)':
            tender_data['data']['enquiryPeriod']['endDate'] = subtract_min_from_date(
                    tender_data['data']['enquiryPeriod']['endDate'], 15) 
            tender_data['data']['tenderPeriod']['startDate'] = subtract_min_from_date(
                    tender_data['data']['tenderPeriod']['startDate'], 15)  
            tender_data['data']['tenderPeriod']['endDate'] = subtract_min_from_date(
                    tender_data['data']['tenderPeriod']['endDate'], 20)
            tender_data.data['procurementMethodDetails'] = "quick, accelerator=280"
    # aboveThresholdUA complaints
    if isComplaints and tender_data.data.has_key('procurementMethodType') and tender_data.data['procurementMethodType'] == 'aboveThresholdUA':
         tender_data.data['procurementMethodDetails'] = "quick, accelerator=720"
         # tender_data['data']['tenderPeriod']['endDate'] = subtract_min_from_date(
         #            tender_data['data']['tenderPeriod']['endDate'], 10)

    for item in tender_data.data['items']:
        if item.has_key('deliveryDate'):
            item['deliveryDate']['startDate'] = delivery_date_to_broker_format(item['deliveryDate']['startDate'])
            item['deliveryDate']['endDate']   = delivery_date_to_broker_format(item['deliveryDate']['endDate'])
    return tender_data

def delivery_date_to_broker_format(date):
    adapt_date = ''.join([date[:date.index('T') + 1], '00:00:00', date[date.index('+'):]])
    return adapt_date

def download_document_from_url(url, file_name, output_dir):
    urllib.urlretrieve(url, ('{}/{}'.format(output_dir, file_name)))

def get_percent(value, precision = '0'):
    value = value * 100
    return format(value, '.' + precision + 'f')

def to_percent(value, precision = '3'):
    value = float(value.replace(' ', '').replace('%', '').replace(',', '.'))
    value = value / 100
    return float(format(value, '.' + precision + 'f'))

def date_to_format(date, format):
    return parse_date(date).strftime(format)

def convert_date_for_compare_without_time(datestr):
    iso_dt = parse_date(datestr)
    date_string = iso_dt.strftime("%Y-%m-%d")
    return date_string

def add_min_to_date(date, minutes):
    date_obj = datetime.strptime(date.split("+")[0], '%Y-%m-%dT%H:%M:%S.%f')
    return "{}+{}".format(date_obj + timedelta(minutes=int(minutes)), date.split("+")[1])

def add_min_to_date_without_ms(date, minutes):
    date_obj = datetime.strptime(date.split("+")[0], '%Y-%m-%dT%H:%M:%S')
    return "{}+{}".format(date_obj + timedelta(minutes=int(minutes)), date.split("+")[1])

def subtract_min_from_date(date, minutes):
    date_obj = datetime.strptime(date.split("+")[0], '%Y-%m-%dT%H:%M:%S.%f')
    return "{}+{}".format(date_obj - timedelta(minutes=minutes), date.split("+")[1])

def convert_float_to_string(number):
    return format(number, '.2f')
