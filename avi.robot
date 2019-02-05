*** Settings ***
Library  String
Library  DateTime
Library  avi_service.py
Library  Collections

*** Variables ***

${locator.tenderId}                                            id=tenderId
${locator.title}                                               id=tenderTitle
${locator.title_en}                                            id=tenderTitleEn
${locator.description}                                         id=tenderDescription
${locator.description_en}                                      id=tenderDescriptionEn
${locator.cause}                                               id=tenderCause
${locator.causeDescription}                                    id=tenderCauseDescription
${locator.minimalStep.amount}                                  id=tenderMinimalStepAmount

${locator.procuringEntity.name}                                id=procuringEntityName

${locator.procuringEntity.address.countryName}                 id=procuringEntityAddressCountryName
${locator.procuringEntity.address.region}                      id=procuringEntityAddressRegion
${locator.procuringEntity.address.locality}                    id=procuringEntityAddressLocality
${locator.procuringEntity.address.streetAddress}               id=procuringEntityAddressStreetAddress
${locator.procuringEntity.address.postalCode}                  id=procuringEntityAddressPostalCode

${locator.awards.suppliers.name}                               css=.award-suppliers-name
${locator.awards.status}                                       css=.award-status
${locator.contracts.status}                                    css=.contract-status
${locator.awards.complaintPeriod.startDate}                    css=.awardComplaintPeriodStart
${locator.awards.complaintPeriod.endDate}                      css=.awardComplaintPeriodEnd
${locator.awards.value.amount}                                 css=.award-value-amount
${locator.awards.value.currency}                               css=.award-value-currency

${locator.award.suppliers.identifier.scheme}                   css=.award-suppliers-identifier-scheme
${locator.award.suppliers.identifier.id}                       css=.award-suppliers-identifier-id

${locator.awards.suppliers.address.countryName}                css=.award-suppliers-address-countryName
${locator.awards.suppliers.address.region}                     css=.award-suppliers-address-region
${locator.awards.suppliers.address.locality}                   css=.award-suppliers-address-locality
${locator.awards.suppliers.address.streetAddress}              css=.award-suppliers-address-streetAddress
${locator.awards.suppliers.address.postalCode}                 css=.award-suppliers-address-postalCode

${locator.awards.suppliers.contactPoint.name}                  css=.award-suppliers-contactPoint-name
${locator.awards.suppliers.contactPoint.telephone}             css=.award-suppliers-contactPoint-telephone
${locator.awards.suppliers.contactPoint.email}                 css=.award-suppliers-contactPoint-email

${locator.procuringEntity.contactPoint.name}                   id=procuringEntityContactPointName
${locator.procuringEntity.contactPoint.telephone}              id=procuringEntityContactPointTelephone
${locator.procuringEntity.contactPoint.url}                    id=procuringEntityContactPointUrl

${locator.procuringEntity.identifier.legalName}                id=procuringEntityIdentifierLegalName
${locator.procuringEntity.identifier.scheme}                   id=procuringEntityIdentifierScheme
${locator.procuringEntity.identifier.id}                       id=procuringEntityIdentifierId

${locator.value.valueAddedTaxIncluded}                         id=tenderValueTax
${locator.value.amount}                                        id=tenderValueAmount
${locator.value.currency}                                      id=tenderValueCurrency

${locator.auctionPeriod.startDate}                             id=auctionPeriodStart
${locator.tenderPeriod.startDate}                              id=tenderPeriodStart
${locator.tenderPeriod.endDate}                                id=tenderPeriodEnd

${locator.enquiryPeriod.startDate}                             id=enquiryPeriodStart
${locator.enquiryPeriod.endDate}                               id=enquiryPeriodEnd
${locator.enquiryPeriod.clarificationsUntil}                   id=enquiryPeriodClarificationsUntil

${locator.qualificationPeriod.endDate}                         id=qualificationPeriodEnd

${locator.items.deliveryAddress.streetAddress}                 address
${locator.items.deliveryAddress.locality}                      locality
${locator.items.deliveryAddress.region}                        region
${locator.items.deliveryAddress.postalCode}                    postal_code
${locator.items.deliveryAddress.countryName}                   country

${locator.items.deliveryLocation.longitude}                    delivery-location-longitude
${locator.items.deliveryLocation.latitude}                     delivery-location-latitude
${locator.items.deliveryDate.startDate}                        delivery-start-date
${locator.items.deliveryDate.endDate}                          delivery-end-date
${locator.items.classification.id}                             classification-id
${locator.items.classification.description}                    classification-description
${locator.items.classification.scheme}                         classification-scheme
${locator.items.additionalClassifications[0].id}               classification-id-additional
${locator.items.additionalClassifications[0].description}      classification-description-additional
${locator.items.additionalClassifications[0].scheme}           classification-scheme-additional
${locator.items.unit.name}                                     unit-name
${locator.items.quantity}                                      item-quantity
${locator.items.description}                                   item-description
${locator.items.deliveryAddress.countryName_en}                country_en
${locator.questions[0].title}                                  css=.question-title
${locator.questions[0].description}                            css=.question-description
${locator.questions[0].date}                                   css=.question-date
${locator.questions[0].answer}                                 css=.question-answer

${locator.status}                                              id=currentStatus
${locator.auction_link}                                        css=.tender-auction-link

${locator.document.title}                                      css=.tender-document-title


${locator.funders[0].name}                                     id=funderName
${locator.funders[0].identifier.scheme}                        id=funderIdentifierScheme
${locator.funders[0].identifier.legalName}                     id=funderIdentifierLegalName
${locator.funders[0].identifier.id}                            id=funderIdentifierId
${locator.funders[0].address.countryName}                      id=funderAddressCountryName
${locator.funders[0].address.locality}                         id=funderAddressLocality
${locator.funders[0].address.postalCode}                       id=funderAddressPostalCode
${locator.funders[0].address.region}                           id=funderAddressRegion
${locator.funders[0].address.streetAddress}                    id=funderAddressStreetAddress
${locator.funders[0].contactPoint.url}                         id=funderContactPointUrl

*** Keywords ***
Підготувати дані для оголошення тендера
  [Arguments]  ${userName}  ${tenderData}  ${role_name}

  ${isComplaints}=  Run Keyword And Return Status
  ...  Should Be Equal  '${SUITE NAME}'  'Tests Files.Complaints'

  ${tenderData}=      prepare_test_data  ${tenderData}  ${isComplaints}
  ${lotsExist}=        Run Keyword And Return Status   Dictionary Should Contain Key  ${tenderData.data}  lots
  Set Global Variable  ${lotsExist}   ${lotsExist}
  [return]             ${tenderData}

Підготувати клієнт для користувача
  [Arguments]  ${userName}

  ${alias}=              Catenate   SEPARATOR=   role_  ${username}
  Set Global Variable    ${BROWSER_ALIAS}  ${alias}

  Open Browser         ${BROKERS['${broker}'].homepage}  ${USERS.users['${userName}'].browser}  alias=${alias}
  Set Window Size      @{USERS.users['${userName}'].size}
  Set Window Position  @{USERS.users['${userName}'].position}

  Run Keyword And Ignore Error   Закрити банера
  Run Keyword If       '${userName}' != 'avi_Viewer'  Login  ${userName}

Закрити банера
  Wait Until Element Is Visible  css=.danger_notif   30
  Execute Javascript             $('.close').trigger('click');
  Sleep                          1

Очиcтити фільтр
  Wait Until Element Is Visible   css=.create-filter  10
  Click Element                   xpath=//a[@href='/prozorro/tender/index']

Login
  [Arguments]  ${userName}
  Wait Until Element Is Visible   id=login-button  30
  Click Element                   id=login-button
  Sleep                           1
  Wait Until Element Is Visible   id=login-form-login    30
  Input text                      xpath=//input[contains(@id, 'login-form-login')]     ${USERS.users['${userName}'].login}
  Input text                      xpath=//input[contains(@id, 'login-form-password')]  ${USERS.users['${userName}'].password}
  Click Element                   id=login-form-button
  Wait Until Element Is Visible   css=.logout  30

Заповнити періоди в допорогах
  [Arguments]  ${tenderData}
  ${enquiry_endDate}=  Get From Dictionary   ${tenderData.data.enquiryPeriod}  endDate
  ${enquiry_endDate}=  convert_datetime_for_input   ${enquiry_endDate}
  Execute Javascript    $('#${procurementMethodTypeLower}-enquiryperiod-enddate').val('${enquiry_endDate}');
  ${startDate}=        Get From Dictionary   ${tenderData.data.tenderPeriod}  startDate
  ${startDate}=        convert_datetime_for_input   ${startDate}
  ${endDate}=          Get From Dictionary   ${tenderData.data.tenderPeriod}  endDate
  ${endDate}=          convert_datetime_for_input   ${endDate}
  Execute Javascript    $('#${procurementMethodTypeLower}-tenderperiod-startdate').val('${startDate}');
  Execute Javascript    $('#${procurementMethodTypeLower}-tenderperiod-enddate').val('${endDate}');

Заповнити період пропозицій
  [Arguments]  ${tenderData}
  ${endDate}=  Get From Dictionary   ${tenderData.data.tenderPeriod}   endDate
  ${endDate}=  convert_datetime_for_input   ${endDate}
  Execute JavaScript  $('#${procurementMethodTypeLower}-tenderperiod-enddate').val('${endDate}');

Обрати класифікатор
  [Arguments]  ${boxDivId}  ${classification}  ${divIndex}=0

  Execute Javascript  $($('#${boxDivId} div[data-index="${divIndex}"]').first().find('input[type="hidden"]')[0]).val('${classification.id}');
  Execute Javascript  $($('#${boxDivId} div[data-index="${divIndex}"]').first().find('input[type="hidden"]')[1]).val('${classification.description}');
  Execute Javascript  $($('#${boxDivId} div[data-index="${divIndex}"]').first().find('input[type="hidden"]')[2]).val('${classification.scheme}');

  Sleep               2

Створити тендер
  [Arguments]   ${userName}   ${tenderData}
  ${procurementTypeExist}=    Run Keyword And Return Status   Dictionary Should Contain Key  ${tenderData.data}  procurementMethodType
  ${procurementMethodType}=   Run Keyword If  ${procurementTypeExist}  Get From Dictionary  ${tenderData.data}   procurementMethodType
  ...  ELSE  Convert To String    belowThreshold
  ${procurementMethodType}=  Set Variable If  '${procurementMethodType}' == 'esco'  energy  ${procurementMethodType}
  ${procurementMethodType}=  convert_avi_string_to_common_string  ${procurementMethodType}

  Set Global Variable  ${procurementMethodType}
  ${procurementMethodTypeLower}=   string_lower    ${procurementMethodType}
  Set Global Variable  ${procurementMethodTypeLower}
  ${procurementMethodTypeStudly}=   string_studly    ${procurementMethodType}
  Set Global Variable  ${procurementMethodTypeStudly}

  Run keyword And Return If  '${procurementMethodType}' == 'reporting'  avi.Створити звіт  ${userName}  ${tenderData}

  Wait Until Page Contains Element   id=add_tender    0

  ${controller}=   convert_method_type_to_controller   ${procurementMethodType}
  Клацнути і дочекатися  id=add_tender   xpath=//a[contains(@href, '${controller}/create')]  0
  Click Element          xpath=//a[contains(@href, '${controller}/create')]

  Run Keyword IF  ${lotsExist}  Execute Javascript  setMySwitchBox('${procurementMethodTypeLower}-multilots', '${lotsExist}')

  Wait Until Page Contains Element  xpath=//input[contains(@id, '${procurementMethodTypeLower}-title')]

  ${hasFunder}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data}  funders
  Run Keyword If  ${hasFunder}  Run Keywords
  ...  Select Checkbox  id=w1-BelowThreshold-has-donor
  ...  AND  Sleep       1
  ...  AND  Execute Javascript  setMySelectBox('w1-BelowThreshold-donor', '${tenderData.data.funders[0].name}');

  ${hasMainProcurementCategory}=    Run Keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data}  mainProcurementCategory
  ${mainProcurementCategoryLabel}=  Run Keyword If  ${hasMainProcurementCategory}  main_procurement_category_types  ${tenderData.data.mainProcurementCategory}

  Run Keyword If  ${hasMainProcurementCategory}
  ...  Execute Javascript  setMySelectBox("${procurementMethodTypeLower}-mainprocurementcategory", "${mainProcurementCategoryLabel}");

  ${hasTitleEn}=       Run Keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data}  title_en
  ${hasTitleEnInput}=  Run Keyword And Return Status  Element Should Be Visible  id=${procurementMethodTypeLower}-titleen

  Input text    xpath=//input[@id='${procurementMethodTypeLower}-title']           ${tenderData.data.title}
  Input text    xpath=//textarea[@id='${procurementMethodTypeLower}-description']  ${tenderData.data.description}

  Run keyword If  ${hasTitleEn} and ${hasTitleEnInput}  Run Keywords
  ...       Input text  xpath=//input[@id='${procurementMethodTypeLower}-titleen']           ${tenderData.data.title_en}
  ...  AND  Input text  xpath=//textarea[@id='${procurementMethodTypeLower}-descriptionen']  ${tenderData.data.description_en}

  ${hasFundingKind}=  Run keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data}  fundingKind
  ${fundingKind}=     Run Keyword If  ${hasFundingKind}  convert_avi_string_to_common_string  ${tenderData.data.fundingKind}
  Run keyword If  ${hasFundingKind}  Execute Javascript  setMySelectBox('${procurementMethodTypeLower}-fundingkind', '${fundingKind}');


  ${hasNBUdiscountRate}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data}  NBUdiscountRate
  ${NBUdiscountRate}=  Run Keyword If  ${hasNBUdiscountRate}  get_percent  ${tenderData.data.NBUdiscountRate}  3
  ${NBUdiscountRate}=  Convert To String  ${NBUdiscountRate}

  Run keyword If  ${hasNBUdiscountRate}  Input Text  id=${procurementMethodTypeLower}-nbudiscountrate  ${NBUdiscountRate}


  ${hasMinimalStepPercentage}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data}  minimalStepPercentage
  ${minimalStepPercentage}=  Run Keyword If  ${hasMinimalStepPercentage}  get_percent  ${tenderData.data.minimalStepPercentage}  3
  ${minimalStepPercentage}=  Convert To String  ${minimalStepPercentage}

  Run keyword If  ${hasMinimalStepPercentage} and ${lotsExist} == ${False}
  ...  Input Text  id=${procurementMethodTypeLower}-minimalsteppercentage  ${minimalStepPercentage}

  ${causeExist}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data}  cause
  ${cause}=       Run Keyword If  ${causeExist}  Get From Dictionary  ${tenderData.data}  cause
  ${cause}=       convert_avi_string_to_common_string    ${cause}
  Run Keyword If  ${causeExist}  Execute Javascript  setMySelectBox("${procurementMethodTypeLower}-cause", "${cause}");

  ${causeDescriptionExist}=  Run Keyword And Return Status   Dictionary Should Contain Key  ${tenderData.data}  causeDescription
  ${causeDescription}=       Run Keyword If  ${causeDescriptionExist}  Get From Dictionary  ${tenderData.data}  causeDescription
  Run Keyword If  ${causeDescriptionExist}  Input Text  xpath=//*[contains(@id, '${procurementMethodTypeLower}-causedescription')]  ${causeDescription}

  ${hasValue}=     Run Keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data}  value
  ${valueAmount}=  Run Keyword If  ${hasValue}  Get From Dictionary  ${tenderData.data.value}  amount
  ...  ELSE  Convert To String   ''
  ${valueAmount}=  Convert To String  ${valueAmount}

  ${hasMinimalStep}=     Run Keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data}  minimalStep
  ${minimalStepAmount}=  Run Keyword If  ${hasMinimalStep}  Get From Dictionary  ${tenderData.data.minimalStep}  amount
  ...  ELSE  Convert To String   ''
  ${minimalStepAmount}=  Convert To String  ${minimalStepAmount}

  Run Keyword If  ${hasValue} and ${lotsExist} == ${False}
  ...  Input Text  xpath=//input[contains(@id, '${procurementMethodTypeStudly}-value-amount')]  ${valueAmount}
  Run keyword If  ${hasMinimalStep} and ${lotsExist} == ${False}
  ...  Input Text  xpath=//input[contains(@id, 'minimalStep-amount')]  ${minimalStepAmount}

  ${valueAddedTaxIncluded}=  Run keyword If  ${hasValue}  Get From Dictionary  ${tenderData.data.value}  valueAddedTaxIncluded
  Run keyword If  ${hasValue}  Execute Javascript  setMySwitchBox('${procurementMethodTypeStudly}-value-valueAddedTaxIncluded', '${valueAddedTaxIncluded}')

  Run Keyword If  '${procurementMethodType}' == 'belowThreshold'  Заповнити періоди в допорогах  ${tenderData}

  ${hasTenderPeriod}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data}  tenderPeriod
  Run Keyword If  ${hasTenderPeriod} and '${procurementMethodType}' != 'belowThreshold'  Заповнити період пропозицій  ${tenderData}


  ${hasContactPoint}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${tenderData.data.procuringEntity}  contactPoint
  Run keyword If  ${hasContactPoint}  Додати контактну особу до тендера  ${tenderData.data.procuringEntity.contactPoint}  contactPoint

  @{features}=   Create List
  ${hasFeatures}=  Run Keyword And Return Status  List Should Contain Value  ${tenderData.data}  features
  @{features}=  Run Keyword If  ${hasFeatures}  Get From Dictionary  ${tenderData.data}  features
  Run Keyword If   ${hasFeatures}   Додати перший неціновий показник   ${features[1]}

  Scroll Page To Element  id=accelerator-box
  Click Element           xpath=//h3[contains(., 'Параметри прискореня')]
  Sleep                   1


  ${procurementMethodDetails}=  Get From Dictionary  ${tenderData.data}  procurementMethodDetails
  ${accelerator}=               Replace String  ${procurementMethodDetails}  quick, accelerator=  ${EMPTY}

  Input Text                    id=${procurementMethodTypeLower}-accelerator  ${accelerator}

  ${hasSubmissionMethodDetails}=  Run Keyword And Return Status
  ...  Dictionary Should Contain Key  ${tenderData.data}  submissionMethodDetails
  ${submissionMethodDetails}=  Set Variable If   ${hasSubmissionMethodDetails}  ${tenderData.data.submissionMethodDetails}  quick
  ${submissionMethodDetails}=  Set Variable If  '${submissionMethodDetails}' == 'quick'  Просте прискорення  Прискорення зі статусом аукціона, без проведення аукціону

  Execute Javascript  setMySelectBox('${procurementMethodTypeLower}-submissionmethoddetails', "${submissionMethodDetails}");

  Click Element   id=next
  ${items}=  Get From Dictionary   ${tenderData.data}  items
  ${lots}=  Run Keyword If  ${lotsExist}  Get From Dictionary  ${tenderData.data}  lots
  Run Keyword IF
   ...  ${lotsExist}  Додати лоти   ${lots}   ${items}   ${features}
   ...  ELSE  Додати предмети до закупівлі   ${items}  ${features}

  Клацнути і дочекатися  id=endEdit   id=publication   10
  ${tenderId}=   Отримати інформацію про tenderId
  Click Element  id=publication
  Wait Until Keyword Succeeds   15 x   5 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   id=tenderId-${tenderId}

  Click Element  id=tenderId-${tenderId}
  Wait Until Page Contains Element     id=tenderId     5

  Run Keyword And Return  Отримати інформацію про tenderId

Додати контактну особу до тендера
  [Arguments]   ${contactPoint}  ${formFieldName}
  Input text  id=${formFieldName}-name       ${contactPoint.name}
  Input text  id=${formFieldName}-email      ${contactPoint.email}
  Input text  id=${formFieldName}-faxNumber  ${contactPoint.faxNumber}

  Execute Javascript  $('#${formFieldName}-telephone').val(null);
  Sleep               1

  Input text  id=${formFieldName}-telephone  ${contactPoint.telephone}
  Input text  id=${formFieldName}-url        ${contactPoint.url}

  ${hasNameEn}=       Run Keyword And Return Status  Dictionary Should Contain Key  ${contactPoint}  name_en
  ${hasNameEnInput}=  Run Keyword And Return Status  Element Should Be Visible  id=${formFieldName}-nameEn
  Run Keyword If  ${hasNameEn} and ${hasNameEnInput}  Input Text  id=${formFieldName}-nameEn  ${contactPoint.name_en}

  ${hasAvailableLanguage}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${contactPoint}  availableLanguage
  Run Keyword If  ${hasAvailableLanguage}  Execute Javascript  setMySelectBox('${formFieldName}-language', '${contactPoint.availableLanguage}');

Додати неціновий показник
  [Arguments]   ${feature}   ${featureIndex}
  Wait Until Element Is Visible  id=feature-features-${featureIndex}-title
  Input Text   id=feature-features-${featureIndex}-title   ${feature.title}
  Input Text   id=feature-features-${featureIndex}-description   ${feature.description}
  @{enums}=    Get From Dictionary   ${feature}   enum
  ${countEnums}=   Get Length   ${enums}
  : FOR  ${optionIndex}  IN RANGE  0  ${countEnums}
  \   Run Keyword If    ${optionIndex} > 1   Click Element   xpath=//div[contains(@class, 'field-feature-features-${featureIndex}-options')]//div[contains(@class, 'add-enum')]
  \   Input Text   id=feature-features-${featureIndex}-options-${optionIndex}-title   ${enums[${optionIndex}].title}
  \  ${enumValue}=   get_percent  ${enums[${optionIndex}].value}
  \  ${enumValue}=   Convert to String   ${enumValue}
  \   Input Text   id=feature-features-${featureIndex}-options-${optionIndex}-value   ${enumValue}

Додати перший неціновий показник
  [Arguments]   ${feature}
  Click Element   xpath=//h3[contains(.,'Нецінові показники')]
  Wait Until Page Contains   Назва показника
  Додати неціновий показник    ${feature}   0

Додати неціновий показник на предмет
  [Arguments]  ${userName}  ${tenderId}  ${feature}  ${itemId}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Click Element                  id=editTender
  Wait Until Element Is Visible  css=.edit-item
  Click Element                  css=.edit-item

  Wait Until Element Is Visible  xpath=//h3[text()='Нецінові показники предмету закупівлі']
  Execute Javascript             showAllCollapsed();
  Sleep                          2
  Scroll Page To Element         css=.box-default h3:contains("Нецінові показники предмету закупівлі")

  Click Element                  xpath=//div[contains(text(), 'Додати новий показник')]
  Wait Until Element Is Visible  id=feature-features-1-title
  Додати неціновий показник      ${feature}   1
  Click Element                  id=next
  Sleep                          2
  ${isShownWarningModal}=  Run Keyword And Return Status  Element Should Be Visible  id=confirm-modal
  Run Keyword If  ${isShownWarningModal}  Run Keywords
   ...  Click Element  xpath=//div[@id='confirm-modal']//button[@type='submit']
   ...  AND  Sleep     1

  Wait Until Element Is Visible  id=endEdit
  Click Element                  id=endEdit
  Wait Until Element Is Visible  id=tenderId

Додати неціновий показник на лот
  [Arguments]  ${userName}  ${tenderId}  ${feature}  ${lotId}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Click Element                     id=editTender
  Wait Until Element Is Visible     css=.edit-lot
  Click Link                        css=.edit-lot

  Wait Until Element Is Visible  xpath=//h3[text()='Нецінові показники лоту']
  Execute Javascript             showAllCollapsed();
  Sleep                          2
  Scroll Page To Element         css=.box-default h3:contains("Нецінові показники лоту")

  Click Element                  xpath=//div[text()= 'Додати новий показник']
  Wait Until Element Is Visible  id=feature-features-1-title
  Додати неціновий показник      ${feature}  1
  Click Element                  id=next
  Wait Until Element Is Visible  id=endEdit
  Click Element                  id=endEdit
  Wait Until Element Is Visible  id=tenderId

Додати неціновий показник на тендер
  [Arguments]  ${userName}  ${tenderId}  ${feature}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Wait Until Element Is Visible     id=editTender
  Click Element                     id=editTender
  Wait Until Element Is Visible     id=editTender
  Click Element                     id=editTender
  Scroll Page To Element            id=next
  Click Element                     xpath=//div[contains(text(), 'Додати новий показник')]
  Wait Until Page Contains          Назва показника
  Додати неціновий показник         ${feature}   1
  Click Element                  id=next
  Wait Until Element Is Visible  id=endEdit
  Click Element                  id=endEdit
  Wait Until Element Is Visible  id=tenderId

Видалити неціновий показник з предмету
  [Arguments]   ${featureId}
  Click Link                css=.edit-item
  Wait Until Page Contains  Нецінові показники предмету закупівлі
  ${inputId}=               Get Element Attribute   xpath=//input[contains(@value, '${featureId}')]@id
  Execute Javascript        $('#${inputId}').closest('tr').find('.js-input-remove').click();
  Sleep                     1
  Click Element             id=next
  Sleep          2
  ${isShownWarningModal}=  Run Keyword And Return Status  Element Should Be Visible  id=confirm-modal
  Run Keyword If  ${isShownWarningModal}  Run Keywords
   ...  Click Element  xpath=//div[@id='confirm-modal']//button[@type='submit']
   ...  AND  Sleep     1


Видалити неціновий показник з лоту
  [Arguments]   ${featureId}
  Click Link                css=.edit-lot
  Wait Until Page Contains  Нецінові показники лоту
  ${inputId}=               Get Element Attribute   xpath=//input[contains(@value, '${featureId}')]@id
  Execute Javascript        $('#${inputId}').closest('tr').find('.js-input-remove').click();
  Sleep                     1
  Click Element             id=next

Видалити неціновий показник з тендеру
  [Arguments]   ${featureId}
  Click Link                id=editTender
  Wait Until Page Contains  Нецінові показники закупівлі
  ${inputId}=               Get Element Attribute   xpath=//input[contains(@value, '${featureId}')]@id
  Execute Javascript        $('#${inputId}').closest('tr').find('.js-input-remove').click();
  Sleep                     1
  Click Element             id=next

Видалити неціновий показник
  [Arguments]  ${userName}  ${tenderId}  ${featureId}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  ${of}=   avi.Отримати інформацію із нецінового показника   ${userName}   ${tenderId}   ${featureId}   featureOf
  Reload Page
  Wait Until Element Is Visible   id=editTender  30
  Click Element                   id=editTender
  Wait Until Element Is Visible   id=endEdit
  Run Keyword If  '${of}' == 'lot'       Видалити неціновий показник з лоту      ${featureId}
  Run Keyword If  '${of}' == 'item'      Видалити неціновий показник з предмету  ${featureId}
  Run Keyword If  '${of}' == 'tenderer'  Видалити неціновий показник з тендеру  ${featureId}
  Wait Until Element Is Visible  id=endEdit
  Click Element                  id=endEdit
  Wait Until Element Is Visible  id=tenderId

Клацнути і дочекатися
  [Arguments]  ${click_locator}  ${wanted_locator}  ${timeout}
  [Documentation]
  ...      click_locator: Where to click
  ...      wanted_locator: What are we waiting for
  ...      timeout: Timeout
  Click Element  ${click_locator}
  Sleep    2
  Wait Until Page Contains Element  ${wanted_locator}  ${timeout}

На початок сторінки
  Execute Javascript  $(window).scrollTop(0);
  Sleep               1

Пошук тендера по ідентифікатору
  [Arguments]  ${userName}  ${tenderId}  ${secondStage}=${None}

  Switch Browser  ${BROWSER_ALIAS}

  Run Keyword And Return If   "UA-P" in "${tenderId}"   avi.Пошук плану по ідентифікатору   ${userName}   ${tenderId}

  Run Keyword And Ignore Error    Очиcтити фільтр
  На початок сторінки

  ${isTenderViewPage}=   Run Keyword And Return Status
  ...  Element Should Be Visible  xpath=//a[@href='#items' or @href='#lots']

  #Дополнительная проверка для Конкуретнтного диалога
  ${checkTenderId}=  Run Keyword And Return Status
  ...  Element Should Be Visible  xpath=//span[@id='tenderId' and text()='${tenderId}']

  Return From Keyword If  ${isTenderViewPage} and ${checkTenderId}  ${True}

  Wait Until Element Is Visible   id=main-tendersearch    30
  Input Text                      id=main-tendersearch    ${tenderId}
  Click Element                   id=search-main
  Sleep                           1

  Wait Until Keyword Succeeds   20 x   30 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   xpath=//div[contains(@class, 'one_card')]//a[@href='/prozorro/tender/${tenderId}']

  Click Element   xpath=//div[contains(@class, 'one_card')]//a[@href='/prozorro/tender/${tenderId}']

  Wait Until Element Is Visible  id=tenderId  30

Завантажити документ
  [Arguments]  ${userName}  ${filePath}  ${tenderId}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Click Element                  id=editTender
  Wait Until Element Is Visible  id=editTender
  Click Element                  id=editTender
  Wait Until Element Is Visible  id=documents-box
  Прикріпити документ            ${filePath}
  Click Element                  id=next
  Wait Until Element Is Visible  id=endEdit
  Click Element                  id=endEdit
  Wait Until Element Is Visible  id=tenderId

Прикріпити документ
  [Arguments]  ${filePath}
  ${isClollapsed}=  Run Keyword And Return Status  Element Should Be Visible  xpath=//div[@id='documents-box']//button[@data-widget='collapse']
  Run keyword If  ${isClollapsed}  Run Keywords
  ...  Click Element  xpath=//div[@id='documents-box']//h3
  ...  AND  Sleep  1
  Scroll Page To Element         id=documents-box
  Wait Until Element Is Visible  css=.add-item
  Click Element                  css=.add-item
  Wait Until Element Is Visible  css=.delete-document
  Select From List By Value      xpath=//select[contains(@name, 'documentType')]  empty
  Choose File                    css=.document-img  ${filePath}
  Wait Until Element Is Visible  xpath=//div[contains(text(), 'Done')]

Завантажити документ в лот
  [Arguments]   ${userName}   ${filePath}   ${tenderId}   ${lotId}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Click Element                  id=editTender
  Wait Until Element Is Visible  css=.edit-lot
  Click Link                     css=.edit-lot
  Wait Until Element Is Visible  id=documents-box

  Прикріпити документ            ${filePath}
  Click Element                  id=next
  Wait Until Element Is Visible  id=endEdit
  Click Element                  id=endEdit
  Wait Until Element Is Visible  id=tenderId

Подати скаргу
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  userName
  ...      ${ARGUMENTS[1]} ==  ${tenderId}
  ...      ${ARGUMENTS[2]} ==  ${Complain}
  Fail  Не реалізований функціонал

порівняти скаргу
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  userName
  ...      ${ARGUMENTS[1]} ==  ${filePath}
  ...      ${ARGUMENTS[2]} ==  ${tenderId}
  Fail  Не реалізований функціонал

Пропозиція з неціновими показниками
  [Arguments]   ${parameters}
  ${countParametrs}=   Get Length   ${parameters}
  : FOR  ${index}  IN RANGE  0  ${countParametrs}
  \  ${value}=  Convert to String  ${parameters[${index}]['value']}
  \  Execute Javascript  $("select[data-id='${parameters[${index}]['code']}']").val('${value}').change();
  \  Execute Javascript  $('.alertify-notifier').empty();

Цінова пропозиція мультилот
  [Arguments]   ${valueAmount}
  ${valueAmount}=   Convert To String    ${valueAmount}
  Input text   xpath=//input[contains(@id, 'valueLot')]   ${valueAmount}

Цінова пропозиція безлот
  [Arguments]   ${valueAmount}
  ${valueAmount}=   Convert To String    ${valueAmount}
  Input text   id=valueTender   ${valueAmount}

Пропозиція на мультилот
  [Arguments]  ${bidData}
  ${hasParametrs}=   Run Keyword And Return Status  Dictionary Should Contain Key  ${bidData}  parameters
  Run Keyword If  ${hasParametrs}  Пропозиція з неціновими показниками  ${bidData.parameters}
  Цінова пропозиція мультилот  ${bidData.lotValues[0].value.amount}

Подати цінову пропозицію
  [Arguments]  ${userName}  ${tenderId}  ${bidData}  ${lotIds}=${None}  ${featuresIds}=${None}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}

  Wait Until Keyword Succeeds   5 x  30 s   Run Keywords
  ...       Click Element                  id=reloadTender
  ...  AND  Wait Until Element Is Visible  id=bidTender  5

  ${isStage2}=  Run Keyword And Return Status
  ...  Element Should Contain  xpath=//div[contains(@class, 'tender_head')]//p[@id='procurementMethodType']  другий етап

  ${featureBtn}=  Run Keyword And Return Status  Element Should Be Visible  id=show-features
  Run Keyword If  ${featureBtn} and ${featuresIds} == ${None}  Fail  Відстутні нецінові показники
  Click Element                  id=bidTender
  Wait Until Element Is Visible  id=bidPublication

  Scroll Page To Element         css=.action_period
  Run Keyword And Return If  '${mode}' == 'open_esco'  Подати цінову пропозицію на еско процедуру  ${bidData}
  Run Keyword And Return If  '${mode}' == 'open_competitive_dialogue' and ${isStage2} == ${False}
  ...  Подати цінову пропозицію на конкурентний діалог  ${bidData}  ${isStage2}

  ${lotsExist}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${bidData.data}  lotValues

  Run Keyword If  ${lotsExist}  Пропозиція на мультилот  ${bidData.data}
  ...  ELSE  Цінова пропозиція безлот  ${bidData.data.value.amount}
  Видалити повідомлення

  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'isqualificationcriterion')]
  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'nogroundsrejecting')]

  Click Element   id=bidPublication
  Run Keyword If  ${lotsExist}  Підтвердити пропозицію у модальному вікні
  Wait Until Element Is Visible      id=bidActiveTender  30
  Click Element                      id=bidActiveTender
  Wait Until Element Is Not Visible  id=bidActiveTender  30

Подати цінову пропозицію на конкурентний діалог
  [Arguments]  ${bidData}  ${isStage2}

  Execute Javascript  setMySwitchBox('w0', 'true');

  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'isqualificationcriterion')]
  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'nogroundsrejecting')]

  Click Element  id=bidPublication

  # Run Keyword If  ${isStage2}  Підтвердити пропозицію у модальному вікні

  Wait Until Element Is Visible      id=bidActiveTender  30
  Click Element                      id=bidActiveTender
  Wait Until Element Is Not Visible  id=bidActiveTender  30

Подати цінову пропозицію на еско процедуру
  [Arguments]  ${bidData}

  ${lotsExist}=     Run Keyword And Return Status  Dictionary Should Contain Key  ${bidData.data}  lotValues
  ${relatedLotId}=  Get From Dictionary  ${bidData.data.lotValues[0]}  relatedLot

  ${contractDurationYears}=     Convert To String  ${bidData.data.lotValues[0].value.contractDuration.years}
  ${contractDurationDays}=      Convert To String  ${bidData.data.lotValues[0].value.contractDuration.days}
  ${yearlyPaymentsPercentage}=  get_percent  ${bidData.data.lotValues[0].value.yearlyPaymentsPercentage}
  ${yearlyPaymentsPercentage}=  Convert To String  ${yearlyPaymentsPercentage}

  ${hasParametrs}=  Run Keyword And Return Status   Dictionary Should Contain Key  ${bidData.data}  parameters
  Run Keyword If  ${hasParametrs}  Пропозиція з неціновими показниками   ${bidData.data.parameters}

  Execute Javascript  setMySelectBox('bidenergy-contractdurationyears-${relatedLotId}', '${contractDurationYears}');
  Sleep               1
  Input Text          id=bidenergy-contractdurationdays-${relatedLotId}      ${contractDurationDays}
  Input Text          id=bidenergy-yearlyPaymentsPercentage-${relatedLotId}  ${yearlyPaymentsPercentage}

  ${annualCostsReductionCount}=  Get Matching Xpath Count
  ...  //div[contains(@id, 'annualCostsReduction-${relatedLotId}') and contains(@style, 'display: block;')]

  : FOR  ${index}  IN RANGE  0  ${annualCostsReductionCount}
  \  ${annualCostsReduction}=  Convert To String  ${bidData.data.lotValues[0].value.annualCostsReduction[${index}]}
  \  Input Text  id=BidEnergy-annualCostsReduction-${relatedLotId}-${index}  ${annualCostsReduction}

  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'isqualificationcriterion')]
  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'nogroundsrejecting')]

  Видалити повідомлення

  Capture Page Screenshot

  Click Element   id=bidPublication
  Run Keyword If  ${lotsExist}  Підтвердити пропозицію у модальному вікні
  Показати вкладку моя пропозиція
  Click Element                  id=bidActiveTender
  Wait Until Element Is Visible  xpath=//a[@href='#items' or @href='#lots']
  На початок сторінки

Перейти в кінець сторінки
  Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);

Видалити повідомлення
  Execute Javascript   $('.alertify-notifier').empty();

Підтвердити пропозицію у модальному вікні
  Wait Until Element Is Visible   id=bidPublicationMulti
  Sleep  2
  Click Element                   id=bidPublicationMulti
  Wait Until Element Is Visible   id=publisher-info   45

Показати вкладку моя пропозиція
  На початок сторінки
  Скролл до табів

  ${currentUrl}=              Get Location
  Run Keyword And Return If  "#myBid" in "${currentUrl}"  Sleep  1

  Wait Until Element Is Visible  xpath=//a[@href='#myBid']
  Click Element                  xpath=//a[@href='#myBid']
  Sleep                          1

Отримати статус цінової пропозиції
  Wait Until Keyword Succeeds   15 x   30 s   Run Keywords
  ...   Reload Page
  ...   AND   Показати вкладку моя пропозиція
  ...   AND   Element Should Be Visible   css=.bid-status
  ${rawStatus}=   Get Text   css=.bid-status
  ${rawStatus}=   convert_avi_string_to_common_string   ${rawStatus}
  [return]   ${rawStatus}

Отримати величину цінової пропозиції
  ${rawValueAmount}=  Get Text  css=.bid-value-amount
  ${rawValueAmount}=  Evaluate  "".join("${rawValueAmount}".split(' ')).replace(",", ".")
  ${rawValueAmount}=  Convert To Number  ${rawValueAmount}
  [return]   ${rawValueAmount}

Отримати інформацію із пропозиції
  [Arguments]  ${userName}   ${tenderId}   ${field}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Показати вкладку моя пропозиція
  Run Keyword And Return If    '${field}' == 'status'   Отримати статус цінової пропозиції
  Run Keyword And Return   Отримати величину цінової пропозиції

скасувати цінову пропозицію
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  userName
  ...      ${ARGUMENTS[1]} ==  ${tenderId}
  avi.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Wait Until Page Contains Element    id=cancelProposition    60
  Click Element   id=cancelProposition

Активувати цінову пропозицію

  Wait Until Keyword Succeeds   15 x   30 s   Run Keywords
  ...       Reload Page
  ...  AND  Sleep                          2
  ...  AND  Wait Until Element Is Visible  id=bidActiveTender

  Click Link                      id=bidActiveTender
  Wait Until Element Is Visible   id=publisher-info

Змінити цінову пропозицію
  [Arguments]  ${userName}  ${tenderId}  ${field}   ${value}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Показати вкладку моя пропозиція
  Run Keyword And Return If   '${field}' == 'status'   Активувати цінову пропозицію
  Wait Until Page Contains Element    id=bidEditTender
  Click Link   id=bidEditTender
  Wait Until Page Contains Element    id=bidPublication
  Run Keyword If   ${lotsExist}   Цінова пропозиція мультилот   ${value}
  ...  ELSE   Цінова пропозиція безлот   ${value}
  Видалити повідомлення

  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'isqualificationcriterion')]
  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'nogroundsrejecting')]

  Click Element   id=bidPublication
  Run Keyword If   ${lotsExist}   Підтвердити пропозицію у модальному вікні

Змінити тип документа в пропозиції
  [Arguments]   ${locator}   ${documentName}
  ${documentType}=    test_documentType_to_option_type   ${documentName}
  Run Keyword And Ignore Error   Select From List By Value   ${locator}//select   ${documentType}

Завантажити документ в ставку
  [Arguments]  ${userName}  ${filePath}  ${tenderId}  ${documentName}=${EMPTY}  ${documentType}=${None}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Показати вкладку моя пропозиція
  Wait Until Element Is Visible  id=bidEditTender
  Click Link                     id=bidEditTender
  Wait Until Element Is Visible  id=bidPublication

  Видалити повідомлення
  Scroll Page To Element   css=.box-default
  ${documentBoxIsOpened}=  Run Keyword And Return Status  Element Should Be Visible  css=.add-item
  Run Keyword Unless  ${documentBoxIsOpened}  Click Element  xpath=//h3[contains(., 'Документи')]
  Wait Until Element Is Visible  css=.add-item
  Click Element                  css=.add-item
  Sleep                          2

  Choose File                    xpath=//div[contains(@class, 'form-documents-item')][last()]//input[@class='document-img']  ${filePath}
  Wait Until Element Is Visible  xpath=//div[contains(., 'Done')]

  Run Keyword If  '${documentName}' != ''
  ...  Змінити тип документа в пропозиції  xpath=//div[contains(@class, 'form-documents-item')][last()]  ${documentName}

  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'isqualificationcriterion')]
  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'nogroundsrejecting')]
  Click Element   id=bidPublication

  Run Keyword If  ${lotsExist} and '${mode}' != 'open_competitive_dialogue'  Підтвердити пропозицію у модальному вікні

Змінити документ в ставці
  [Arguments]  ${userName}  ${tenderId}  ${filePath}  ${documentId}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Показати вкладку моя пропозиція
  Wait Until Element Is Visible  id=bidEditTender
  Click Link                     id=bidEditTender
  Wait Until Element Is Visible  id=bidPublication
  Видалити повідомлення

  Scroll Page To Element         css=.box-default
  Wait Until Page Contains       ${documentId}
  Choose File                    css=.document-img  ${filePath}
  Wait Until Element Is Visible  xpath=//div[contains(., 'Done')]

  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'isqualificationcriterion')]
  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'nogroundsrejecting')]

  Click Element                 id=bidPublication

  Run Keyword If  ${lotsExist} and '${mode}' != 'open_competitive_dialogue'  Підтвердити пропозицію у модальному вікні

Змінити документацію в ставці
  [Arguments]   ${userName}   ${tenderId}   ${documentData}   ${documentId}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Показати вкладку моя пропозиція
  Wait Until Element Is Visible  id=bidEditTender
  Click Link                     id=bidEditTender
  Wait Until Element Is Visible  id=bidPublication

  Видалити повідомлення
  Scroll Page To Element         css=.box-default
  Wait Until Element Is Visible  css=.private
  Click Element                  css=.private
  Wait Until Element Is Visible  xpath=//div[contains(@id, 'privateReason')]//textarea
  Input Text                     xpath=//div[contains(@id, 'privateReason')]//textarea   ${documentData.data.confidentialityRationale}

  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'isqualificationcriterion')]
  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'nogroundsrejecting')]

  Click Element    id=bidPublication
  Run Keyword If  ${lotsExist} and '${mode}' != 'open_competitive_dialogue'  Підтвердити пропозицію у модальному вікні

  Sleep  10

Оновити сторінку з тендером
  [Arguments]  ${userName}  ${tenderId}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}

  ${isVisibleReloadBtn}=   Run keyword And Return Status   Element Should Be Visible   id=reloadTender
  Run keyword If   ${isVisibleReloadBtn}   Run Keywords
  ...         Click Element                   id=reloadTender
  ...   AND   Wait Until Element Is Visible   id=tenderId   30

Змінити період пропозицій
  [Arguments]   ${tenderPeriodEndDateISO}
  ${tenderPeriodEndDateISO}=  Run Keyword If  '${mode}' == 'openua_defense'  add_min_to_date_without_ms  ${tenderPeriodEndDateISO}  5
  ...  ELSE  Set Variable  ${tenderPeriodEndDateISO}
  ${toInputFormat}=   convert_datetime_for_input   ${tenderPeriodEndDateISO}
  Execute JavaScript  $('#${procurementMethodTypeLower}-tenderperiod-enddate').val('${toInputFormat}');

Внести зміни в тендер
  [Arguments]  ${userName}  ${tenderId}  ${fieldName}  ${fieldValue}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Wait Until Element Is Visible  id=editTender
  Click Element                  id=editTender
  Wait Until Element Is Visible  id=editTender
  Click Element                  id=editTender
  Wait Until Element Is Visible  id=next

  Run Keyword If  '${fieldName}' == 'tenderPeriod.endDate'  Змінити період пропозицій  ${fieldValue}
  Run Keyword If  '${fieldName}' == 'description'  Input Text  id=${procurementMethodTypeLower}-description  ${fieldValue}

  Click Element                   id=next
  Wait Until Element Is Visible   id=endEdit   30
  Click Element                   id=endEdit
  Wait Until Element Is Visible   id=tenderId

Отримати текст із поля і показати на сторінці
  [Arguments]   ${fieldname}
  Wait Until Page Contains Element    ${locator.${fieldname}}    22
  ${value}=   Get Text  ${locator.${fieldname}}
  [return]  ${value}

Таб Протокол розкриття
  ${awardsTab}=   Run Keyword And Return Status   Element Should Be Visible   xpath=//a[contains(@href,'#awards')]
  Run Keyword If   ${awardsTab} == ${FALSE}   Wait Until Keyword Succeeds   10 x   30 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   xpath=//a[contains(@href,'#awards')]
  Click link   xpath=//a[contains(@href,'#awards')]
  Скролл до табів

Отримати інформацію про awards[0].documents[0].title
  Таб Протокол розкриття
  Execute Javascript   $('.fa-plus').trigger('click');
  Sleep   1
  ${title}=   Get Text   xpath=//div[contains(@class,'one_bid')]//div[@class='box-body']//a
  [return]   ${title}

Таб контракти
  ${hasContractsTab}=  Run Keyword And Return Status  Element Should Be Visible  xpath=//a[@href='#contracts']
  Run Keyword Unless  ${hasContractsTab}  Wait Until Keyword Succeeds   10 x   30 s   Run Keywords
  ...       Reload Page
  ...  AND  Wait Until Element Is Visible  xpath=//a[@href='#contracts']

  Скролл до табів
  Click Element       xpath=//a[@href='#contracts']
  Execute Javascript  showAllCollapsed();
  Sleep               1

Отримати інформацію із тендера
  [Arguments]  ${userName}  ${tenderId}  ${fieldName}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Run Keyword And Return If   '${fieldName}' == 'documents[0].title'   Отримати тайтл першого документа
  Run Keyword And Return If   '${fieldName}' == 'qualifications[0].status'   Отримати статус пропозиції кваліфікації  1
  Run Keyword And Return If   '${fieldName}' == 'qualifications[1].status'   Отримати статус пропозиції кваліфікації  2
  Run Keyword And Return If   '${fieldName}' == 'procuringEntity.identifier.scheme'   Return From Keyword    UA-EDR
  Run Keyword And Return If   '${fieldName}' == 'awards[0].suppliers[0].name'   Отримати інформацію про назву організації з протоколу розкриття
  Run Keyword And Return If   '${fieldName}' == 'awards[0].suppliers[0].identifier.legalName'   Отримати інформацію про назву організації з протоколу розкриття

  Run Keyword And Return If   '${fieldName}' == 'title_ru'   Fail   Поле не відображаем
  Run Keyword And Return If   '${fieldName}' == 'description_ru'   Fail   Поле не відображаем
  Run Keyword And Return If   '${fieldName}' == 'items[0].deliveryLocation.latitude'   Fail   Поле не відображаем
  Run Keyword And Return If   '${fieldName}' == 'items[0].deliveryAddress.countryName_ru'   Fail   Поле не відображаем
  Run Keyword And Return If   '${fieldName}' == 'items[0].deliveryAddress.countryName_en'   Fail   Поле не відображаем


  Run Keyword And Return If  'funders' in '${fieldName}'  Отримати інформацію із донора закупівлі  ${userName}  ${tenderId}  ${fieldName}

  Run Keyword And Return  Отримати інформацію про ${fieldName}

Отримати інформацію про items[0].deliveryDate.startDate
  Wait Until Page Contains   Дата поставки
  ${startDate}=   Get Text   css=.delivery-start-date
  ${startDate}=   convert_date_for_delivery   ${startDate}
  [return]   ${startDate}

Отримати інформацію про items[0].deliveryDate.endDate
  Wait Until Page Contains   Дата поставки
  ${endDate}=   Get Text   css=.delivery-end-date
  ${endDate}=   convert_date_for_delivery   ${endDate}
  [return]   ${endDate}

Таб запитання та вимоги
  ${questionsComplaintsTab}=   Run Keyword And Return Status   Element Should Be Visible   xpath=//a[contains(@href,'#questions-complaints')]
  Run Keyword If   ${questionsComplaintsTab} == ${FALSE}   Wait Until Keyword Succeeds   20 x   30 s   Run Keywords
  ...   Reload Page
  ...   AND   Wait Until Element Is Visible  id=publisher-info  15
  ...   AND   Скролл до табів
  ...   AND   Element Should Be Visible   xpath=//a[contains(@href,'#questions-complaints')]
  Скролл до табів
  Click link   xpath=//a[contains(@href,'#questions-complaints')]

Отримати інформацію про features[0].title
  Click Link   id=show-features
  Wait Until Page Contains   Нецінові Показники
  ${tenderFeatureTitle}=   Get Text   xpath=(//h3[contains(@class, 'features-title')])[2]
  Click Element   id=publisher-info-modal
  [return]   ${tenderFeatureTitle}

Отримати інформацію про questions[0].title
  Таб запитання та вимоги
  ${text}=   Get Text  css=.question-title
  [return]   ${text}

Отримати інформацію про awards[0].status
  Таб Протокол розкриття
  ${rawStatus}=   Get Text   css=.award-status
  ${rawStatus}=   convert_avi_string_to_common_string   ${rawStatus}
  [return]   ${rawStatus}

Отримати інформацію про awards[0].complaintPeriod.endDate
  Таб Протокол розкриття
  ${complaintPeriodEnd}=   Отримати текст із поля і показати на сторінці   awards.complaintPeriod.endDate
  ${complaintPeriodEnd}=   convert_date_for_compare   ${complaintPeriodEnd}
  [return]   ${complaintPeriodEnd}

Отримати інформацію про awards[0].complaintPeriod.startDate
  Таб Протокол розкриття
  ${complaintPeriodStart}=  Отримати текст із поля і показати на сторінці   awards.complaintPeriod.startDate
  ${complaintPeriodStart}=  convert_date_for_compare   ${complaintPeriodStart}
  [return]                  ${complaintPeriodStart}

Отримати інформацію про awards[1].complaintPeriod.endDate
  Таб Протокол розкриття
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_bid')][1]//span[contains(@class, 'awardComplaintPeriodEnd')]
  ${complaintPeriodEnd}=          Get Text   xpath=//div[contains(@class, 'one_bid')][1]//span[contains(@class, 'awardComplaintPeriodEnd')]
  ${complaintPeriodEnd}=          convert_date_for_compare   ${complaintPeriodEnd}

  [return]   ${complaintPeriodEnd}

Отримати інформацію про awards[2].complaintPeriod.endDate
  Таб Протокол розкриття

  ${bidIndex}=  Set Variable If  '${mode}' == 'open_esco'  1  2
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_bid')][${bidIndex}]//span[contains(@class, 'awardComplaintPeriodEnd')]
  ${complaintPeriodEnd}=          Get Text   xpath=//div[contains(@class, 'one_bid')][${bidIndex}]//span[contains(@class, 'awardComplaintPeriodEnd')]
  ${complaintPeriodEnd}=          convert_date_for_compare   ${complaintPeriodEnd}

  [return]   ${complaintPeriodEnd}

Отримати інформацію про awards[0].value.amount
  Таб Протокол розкриття
  Wait Until Element Is Visible   css=.award-value
  ${amount}=                      Get Element Attribute   xpath=//p[contains(@class, 'award-value')]@data-value-amount
  ${amount}=                      Convert To Number   ${amount}
  [return]                        ${amount}

Отримати інформацію про awards[1].value.amount
  Таб Протокол розкриття
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_bid')][1]//p[contains(@class, 'award-value')]
  ${amount}=                      Get Element Attribute   xpath=//div[contains(@class, 'one_bid')][1]//p[contains(@class, 'award-value')]@data-value-amount
  ${amount}=                      Convert To Number   ${amount}
  [return]                        ${amount}

Отримати інформацію про awards[2].value.amount
  Таб Протокол розкриття
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_bid')][2]//p[contains(@class, 'award-value')]
  ${amount}=                      Get Element Attribute   xpath=//div[contains(@class, 'one_bid')][2]//p[contains(@class, 'award-value')]@data-value-amount
  ${amount}=                      Convert To Number   ${amount}
  [return]                        ${amount}

Отримати інформацію про awards[0].value.currency
  Таб Протокол розкриття
  Wait Until Element Is Visible          css=.award-value
  ${currency}=                           Get Element Attribute   xpath=//p[contains(@class, 'award-value')]@data-value-currency
  [return]                               ${currency}

Отримати інформацію про awards[0].value.valueAddedTaxIncluded
  Таб Протокол розкриття
  Wait Until Element Is Visible   css=.award-value
  ${valueaddedtaxincluded}=       Get Element Attribute   xpath=//p[contains(@class, 'award-value')]@data-value-valueaddedtaxincluded
  ${valueaddedtaxincluded}=       Convert To Boolean   ${valueaddedtaxincluded}
  [return]                        ${valueaddedtaxincluded}

Отримати інформацію про contracts[0].status
  Таб контракти
  ${value}=   Отримати текст із поля і показати на сторінці   contracts.status
  ${value}=   convert_avi_string_to_common_string   ${value}
  [return]  ${value}

Отримати інформацію про contracts[1].status
  Таб контракти
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_contract')][2]//div[contains(@class, 'contract-status')]

  ${value}=   Get Text   xpath=//div[contains(@class, 'one_contract')][2]//div[contains(@class, 'contract-status')]
  ${value}=   convert_avi_string_to_common_string   ${value}
  [return]  ${value}

Отримати інформацію про contracts[0].dateSigned
  Таб контракти
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_contract')][1]//span[contains(@class, 'contract-dateSigned')]

  ${value}=   Get Element Attribute   xpath=//div[contains(@class, 'one_contract')][1]//span[contains(@class, 'contract-dateSigned')]@data-dateSigned
  [return]  ${value}

Отримати інформацію про contracts[1].dateSigned
  Таб контракти
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_contract')][2]//span[contains(@class, 'contract-dateSigned')]

  ${value}=   Get Element Attribute   xpath=//div[contains(@class, 'one_contract')][2]//span[contains(@class, 'contract-dateSigned')]@data-dateSigned
  [return]  ${value}

Отримати інформацію про contracts[0].period.startDate
  Таб контракти
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_contract')][1]//p[contains(@class, 'contract-period')]

  ${value}=   Get Element Attribute   xpath=//div[contains(@class, 'one_contract')][1]//p[contains(@class, 'contract-period')]@data-startDate
  [return]  ${value}

Отримати інформацію про contracts[1].period.startDate
  Таб контракти
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_contract')][2]//p[contains(@class, 'contract-period')]

  ${value}=   Get Element Attribute   xpath=//div[contains(@class, 'one_contract')][2]//p[contains(@class, 'contract-period')]@data-startDate
  [return]  ${value}

Отримати інформацію про contracts[0].period.endDate
  Таб контракти
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_contract')][1]//p[contains(@class, 'contract-period')]

  ${value}=   Get Element Attribute   xpath=//div[contains(@class, 'one_contract')][1]//p[contains(@class, 'contract-period')]@data-endDate
  [return]  ${value}

Отримати інформацію про contracts[1].period.endDate
  Таб контракти
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_contract')][2]//p[contains(@class, 'contract-period')]

  ${value}=   Get Element Attribute   xpath=//div[contains(@class, 'one_contract')][2]//p[contains(@class, 'contract-period')]@data-endDate
  [return]  ${value}

Отримати інформацію про contracts[0].value.amount
  Wait Until Element Is Visible  id=reloadTender   30
  Click Element                  id=reloadTender
  Wait Until Element Is Visible  id=tenderId   30
  Таб контракти
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_contract')][1]//span[contains(@class, 'contract-value')]

  ${amount}=                      Get Element Attribute   xpath=//div[contains(@class, 'one_contract')][1]//span[contains(@class, 'contract-value')]@data-value-amount
  ${amount}=                      Convert To Number   ${amount}
  [return]                        ${amount}

Отримати інформацію про contracts[1].value.amount
  Wait Until Element Is Visible  id=reloadTender   30
  Click Element                  id=reloadTender
  Wait Until Element Is Visible  id=tenderId   30
  Таб контракти
  Wait Until Element Is Visible   xpath=//div[contains(@class, 'one_contract')][2]//span[contains(@class, 'contract-value')]

  ${amount}=                      Get Element Attribute   xpath=//div[contains(@class, 'one_contract')][2]//span[contains(@class, 'contract-value')]@data-value-amount
  ${amount}=                      Convert To Number   ${amount}
  [return]                        ${amount}

Отримати інформацію про назву організації з протоколу розкриття
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   awards.suppliers.name
  [return]  ${value}

Отримати інформацію про awards[0].suppliers[0].identifier.id
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   award.suppliers.identifier.id
  [return]  ${value}

Отримати інформацію про awards[0].suppliers[0].identifier.scheme
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   award.suppliers.identifier.scheme
  [return]  ${value}

Отримати інформацію про awards[0].suppliers[0].contactPoint.name
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   awards.suppliers.contactPoint.name
  [return]  ${value}

Отримати інформацію про awards[0].suppliers[0].contactPoint.email
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   awards.suppliers.contactPoint.email
  [return]  ${value}

Отримати інформацію про awards[0].suppliers[0].contactPoint.telephone
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   awards.suppliers.contactPoint.telephone
  [return]  ${value}

Отримати інформацію про awards[0].suppliers[0].address.countryName
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   awards.suppliers.address.countryName
  [return]  ${value}

Отримати інформацію про awards[0].suppliers[0].address.locality
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   awards.suppliers.address.locality
  [return]  ${value}

Отримати інформацію про awards[0].suppliers[0].address.postalCode
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   awards.suppliers.address.postalCode
  [return]  ${value}

Отримати інформацію про awards[0].suppliers[0].address.region
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   awards.suppliers.address.region
  [return]  ${value}

Отримати інформацію про awards[0].suppliers[0].address.streetAddress
  Таб Протокол розкриття
  ${value}=   Отримати текст із поля і показати на сторінці   awards.suppliers.address.streetAddress
  [return]  ${value}

Отримати інформацію про title
  ${value}=   Отримати текст із поля і показати на сторінці   title
  [return]  ${value}

Отримати інформацію про title_en
  ${value}=   Отримати текст із поля і показати на сторінці   title_en
  [return]  ${value}

Отримати інформацію про description
  ${value}=   Отримати текст із поля і показати на сторінці   description
  [return]  ${value}

Отримати інформацію про description_en
  ${value}=   Отримати текст із поля і показати на сторінці   description_en
  [return]  ${value}

Отримати інформацію про cause
  ${value}=   Отримати текст із поля і показати на сторінці   cause
  ${value}=   convert_avi_string_to_common_string   ${value}
  [return]  ${value}

Отримати інформацію про causeDescription
  ${value}=   Отримати текст із поля і показати на сторінці   causeDescription
  [return]  ${value}

Отримати інформацію про value.valueAddedTaxIncluded
  ${value}=   Отримати текст із поля і показати на сторінці   value.valueAddedTaxIncluded
  ${value}=   convert_avi_string_to_common_string   ${value}
  ${value}=   Convert To Boolean   ${value}
  [return]  ${value}

Отримати інформацію про value.currency
  ${value}=   Отримати текст із поля і показати на сторінці   value.currency
  [return]  ${value}

Отримати інформацію про minimalStep.amount
  ${value}=   Отримати текст із поля і показати на сторінці   minimalStep.amount
  ${value}=   Evaluate   "".join("${value}".split(' ')).replace(",", ".")
  ${value}=   Convert To Number   ${value}
  [return]  ${value}

Отримати інформацію про value.amount
  ${value}=   Отримати текст із поля і показати на сторінці  value.amount
  ${value}=   Evaluate   "".join("${value}".split(' ')).replace(",", ".")
  ${value}=   Convert To Number   ${value}
  [return]  ${value}

Отримати інформацію про tenderId
  ${value}=   Отримати текст із поля і показати на сторінці   tenderId
  [return]  ${value}

Отримати інформацію про procuringEntity.name
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.name
  Click Element      xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.address.countryName
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.address.countryName
  Click Element      xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.address.locality
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.address.locality
  Click Element      xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.address.postalCode
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.address.postalCode
  Click Element      xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.address.region
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.address.region
  Click Element      xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.address.streetAddress
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.address.streetAddress
  Click Element      xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.contactPoint.name
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.contactPoint.name
  Click Element      xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.contactPoint.telephone
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.contactPoint.telephone
  Click Element     xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.contactPoint.url
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.contactPoint.url
  Click Element      xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.identifier.legalName
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.identifier.legalName
  Click Element     xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.identifier.id
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.identifier.id
  Click Element     xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про procuringEntity.identifier.scheme
  Click Element    id=publisher-info
  Sleep   1
  ${value}=   Отримати текст із поля і показати на сторінці   procuringEntity.identifier.scheme
  Click Element     xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep  1
  [return]  ${value}

Отримати інформацію про auctionPeriod.startDate
  ${value}=   Отримати текст із поля і показати на сторінці  auctionPeriod.startDate
  ${value}=   convert_date_for_compare   ${value}
  [return]  ${value}

Отримати інформацію про tenderPeriod.startDate
  ${value}=   Отримати текст із поля і показати на сторінці  tenderPeriod.startDate
  ${value}=   convert_date_for_compare   ${value}
  [return]  ${value}

Отримати інформацію про tenderPeriod.endDate
  ${value}=   Отримати текст із поля і показати на сторінці  tenderPeriod.endDate
  ${value}=   convert_date_for_compare   ${value}
  [return]  ${value}

Отримати інформацію про enquiryPeriod.startDate
  ${value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.startDate
  ${value}=   convert_date_for_compare   ${value}
  [return]  ${value}

Отримати інформацію про enquiryPeriod.endDate
  ${value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.endDate
  ${value}=   convert_date_for_compare   ${value}
  [return]  ${value}

Отримати інформацію про enquiryPeriod.clarificationsUntil
  ${value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.clarificationsUntil
  ${value}=   convert_date_for_compare   ${value}
  [return]  ${value}

Отримати інформацію про qualificationPeriod.endDate
  Wait Until Keyword Succeeds   10 x   15 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   ${locator.qualificationPeriod.endDate}
  ${value}=   Отримати текст із поля і показати на сторінці  qualificationPeriod.endDate
  ${value}=   convert_date_for_compare   ${value}
  [return]  ${value}

Отримати інформацію про status
  Run Keyword If  'періоду блокування' in '${TEST_NAME}'  Run Keywords
  ...   Run Keyword And Ignore Error        Click Element  id=reloadTender
  ...   AND  Wait Until Element Is Visible  id=publisher-info

  Run Keyword Unless  'періоду блокування' in '${TEST_NAME}'  Reload Page

  Return From Keyword If  '${TEST_NAME}' == 'Можливість перевести тендер в статус очікування обробки мостом'  active.stage2.waiting

  ${value}=   Отримати текст із поля і показати на сторінці   status
  ${value}=   convert_avi_string_to_common_string   ${value}
  [return]  ${value}

Додати лоти
  [Arguments]  ${lots}  ${items}   ${features}
  ${lots_count}=  Get Length  ${lots}
  : FOR  ${index}  IN RANGE  0  ${lots_count}
  \  Run Keyword IF  ${index} > 0  Wait Element Visibility And Click  id=add-lot
  \  Додати лот  ${lots[${index}]}   ${features}
  \  ${lot_items}=  get_items_from_lot  ${items}  ${lots[${index}].id}
  \  Додати предмети до лоту  ${lot_items}  ${lots[${index}].title}   ${features}

Створити лот із предметом закупівлі
  [Arguments]  ${userName}  ${tenderId}  ${lot}  ${item}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Wait Until Page Contains Element   id=editTender
  Click Element   id=editTender
  Wait Until Page Contains Element   id=add-lot
  Click Element   id=add-lot
  ${features}=  Create Dictionary
  Run Keyword  Додати лот  ${lot.data}  ${features}
  Run Keyword  Додати предмет  ${item}  ${features}

Додати предмет закупівлі в лот
  [Arguments]  ${userName}  ${tenderId}  ${lotId}  ${item}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Wait Until Page Contains Element   id=editTender
  Click Element   id=editTender
  Execute Javascript   $(".tab-pane").addClass("active")
  Wait Until Element Is Visible  xpath=//div[contains(@data-lot-title,'${lotId}')]//a[contains(@href, '/edit-item?') and not(contains(@href, '&itemId'))]
  Click Element                  xpath=//div[contains(@data-lot-title,'${lotId}')]//a[contains(@href, '/edit-item?') and not(contains(@href, '&itemId'))]
  ${features}=  Create Dictionary
  Run Keyword  Додати предмет  ${item}  ${features}

Видалити предмет закупівлі
  [Arguments]  ${userName}  ${tenderId}  ${itemId}  ${lotId}=${None}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Wait Until Page Contains Element   id=editTender
  Click Element   id=editTender
  Wait Until Element Is Visible  id=editTender
  ${click_locator}=  Set Variable  //a[contains(@href, '/remove-item?') and contains(@data-item-description, '${itemId}')]
  ${click_locator}=  Set Variable If  '${lotId}' != '${None}'  //div[contains(@data-lot-title,'${lotId}')]${click_locator}  ${click_locator}
  Execute Javascript   $(".tab-pane").addClass("active")
  Wait Until Element Is Visible  xpath=${click_locator}
  Click Element  xpath=${click_locator}
  Wait Until Element Is Visible   id=endEdit
  Click Element                   id=endEdit

Видалити лот
  [Arguments]  ${userName}  ${tenderId}  ${lotId}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Wait Until Page Contains Element   id=editTender
  Click Element   id=editTender
  Wait Until Element Is Visible  id=editTender

  ${click_locator}=  Set Variable  xpath=//div[contains(@data-lot-title,'${lotId}')]//a[contains(@href, '/remove-lot')]
  Execute Javascript   $(".tab-pane").addClass("active")
  Wait Until Element Is Visible  ${click_locator}
  Click Element  ${click_locator}
  Wait Until Element Is Visible   id=endEdit
  Click Element                   id=endEdit

Додати лот
  [Arguments]  ${lot}  ${features}

  Wait Until Page Contains Element   xpath=//input[@id='${procurementMethodTypeLower}lot-title']
  Input text                         xpath=//input[@id='${procurementMethodTypeLower}lot-title']           ${lot.title}
  Input text                         xpath=//textarea[@id='${procurementMethodTypeLower}lot-description']  ${lot.description}

  ${hasTitleEn}=       Run Keyword And Return Status  Dictionary Should Contain Key  ${lot}  title_en
  ${hasTitleEnInput}=  Run Keyword And Return Status  Element Should Be Visible  xpath=//textarea[@id='${procurementMethodTypeLower}lot-titleen']

  Run Keyword If  ${hasTitleEn} and ${hasTitleEnInput}  Run Keyword
  ...  Input Text  xpath=//textarea[@id='${procurementMethodTypeLower}lot-titleen']   ${lot.title_en}
  # ...  AND  Input Text  xpath=//textarea[@id='${procurementMethodTypeLower}lot-descriptionen']   ${lot.description_en}

  ${hasValue}=     Run Keyword And Return Status  Dictionary Should Contain Key  ${lot}  value
  ${valueAmount}=  Run Keyword If  ${hasValue}  Get From Dictionary  ${lot.value}  amount
  ...  ELSE  Convert To String   ''
  ${valueAmount}=  Convert To String  ${valueAmount}

  ${hasMinimalStep}=     Run Keyword And Return Status  Dictionary Should Contain Key  ${lot}  minimalStep
  ${minimalStepAmount}=  Run Keyword If  ${hasMinimalStep}  Get From Dictionary  ${lot.minimalStep}  amount
  ...  ELSE  Convert To String   ''
  ${minimalStepAmount}=  Convert To String  ${minimalStepAmount}


  ${hasMinimalStepPercentage}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${lot}  minimalStepPercentage
  ${minimalStepPercentage}=  Run Keyword If  ${hasMinimalStepPercentage}  get_percent  ${lot.minimalStepPercentage}  3
  ${minimalStepPercentage}=  Convert To String  ${minimalStepPercentage}

  Run keyword If  ${hasMinimalStepPercentage}
  ...  Input Text  id=${procurementMethodTypeLower}lot-minimalsteppercentage  ${minimalStepPercentage}

  ${hasYearlyPaymentsPercentageRange}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${lot}  yearlyPaymentsPercentageRange
  ${yearlyPaymentsPercentageRange}=  Run Keyword If  ${hasYearlyPaymentsPercentageRange}  get_percent  ${lot.yearlyPaymentsPercentageRange}  3
  ${yearlyPaymentsPercentageRange}=  Convert To String  ${yearlyPaymentsPercentageRange}

  Run keyword If  ${hasYearlyPaymentsPercentageRange}
  ...  Input Text  id=${procurementMethodTypeLower}lot-yearlypaymentspercentagerange  ${yearlyPaymentsPercentageRange}

  Run Keyword If  ${hasValue}        Input Text  xpath=//input[@id='${procurementMethodTypeStudly}Lot-value-amount']        ${valueAmount}
  Run Keyword If  ${hasMinimalStep}  Input Text  xpath=//input[@id='${procurementMethodTypeStudly}Lot-minimalStep-amount']  ${minimalStepAmount}

  ${lotFeatures}=   Get Length    ${features}
  Run Keyword If  ${lotFeatures} > 0   Додати перший неціновий показник   ${features[0]}

  Click Element     id=next

Числове значення
  [Arguments]  ${value}
  ${value}=  Evaluate  "".join("${value}".split(' ')).replace(",", ".")
  ${value}=  Convert To Number  ${value}
  [return]   ${value}

Отримати інформацію із лоту
  [Arguments]  ${userName}  ${tenderId}  ${lotId}  ${fieldName}

  Wait Until Element Is Visible  xpath=//div[contains(@data-lot-title,'${lotId}')]//*[contains(@class,'lot-${fieldName}')]   1

  ${value}=   Get Text   xpath=//div[contains(@data-lot-title,'${lotId}')]//*[contains(@class,'lot-${fieldName}')]
  Run Keyword And Return If  '${fieldName}' == 'value.amount'   Числове значення   ${value}
  Run Keyword And Return If  '${fieldName}' == 'minimalStep.amount'   Числове значення   ${value}
  Run Keyword And Return If  '${fieldName}' == 'value.valueAddedTaxIncluded'  convert_avi_string_to_common_string   ${value}
  Run Keyword And Return If  '${fieldName}' == 'minimalStep.valueAddedTaxIncluded'  convert_avi_string_to_common_string   ${value}
  Run Keyword And Return If  '${fieldName}' == 'auctionPeriod.startDate'  convert_date_for_compare  ${value}
  Run Keyword And Return If  '${fieldName}' == 'fundingKind'  convert_avi_string_to_common_string  ${value}  True
  Run Keyword And Return If  '${fieldName}' == 'minimalStepPercentage' or '${fieldName}' == 'yearlyPaymentsPercentageRange'
  ...  to_percent  ${value}  5

  [return]  ${value}

Змінити value.amount лоту
  [Arguments]   ${value}
  ${value2string}=   Convert To String    ${value}
  Input Text   xpath=//input[contains(@id,'value-amount')]   ${value2string}

Змінити minimalStep.amount лоту
  [Arguments]   ${value}
  ${value2string}=   Convert To String    ${value}
  Input Text   xpath=//input[contains(@id,'minimalStep-amount')]   ${value2string}

Змінити лот
  [Arguments]  ${userName}  ${tenderId}  ${lotId}  ${field}  ${value}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Click Link   id=editTender
  Wait Until Page Contains Element   css=.edit-lot
  Click Link   css=.edit-lot
  Run Keyword And Return If  'value.amount' == '${field}'  Змінити ${field} лоту  ${value}
  Run Keyword And Return If  'minimalStep.amount' == '${field}'  Змінити ${field} лоту  ${value}
  Click Element   id=next
  Wait Until Element Is Visible   id=endEdit   40
  Click Link   id=endEdit
  Wait Until Page Contains   Інформація про замовника

Розгорнути лоти та предмети до лоту
  Execute Javascript   $("#lots .tab-pane").addClass("active")
  Execute Javascript   showAllCollapsed()
  Sleep                1

Заповнити дату поставки
  [Arguments]  ${deliveryDate}
  ${deliveryStartDate}=  convert_datetime_for_delivery   ${deliveryDate.startDate}
  ${deliveryEndDate}=    convert_datetime_for_delivery   ${deliveryDate.endDate}

  Execute Javascript    $('#${procurementMethodTypeLower}item-deliverydate-startdate').val('${deliveryStartDate}');
  Execute Javascript    $('#${procurementMethodTypeLower}item-deliverydate-enddate').val('${deliveryEndDate}');

Додати предмет
  [Arguments]  ${item}  ${features}
  ${quantity}=              Convert To String     ${item.quantity}
  ${unitName}=              Convert To Lowercase  ${item.unit.name}
  ${mainClassificationId}=  Get From Dictionary   ${item.classification}  id

  Wait Until Page Contains Element   xpath=//textarea[contains(@id, '${procurementMethodTypeLower}item-description')]
  Input Text                         xpath=//textarea[contains(@id, '${procurementMethodTypeLower}item-description')]  ${item.description}

  ${hasDescriptionEn}=       Run Keyword And Return Status   Dictionary Should Contain Key  ${item}   description_en
  ${hasDescriptionEnInput}=  Run Keyword And Return Status   Element Should Be Visible  id=${procurementMethodTypeLower}item-descriptionen

  Run Keyword If  ${hasDescriptionEn} and ${hasDescriptionEnInput}
  ...  Input text  xpath=//textarea[contains(@id, '${procurementMethodTypeLower}item-descriptionen')]  ${item.description_en}

  Run Keyword If  '${procurementMethodType}' != 'energy'  Run Keywords
  ...  Input text  xpath=//input[contains(@id, '${procurementMethodTypeLower}item-quantity')]  ${quantity}
  ...  AND  Execute Javascript  setMySelectBox('${procurementMethodTypeLower}item-unit', '${unitName}');

  Sleep    1
  Обрати класифікатор   collapseClassificationCpv   ${item.classification}

  ${additionalClassificationsExist}=  Run Keyword And Return Status   Dictionary Should Contain Key  ${item}   additionalClassifications

  ${isMedicalGroup}=   Get Substring   ${mainClassificationId}   0  3
  Run Keyword If   ${additionalClassificationsExist} and '${isMedicalGroup}' == '336'   Обрати класифікатор   collapseClassificationMulti   ${item.additionalClassifications[0]}   0
  # ...   Обрати класифікатор   collapseClassificationMulti   ${item.additionalClassifications[0]}   0
  # ...   AND   Обрати класифікатор   collapseClassificationMulti   ${item.additionalClassifications[1]}   1


  ${hasDeliveryDate}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${item}  deliveryDate
  Run Keyword If  ${hasDeliveryDate}  Заповнити дату поставки  ${item.deliveryDate}

  Scroll Page To Element         id=deliveryAddress
  Run Keyword And Ignore Error   Execute Javascript  setMySwitchBox("${procurementMethodTypeLower}item-deliveryrequired", "true")

  Input text          xpath=//input[contains(@id, 'deliveryAddress-locality')]    ${item.deliveryAddress.locality}
  Input text          xpath=//input[contains(@id, 'deliveryAddress-address')]     ${item.deliveryAddress.streetAddress}
  Execute Javascript  setMySelectBox('deliveryAddress-regionId', '${item.deliveryAddress.region}');
  Input text          xpath=//input[contains(@id, 'deliveryAddress-postalCode')]  ${item.deliveryAddress.postalCode}

  ${itemFeatures}=   Get Length    ${features}
  Run Keyword If    ${itemFeatures} > 0   Додати перший неціновий показник   ${features[2]}

  Click Element  id=next
  Sleep          2
  ${isShownWarningModal}=  Run Keyword And Return Status  Element Should Be Visible  id=confirm-modal
  Run Keyword If  ${isShownWarningModal}  Run Keywords
   ...  Click Element  xpath=//div[@id='confirm-modal']//button[@type='submit']
   ...  AND  Sleep     1

  Wait Until Element Is Visible  id=endEdit

Wait Element Visibility And Input Text
  [Arguments]  ${elementLocator}  ${input}
  Wait Until Element Is Visible  ${elementLocator}  10
  Input Text  ${elementLocator}  ${input}

Wait Element Visibility And Click
  [Arguments]  ${elementLocator}
  Wait Until Element Is Visible  ${elementLocator}  10
  Click Element    ${elementLocator}

Додати предмети до лоту
  [Arguments]  ${items}  ${lot_title}   ${features}
  ${items_count}=  Get Length  ${items}

  : FOR  ${index}  IN RANGE  0  ${items_count}
  \  Run Keyword IF  ${index} > 0   Execute Javascript   $(".tab-pane").addClass("active")
  \  Sleep    3
  \  Run Keyword IF  ${index} > 0   Wait Element Visibility And Click  xpath=//a[contains(@data-lot-title, "${lot_title}")]
  \  Додати предмет  ${items[${index}]}   ${features}

Додати предмети до закупівлі
  [Arguments]  ${items}   ${features}
  ${items_count}=  Get Length  ${items}

  : FOR  ${index}  IN RANGE  0  ${items_count}
  \  Run Keyword IF  ${index} > 0  Wait Element Visibility And Click  id=add-item
  \  Додати предмет  ${items[${index}]}   ${features}

Розгорнути предмети
  Execute Javascript   $("#items .tab-pane").addClass("active");
  Sleep                1

Отримати інформацію із предмету
  [Arguments]  ${userName}  ${tenderId}  ${itemId}  ${fieldName}
  На початок сторінки
  Скролл до табів
  Run Keyword If  ${lotsExist}   Run Keywords
  ...   Click Element  xpath=//a[@href='#lots']
  ...   AND  Sleep  1
  ...   AND  Розгорнути лоти та предмети до лоту

  Run Keyword Unless  ${lotsExist}   Run Keywords
  ...   Click Element  xpath=//a[@href='#items']
  ...   AND  Sleep  1
  ...   AND  Розгорнути предмети

  ${class}=  Run Keyword If  '${fieldName}' == 'unit.code'   Catenate  SEPARATOR=  items.  unit.name
  ...  ELSE  Catenate  SEPARATOR=  items.  ${fieldname}
  Wait Until Element Is Visible  xpath=//div[contains(@data-item-description,'${itemId}')]//*[contains(@class,'${locator.${class}}')]

  ${value}=  Run Keyword If  '${fieldName}' == 'deliveryDate.startDate' or '${fieldName}' == 'deliveryDate.endDate'  Get Element Attribute  xpath=//div[contains(@data-item-description,'${itemId}')]//*[contains(@class,'${locator.${class}}')]@data-value
  ...  ELSE  Get Text  xpath=//div[contains(@data-item-description,'${itemId}')]//*[contains(@class,'${locator.${class}}')]
  Run Keyword And Return If  '${fieldName}' == 'unit.code'                convert_avi_string_to_common_string   ${value}
  Run Keyword And Return If  '${fieldName}' == 'quantity'   Convert To Number   ${value}

  [return]  ${value}

Задати запитання
  [Arguments]  ${userName}  ${tenderId}  ${question}  ${relatedId}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Wait Until Element Is Visible   xpath=//a[@id='questionTender']
  Click Element                   xpath=//a[@id='questionTender']
  Wait Until Element Is Visible   id=question-title
  Input text                      id=question-title         ${question.data.title}
  Input text                      id=question-description   ${question.data.description}
  Click Element                   id=next
  Wait Until Element Is Visible   id=tenderId

Задати запитання на тендер
  [Arguments]  ${userName}  ${tenderId}  ${question}
  Задати запитання  ${userName}  ${tenderId}  ${question}  ${tenderId}

Задати запитання на предмет
  [Arguments]  ${userName}  ${tenderId}  ${itemId}  ${question}
  Задати запитання  ${userName}  ${tenderId}  ${question}  ${itemId}

Задати запитання на лот
  [Arguments]  ${userName}  ${tenderId}  ${lotId}  ${question}
  Задати запитання  ${userName}  ${tenderId}  ${question}  ${lotId}

Відповісти на запитання
  [Arguments]  ${userName}  ${tenderId}  ${answerData}  ${questionId}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Таб запитання та вимоги
  Wait Until Element Is Visible   xpath=//a[@href='#questions-complaints_questions']
  Click Element                   xpath=//a[@href='#questions-complaints_questions']
  Wait Until Element Is Visible   xpath=//div[contains(@data-question-title, '${questionId}')]

  Click Element                   xpath=//div[contains(@data-question-title, '${questionId}')]//a[contains(@id, 'answerQuestionTender')]
  Wait Until Element Is Visible   id=questionanswer-answer
  Input text                      id=questionanswer-answer   ${answerData.data.answer}
  Click Element                   id=next
  Wait Until Element Is Visible   id=tenderId

Отримати інформацію із запитання
  [Arguments]  ${userName}  ${tenderId}  ${questionId}  ${fieldName}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Wait Until Element Is Visible  id=reloadTender   30
  Click Element                  id=reloadTender
  Wait Until Element Is Visible  id=tenderId   30
  Таб запитання та вимоги
  Wait Until Element Is Visible   xpath=//a[@href='#questions-complaints_questions']
  Execute Javascript   $("#questions-complaints .tab-pane").addClass("active")
  Wait Until Element Is Visible  xpath=//div[contains(@data-question-title,'${questionId}')]//*[contains(@class,'question-${fieldName}')]   1

  ${value}=   Get Text   xpath=//div[contains(@data-question-title,'${questionId}')]//*[contains(@class,'question-${fieldName}')]
  [return]  ${value}

Рішення щодо вимоги
  [Arguments]  ${complaintId}
  ${satisfied}=  Get Element Attribute   xpath=//div[@data-complaintid='${complaintId}']//*[@data-field='status']@data-value
  ${satisfied}=  convert_avi_string_to_common_string  ${satisfied}
  [return]       ${satisfied}

Скарги до початку кваліфікації переможця
  Click Element                     xpath=//a[@href='#questions-complaints']
  Wait Until Page Contains Element  xpath=//a[@href='#questions-complaints_claims']
  Click Element                     xpath=//a[@href='#questions-complaints_claims']
  Sleep                             1

Отримати інформацію із скарги
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${fieldName}  ${awardIndex}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Run Keyword If  '${fieldName}' == 'status'  Run Keyword And Ignore Error  avi.Оновити сторінку з тендером  ${userName}  ${tenderId}
  Скролл до табів

  ${isOpenUa}=  Run Keyword And Return Status
  ...  Should Be Equal  '${mode}'  'openua'

  ${isLotComplaint}=  Run Keyword And Return Status
  ...  Should Be Equal  '${TEST_NAME}'  'Відображення кінцевих статусів двох останніх вимог'

  ${openAwardTab}=  Set Variable If  ${isOpenUa} and ${isLotComplaint}  ${False}  ${True}

  ${isAwardComplaint}=  Run Keyword And Return Status  Element Should Be Visible  xpath=//a[@href='#awards']

  Run Keyword If  ${isAwardComplaint} and ${openAwardTab}  Click Element   xpath=//a[@href='#awards']
  ...   ELSE                           Скарги до початку кваліфікації переможця
  Wait Until Element Is Visible  xpath=//div[@data-complaintid='${complaintId}']

  Run Keyword And Return If  '${fieldName}' == 'satisfied'       Рішення щодо вимоги  ${complaintId}
  Run Keyword And Return If  '${fieldName}' == 'status'          Get Element Attribute   xpath=//div[@data-complaintid='${complaintId}']//span[@data-field='status']@data-value
  Run Keyword And Return If  '${fieldName}' == 'resolutionType'  Get Element Attribute   xpath=//div[@data-complaintid='${complaintId}']//*[@data-field='resolutionType']@data-value
  Run Keyword And Return If  '${fieldName}' == 'resolution'      Get Text  xpath=//div[@data-complaintid='${complaintId}']//*[@class='complaints-${fieldName}']
  ${fieldValue}=                                                 Get Text  xpath=//div[@data-complaintid='${complaintId}']//*[contains(@class,'complaints-${fieldName}')]
  [return]                                                       ${fieldValue}

Отримати посилання на аукціон для глядача
  [Arguments]  ${userName}  ${tenderId}  ${lotId}=${EMPTY}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Очікування посилання
  Run Keyword And Return    Get Element Attribute   id=auctionTender@href

Очікування посилання
  Wait Until Keyword Succeeds   50 x   45 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   id=auctionTender  15

Отримати посилання на аукціон по лоту в модальному вікні
  [Arguments]   ${lotId}
  Click Link                id=auctionTender
  Wait Until Page Contains  Перегляд аукціонів по лотам
  Run Keyword And Return    Get Element Attribute   xpath=//a[contains(text(), '${lotId}')]@href

Отримати посилання на аукціон для учасника
  [Arguments]  ${userName}  ${tenderId}  ${lotId}=${None}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Очікування посилання
  ${url}=   Get Element Attribute   id=auctionTender@href
  Run Keyword And Return If   '${url}' == '#'   Отримати посилання на аукціон по лоту в модальному вікні   ${lotId}
  [return]   ${url}

Отримати інформацію із документа
  [Arguments]  ${userName}  ${tenderId}  ${documentId}  ${fieldName}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Wait Until Keyword Succeeds   10 x   15 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   xpath=//a[@href='#documents']
  Скролл до табів
  Execute Javascript   $(".tab-pane").addClass("active")
  Execute Javascript   $(".box-body").show()
  Wait Until Element Is Visible   xpath=//a[contains(., '${documentId}')]
  Run Keyword And Return If  '${fieldName}' == 'documentOf'          Get Element Attribute   xpath=//a[contains(., '${documentId}')]@data-documentOf
  ${value}=    Get Text   xpath=//a[contains(., '${documentId}')]

  [return]   ${value}

Scroll Page To Element
  [Arguments]  ${locator}
   ${jsSelector}=  Run Keyword If  'css' in '${locator}'  Replace String  ${locator}  css=  ${EMPTY}  count=1
   ...  ELSE  Replace String  ${locator}  id=  \#  count=1

   Execute Javascript  window.$('${jsSelector}')[0].scrollIntoView();
   Sleep  2s

Отримати інформацію із документа до скасування
  [Arguments]  ${userName}  ${tenderId}  ${cancellation_id}  ${documentId}  ${fieldName}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Click Element    xpath=//a[contains(@href,'#documents')]
  Execute Javascript   $("#documents .tab-pane").addClass("active")
  Wait Until Page Contains Element   xpath=//div[contains(@class,'row') and contains(@data-doc-title,'${documentId}')]//*[contains(@class,'doc-${fieldName}')]
  ${value}=   Get Text   xpath=//div[contains(@class,'row') and contains(@data-doc-title,'${documentId}')]//*[contains(@class,'doc-${fieldName}')]
  [return]  ${value}

Отримати документ
  [Arguments]  ${userName}  ${tenderId}  ${documentId}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Wait Until Keyword Succeeds   10 x   20 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   xpath=//a[contains(@href,'#documents')]
  ...   AND   Execute Javascript   $(".tab-pane").addClass("active")
  ...   AND   Execute Javascript   $(".box-body").show()
  ...   AND   Element Should Be Visible   xpath=//a[contains(., '${documentId}')]
  Скролл до табів

  ${fileName}=   Get Text   xpath=//a[contains(., '${documentId}')]
  ${fileUrl}=    Get Element Attribute    xpath=//a[contains(., '${documentId}')]@href
  download_document_from_url   ${fileUrl}   ${fileName}   ${OUTPUT_DIR}

  [return]  ${fileName}

Очікування документів
  Wait Until Keyword Succeeds   10 x   20 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   xpath=//a[contains(@href,'#documents')]
  ...   AND   Click Element    xpath=//a[contains(@href,'#documents')]

Отримати тайтл першого документа
  Очікування документів
  Скролл до табів
  Click Element            xpath=//a[@href='#documents_tender']
  Sleep                    1
  Run Keyword And Return   Get Text   xpath=//div[@id='documents_tender']//a

Отримати документ до лоту
  [Arguments]  ${userName}  ${tenderId}  ${lotId}  ${documentId}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Скролл до табів
  Click Link    xpath=//a[contains(@href,'#documents')]
  Execute Javascript   $("#documents .tab-pane").addClass("active")
  Wait Until Keyword Succeeds   10 x   20 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   xpath=//a[contains(@href,'#documents')]
  ...   AND   Click Element               xpath=//a[contains(@href,'#documents')]
  ...   AND   Execute Javascript   $("#documents .tab-pane").addClass("active")
  ...   AND   Element Should Be Visible   xpath=//a[contains(., '${documentId}')]

  ${file_name}=   Get Text   xpath=//a[contains(., '${documentId}')]
  ${url}=   Get Element Attribute    xpath=//a[contains(., '${documentId}')]@href
  download_document_from_url   ${url}   ${file_name}   ${OUTPUT_DIR}

  [return]  ${file_name}

Отримати інформацію із нецінового показника
  [Arguments]  ${userName}  ${tenderId}  ${featureId}  ${fieldName}
  На початок сторінки
  Wait Until Page Contains Element   xpath=//*[contains(@id,'show-features')]
  Click Element    xpath=//*[contains(@id,'show-features')]
  Execute Javascript  showAllCollapsed()
  Wait Until Element Is Visible   xpath=//div[contains(@class,'features-parent') and contains(.,'${featureId}')]//*[contains(@class, 'features-${fieldName}')]   5
  ${value}=   Get Text  xpath=//div[contains(@class,'features-parent') and contains(.,'${featureId}')]//*[contains(@class, 'features-${fieldName}')]
  Execute Javascript  hideModal('non-price-criterion-modal')
  Run Keyword And Return If  '${fieldName}' == 'featureOf'   convert_avi_string_to_common_string   ${value}
  [return]  ${value}

Перейти в прекваліфікаію
  [Arguments]  ${userName}  ${tenderId}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}

  Click Element                  id=preQualificationTender
  Wait Until Element Is Visible  css=.back_tend
  Scroll Page To Element         css=.action_period
  Execute Javascript             $('.fa-plus').trigger('click');
  Sleep                          1

Завантажити документ у кваліфікацію
  [Arguments]  ${userName}  ${filePath}  ${tenderId}  ${bidIndex}
  Перейти в прекваліфікаію  ${userName}  ${tenderId}
  Return From Keyword If  '${mode}' == 'openeu'  ${True}
  #${bidIndex}=  Evaluate  ${bidIndex} + 1
  ${bidIndex}=  Set Variable If  ${bidIndex} == 0 or ${bidIndex} == -1  1  ${bidIndex}  #For energy

  Wait Until Element Is Visible     xpath=//div[contains(@class, 'bid-${bidIndex}')]//a[contains(@href, '#active-')]
  Click Element                     xpath=//div[contains(@class, 'bid-${bidIndex}')]//a[contains(@href, '#active-')]
  Wait Until Page Contains Element  xpath=//div[contains(@class,' bid-${bidIndex}')]//input[@class="document-img"]
  Choose File                       xpath=//div[contains(@class, 'bid-${bidIndex}')]//input[@class="document-img"]  ${filePath}
  Wait Until Element Is Visible     xpath=//div[contains(., 'Done')]
  Click Element                     xpath=//div[contains(@class, 'bid-${bidIndex}')]//input[contains(@id, 'pre-qualification-qualified')]
  Click Element                     xpath=//div[contains(@class, 'bid-${bidIndex}')]//input[contains(@id, 'pre-qualification-eligible')]
  Click Element                     xpath=//div[contains(@class, 'bid-${bidIndex}')]//button[@name='PreQualification[status]']
  Wait Until Element Is Visible     xpath=//div[contains(@class, 'bid-${bidIndex}')]//a[contains(@href, '/ecp/')]  30
  Накласти ЄЦП

Скасувати кваліфікацію
  [Arguments]  ${userName}  ${tenderId}  ${qualificationIndex}
  Перейти в прекваліфікаію   ${userName}  ${tenderId}
  ${qualificationIndex}=  Set Variable If  ${qualificationIndex} == 0 or ${qualificationIndex} == -1  1  ${qualificationIndex}  #For energy
  Run Keyword  Скасувати кваліфікацію пропозиції    ${userName}  ${tenderId}  ${qualificationIndex}

Скасувати кваліфікацію пропозиції
  [Arguments]  ${userName}  ${tenderId}  ${qualificationIndex}
  Execute Javascript   $(".box-body").show()
  Wait Until Element Is Visible  xpath=//a[contains(@href, '/prozorro/tender/pre-qualification-cancel')][${qualificationIndex}]
  Click Element                  xpath=//a[contains(@href, '/prozorro/tender/pre-qualification-cancel')][${qualificationIndex}]
  Sleep                          1

Відхилити кваліфікацію
  [Arguments]  ${userName}  ${tenderId}  ${qualificationIndex}
  Перейти в прекваліфікаію   ${userName}  ${tenderId}
  ${qualificationIndex}=  Set Variable If  ${qualificationIndex} == 0 or ${qualificationIndex} == -1  1  ${qualificationIndex}  #For energy
  Run Keyword  Відхилити кваліфікацію пропозиції    ${userName}  ${tenderId}  ${qualificationIndex}

Відхилити кваліфікацію пропозиції
  [Arguments]  ${userName}  ${tenderId}  ${qualificationIndex}
  Execute Javascript   $(".box-body").show()
  Wait Until Element Is Visible  xpath=//a[contains(@href, '#unsuccessful')][${qualificationIndex}]
  Click Element                  xpath=//a[contains(@href, '#unsuccessful')][${qualificationIndex}]
  Sleep                          1

  ${filePath}  ${file_name}  ${file_content}=  create_fake_doc
  Choose File                    css=.document-img  ${filePath}
  Wait Until Element Is Visible  xpath=//div[contains(., 'Done')]
  Select Checkbox                xpath=//input[@name='PreQualification[titles][0]' and @value='1']
  Click Element                  xpath=//button[@name='PreQualification[status]' and @value='unsuccessful']
  Wait Until Element Is Visible  xpath=//a[contains(@href, '/ecp/')]
  Накласти ЄЦП
  Wait Until Element Is Visible  xpath=//button[@name='Qualification[status]' and @value='unsuccessful']
  Click Element                  xpath=//button[@name='Qualification[status]' and @value='unsuccessful']
  Wait Until Element Is Visible  xpath=//span[text()='учасник не пройшов кваліфікації']


Підтвердити кваліфікацію конкурентний діалог(ua)
  [Arguments]  ${bidIndex}
  #${bidIndex} всегда равен 1 - так как участники, которіе ждут квалификацию поднимаются на вверх
  ${filePath}  ${file_name}  ${file_content}=  create_fake_doc

  Click Element                  xpath=//div[contains(@class, 'bid-${bidIndex}')]//a[contains(@href, '#active')]
  Sleep                          1
  Choose File                    xpath=//div[contains(@class, 'bid-${bidIndex}')]//input[@class='document-img']  ${filePath}
  Wait Until Element Is Visible  xpath=//div[contains(., 'Done')]
  Select Checkbox                xpath=//div[contains(@class, 'bid-${bidIndex}')]//input[contains(@id, 'pre-qualification-qualified')]
  Select Checkbox                xpath=//div[contains(@class, 'bid-${bidIndex}')]//input[contains(@id, 'pre-qualification-eligible')]
  Click Element                  xpath=//div[contains(@class, 'bid-${bidIndex}')]//button[@name='PreQualification[status]']
  Wait Until Element Is Visible  xpath=//div[contains(@class, 'bid-${bidIndex}')]//a[contains(@href, '/ecp/')]  30
  Накласти ЄЦП
  Wait Until Element Is Visible  xpath=//div[contains(@class, 'bid-${bidIndex}')]//button[@name='Qualification[status]']
  Click Element                  xpath=//div[contains(@class, 'bid-${bidIndex}')]//button[@name='Qualification[status]']

Підтвердити кваліфікацію Відкриті торги(eu)
  [Arguments]  ${bidIndex}
  #${bidIndex} всегда равен 1 - так как участники, которіе ждут квалификацию поднимаются на вверх
  ${bidIndex}=  Set Variable If  ${bidIndex} == 0 or ${bidIndex} == -1  1  ${bidIndex}  #For energy
  ${filePath}  ${file_name}  ${file_content}=  create_fake_doc

  Click Element                  xpath=//div[contains(@class, 'bid-${bidIndex}')]//a[contains(@href, '#active')]
  Sleep                          1
  Choose File                    xpath=//div[contains(@class, 'bid-${bidIndex}')]//input[@class='document-img']  ${filePath}
  Wait Until Element Is Visible  xpath=//div[contains(., 'Done')]
  Select Checkbox                xpath=//div[contains(@class, 'bid-${bidIndex}')]//input[contains(@id, 'pre-qualification-qualified')]
  Select Checkbox                xpath=//div[contains(@class, 'bid-${bidIndex}')]//input[contains(@id, 'pre-qualification-eligible')]
  Click Element                  xpath=//div[contains(@class, 'bid-${bidIndex}')]//button[@name='PreQualification[status]']
  Wait Until Element Is Visible  xpath=//div[contains(@class, 'bid-${bidIndex}')]//a[contains(@href, '/ecp/')]  30
  Накласти ЄЦП
  Wait Until Element Is Visible  xpath=//div[contains(@class, 'bid-${bidIndex}')]//button[@name='Qualification[status]']
  Click Element                  xpath=//div[contains(@class, 'bid-${bidIndex}')]//button[@name='Qualification[status]']

Підтвердити кваліфікацію
  [Arguments]  ${userName}  ${tenderId}  ${bidIndex}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}

  ${procurementMethodType}=  Get Text  xpath=//div[contains(@class, 'tender_head')]//p[@id='procurementMethodType']
  ${isCompetitiveUa}=        Run Keyword And Return Status  Should Be Equal As Strings  ${procurementMethodType}  Конкурентний діалог

  Click Element                  id=preQualificationTender
  Wait Until Element Is Visible  css=.back_tend
  Scroll Page To Element         css=.action_period
  Run Keyword And Return If  '${mode}' == 'open_competitive_dialogue' and ${isCompetitiveUa}
   ...  Підтвердити кваліфікацію конкурентний діалог(ua)  1
  Run Keyword And Return If  '${mode}' == 'openeu'
   ...  Підтвердити кваліфікацію Відкриті торги(eu)  ${bidIndex}

  # Данное условие валидно для *Конкурентний діалог з публікацією англ.мовою* - так как для 3 го участника
  # тестом не загружается документ, а сразу подтверждается - то используем кейворд *конкурентний діалог(ua)*
  Run Keyword And Return If  '${mode}' == 'open_competitive_dialogue' and ${bidIndex} == -2
  ...  Підтвердити кваліфікацію конкурентний діалог(ua)  1

  # ${bidIndex}=  Set Variable If  ${bidIndex} == 0 or ${bidIndex} == -1  1  ${bidIndex}  #For energy
  ${bidIndex}=  Set Variable  1
  Wait Until Page Contains Element  xpath=//div[contains(@class,'bid-${bidIndex}')]//button[@name='Qualification[status]']
  Click Element                     xpath=//div[contains(@class,'bid-${bidIndex}')]//button[@name='Qualification[status]']

Затвердити остаточне рішення кваліфікації
  [Arguments]  ${userName}  ${tenderId}
  Перейти в прекваліфікаію  ${userName}  ${tenderId}
  Wait Until Element Is Visible  id=standStillPreQualification
  Click Link                     id=standStillPreQualification

Отримати статус пропозиції кваліфікації
  [Arguments]   ${index}
  Wait Until Keyword Succeeds   10 x   15 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   id=preQualificationTender
  Click Link                id=preQualificationTender
  Wait Until Page Contains  Прекваліфікація
  ${status}=  Get Text  xpath=//div[contains(@class, 'bid-${index}')]//span[contains(@class,'bid-status')]
  ${status}=  convert_avi_string_to_common_string  ${status}
  [return]    ${status}

Накласти ЄЦП
  Execute Javascript  $.post($("a[href*='/ecp/']").attr("href"), {sign:"fake"}, function(){ location.reload();});
  Sleep               3

Скролл до табів
  Scroll Page To Element  css=.nav-tabs-ubiz

Створити постачальника, додати документацію і підтвердити його
  [Arguments]   ${userName}   ${tenderId}   ${supplier_data}   ${file}

  ${contactPointPhone}=   Get From Dictionary   ${supplier_data.data.suppliers[0].contactPoint}  telephone
  ${contactPointPhone}=   Catenate  SEPARATOR=  +  ${contactPointPhone}

  Set To Dictionary  ${USERS.users['${userName}']['supplier_data']['data']['suppliers'][0]['contactPoint']}   telephone=${contactPointPhone}

  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}

  Wait Until Element Is Visible  id=ecpTender
  Накласти ЄЦП

  Wait Until Element Is Visible     id=addAwardTender   15
  Click Element                     id=addAwardTender
  Wait Until Element Is Visible     id=supplier-name   15
  Input Text                        id=supplier-name            ${supplier_data.data.suppliers[0].name}
  ${valueAmount}                    Get From Dictionary         ${supplier_data.data.value}   amount
  ${valueAmount}                    Convert To String           ${valueAmount}
  Input Text                        id=Supplier-value-amount    ${valueAmount}
  Input Text                        id=supplier-edrpou          ${supplier_data.data.suppliers[0].identifier.id}
  Input text                        id=contactPoint-name        ${supplier_data.data.suppliers[0].contactPoint.name}
  Input text                        id=contactPoint-email       ${supplier_data.data.suppliers[0].contactPoint.email}
  Input text                        id=contactPoint-faxNumber   ${supplier_data.data.suppliers[0].contactPoint.faxNumber}

  Execute Javascript  $('#contactPoint-telephone').val(null);
  Sleep               1

  Input text                        id=contactPoint-telephone   ${supplier_data.data.suppliers[0].contactPoint.telephone}
  Input text                        id=contactPoint-url         ${supplier_data.data.suppliers[0].contactPoint.url}
  ${region}=                        Get From Dictionary         ${supplier_data.data.suppliers[0].address}     region
  ${region}=                        convert_avi_string_to_common_string   ${region}
  Execute Javascript                setMySelectBox("addressFirm-regionId", "${region}")
  Input Text                        id=addressFirm-locality         ${supplier_data.data.suppliers[0].address.locality}
  Input Text                        id=addressFirm-address          ${supplier_data.data.suppliers[0].address.streetAddress}
  Input text                        id=addressFirm-postalCode       ${supplier_data.data.suppliers[0].address.postalCode}
  Click Element                     id=next
  Wait Until Page Contains Element  xpath=//p[contains(text(), 'Кваліфікація')]
  Sleep                             2
  Execute Javascript                $('.fa-plus').trigger('click');
  Sleep                             1
  Scroll Page To Element            css=.box-body
  Click Element                     xpath=//a[contains(@href, '#active-')]

  Wait Until Element Is Visible     css=.add-item
  Click Element                     css=.add-item
  Wait Until Element Is Visible     css=.delete-document
  Choose File                       css=.document-img  ${file}
  Wait Until Page Contains          Done
  ${qualificationCheckBoxes}=       Run Keyword And Return Status  Element Should Be Visible  xpath=//input[contains(@id, 'qualification-qualified')]
  Run Keyword If                    ${qualificationCheckBoxes}  Чекбокси кваліфікації
  Click Element                     xpath=//button[@name='Qualification[status]']
  Wait Until Page Contains          Розглядається   30
  Sleep    1
  Накласти ЄЦП
  Wait Until Page Contains Element   xpath=//button[@name='Qualification[status]']
  Scroll Page To Element             css=.action_period
  Click Element                      xpath=//button[@name='Qualification[status]']
  Wait Until Page Contains           Пропозицію прийнято   40
  Click Link                         css=.back_tend

Чекбокси кваліфікації
  Run Keyword And Ignore Error   Click Element  xpath=//input[contains(@id, 'qualification-qualified')]
  Run Keyword And Ignore Error   Click Element  xpath=//input[contains(@id, 'qualification-eligible')]

Отримати інформацію із документа до скарги
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${documentId}  ${field}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Скролл до табів
  ${isAwardComplaint}=  Run Keyword And Return Status  Element Should Be Visible  xpath=//a[@href='#awards']

  Run Keyword If  ${isAwardComplaint}  Click Element  xpath=//a[@href='#awards']
  ...  ELSE  Скарги до початку кваліфікації переможця


  ${tabPaneId}=  Set Variable If  ${isAwardComplaint}  awards  questions-complaints

  Scroll Page To Element         id=${tabPaneId} div[data-complaintid="${complaintId}"]
  Wait Until Element Is Visible  xpath=//div[@data-complaintid='${complaintId}']//a[contains(., '${documentId}')]
  ${documentTitle}=              Get Text  xpath=//div[@data-complaintid='${complaintId}']//a[contains(., '${documentId}')]
  [return]                       ${documentTitle}

Відповісти на вимогу про виправлення умов закупівлі
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${answerData}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Wait Until Keyword Succeeds   10 x   15 s   Run Keywords
  ...   Reload Page
  ...   AND   Скролл до табів
  ...   AND   Wait Until Element Is Visible   xpath=//a[contains(@href,'#questions-complaints')]
  ...   AND   Click Element                   xpath=//a[contains(@href,'#questions-complaints')]
  ...   AND   Wait Until Element Is Visible   xpath=//a[contains(@href,'#questions-complaints_claims')]
  ...   AND   Click Element                   xpath=//a[contains(@href,'#questions-complaints_claims')]
  ...   AND   Wait Until Element Is Visible   xpath=//div[@data-complaintid='${complaintId}']

  Click Link                                  xpath=//div[@data-complaintid='${complaintId}']//a[contains(@href, '/prozorro/complaint/answer')]
  Відповісти на скаргу                        ${answerData.data}

Відповісти на скаргу
  [Arguments]   ${answerData}
  Wait Until Page Contains Element    id=complaintanswer-resolution   15
  ${resolutionType}=                  Get From Dictionary   ${answerData}   resolutionType
  ${resolutionType}=                  convert_avi_string_to_common_string   resolution_${resolutionType}
  Execute Javascript                  setMySelectBox("complaintanswer-resolutiontype", "${resolutionType}")
  Input Text                          id=complaintanswer-resolution       ${answerData.resolution}
  Input Text                          id=complaintanswer-tendereraction   ${answerData.tendererAction}
  Capture Page Screenshot
  Click Element                       id=next

Завантажити документ рішення кваліфікаційної комісії
  [Arguments]  ${userName}  ${file}  ${tenderId}  ${awardIndex}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Wait Until Keyword Succeeds   10 x   15 s   Run Keywords
  ...   Reload Page
  ...   AND   Wait Until Element Is Visible   id=qualificationTender
  ...   AND   Click Element                   id=qualificationTender

  Wait Until Element Is Visible   xpath=//a[contains(@href, '#active')]
  Scroll Page To Element          css=.action_period
  Click Element                   xpath=//a[contains(@href, '#active')]
  Sleep                           1

  ${addItem}=  Run Keyword And Return Status  Element Should Be Visible  css=.add-item
  Run Keyword If  ${addItem}  Run Keywords
  ...       Click Element                  css=.add-item
  ...  AND  Wait Until Element Is Visible  css=.delete-document
  Choose File                     css=.document-img  ${file}
  Wait Until Element Is Visible   xpath=//div[contains(., 'Done')]

  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'qualification-eligible')]
  Run Keyword And Ignore Error  Select Checkbox  xpath=//input[contains(@id, 'qualification-qualified')]

  Click Element                   xpath=//button[@name='Qualification[status]']
  Wait Until Element Is Visible   xpath=//a[contains(@href, '/ecp/')]
  Накласти ЄЦП
  Wait Until Element Is Visible   xpath=//button[@name='Qualification[status]']

Підтвердити постачальника в допорогових закупівлях за донороські кошти
  Wait Until Element Is Visible   xpath=//a[contains(@href, '#active')]
  Click Element                   xpath=//a[contains(@href, '#active')]
  Sleep                           1

  ${filePath}  ${file_name}  ${file_content}=  create_fake_doc
  Click Element                               css=.add-item
  Wait Until Element Is Visible               css=.delete-document
  Choose File                                 css=.document-img  ${filePath}
  Wait Until Element Is Visible               xpath=//div[contains(., 'Done')]
  Click Element                               xpath=//button[@name='Qualification[status]']

  Sleep                                       2
  Wait Until Element Is Visible               xpath=//button[@name='Qualification[status]' and not(contains(@class, 'inactive-opacity'))]
  Click Element                               xpath=//button[@name='Qualification[status]' and not(contains(@class, 'inactive-opacity'))]
  Wait Until Element Is Visible               id=qualificationCancel

Підтвердити постачальника
  [Arguments]  ${userName}  ${tenderId}  ${awardIndex}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  ${qualificationBtnIsVisible}=  Run Keyword And Return Status  Element Should Be Visible  id=qualificationTender

  Run Keyword Unless  ${qualificationBtnIsVisible}  Return From Keyword  ${True}

  Click Element                  id=qualificationTender
  Wait Until Element Is Visible  xpath=//div[contains(@class, 'all-bid')]

  ${isBelowFunders}=  Run Keyword And Return Status  Element Should Be Visible  xpath=//span[contains(., 'Допорогові закупівлі (донорські кошти)')]
  Run Keyword And Return If  ${isBelowFunders}  Підтвердити постачальника в допорогових закупівлях за донороські кошти

  Wait Until Element Is Visible   xpath=//button[@name='Qualification[status]']
  Click Element                   xpath=//button[@name='Qualification[status]']
  Wait Until Element Is Visible   xpath=//a[@id='qualificationCancel']

Відповісти на вимогу про виправлення визначення переможця
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${answerData}  ${awardIndex}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Wait Until Keyword Succeeds   10 x   15 s   Run Keywords
  ...   Reload Page
  ...   AND   Скролл до табів
  ...   AND   Wait Until Element Is Visible   xpath=//a[contains(@href,'#awards')]
  ...   AND   Click Element                   xpath=//a[contains(@href,'#awards')]
  ...   AND   Wait Until Element Is Visible   xpath=//div[@data-complaintid='${complaintId}']
  Скролл до табів
  Click Link                                  xpath=//div[@data-complaintid='${complaintId}']//a[contains(@href, '/prozorro/award-complaint/answer')]
  Відповісти на скаргу                        ${answerData.data}

Підтвердити підписання контракту для відкритих торгів енергосервісу
  Накласти ЄЦП
  Wait Until Element Is Visible  xpath=//button[@data-status='3']
  Click Element                  xpath=//button[@data-status='3']

Підтвердити підписання контракту для openua
  Накласти ЄЦП
  Wait Until Element Is Visible  xpath=//button[@data-status='3']

  ${currentDate}=                get_contract_end_date
  Execute Javascript             $('#contract-period-enddate').val('${currentDate}');
  Sleep                          1

  Click Element                  xpath=//button[@data-status='3']

Підтвердити підписання контракту для openeu
  Накласти ЄЦП
  Wait Until Element Is Visible  xpath=//button[@data-status='3']

  ${currentDate}=                get_contract_end_date
  Execute Javascript             $('#contract-period-enddate').val('${currentDate}');
  Sleep                          1

  Click Element                  xpath=//button[@data-status='3']

Підтвердити підписання контракту для openua_defense
  Накласти ЄЦП
  Wait Until Element Is Visible  xpath=//button[@data-status='3']

  ${currentDate}=                get_contract_end_date
  Execute Javascript             $('#contract-period-enddate').val('${currentDate}');
  Sleep                          1

  Click Element                  xpath=//button[@data-status='3']

Підтвердити підписання контракту для competitive_dialogue
  Накласти ЄЦП
  Wait Until Element Is Visible  xpath=//button[@data-status='3']
  Scroll Page To Element         id=documents-box

  ${currentDate}=     get_contract_end_date
  Execute Javascript  $('#contract-period-enddate').val('${currentDate}');
  Sleep               1

  Click Element                  xpath=//button[@data-status='3']

Підтвердити підписання контракту
  [Arguments]  ${userName}  ${tenderId}  ${contractIndex}
  avi.Пошук тендера по ідентифікатору   ${userName}   ${tenderId}
  Wait Until Keyword Succeeds   10 x   15 s   Run Keywords
  ...   Reload Page
  ...   AND   Скролл до табів
  ...   AND   Wait Until Element Is Visible   xpath=//a[contains(@href,'#contracts')]
  ...   AND   Click Element                   xpath=//a[contains(@href,'#contracts')]
  ...   AND   Execute Javascript              showAllCollapsed();
  ...   AND   Wait Until Element Is Visible   xpath=//span[@class='contract-awarded']
  ...   AND   Click Element                   xpath=//span[@class='contract-awarded']

  Wait Until Element Is Visible               id=contract-contractnumber  30
  Log To Console  ${mode}
  Run Keyword And Return If  '${mode}' == 'open_esco'  Підтвердити підписання контракту для відкритих торгів енергосервісу
  Run Keyword And Return If  '${mode}' == 'openua'  Підтвердити підписання контракту для openua
  Run Keyword And Return If  '${mode}' == 'openeu'  Підтвердити підписання контракту для openeu
  Run Keyword And Return If  '${mode}' == 'openua_defense'  Підтвердити підписання контракту для openua_defense
  Run Keyword And Return If  '${mode}' == 'open_competitive_dialogue'  Підтвердити підписання контракту для competitive_dialogue

  #${isNegotiation}=                           Run Keyword And Return Status  Element Should Be Visible  xpath=//span[contains(., 'Переговорна процедура')]

  Scroll Page To Element                       id=documents-box
  Input Text                                   id=contract-contractnumber    ${tenderId}
  ${currentDate}=                              get_contract_end_date
  Execute Javascript                           $('#contract-period-enddate').val('${currentDate}');
  Execute Javascript                           $('#contract-period-enddate-disp').val('${currentDate}');
  ${filePath}  ${file_name}  ${file_content}=  create_fake_doc
  Click Element                                css=.add-item
  Wait Until Element Is Visible                css=.delete-document
  Choose File                                  css=.document-img  ${filePath}
  Wait Until Element Is Visible                xpath=//div[contains(., 'Done')]

  Run Keyword And Return If  '${mode}' == 'negotiation'  Підтвердити контракт для переговорної
  Scroll Page To Element                       id=documents-box

  ${isVisibleUploadContractButton}=   Run Keyword And Return Status
  ...   Element Should Be Visible  xpath=//button[@data-status='1']

  Run Keyword If  ${isVisibleUploadContractButton}  Click Element  xpath=//button[@data-status='1']
  ...   ELSE  Click Element   xpath=//button[@data-status='4']

  Sleep                                        2
  Wait Until Element Is Visible                xpath=//a[@data-status='10']

  Scroll Page To Element                       css=.box-buttons
  Накласти ЄЦП
  Wait Until Element Is Visible                css=.action_period
  Scroll Page To Element                       css=.box-buttons

  Wait Until Element Is Visible                xpath=//button[@data-status='3']    30
  Sleep                                        1
  Click Element                                xpath=//button[@data-status='3']

Підтвердити контракт для переговорної
  Click Element                   xpath=//button[@data-status='1']
  Wait Until Element Is Visible   xpath=//a[@data-status='10']  45
  Накласти ЄЦП
  Wait Until Element Is Visible   css=.action_period
  Scroll Page To Element          css=.action_period
  Wait Until Element Is Visible   xpath=//button[@data-status='3']    30
  Sleep                           1
  Click Element                   xpath=//button[@data-status='3']

Створити вимогу про виправлення умов закупівлі
  [Arguments]  ${userName}  ${tenderId}  ${complaintData}  ${file}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Wait Until Element Is Visible   id=draftComplaintTender
  Click Element                   id=draftComplaintTender
  Wait Until Element Is Visible   css=.action_period
  Scroll Page To Element          css=.action_period
  Input Text                      id=complaintdraft-title  ${complaintData.data.title}
  Input Text                      id=complaintdraft-description  ${complaintData.data.description}
  Execute Javascript              $('.fa-plus').trigger('click');
  Wait Until Element Is Visible   css=.add-item
  Click Element                   css=.add-item
  Wait Until Element Is Visible   css=.delete-document
  Choose File                     css=.document-img  ${file}
  Wait Until Page Contains        Done
  Click Element                   xpath=//button[contains(text(), 'Подати')]
  Wait Until Element Is Visible   id=publisher-info  45
  Скролл до табів
  Wait Until Page Contains        ${complaintData.data.title}
  Wait Until Element Is Visible   xpath=//h3[@class='box-title']//span[contains(., "${complaintData.data.title}")]
  ${complaintId}=                 Get Element Attribute  xpath=//div[@id='questions-complaints_claims']/div[last()]@data-complaintid
  [return]                        ${complaintId}

Підтвердити вирішення вимоги про виправлення умов закупівлі
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${complaintData}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Скролл до табів
  Click Element                   xpath=//a[@href='#questions-complaints']
  Wait Until Element Is Visible   xpath=//a[@href='#questions-complaints_claims']
  Click Element                   xpath=//a[@href='#questions-complaints_claims']
  Wait Until Element Is Visible   xpath=//div[@data-complaintid='${complaintId}']
  Click Element                   xpath=//div[@data-complaintid='${complaintId}']//a[contains(text(), 'Задоволення вимоги')]

  Return From Keyword If  '${mode}' == 'openua'  ${True}

  Wait Until Page Contains        Задоволення вимоги  45
  Scroll Page To Element          css=.action_period
  Run Keyword If  ${complaintData.data.satisfied}  Click Element  xpath=//div[@id='complaintresolve-satisfied']//input[@value="1"]
  ...   ELSE   Click Element  xpath=//div[@id='complaintresolve-satisfied']//input[@value="0"]
  Sleep  1
  Capture Page Screenshot
  Click Element  xpath=//button[contains(text(), 'Підтвердити')]

Створити вимогу про виправлення умов лоту
  [Arguments]  ${userName}  ${tenderId}  ${complaintData}  ${lotId}  ${file}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Wait Until Element Is Visible   id=draftComplaintTender
  Click Element                   id=draftComplaintTender
  Wait Until Element Is Visible   css=.action_period
  Scroll Page To Element          css=.action_period
  Execute Javascript              $("#claim-element").val($("#claim-element :contains('${lotId}') option").first().attr("value")).change();
  Input Text                      id=complaintdraft-title  ${complaintData.data.title}
  Input Text                      id=complaintdraft-description  ${complaintData.data.description}
  Execute Javascript              $('.fa-plus').trigger('click');
  Wait Until Element Is Visible   css=.add-item
  Click Element                   css=.add-item
  Wait Until Element Is Visible   css=.delete-document
  Choose File                     css=.document-img  ${file}
  Wait Until Page Contains        Done
  Click Element                   xpath=//button[contains(text(), 'Подати')]
  Wait Until Element Is Visible   id=publisher-info  45
  На початок сторінки
  Скролл до табів
  Click Element                   xpath=//a[@href='#questions-complaints']
  Wait Until Page Contains        ${complaintData.data.title}
  ${complaintId}=                 Get Element Attribute  xpath=//div[@id='questions-complaints_claims']/div[last()]@data-complaintid
  [return]                        ${complaintId}

Підтвердити вирішення вимоги про виправлення умов лоту
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${complaintData}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Скролл до табів
  Click Element                   xpath=//a[@href='#questions-complaints']
  Wait Until Element Is Visible   xpath=//a[@href='#questions-complaints_claims']
  Click Element                   xpath=//a[@href='#questions-complaints_claims']
  Wait Until Element Is Visible   xpath=//div[@data-complaintid='${complaintId}']
  Click Element                   xpath=//div[@data-complaintid='${complaintId}']//a[contains(text(), 'Задоволення вимоги')]
  Wait Until Page Contains        Задоволення вимоги  45
  Scroll Page To Element          css=.action_period
  Run Keyword If  ${complaintData.data.satisfied}  Click Element  xpath=//div[@id='complaintresolve-satisfied']//input[@value="1"]
  ...   ELSE   Click Element  xpath=//div[@id='complaintresolve-satisfied']//input[@value="0"]
  Sleep  1
  Capture Page Screenshot
  Click Element  xpath=//button[contains(text(), 'Підтвердити')]

Створити чернетку вимоги про виправлення умов закупівлі
  [Arguments]  ${userName}  ${tenderId}  ${complaintData}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Wait Until Element Is Visible   id=draftComplaintTender
  Click Element                   id=draftComplaintTender
  Wait Until Element Is Visible   css=.action_period
  Scroll Page To Element          css=.action_period
  Input Text                      id=complaintdraft-title  ${complaintData.data.title}
  Input Text                      id=complaintdraft-description  ${complaintData.data.description}
  Click Element                   xpath=//button[contains(text(), 'Подати')]
  Wait Until Element Is Visible   id=publisher-info  45
  Скролл до табів
  Click Element                   xpath=//a[@href='#questions-complaints']
  Wait Until Page Contains        ${complaintData.data.title}
  ${complaintId}=                 Get Element Attribute  xpath=//div[@id='questions-complaints_claims']/div[last()]@data-complaintid
  [return]                        ${complaintId}

Створити чернетку вимоги про виправлення умов лоту
  [Arguments]  ${userName}  ${tenderId}  ${complaintData}  ${lotId}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Wait Until Element Is Visible   id=draftComplaintTender
  Click Element                   id=draftComplaintTender
  Wait Until Element Is Visible   css=.action_period
  Scroll Page To Element          css=.action_period
  Execute Javascript              $("#claim-element").val($("#claim-element :contains('${lotId}') option").first().attr("value")).change();
  Input Text                      id=complaintdraft-title  ${complaintData.data.title}
  Input Text                      id=complaintdraft-description  ${complaintData.data.description}
  Click Element                   xpath=//button[contains(text(), 'Подати')]
  Wait Until Element Is Visible   id=publisher-info  45
  Скролл до табів
  Click Element                   xpath=//a[@href='#questions-complaints']
  Wait Until Page Contains        ${complaintData.data.title}
  ${complaintId}=                 Get Element Attribute  xpath=//div[@id='questions-complaints_claims']/div[last()]@data-complaintid
  [return]                        ${complaintId}

Скасувати вимогу
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${cancellationData}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Скролл до табів
  Click Element                     xpath=//a[@href='#questions-complaints']
  Wait Until Element Is Visible     xpath=//a[@href='#questions-complaints_claims']
  Click Element                     xpath=//a[@href='#questions-complaints_claims']
  Wait Until Page Contains Element  xpath=//div[@data-complaintid='${complaintId}']
  Click Element                     xpath=//div[@data-complaintid='${complaintId}']//a[contains(text(), 'Відмінити вимогу')]
  Wait Until Element Is Visible     css=.action_period
  Scroll Page To Element            css=.action_period
  Input Text                        id=complaintcancel-cancellationreason  ${cancellationData.data.cancellationReason}
  Capture Page Screenshot
  Click Element                     xpath=//button[contains(text(), 'Далі')]

Скасувати вимогу про виправлення умов закупівлі
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${cancellationData}
  Скасувати вимогу  ${userName}  ${tenderId}  ${complaintId}  ${cancellationData}

Скасувати вимогу про виправлення умов лоту
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${cancellationData}
  Скасувати вимогу  ${userName}  ${tenderId}  ${complaintId}  ${cancellationData}

Створити вимогу про виправлення визначення переможця
  [Arguments]  ${userName}  ${tenderId}  ${complaintData}  ${awardIndex}  ${file}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Скролл до табів
  Click Element                   xpath=//a[@href='#awards']
  Wait Until Element Is Visible   id=draftComplaintAward  10
  Click Element                   id=draftComplaintAward
  Wait Until Element Is Visible   css=.action_period
  Scroll Page To Element          css=.action_period
  Input Text                      id=complaintdraft-title  ${complaintData.data.title}
  Input Text                      id=complaintdraft-description  ${complaintData.data.description}
  Execute Javascript              $('.fa-plus').trigger('click');
  Wait Until Element Is Visible   css=.add-item
  Click Element                   css=.add-item
  Wait Until Element Is Visible   css=.delete-document
  Choose File                     css=.document-img  ${file}
  Wait Until Page Contains        Done
  Click Element                   xpath=//button[contains(text(), 'Подати')]
  Wait Until Element Is Visible   id=publisher-info  45
  ${complaintId}=                 Get Element Attribute  xpath=//div[@class='form_box mrgn-t20']//div[@class='dib']/div[last()]@data-complaintid
  [return]                        ${complaintId}

Підтвердити вирішення вимоги про виправлення визначення переможця
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${complaintData}  ${awardIndex}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Скролл до табів
  Click Element                     xpath=//a[@href='#awards']
  Wait Until Page Contains Element  xpath=//div[@data-complaintid='${complaintId}']
  Click Element                     xpath=//div[@data-complaintid='${complaintId}']//a[contains(text(), 'Задоволення вимоги')]
  Wait Until Page Contains          Задоволення вимоги  45
  Scroll Page To Element            css=.action_period
  Run Keyword If  ${complaintData.data.satisfied}  Click Element  xpath=//div[@id='complaintresolve-satisfied']//input[@value="1"]
  ...   ELSE   Click Element  xpath=//div[@id='complaintresolve-satisfied']//input[@value="0"]
  Sleep  1
  Capture Page Screenshot
  Click Element  xpath=//button[contains(text(), 'Підтвердити')]

Створити чернетку вимоги про виправлення визначення переможця
  [Arguments]  ${userName}  ${tenderId}  ${complaintData}  ${awardIndex}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Скролл до табів
  Click Element                     xpath=//a[@href='#awards']
  Wait Until Page Contains Element  id=draftComplaintAward
  Click Element                     id=draftComplaintAward
  Wait Until Element Is Visible     css=.action_period
  Scroll Page To Element            css=.action_period
  Input Text                        id=complaintdraft-title  ${complaintData.data.title}
  Input Text                        id=complaintdraft-description  ${complaintData.data.description}
  Click Element                     xpath=//button[contains(text(), 'Подати')]
  Wait Until Element Is Visible     id=publisher-info  45
  Скролл до табів
  Click Element                     xpath=//a[@href='#awards']
  Wait Until Page Contains          ${complaintData.data.title}
  ${complaintId}=                   Get Element Attribute  xpath=//div[@class='form_box mrgn-t20']//div[@class='dib']/div[last()]@data-complaintid
  [return]                          ${complaintId}

Скасувати вимогу про виправлення визначення переможця
  [Arguments]  ${userName}  ${tenderId}  ${complaintId}  ${cancellationData}  ${awardIndex}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Скролл до табів
  Click Element                     xpath=//a[@href='#awards']
  Wait Until Page Contains Element  xpath=//div[@data-complaintid='${complaintId}']


  Run Keyword If  '${mode}' == 'openua' and 'скасувати скаргу' in '${TEST_NAME}'  Click Element  xpath=//div[@data-complaintid='${complaintId}']//a[contains(text(), 'Відміна скарги')]
  ...  ELSE  Click Element  xpath=//div[@data-complaintid='${complaintId}']//a[contains(text(), 'Відмінити вимогу')]

  Wait Until Element Is Visible     id=complaintcancel-cancellationreason  30
  Input Text                        id=complaintcancel-cancellationreason  ${cancellationData.data.cancellationReason}
  Click Element                     id=next

  ### Plans:start ###

Оновити сторінку з планом
  [Arguments]  ${userName}  ${planId}
  avi.Пошук плану по ідентифікатору   ${userName}   ${planId}

Пошук плану по ідентифікатору
  [Arguments]  ${userName}  ${planId}
  На початок сторінки

  ${isPlanModule}=    Run Keyword And Return Status   Element Should Be Visible  id=main-plansearch

  Run Keyword Unless  ${isPlanModule}   Run Keywords
  ...   Click Element   xpath=//ul[contains(@class, 'list-group')]//li//a[@href='/prozorro/plan-view']
  ...   AND   Wait Until Element Is Visible  id=main-plansearch  30

  Input Text                      id=main-plansearch  ${planId}
  Click Element                   id=search-main
  Sleep                           1

  Wait Until Keyword Succeeds   10 x   30 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   xpath=//div[contains(@class, 'one_card')]//a[@href='/prozorro/plan-view/${planId}']

  Click Element                  xpath=//div[contains(@class, 'one_card')]//a[@href='/prozorro/plan-view/${planId}']
  Wait Until Element Is Visible  id=tenderId  30

Отримати інформацію із плану
  [Arguments]  ${userName}  ${planId}  ${fieldName}

  Run keyword And Return If  '${fieldName}' == 'budget.currency'      Get Text  xpath=//span[@data-field='budget.currency']
  Run keyword And Return If  '${fieldName}' == 'budget.description'   Get Text  xpath=//h1[@id='tenderTitle']
  Run keyword And Return If  '${fieldName}' == 'budget.project.name'  Get Text  xpath=//span[@data-field='budget.project.name']

  Run keyword And Return If  '${fieldName}' == 'tender.tenderPeriod.startDate'         Get Element Attribute  xpath=//span[@data-field='tender.tenderPeriod.startDate']@data-value
  Run keyword And Return If  '${fieldName}' == 'procuringEntity.identifier.legalName'  Отримати інформацію про plan.${fieldName}

  Run Keyword And Return If  'items' in '${fieldName}'  Отримати інформацію із предмету в плані  ${userName}  ${planId}  ${fieldName}

  Run keyword And Return If  '${fieldName}' == 'classification.id'           Get Text  xpath=//div[contains(@class, 'tender_head ')]//span[@class='classification-id']
  Run keyword And Return If  '${fieldName}' == 'classification.scheme'       Get Text  xpath=//div[contains(@class, 'tender_head ')]//span[@class='classification-scheme']
  Run keyword And Return If  '${fieldName}' == 'classification.description'  Get Text  xpath=//div[contains(@class, 'tender_head ')]//span[@class='classification-description']

  Run Keyword And Return   Отримати інформацію про ${fieldName}

Отримати інформацію про tender.procurementMethodType
  ${procurementMethodType}=  Get Text  xpath=//p[@data-field='tender.procurementMethodType']//span
  ${procurementMethodType}=  procurement_method_types  ${procurementMethodType}   True

  [return]  ${procurementMethodType}

Отримати інформацію про budget.amount
  ${budgetAmount}=   Get Text  xpath=//span[@data-field='budget.amount']
  ${budgetAmount}=   Evaluate  "".join("${budgetAmount}".split(' ')).replace(",", ".")
  ${budgetAmount}=   Convert To Number  ${budgetAmount}

  [return]  ${budgetAmount}

Отримати інформацію про budget.id
  Run Keyword And Return  Get Text  xpath=//span[@data-field='budget.id']

Отримати інформацію про budget.project.id
  Run Keyword And Return  Get Text  xpath=//span[@data-field='budget.project.id']

Отримати інформацію про plan.procuringEntity.identifier.legalName
  Click Element                  id=publisher-info
  Wait Until Element Is Visible  id=procuringEntityLegalName
  ${legalName}=                  Get Text  id=procuringEntityLegalName
  Click Element                  xpath=//div[@id='publisher-info-modal']//button[@class='close']
  Sleep                          1
  [return]  ${legalName}

Отримати інформацію із предмету в плані
  [Arguments]  ${userName}  ${planId}  ${fieldName}
  Скролл до табів
  ${itemIndex}=            Get Substring    ${fieldName}   6  7
  ${fieldName}=            Replace String   ${fieldName}   items[${itemIndex}].  ${EMPTY}
  ${itemIndex}=            Evaluate         ${itemIndex} + 1
  ${itemDescription}=      Get Text  xpath=(//a[contains(@href, '#items_item')])[${itemIndex}]
  ${itemId}=               Get Substring   ${itemDescription}   0  10
  ${itemId}=               Convert To Lowercase  ${itemId}

  Run keyword And Return   avi.Отримати інформацію із предмету  ${userName}  ${planId}  ${itemId}  ${fieldName}

Створити план
  [Arguments]  ${userName}  ${planData}
  Wait Until Element Is Visible  id=add_tender
  Клацнути і дочекатися  id=add_tender   xpath=//a[contains(@href, '/prozorro/plan/create?add=1')]  0
  Click Element          xpath=//a[contains(@href, '/prozorro/plan/create?add=1')]

  Wait Until Element Is Visible   id=plan-title

  ${procurementMethodTypeUkr}=  procurement_method_types  ${planData.data.tender.procurementMethodType}
  ${budgetYear} =               date_to_format            ${planData.data.tender.tenderPeriod.startDate}  %Y
  ${tenderPeriod}=              date_to_format            ${planData.data.tender.tenderPeriod.startDate}  %Y/%m
  ${budgetAmount}=              convert_float_to_string   ${planData.data.budget.amount}
  ${budgetCurrency}=            currency_types            ${planData.data.budget.currency}

  Input Text             id=plan-title  ${planData.data.budget.description}
  Execute Javascript     setMySelectBox('plan-methodtype', '${procurementMethodTypeUkr}');
  Execute Javascript     setMySelectBox('plan-budgetyear', '${budgetYear}');
  Input Text             id=plan-procurementmonth   ${tenderPeriod}
  Input Text             id=Plan-value-amount   ${budgetAmount}
  Execute Javascript     setMySelectBox('Plan-value-currency', '${budgetCurrency}');
  Обрати класифікатор    collapseClassificationCpv   ${planData.data.classification}

  Click Element          id=next

  Wait Until Element Is Visible  xpath=//a[contains(@href, '/prozorro/plan/add-item-tender')]
  Click Element                  xpath=//a[contains(@href, '/prozorro/plan/add-item-tender')]

  ${items}=       Get From Dictionary   ${planData.data}  items
  ${itemsCount}=  Get Length  ${items}

  : FOR  ${index}  IN RANGE  0  ${itemsCount}
  \  Run Keyword IF  ${index} > 0   Click Element  xpath=//a[contains(@href, '/prozorro/plan/add-item-tender')]
  \  Додати предмет до плану  ${items[${index}]}

  Click Element                  id=endEdit
  Wait Until Element Is Visible  id=tenderId
  ${planId}=                     Get Text  id=tenderId
  Click Element                  xpath=//a[contains(@id, 'publication')]
    Wait Until Keyword Succeeds   15 x   5 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   id=tenderId-${planId}
  Click Element  id=tenderId-${planId}

  Run Keyword And Return  Get Text  id=tenderId

Додати предмет до плану
  [Arguments]  ${item}
  Wait Until Element Is Visible  id=planitem-description
  Input Text                     id=planitem-description  ${item.description}
  Input Text                     id=planitem-quantity    ${item.quantity}
  Execute Javascript             setMySelectBox("planitem-unit", "${item.unit.name}");

  ${mainClassificationId}=            Get From Dictionary   ${item.classification}  id
  Обрати класифікатор                 collapseClassificationCpv   ${item.classification}
  ${additionalClassificationsExist}=  Run Keyword And Return Status   Dictionary Should Contain Key  ${item}   additionalClassifications
  ${isMedicalGroup}=   Get Substring   ${mainClassificationId}   0  3
  Run Keyword If   ${additionalClassificationsExist} and '${isMedicalGroup}' == '336'   Обрати класифікатор   collapseClassificationMulti   ${item.additionalClassifications[0]}   0
  # ...   Обрати класифікатор   collapseClassificationMulti   ${item.additionalClassifications[0]}   0
  # ...   AND   Обрати класифікатор   collapseClassificationMulti   ${item.additionalClassifications[1]}   1

  ${deliveryDateEnd}=  convert_datetime_for_delivery   ${item.deliveryDate.endDate}
  Execute Javascript   $('#planitem-deliverydate-enddate').val('${deliveryDateEnd}');
  Клацнути і дочекатися  id=next   id=endEdit   10

Внести зміни в план
  [Arguments]  ${userName}  ${planId}  ${fieldName}  ${fieldValue}
  avi.Пошук плану по ідентифікатору  ${userName}  ${planId}
  Wait Until Element Is Visible   xpath=//a[contains(@href, '/prozorro/plan/edit-items')]
  Click Element                   xpath=//a[contains(@href, '/prozorro/plan/edit-items')]
  Wait Until Element Is Visible   id=endEdit

  Run Keyword                     Змінити ${fieldName} в плані  ${fieldValue}
  Wait Until Element Is Visible   id=endEdit
  Click Element                   id=endEdit
  Wait Until Element Is Visible   id=tenderId

Змінити budget.description в плані
  [Arguments]  ${value}
  Click Element                  xpath=//a[contains(@href, '/prozorro/plan/edit')]
  Wait Until Element Is Visible  id=plan-title
  Input Text                     id=plan-title  ${value}
  Click Element                  id=next

Змінити budget.amount в плані
  [Arguments]  ${value}
  Click Element                  xpath=//a[contains(@href, '/prozorro/plan/edit')]
  Wait Until Element Is Visible  id=Plan-value-amount
  ${value}=                      Convert To String     ${value}
  Input Text                     id=Plan-value-amount  ${value}
  Click Element                  id=next

Змінити budget.period в плані
  [Arguments]  ${tenderPeriod}
  Click Element                  xpath=//a[contains(@href, '/prozorro/plan/edit')]
  Wait Until Element Is Visible  id=plan-procurementmonth
  ${endDate}=                    Get From Dictionary  ${tenderPeriod}  endDate
  ${endDate}=                    date_to_format  ${endDate}  %Y/%m
  Input Text                     id=plan-procurementmonth  ${endDate}
  Click Element                  id=next

Змінити items[0].quantity в плані
  [Arguments]  ${value}
  Wait Until Element Is Visible   xpath=//a[contains(@href, '/prozorro/plan/edit-item') and contains(@href, '&itemId')]
  Click Element                   xpath=//a[contains(@href, '/prozorro/plan/edit-item') and contains(@href, '&itemId')]

  Wait Until Element Is Visible   id=planitem-quantity
  Input Text                      id=planitem-quantity  ${value}
  Click Element                   id=next

Змінити items[0].deliveryDate.endDate в плані
  [Arguments]  ${value}
  Wait Until Element Is Visible   xpath=//a[contains(@href, '/prozorro/plan/edit-item') and contains(@href, '&itemId')]
  Click Element                   xpath=//a[contains(@href, '/prozorro/plan/edit-item') and contains(@href, '&itemId')]
  Wait Until Element Is Visible   id=planitem-quantity

  ${value}=                       convert_datetime_for_delivery   ${value}
  Execute Javascript              $('#planitem-deliverydate-enddate').val('${value}');
  Click Element                   id=next

Додати предмет закупівлі в план
  [Arguments]  ${userName}  ${planId}  ${item}
  avi.Пошук плану по ідентифікатору  ${userName}  ${planId}
  Wait Until Element Is Visible   xpath=//a[contains(@href, '/prozorro/plan/edit-items')]
  Click Element                   xpath=//a[contains(@href, '/prozorro/plan/edit-items')]

  Wait Until Element Is Visible   xpath=//a[contains(@href, '/prozorro/plan/edit-item') and not(contains(@href, '&itemId'))]
  Click Element                   xpath=//a[contains(@href, '/prozorro/plan/edit-item') and not(contains(@href, '&itemId'))]
  Додати предмет до плану         ${item}
  Click Element                   id=endEdit

Видалити предмет закупівлі плану
  [Arguments]  ${userName}  ${planId}  ${itemId}
  avi.Пошук плану по ідентифікатору  ${userName}  ${planId}
  Wait Until Element Is Visible   xpath=//a[contains(@href, '/prozorro/plan/edit-items')]
  Click Element                   xpath=//a[contains(@href, '/prozorro/plan/edit-items')]
  Wait Until Element Is Visible   id=endEdit

  Click Element                   xpath=//a[contains(@href, '/prozorro/plan/remove-item') and contains(@data-item-description, '${itemId}')]
  Wait Until Element Is Visible   id=endEdit
  Click Element                   id=endEdit

#Plans:end

#Reports:start

Створити звіт
  [Arguments]  ${userName}  ${reportData}
  Wait Until Element Is Visible  id=add_tender
  Клацнути і дочекатися          id=add_tender   xpath=//a[contains(@href, '/prozorro/reporting/create')]  0
  Click Element                  xpath=//a[contains(@href, '/prozorro/reporting/create')]

  ${valueAmount}=                Convert To String    ${reportData.data.value.amount}
  ${valueCurrency}=              currency_types       ${reportData.data.value.currency}
  ${valueTax}=                   Get From Dictionary  ${reportData.data.value}   valueAddedTaxIncluded

  Wait Until Element Is Visible  id=reporting-title
  Input Text                     id=reporting-title  ${reportData.data.title}
  Input Text                     id=reporting-description  ${reportData.data.description}
  Input Text                     id=Reporting-value-amount  ${valueAmount}
  Execute Javascript             setMySelectBox('Reporting-value-currency', '${valueCurrency}');
  Execute Javascript             setMySwitchBox('Reporting-value-valueAddedTaxIncluded', '${valueTax}');
  Click Element                  id=next

  Wait Until Element Is Visible  id=reportingitem-description

  ${items}=     Get From Dictionary   ${reportData.data}  items
  ${features}=  Create Dictionary
  Додати предмети до закупівлі  ${items}  ${features}

  Клацнути і дочекатися  id=endEdit   id=publication   10
  ${tenderId}=   Get Text  id=tenderId
  Click Element  id=publication

  Wait Until Keyword Succeeds   15 x   5 s   Run Keywords
  ...   Reload Page
  ...   AND   Element Should Be Visible   id=tenderId-${tenderId}

  Click Element                        id=tenderId-${tenderId}
  Wait Until Page Contains Element     id=tenderId     5
  Run Keyword And Return               Отримати інформацію про tenderId

#Reports:end

#BelowFunders
Отримати інформацію із донора закупівлі
  [Arguments]  ${userName}  ${tenderId}  ${fieldName}
  Click Element       id=funder-info
  Sleep               1
  ${fieldValue}=      Отримати текст із поля і показати на сторінці  ${fieldName}
  Click Element       xpath=//div[@id='funder-info-modal']//button[@class='close']
  Sleep               1
  [return]            ${fieldValue}

Отримати інформацію про mainProcurementCategory
  ${mainProcurementCategory}=  Get Text  id=mainProcurementCategory
  ${mainProcurementCategory}=  main_procurement_category_types  ${mainProcurementCategory}  True
  [return]  ${mainProcurementCategory}

Видалити донора
  [Arguments]  ${userName}  ${tenderId}  ${index}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Wait Until Element Is Visible  id=editTender
  Click Element                  id=editTender
  #Edit view
  Wait Until Element Is Visible  id=editTender
  Click Element                  id=editTender
  Wait Until Element Is Visible  id=w1-BelowThreshold-has-donor
  Select Checkbox                id=w1-BelowThreshold-has-donor
  Click Element                  id=next
  Wait Until Element Is Visible  id=endEdit  30
  Click Element                  id=endEdit
  Wait Until Element Is Visible  id=tenderId

Додати донора
  [Arguments]  ${userName}  ${tenderId}  ${funderData}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Wait Until Element Is Visible  id=editTender
  Click Element                  id=editTender
  #Edit view
  Wait Until Element Is Visible  id=editTender
  Click Element                  id=editTender
  Wait Until Element Is Visible  id=w1-BelowThreshold-has-donor
  Select Checkbox                id=w1-BelowThreshold-has-donor
  Sleep                          1

  Execute Javascript             setMySelectBox('w1-BelowThreshold-donor', 'Світовий Банк');
  Click Element                  id=next
  Wait Until Element Is Visible  id=endEdit  30
  Click Element                  id=endEdit
  Wait Until Element Is Visible  id=tenderId

#BelowFunders:end

#Esco

Отримати інформацію про procurementMethodType
  ${procurementMethodType}=  Get Text  xpath=//p[@id='procurementMethodType']
  ${procurementMethodType}=  procurement_method_types  ${procurementMethodType}  True
  [return]  ${procurementMethodType}

Відкрити таб з лотами
  Скролл до табів
  Click Element  xpath=//a[@href='#lots']
  Sleep          1

Отримати інформацію про minimalStepPercentage
  Відкрити таб з лотами
  ${minimalStepPercentage}=  Get Text    xpath=//span[@class='lot-minimalStepPercentage']
  Run Keyword And Return     to_percent  ${minimalStepPercentage}  5

Отримати інформацію про fundingKind
  Відкрити таб з лотами
  ${fundingKind}=  Get Text  xpath=//span[@class='lot-fundingKind']

  Run Keyword And Return  convert_avi_string_to_common_string  ${fundingKind}  True

Отримати інформацію про yearlyPaymentsPercentageRange
  Відкрити таб з лотами
  ${yearlyPaymentsPercentageRange}=   Get Text  xpath=//span[@class='lot-yearlyPaymentsPercentageRange']
  Run Keyword And Return  to_percent  ${yearlyPaymentsPercentageRange}  5

Отримати інформацію про complaintPeriod.endDate
  На початок сторінки
  ${complaintPeriodEndDate}=  Get Text  id=complaintPeriodEnd
  Run Keyword And Return      convert_date_for_compare  ${complaintPeriodEndDate}

Отримати інформацію про NBUdiscountRate
  На початок сторінки
  ${NBUdiscountRate}=     Get Text  id=NBUdiscountRate
  Run Keyword And Return  to_percent  ${NBUdiscountRate}  5

Скасування рішення кваліфікаційної комісії
  [Arguments]  ${userName}  ${tenderId}  ${awardIndex}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}

  Wait Until Element Is Visible  id=qualificationTender
  Click Element                  id=qualificationTender
  Wait Until Element Is Visible  id=qualificationCancel
  Click Element                  id=qualificationCancel

  Wait Until Element Is Visible  xpath=//a[contains(@href, '#unsuccessful')]

Дискваліфікувати постачальника
  [Arguments]  ${userName}  ${tenderId}  ${awardIndex}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}

  Wait Until Element Is Visible  id=qualificationTender
  Click Element                  id=qualificationTender
  Wait Until Element Is Visible  xpath=//a[contains(@href, '#unsuccessful')]
  Click Element                  xpath=//a[contains(@href, '#unsuccessful')]
  Sleep                          1

  ${filePath}  ${file_name}  ${file_content}=  create_fake_doc
  Choose File                    css=.document-img  ${filePath}
  Wait Until Element Is Visible  xpath=//div[contains(., 'Done')]
  Select Checkbox                xpath=//input[@name='Qualification[titles][0]' and @value='1']
  Click Element                  xpath=//button[@name='Qualification[status]' and @value='unsuccessful']
  Wait Until Element Is Visible  xpath=//a[contains(@href, '/ecp/')]
  Накласти ЄЦП
  Wait Until Element Is Visible  xpath=//button[@name='Qualification[status]' and @value='unsuccessful']
  Click Element                  xpath=//button[@name='Qualification[status]' and @value='unsuccessful']
  Wait Until Element Is Visible  xpath=//span[text()='Пропозицію відхилено']

Редагувати угоду
  [Arguments]  ${userName}  ${tenderId}  ${awardIndex}  ${fieldName}  ${value}

  ${dateSigned}=      create_fake_date
  avi.Встановити дату підписання угоди  ${userName}  ${tenderId}  ${awardIndex}  ${dateSigned}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Wait Until Keyword Succeeds   10 x   15 s   Run Keywords
  ...   Reload Page
  ...   AND   Скролл до табів
  ...   AND   Wait Until Element Is Visible   xpath=//a[@href='#contracts']
  ...   AND   Click Element                   xpath=//a[@href='#contracts']
  ...   AND   Execute Javascript              showAllCollapsed();
  ...   AND   Wait Until Element Is Visible   xpath=//span[@class='contract-awarded']
  ...   AND   Click Element                   xpath=//span[@class='contract-awarded']

  ${valueAmount}=                Convert To String    ${value}
  Input Text     id=contract-amountpaid  ${valueAmount}
  Sleep                          1
  Click Element                  xpath=//button[@data-status='4']
  Sleep                          2
  Wait Until Element Is Visible  xpath=//a[@data-status='10']

Встановити дату підписання угоди
  [Arguments]  ${userName}  ${tenderId}  ${awardIndex}  ${dateSigned}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Wait Until Keyword Succeeds   10 x   15 s   Run Keywords
  ...   Reload Page
  ...   AND   Скролл до табів
  ...   AND   Wait Until Element Is Visible   xpath=//a[@href='#contracts']
  ...   AND   Click Element                   xpath=//a[@href='#contracts']
  ...   AND   Execute Javascript              showAllCollapsed();
  ...   AND   Wait Until Element Is Visible   xpath=//span[@class='contract-awarded']
  ...   AND   Click Element                   xpath=//span[@class='contract-awarded']
  #Таб контракти
  #Click Element  xpath=//span[@class='contract-awarded']

  ${filePath}  ${file_name}  ${file_content}=  create_fake_doc

  Wait Until Element Is Visible  id=contract-container
  Scroll Page To Element         id=contract-container

  Input Text                     id=contract-contractnumber  ${tenderId}
  ${dateSigned}=                 add_min_to_date  ${dateSigned}  1
  ${dateSignedDisp}=             date_to_format  ${dateSigned}  %d.%m.%Y %H:%M
  ${dateSignedHide}=             date_to_format  ${dateSigned}  %Y-%m-%d %H:%M

  Execute Javascript             $('#contract-datesigned-disp').val('${dateSignedDisp}');
  Execute Javascript             $('#contract-datesigned').val('${dateSignedHide}');

  ${contractPeriodEndDate}=      get_contract_end_date
  Execute Javascript             $('#contract-period-enddate').val('${contractPeriodEndDate}');

  ${documentBoxIsOpened}=  Run Keyword And Return Status  Element Should Be Visible  css=.add-item
  Run Keyword Unless  ${documentBoxIsOpened}  Run Keywords
  ...       Click Element                  xpath=//div[@id='documents-box']//button[@data-widget='collapse']
  ...  AND  Wait Until Element Is Visible  css=.add-item

  Click Element                  css=.add-item
  Sleep                          2
  Choose File                    xpath=//div[contains(@class, 'form-documents-item')][last()]//input[@class='document-img']  ${filePath}
  Wait Until Element Is Visible  xpath=//div[contains(., 'Done')]

  Sleep                          60
  Run Keyword If  ${documentBoxIsOpened}  Click Element  xpath=//button[@data-status='1']
  ...  ELSE  Click Element  xpath=//button[@data-status='4']

  Sleep                          2
  Wait Until Element Is Visible  xpath=//a[@data-status='10']

Вказати період дії угоди
  [Arguments]  ${userName}  ${tenderId}  ${awardIndex}  ${startDate}  ${endDate}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Таб контракти
  Click Element  xpath=//span[@class='contract-awarded']

  Wait Until Element Is Visible  id=contract-container
  Scroll Page To Element         id=contract-container

  Input Text                     id=contract-contractnumber  ${tenderId}

  ${startDate}=                  date_to_format  ${startDate}  %Y-%m-%d %H:%M
  ${endDate}=                    date_to_format  ${endDate}    %Y-%m-%d %H:%M
  Execute Javascript             $('#contract-period-startdate').val('${startDate}');
  Execute Javascript             $('#contract-period-enddate').val('${endDate}');
  Sleep                          1
  Click Element                  xpath=//button[@data-status='4']
  Sleep                          2
  Wait Until Element Is Visible  xpath=//a[@data-status='10']

Завантажити документ в угоду
  [Arguments]  ${userName}  ${filePath}  ${tenderId}  ${awardIndex}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}
  Таб контракти
  Click Element  xpath=//span[@class='contract-awarded']

  Wait Until Element Is Visible  id=contract-container
  ${contractPeriodEndDate}=      get_contract_end_date
  Execute Javascript             $('#contract-period-enddate').val('${contractPeriodEndDate}');

  Scroll Page To Element         id=documents-box

  ${documentBoxIsOpened}=  Run Keyword And Return Status  Element Should Be Visible  css=.add-item
  Run Keyword Unless  ${documentBoxIsOpened}  Run Keywords
  ...       Click Element                  xpath=//div[@id='documents-box']//button[@data-widget='collapse']
  ...  AND  Wait Until Element Is Visible  css=.add-item

  Click Element                  css=.add-item
  Sleep                          2
  Choose File                    xpath=//div[contains(@class, 'form-documents-item')][last()]//input[@class='document-img']  ${filePath}
  Wait Until Element Is Visible  xpath=//div[contains(., 'Done')]
  Click Element                  xpath=//button[@data-status='4']
  Wait Until Element Is Visible  xpath=//a[@data-status='10']  60

Перевести тендер на статус очікування обробки мостом
  [Arguments]  ${userName}  ${tenderId}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderId}

  Wait Until Keyword Succeeds   10 x   30 s   Run Keywords
  ...  Reload Page
  ...  AND  Element Should Be Visible  id=activeStage2Waiting

  Click Element                      id=activeStage2Waiting
  Wait Until Element Is Not Visible  id=activeStage2Waiting

  Run Keyword And Ignore Error  Click Element  id=reloadTender

  Wait Until Keyword Succeeds   10 x   30 s   Run Keywords
  ...       Reload Page
  ...  AND  Element Should Not Be Visible  id=reloadTender

активувати другий етап
  [Arguments]  ${userName}  ${tenderStage2Id}
  avi.Пошук тендера по ідентифікатору  ${userName}  ${tenderStage2Id}

  Click Element                      id=activeStage2
  Wait Until Element Is Not Visible  id=activeStage2

Отримати тендер другого етапу
  [Arguments]  ${userName}  ${tenderStage2Id}
  Log to Console  ${tenderStage2Id}

Отримати тендер другого етапу та зберегти його
  [Arguments]  ${userName}  ${tenderStage2Id}
  Log to Console  ${tenderStage2Id}

Створити скаргу про виправлення визначення переможця
  [Arguments]  ${userName}  ${tenderId}  ${complaintData}  ${awardIndex}  ${filePath}
  avi.Пошук тендера по ідентифікатору   ${userName}  ${tenderId}
  Скролл до табів
  Click Element                   xpath=//a[@href='#awards']
  Sleep                           2
  Click Element                   id=draftComplaintAward

  Wait Until Element Is Visible   css=.action_period  30
  Scroll Page To Element          css=.action_period

  Click Element                   xpath=//a[@href="#complaint"]
  Sleep                           1

  Input Text                      xpath=//div[@id='complaint']//input[@id='complaintdraft-title']        ${complaintData.data.title}
  Input Text                      xpath=//div[@id='complaint']//textarea[@id='complaintdraft-description']  ${complaintData.data.description}

  Click Element                   xpath=//div[@id='complaint']//button[contains(@class, 'add-item')]
  Wait Until Element Is Visible   xpath=//div[@id='complaint']//button[contains(@class, 'delete-document')]
  Choose File                     xpath=//div[@id='complaint']//input[@class='document-img']  ${filePath}
  Wait Until Page Contains        Done
  Click Element                   xpath=//div[@id='complaint']//button[@type="submit"]
  Wait Until Element Is Visible   id=publisher-info  45
  ${complaintId}=                 Get Element Attribute  xpath=//div[@class='form_box mrgn-t20']//div[@class='dib']/div[last()]@data-complaintid
  [return]                        ${complaintId}

Отримати інформацію про auctionPeriod.endDate
  На початок сторінки

  Wait Until Keyword Succeeds   5 x  30 s   Run Keywords
  ...       Click Element                  id=reloadTender
  ...  AND  Wait Until Element Is Visible  id=auctionPeriodEnd

  ${auctionPeriodEnd}=  Get Text  id=auctionPeriodEnd
  ${auctionPeriodEnd}=  convert_date_for_compare  ${auctionPeriodEnd}
  [return]              ${auctionPeriodEnd}