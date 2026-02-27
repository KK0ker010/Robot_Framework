*** Settings ***
Library    Selenium2Library

*** Keywords ***
Successful login
    Open Browser    https://www.saucedemo.com/    chrome
    Maximize Browser Window
    Input Text    id:user-name    standard_user
    Input Password    id:password     secret_sauce
    Click Button    id:login-button
    Sleep   1s