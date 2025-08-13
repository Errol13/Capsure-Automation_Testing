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
    Capture Overwrite Screenshot  screenshots/freelancer/sign_up_valid.png

Invalid Sign Up Flow
    [Documentation]  ID:  TC_FRLNCR_001b | Register with invalid inputs
    Sign Up Options    freelancer
    Invalid Freelancer Sign Up Flow 
    Capture Overwrite Screenshot  screenshots/freelancer/sign_up_invalid.png

Login As Freelancer
    [Documentation]  ID:  TC_FRLNCR_002a | Login with valid freelancer credentials
    Login to Application  ${FREELANCER_EMAIL}  ${FREELANCER_PASSWORD}
    Capture Overwrite Screenshot  screenshots/freelancer/successful_login_freelancer.png

Invalid Login As Freelancer
    [Documentation]  ID:  TC_FRLNCR_002b | Login with invalid freelancer credentials
    Login Enter Email and Password   ${FREELANCER_EMAIL}  wrongpassword
    Wait Until Element Is Visible   xpath=//span[normalize-space(.)="These credentials do not match our records."]
    Capture Overwrite Screenshot  screenshots/freelancer/unsuccessful_login_freelancer.png

Reset Password As Freelancer
    [Documentation]  ID:  TC_FRLNCR_003 | Reset password for freelancer account
    Reset Password  ${FREELANCER_EMAIL}  newpassword1234!
    Capture Overwrite Screenshot  screenshots/freelancer/reset_password_freelancer.png