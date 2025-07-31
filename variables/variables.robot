*** Variables ***
#Common Variables
${BASE_URL}  http://localhost
${LOGIN_URL}  ${BASE_URL}/login
${SIGNUP_URL}  ${BASE_URL}/choose
${BROWSER}  Chrome
${email_field}  id=email
${password_field}  id=password


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
