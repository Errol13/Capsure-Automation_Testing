*** Variables ***
#Common Variables
${BASE_URL}  http://localhost
${LOGIN_URL}  ${BASE_URL}/login
${BROWSER}  Chrome
${email_field}  id=email
${password_field}  id=password

#Sign Up Credentials
${SIGNUP_URL}  ${BASE_URL}/choose


#Admin Credentials and URLs
${ADMIN_URL}  ${BASE_URL}/admin/login
${ADMIN_PASSWORD}  admin 1234!
${ADMIN_EMAIL}  admin@gmail.com

#Freelancer Credentials and URLs
${FREELANCER_EMAIL}  daisy3@example.com
${FREELANCER_PASSWORD}  password 3

#Client Credentials and URLs
${CLIENT_EMAIL}  pmcastro@example.com
${CLIENT_PASSWORD}  password 1234!

#Mail API
${MAILTRAP_API_BASE_URL}  https://mailtrap.io
${INBOX_ID}    %{MAILTRAP_INBOX_ID}           # inbox ID
${API_TOKEN}   %{MAILTRAP_API_KEY}        # Mailtrap API token
${VERIFY_REGEX}    https?://localhost/email/verify\\S+
${ACCOUNT_ID}  %{ACCOUNT_ID}  # Account ID for Mailtrap

