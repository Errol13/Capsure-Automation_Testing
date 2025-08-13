*** Settings ***
Library  RequestsLibrary
Library  SeleniumLibrary
Library    ../venv/lib/python3.12/site-packages/robot/libraries/OperatingSystem.py
Library    ../venv/lib/python3.12/site-packages/robot/libraries/Collections.py
Library    ../venv/lib/python3.12/site-packages/robot/libraries/String.py
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
    Element Should Be Visible  xpath=//span[normalize-space(.)='Choose to Sign Up']
    IF    $user_type == 'freelancer'
        Click Element  css=[data-page="freelancer"]
    ELSE
        Click Element  css=[data-page="client"]
    END
    Click Button    id=continueBtn
    Log  Navigated to Sign Up page

Login Enter Email and Password 
    [Documentation]    This keyword enters the email and password into the login form.
    [Arguments]    ${email}    ${password}
    Open Browser To Application  login
    Input Text  id=email  ${email}
    Input Password  id=password  ${password}
    Click Button  xpath=//button[@type='submit']

Login to Application 
    [Documentation]    This keyword logs in to the application using provided credentials.
    [Arguments]    ${email}    ${password}
    Login Enter Email and Password    ${email}    ${password}
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

Wait For Verification Email And Get Link
    [Arguments]    ${recipient_email}     ${timeout}=10s
    ${auth_header}=    Create Dictionary    Authorization=Bearer ${API_TOKEN}
    Create Session    mailtrap    https://mailtrap.io/api/accounts/${ACCOUNT_ID}    headers=${auth_header}    verify=True
    ${max}=    Convert To Integer    ${timeout[:-1]}
    FOR    ${i}    IN RANGE    ${max}
        Sleep    1s
        ${resp}=    GET On Session    mailtrap    /inboxes/${INBOX_ID}/messages
        #Log    Mailtrap messages endpoint returned status: ${resp.status_code}
        #Log   Raw response body: ${resp.text}
        Should Be Equal As Integers    ${resp.status_code}    200
        ${messages}=    Set Variable    ${resp.json()}
        #Log  Parsed JSON : ${messages}
        ${message_id}=    Set Variable    ${NONE}
        FOR    ${msg}    IN    @{messages}
           ${to_email}=    Get From Dictionary    ${msg}    to_email
           #Log To Console    RAW to_email: '${to_email}'
           #Log To Console    RAW recipient_email: '${recipient_email}'
            ${to_email_normalized}=    Convert To Lowercase    ${to_email}
            ${recipient_normalized}=   Convert To Lowercase    ${recipient_email}
            #Log To Console    Considering message to: ${to_email_normalized}
            IF    '${to_email_normalized}' == '${recipient_normalized}'
                ${message_id}=    Set Variable    ${msg['id']}
                #Log To Console    MATCH FOUND, message_id: ${message_id}
                Exit For Loop
            END
        END
        Run Keyword If    not ${message_id}    Continue For Loop
        ${body_resp}=    GET On Session    mailtrap    /inboxes/${INBOX_ID}/messages/${message_id}/body.txt
        Should Be Equal As Integers    ${body_resp.status_code}    200
        ${body}=    Set Variable    ${body_resp.text}
        ${matches}=    Get Regexp Matches  ${body}    ${VERIFY_REGEX}   
        #Log To Console    Match:${matches}
        Run Keyword If    not ${matches}    Fail    Could not extract verification link from email body.
        ${raw_link}=    Set Variable    ${matches[0]}
        ${link}=   Replace String Using Regexp    ${raw_link}    [\]\)\.]+$    ${EMPTY}
        #Log To Console    ${link}
        Return From Keyword   ${link}

    END
    Fail    Verification email did not arrive for ${recipient_email} after ${timeout}

Wait For Reset Password Notification And Get Link
    [Arguments]    ${recipient_email}     ${timeout}=10s
    ${auth_header}=    Create Dictionary    Authorization=Bearer ${API_TOKEN}
    Create Session    mailtrap    https://mailtrap.io/api/accounts/${ACCOUNT_ID}    headers=${auth_header}    verify=True
    ${max}=    Convert To Integer    ${timeout[:-1]}
    FOR    ${i}    IN RANGE    ${max}
        Sleep    1s
        ${resp}=    GET On Session    mailtrap    /inboxes/${INBOX_ID}/messages
        #Log    Mailtrap messages endpoint returned status: ${resp.status_code}
        #Log   Raw response body: ${resp.text}
        Should Be Equal As Integers    ${resp.status_code}    200
        ${messages}=    Set Variable    ${resp.json()}
        #Log  Parsed JSON : ${messages}
        ${message_id}=    Set Variable    ${NONE}
        FOR    ${msg}    IN    @{messages}
           ${to_email}=    Get From Dictionary    ${msg}    to_email
           #Log To Console    RAW to_email: '${to_email}'
           #Log To Console    RAW recipient_email: '${recipient_email}'
            ${to_email_normalized}=    Convert To Lowercase    ${to_email}
            ${recipient_normalized}=   Convert To Lowercase    ${recipient_email}
            #Log To Console    Considering message to: ${to_email_normalized}
            IF    '${to_email_normalized}' == '${recipient_normalized}'
                ${message_id}=    Set Variable    ${msg['id']}
                #Log To Console    MATCH FOUND, message_id: ${message_id}
                Exit For Loop
            END
        END
        Run Keyword If    not ${message_id}    Continue For Loop
        ${body_resp}=    GET On Session    mailtrap    /inboxes/${INBOX_ID}/messages/${message_id}/body.txt
        Should Be Equal As Integers    ${body_resp.status_code}    200
        ${body}=    Set Variable    ${body_resp.text}
        ${matches}=    Get Regexp Matches  ${body}    ${RESET_PASSWORD_REGEX}   
        #Log To Console    Match:${matches}
        Run Keyword If    not ${matches}    Fail    Could not extract reset password link from email body.
        ${raw_link}=    Set Variable    ${matches[0]}
        ${link}=   Replace String Using Regexp    ${raw_link}    [\]\)\.]+$    ${EMPTY}
        #Log To Console    ${link}
        Return From Keyword   ${link}

    END
    Fail    Verification email did not arrive for ${recipient_email} after ${timeout}

Reset Password 
    [Documentation]    This keyword resets the password for a user account.
    [Arguments]    ${email}  ${new_password} 
    Open Browser To Application  login
    Element Should Be Visible  xpath=//a[contains(@class, 'btn-link') and contains(text(), 'Forgot your password?')]
    Click Element    xpath=//a[contains(@class, 'btn-link') and contains(text(), 'Forgot your password?')]
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(text(), 'Send Password Reset Link')]
    Input Text    id=email    ${email}
    Click Button    xpath=//button[@type='submit' and contains(text(), 'Send Password Reset Link')]
    ${reset_password_link}=  Wait For Reset Password Notification And Get Link    ${email}
    #Visit the reset password link
    Go To   ${reset_password_link}
    Wait Until Element Is Visible    xpath=//input[@id='password']
    Input Password    id=password    ${new_password}
    Input Password    id=password-confirm    ${new_password}
    Click Button    xpath=//button[@type='submit' and contains(text(), 'Reset Password')]
    #Verify if the password reset was successful
    Wait Until Location Contains    home   timeout=10s
    #Login with the new password
    Login to Application    ${email}    ${new_password}
