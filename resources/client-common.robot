*** Settings ***
Library  RequestsLibrary
Library  SeleniumLibrary
Resource  ../variables/variables.robot
Resource    common.robot

*** Keywords ***

Fill Base Data Sign Up
    Input Text  id=first_name  Red
    Input Password    id=last_name    Wyvern
    Input Text  id=email  ${CLIENT_SIGNUP_EMAIL}
    Input Password    id=password    ${CLIENT_SIGNUP_PASSWORD}
    Input Password  id=password_confirmation  ${CLIENT_SIGNUP_PASSWORD}
    Select From List By Value    id=birth_month  2
    Select From List By Value    id=birth_day  15
    Select From List By Value    id=birth_year  2002
    Input Text    id=street    St. 123
    Input Text    id=barangay  Barangay 123
    Input Text    id=city     CityVille

Client Sign Up Flow 
    [Documentation]  This keyword performs the sign-up flow for a client.
    Fill Base Data Sign Up
    Click Element    xpath=//button[@type='submit']
    Wait Until Location Contains    verify  timeout=20s
    ${verification_link}=  Wait For Verification Email And Get Link    ${CLIENT_SIGNUP_EMAIL}
    #Visit the link 
    Go To   ${verification_link}
    Sleep   1s
    Reload Page
    #Assert if the user is redirected to the homepage
    Wait Until Location Contains    expected=client-homepage  timeout=10s

Invalid Client Sign Up Flow
    [Documentation]   This keyword performs the negative testing of register client flow.
    ${invalid_methods}=  Create List  Invalid Email Format  Mismatched Password and Confirm Password  Leave Required Field Blank
    FOR    ${method}    IN     @{invalid_methods}
        Reload Page
        ${before_url}=  Get Location
        Fill Base Data Sign Up
        IF    '${method}' == 'Invalid Email Format' or '${method}' == 'Leave Required Field Blank'
            Input Text   id=email   redwyvern.com
            Click Element    xpath=//button[@type='submit']
            ${after_url}=  Get Location
            #Assert that invalid sign up methods will not register and remains in the sign up page
            Should Be Equal    ${before_url}    ${after_url}

        ELSE IF   '${method}' == 'Mismatched Password and Confirm Password'
            Input Password    id=password   ${CLIENT_SIGNUP_PASSWORD}
            Input Password    id=password_confirmation   password1234!
             Click Element    xpath=//button[@type='submit']
            ${after_url}=  Get Location
            #Assert that invalid sign up methods will not register and remains in the sign up page
            Should Be Equal    ${before_url}    ${after_url}
            Wait Until Element Is Visible   xpath=//*[contains(@class, 'invalid-feedback')]//strong[contains(text(), "The password field confirmation does not match.")]
        END
        
    END