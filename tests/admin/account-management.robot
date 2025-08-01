*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/variables.robot
Resource  ../../resources/common.robot

*** Test Cases ***
Login As Admin
    [Documentation]  ID:  TC_ADMIN_001a | Login with valid admin credentials
    Open Browser  ${ADMIN_URL}  ${BROWSER}
    Input Text  id=data.email  ${ADMIN_EMAIL}
    Input Text  id=data.password  ${ADMIN_PASSWORD}
    Click Button  xpath=//button[@type='submit']
    Wait Until Page Contains Element  xpath=//h1[contains(text(), 'Dashboard')]
    Capture Overwrite Screenshot  screenshots/admin/successful_login_admin.png
    Close Browser