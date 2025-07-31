*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/variables.robot
Resource  ../../variables/keywords.robot


*** Test Cases ***
Login As Freelancer
    Login to Application  ${FREELANCER_EMAIL}  ${FREELANCER_PASSWORD}
    Capture Page Screenshot  screenshots/freelancer/successful_login_freelancer.png
    Close Browser
