*** Settings ***
Library    Browser

*** Variables ***
# user data
${firstName}     Sheldon
${lastName}      Cooper
${userEmail}     sheldon.cooper@bigbangtheory.tv
${age}           30
${salary}        200000
${department}    Physics

# create url variable
${url}           https://demoqa.com/webtables

*** Test Cases ***
# The user can register a new user using the registration form 
Create new user
    New page    ${url}
    Log to console    Opened the web tables page
    Click             id=addNewRecordButton
    Log to console    Fill data
    Fill text         id=firstName                    ${firstName}
    Fill text         id=lastName                     ${lastName}
    Fill text         id=userEmail                    ${userEmail}
    Fill text         id=age                          ${age}
    Fill text         id=salary                       ${salary}
    Fill text         id=department                   ${department}
    Click             id=submit
    Log to console    User created
    #search test template

   # Gets the content of the table's last column to verify the created user
   # Used a fixed index (4) to access the column content since when testing we have control over the test data and this allows for a simpler approach, than trying to dynamically find the column index
    ${column_firstName}=    Get Text    css=.rt-tr-group:nth-of-type(4) .rt-td:nth-of-type(1)  ==  ${firstName}
    ${column_lastName}=     Get Text    css=.rt-tr-group:nth-of-type(4) .rt-td:nth-of-type(2)  ==  ${lastName}
    ${column_age}=          Get Text    css=.rt-tr-group:nth-of-type(4) .rt-td:nth-of-type(3)  ==  ${age}
    ${column_email}=        Get Text    css=.rt-tr-group:nth-of-type(4) .rt-td:nth-of-type(4)  ==  ${userEmail}
    ${column_salary}=       Get Text    css=.rt-tr-group:nth-of-type(4) .rt-td:nth-of-type(5)  ==  ${salary}
    ${column_dept}=         Get Text    css=.rt-tr-group:nth-of-type(4) .rt-td:nth-of-type(6)  ==  ${department}