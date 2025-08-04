*** Settings ***
Library  RequestsLibrary
Library  SeleniumLibrary
Resource  ../variables/variables.robot
Resource    common.robot

*** Keywords ***
Freelancer Sign Up Flow 
    [Documentation]  This keyword performs the sign-up flow for a freelancer.
    Input Text  id=first_name  Daisy
    Input Password    id=last_name    Soares 
    Input Text  id=email  daisysoares@example.com
    Input Password    id=password    daisysoares 1234
    Input Password  id=password_confirmation  daisysoares 1234
    Select From List By Value    id=job_category  Arts 
    Select From List By Value    id=job_title  Painter
    Input Text    id=job_fee    200
    Select From List By Label    id=fee_type    per hour
    Select From List By Value    id=birth_month  2
    Select From List By Value    id=birth_day  15
    Select From List By Value    id=birth_year  2002
    Input Text    id=street    St. 123
    Input Text    id=barangay  Barangay 123
    Input Text    id=city     CityVille
    Click Element    xpath=//button[@type='submit']
    Wait Until Location Contains    verify  timeout=20s
    ${verification_link}=  Wait For Verification Email And Get Link    daisysoares@example.com
    #Visit the link 
    Go To   ${verification_link}
    Sleep   1s
    Reload Page
    #Assert if the user is redirected to the homepage
    Wait Until Location Contains    expected=freelancer-homepage  timeout=10s


 