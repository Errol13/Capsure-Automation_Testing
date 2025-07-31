*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/keywords.robot
Resource  ../../variables/variables.robot

*** Test Cases ***
Login As Admin
    Open Browser  ${ADMIN_URL}  ${BROWSER}
    Input Text  id=data.email  ${ADMIN_EMAIL}
    Input Text  id=data.password  ${ADMIN_PASSWORD}
    Click Button  xpath=//button[@type='submit']
    Wait Until Page Contains Element  xpath=//h1[contains(text(), 'Dashboard')]
    Capture Page Screenshot  screenshots/admin/successful_login_admin.png
    Close Browser