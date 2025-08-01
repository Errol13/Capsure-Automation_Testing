*** Settings ***
Library  SeleniumLibrary
Library    ../venv/lib/python3.12/site-packages/robot/libraries/OperatingSystem.py
Resource  ../variables/variables.robot

*** Keywords ***
Open Browser To Application
    [Documentation]    This keyword opens the browser to the application base URL plus the desired target URL.
    [Arguments]    ${target_url}
    Open Browser    ${BASE_URL}/${target_url}    ${BROWSER}
    Maximize Browser Window
    Log  Opened browser to ${BASE_URL}

Sign Up Options
    [Documentation]    This keyword navigates to the sign-up options page.
    [Arguments]    ${user_type}
    Open Browser To Application  choose
    Element Should Be Visible  xpath=//span[normalize-space()='Choose to Sign Up']
    IF    $user_type == 'freelancer'
        Click Element  css=[data-page="freelancer"]
    ELSE
        Click Element  css=[data-page="client"]
    END
    Click Button    id=continueBtn
    Log  Navigated to Sign Up page

Login to Application 
    [Documentation]    This keyword logs in to the application using provided credentials.
    [Arguments]    ${email}    ${password}
    Open Browser To Application  login
    Input Text    ${email_field}   ${email}
    Input Text    ${password_field}   ${password}
    Click Button  xpath=//button[@type='submit']
    Wait Until Location Contains    -homepage    timeout=10s
    #Verify if what user is logged in
    ${url}=  Get Location
    Log  Current URL: ${url}
    IF  '${url}' == '${BASE_URL}/client-homepage'
        Log  Successfully logged in as Client.
    ELSE IF  '${url}' == '${BASE_URL}/freelancer-homepage'
        Log  Successfully logged in as Freelancer.
    ELSE
        Fail  Login failed, still on login page.
    END

Capture Overwrite Screenshot
    [Documentation]    This keyword captures a screenshot and overwrites the existing one.
    [Arguments]    ${screenshot_path}
    Run Keyword And Ignore Error    Remove File    ${screenshot_path}
    Capture Page Screenshot  ${screenshot_path}
