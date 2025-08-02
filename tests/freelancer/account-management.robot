*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/variables.robot
Resource  ../../resources/common.robot
Resource    ../../resources/freelancer-common.robot
Test Teardown  Close All Browsers

*** Test Cases ***
Sign Up Flow 
    [Documentation]  ID:  TC_FRLNCR_001a | Register with valid inputs
    Sign Up Options    freelancer
    Freelancer Sign Up Flow  
    #Capture Page Screenshot  screenshots/signup/signup_options_page.png


Login As Freelancer
    [Documentation]  ID:  TC_FRLNCR_002a | Login with valid freelancer credentials
    Login to Application  ${FREELANCER_EMAIL}  ${FREELANCER_PASSWORD}
    Capture Overwrite Screenshot  screenshots/freelancer/successful_login_freelancer.png
