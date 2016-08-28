*** Settings ***
Documentation  test suite for checking the asset manager risk slider functionality
Library  Selenium2Library
Library  BuiltIn
Library  csvLibrary.py
Suite Teardown    Close All Browsers

*** Variables ***
${baseurl}  http://localhost:8080/asset-manager-react1
${Browser}  chrome
${slider_locator}  name=risk
${rating}  xpath=//span[@class='badge']
${heading}  xpath=//h1[contains(text(),'Asset Manager')]
${question}  xpath=//p[contains(text(), 'What does your risk profile look like?')]
${recommendations}  xpath=//ul/li
${submitButton}  xpath=//form/input[6]
${offset}   100



*** Test Cases ***
User can open page and see the title
	[Documentation]    This is for title verification
	[Tags]     Smoke
    Open Browser  http://localhost:8080/asset-manager-react1  ${Browser}
    Maximize Browser Window
    Wait Until Page Contains  React Tutorial
    Title Should Be     React Tutorial


User can view text on page
	[Documentation]	This is for static text verification
	[Tags]	Smoke
	Page Should Contain Element  ${heading}
	Page Should Contain Element  ${rating}
	Page Should Contain Element  ${question}
	Page Should Contain Element  ${slider_locator}
	${ratingval}	Get Text  ${rating}
    ${sliderval}    Get Element Attribute  ${slider_locator}@value
	Should Be Equal As Strings  ${ratingval}  ${sliderval}


User should be able to move slider right
	[Documentation]	This is for moving the rating slider and verifying %values
	[Tags]	Smoke
	${sliderval}    Get Element Attribute  ${slider_locator}@value
	Log To Console  ${sliderval}
    ${data}=  Read CSV File  ./Tests/ratings.csv
    Log To Console  ${data[0]}
    :For  ${index}  IN RANGE  4  9
    \  Log To Console  ${index}
    \  Log To Console   ${data[${index}]}
    \  Move Slider And Check    ${data[${index}]}

#    Press Key  xpath=//*[@name='risk']  ARROW_UP
    \  Drag And Drop By Offset  ${slider_locator}  ${offset}  0

	\  ${sliderval}    Get Element Attribute  ${slider_locator}@value
    \  Log To Console  Slider position is at ${sliderval}
    \  ${offset}=   Evaluate    ${offset}+100
    \   Log to Console      Need to move slider by (px) ${offset}


User should be able to move slider left
    [Documentation]  This is for moving the rating slider and verifying %values
    [Tags]  Smoke
    Go To   ${baseurl}
    Drag And Drop By Offset  ${slider_locator}  -${offset}  0
    :For  ${index}  IN RANGE  4  1
    \  Log To Console  ${index}
    \  Log To Console   ${data[${index}]}
    \  Move Slider And Check    ${data[${index}]}

#    Press Key  xpath=//*[@name='risk']  ARROW_UP
    \  Drag And Drop By Offset  ${slider_locator}  ${offset}  0

    \  ${sliderval}    Get Element Attribute  ${slider_locator}@value
    \  Log To Console  Slider position is at ${sliderval}
    \  ${offset}=   Evaluate    ${offset}-100
    \   Log to Console      ${offset}

    Close Browser






*** Keywords ***
Move Slider And Check
     [Arguments]  ${values}
     Log To Console  ${values}
     ${bond}  Catenate  SEPARATOR=  xpath=//span[contains(text(),'Bonds:')]/following-sibling::span[1][contains(text(),"  ${values[1]}    ")]
     Log To Console  ${bond}
     ${stock}  Catenate  SEPARATOR=  xpath=//span[contains(text(),'Stocks:')]/following-sibling::span[1][contains(text(),"  ${values[2]}    ")]
     ${etf}  Catenate  SEPARATOR=  xpath=//span[contains(text(),'ETFs:')]/following-sibling::span[1][contains(text(),"  ${values[3]}    ")]
     ${realestate}  Catenate  SEPARATOR=  xpath=//span[contains(text(),'Real Estate:')]/following-sibling::span[1][contains(text(),"  ${values[4]}    ")]
     ${cash}  Catenate  SEPARATOR=  xpath=//span[contains(text(),'Cash:')]/following-sibling::span[1][contains(text(),"  ${values[5]}    ")]
     Page Should Contain Element  ${bond}
     Page Should Contain Element  ${stock}
     Page Should Contain Element  ${etf}
     Page Should Contain Element  ${realestate}
     Page Should Contain Element  ${cash}

Enter values
    Log To Console  Entering values
    [Arguments]  ${testDataValues}
    Log To Console  ${testDataValues}
    :For  ${index}  IN RANGE  1  5
    \   Input Text  //form/input[${index}]  ${testDataValues[${index}]}
    Click Button    ${submitButton}
    Page Should Not Contain Element     ${recommendations}







