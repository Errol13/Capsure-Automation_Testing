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

Invalid Login As Admin
    [Documentation]  ID:  TC_ADMIN_001b | Login with invalid admin credentials
    Open Browser  ${ADMIN_URL}  ${BROWSER}
    Input Text  id=data.email  ${ADMIN_EMAIL}
    Input Text  id=data.password  wrongpassword
    Click Button  xpath=//button[@type='submit']
    Wait Until Element Is Visible  xpath=//p[contains(@class, 'fi-fo-field-wrp-error-message') and contains(text(), "These credentials do not match our records.")]
    Capture Overwrite Screenshot  screenshots/admin/unsuccessful_login_admin.png
    Close Browser