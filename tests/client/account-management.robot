*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/variables.robot
Resource  ../../resources/common.robot
Resource    ../../resources/client-common.robot
Test Teardown  Close All Browsers


*** Test Cases ***

Sign Up Flow
    [Documentation]  ID:  TC_CLNT_001a | Register with valid inputs
    Sign Up Options    client
    Client Sign Up Flow  
    Capture Overwrite Screenshot  screenshots/client/sign_up_valid.png

Invalid Sign Up Flow
    [Documentation]  ID:  TC_CLNT_001b | Register with invalid inputs
    Sign Up Options    client
    Invalid Client Sign Up Flow
    Capture Overwrite Screenshot    screenshots/client/sign_up_invalid.png

Login As Client
    [Documentation]  ID:  TC_CLNT_002a | Login with valid client credentials
    Login to Application  ${CLIENT_EMAIL}  ${CLIENT_PASSWORD}
    Capture Overwrite Screenshot  screenshots/client/successful_login_client.png
    Close Browser
