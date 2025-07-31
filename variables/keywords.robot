*** Keywords ***
Login to Application 
    [Documentation]    This keyword logs in to the application using provided credentials.
    [Arguments]    ${email}    ${password}
    Open Browser    ${LOGIN_URL}    chrome
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
    