*** Settings ***
Documentation  test suite for checking the value entry and recommendations
Library  Selenium2Library
Library  BuiltIn
Library  csvLibrary.py

Suite Teardown    Close All Browsers


*** Variables ***
${baseurl}  http://localhost:8080/asset-manager-react1
${Browser}  chrome
${slider_locator}  name=risk
${recommendations}  xpath=//ul/li
${submitButton}  xpath=//form/input[6]
${offset}   100
${testdata}  -10  -20  -30  -40  -50



*** Test Cases ***
User should not see recommendations when clicking submit before entering values in fields
    [Documentation]     This test verifies that user can't see recommendations if values aren't entered
    [Tags]  Negative
    Open Browser  ${baseurl}  ${Browser}
    Maximize Browser Window
    Wait Until Page Contains  React Tutorial
    Drag And Drop By Offset  ${slider_locator}  ${offset}  0
    ${sliderval}    Get Element Attribute  ${slider_locator}@value
    Should Be Equal As Strings  ${sliderval}    6
    Click Button    ${submitButton}
    Page Should Not Contain List     ${recommendations}

User should not see recommendations when clicking submit after entering 1 value
    [Documentation]     This test verifies that user can't see recommendations if only 1 value is entered
    [Tags]  Negative
    Input Text  //form/input[1]  100
    Click Button    ${submitButton}
    Xpath Should Match X Times   //ul/li  0
    Page Should Not Contain      your bonds by

User should not see recommendations when clicking submit after entering invalid values
    [Documentation]     This test verifies that user can't see recommendations if invalid values are entered
    [Tags]  Negative
    Input Text  //form/input[1]  abcd
    Click Button    ${submitButton}
    Page Should Not Contain List     ${recommendations}

System should not allow negative values
    [Documentation]     This test verifies that system doesn't allow negative numbers
    [Tags]  Negative
    ${testvalues}=  Create List     -10     -20     -30     -40     -50
    Log To Console   the test data passed is ${testvalues}
    Fill Values     ${testvalues}
    Click Button    ${submitButton}
    Xpath Should Match X Times   //ul/li  0
    Page Should Not Contain List     ${recommendations}


User should see recommendations on entering all values
    [Documentation]     This test verifies that user can enter values and verify if recommendations are generated
    [Tags]  Smoke
    Drag And Drop By Offset  ${slider_locator}  ${offset}  0
    ${length}=   CSV File Length   ./Tests/positivedata.csv
    ${data}=   Read CSV File   ./Tests/positivedata.csv
    Log To Console  Length of csv file is ${length}
    :For  ${index}  IN RANGE  0  ${length}
    \  Log To Console  ${index}
    \  Log To Console   ${data[${index}]}
    \  Enter Multi Row Values    ${data[${index}]}
    Close Browser

*** Keywords ***
Enter Multi Row values
    Log To Console  Entering values
    [Arguments]  ${values}
    Log To Console  ${values}
    :For  ${index}  IN RANGE  0  5
    \   ${xpathindex}=   Evaluate    ${index}+1
    \   ${formxpath}  Catenate  SEPARATOR=  xpath=//form/input[  ${xpathindex}  ]
    \   Input Text  ${formxpath}  ${values[${index}]}
    Click Button    ${submitButton}
    Page Should Contain Element     ${recommendations}
    Page Should Contain     your bonds by
    Xpath Should Match X Times   //ul/li  5    loglevel=INFO

Fill Values
    [Arguments]     ${values}
    :For  ${index}  IN RANGE  0  5
    \  Log To Console  ${index}
    \  Log To Console   value read is ${values[${index}]}
    \  ${xpathindex}=   Evaluate    ${index}+1
    \  ${formxpath}  Catenate  SEPARATOR=  xpath=//form/input[  ${xpathindex}  ]
    \  Input Text    ${formxpath}     ${values[${index}]}



