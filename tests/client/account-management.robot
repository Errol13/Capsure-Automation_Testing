*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/variables.robot
Resource  ../../variables/keywords.robot


*** Test Cases ***
Login As Client
    [Documentation]  ID:  TC_CLNT_001a | Login with valid client credentials
    Login to Application  ${CLIENT_EMAIL}  ${CLIENT_PASSWORD}
    Capture Page Screenshot  screenshots/client/successful_login_client.png
    Close Browser
