# 1. Shopping cart functionality
#    Add multiple products
#    Remove products from the shopping cart
#    Check the contents of the shopping cart

*** Settings ***
Library           SeleniumLibrary

*** Test Cases ***
Add multiple products
    Successful login
    Add multiple products
    Close Browser
Remove products from the shopping cart
    Successful login
    Add multiple products
    Go to shopping cart
    Remove products from the shopping cart
    Close Browser
Check shopping cart contents
    Successful login
    Add multiple products
    Go to shopping cart
    Check shopping cart contents
    Close Browser



*** Keywords ***
Successful login
    Open Browser    https://www.saucedemo.com/    chrome
    Maximize Browser Window
    Input Text    id:user-name    standard_user
    Input Password    id:password     secret_sauce
    Click Button    id:login-button
    Sleep   1s

Go to shopping cart
    Click Element    class:shopping_cart_link
    Sleep   1s

Remove products from the shopping cart
    Click Element    id:remove-sauce-labs-backpack
    Element Should Not Be Visible    id:remove-sauce-labs-backpack
    Click Element    id:remove-sauce-labs-bike-light
    Element Should Not Be Visible    id:remove-sauce-labs-bike-light
    Click Element    id:remove-sauce-labs-bolt-t-shirt
    Element Should Not Be Visible    id:remove-sauce-labs-bolt-t-shirt
    Element Should Not Be Visible    class:cart_item
    Sleep   1s

Add multiple products
    Click Element    id:add-to-cart-sauce-labs-backpack
    Click Element    id:add-to-cart-sauce-labs-bike-light
    Click Element    id:add-to-cart-sauce-labs-bolt-t-shirt
    Element Should Contain    class:shopping_cart_badge    3
    Sleep   1s

Check shopping cart contents
    ${count_items}=    Get Element Count    class:cart_item
    Should Be Equal As Numbers    ${count_items}    3
    Sleep   1s