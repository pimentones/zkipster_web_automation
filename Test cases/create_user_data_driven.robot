*** Settings ***
Library    Browser
Library    DataDriver   ../TestData/create_user_data_driven.csv 
Resource    ../Resources/common.robot

Suite Setup    common.Start TestCase
Test Template   Create new user

*** Test Cases ***
Create user

*** Keywords ***
# using arguments to pass the test data made available in the create_user_data_driven.csv file
Create new user
    [Arguments]    ${firstName}    ${lastName}    ${userEmail}    ${age}    ${salary}    ${department}
    Click             id=addNewRecordButton
    Fill text         id=firstName                    ${firstName}
    Fill text         id=lastName                     ${lastName}
    Fill text         id=userEmail                    ${userEmail}
    Fill text         id=age                          ${age}
    Fill text         id=salary                       ${salary}
    Fill text         id=department                   ${department}
    Click             id=submit

${row_count}=    Get Elements    css=.rt-tr-group
${found}=   Set Variable    ${False}

FOR    ${i}    IN RANGE    ${row_count}
    ${index}=         Evaluate    ${i} + 1
    ${first}=         Get Text    css=.rt-tr-group:nth-of-type(${index}) .rt-td:nth-of-type(1)
    ${last}=          Get Text    css=.rt-tr-group:nth-of-type(${index}) .rt-td:nth-of-type(2)
    ${age}=           Get Text    css=.rt-tr-group:nth-of-type(${index}) .rt-td:nth-of-type(3)
    ${email}=         Get Text    css=.rt-tr-group:nth-of-type(${index}) .rt-td:nth-of-type(4)
    ${salary}=        Get Text    css=.rt-tr-group:nth-of-type(${index}) .rt-td:nth-of-type(5)
    ${department}=    Get Text    css=.rt-tr-group:nth-of-type(${index}) .rt-td:nth-of-type(6)

    # Check if the user data matches the expected values as a whole and not just individual fields
    Run Keyword If    '${first}' == '${firstName}' and
    ...               '${last}' == '${lastName}' and
    ...               '${age}' == '${age}' and
    ...               '${email}' == '${userEmail}' and
    ...               '${salary}' == '${salary}' and
    ...               '${department}' == '${department}'
    ...               Set Variable    ${found}    ${True}

    Run Keyword If    '${found}' == 'True'    BREAK
END