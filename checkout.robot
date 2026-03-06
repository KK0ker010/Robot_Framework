*** Settings ***
Library    Selenium2Library
Library    Collections
Resource    login_keyword.robot

*** Test Cases ***
#4. Checkout validáció:

#Üres mezők ellenőrzése - név
#Üres mezők ellenőrzése - cím
#Üres mezők ellenőrzése - minden mező üres
#Érvénytelen adatok kezelése - túl hosszú név        ${long_name}=    Evaluate    "A" * 100
#Érvénytelen adatok kezelése - speciális karakterek
#Érvénytelen adatok kezelése - csak számok a névben
#Checkout megszakítása - Cancel gombbal    (Ellenőrzni, hogy a Cancel gomb megnyomásakor visszatér-e a kosár oldalra)
#Érvényes adatokkal sikeres checkout folytatás

Checkout with no first name
    Successful login
    Way to Checkout
    Input Text    id:last-name     Doe
    Input Text    id:postal-code   12345
    Click Element    id:continue
    Element Should Be Visible    class:error-button


Checkout with no address
    Successful login
    Way to Checkout
    Input Text    id:first-name    John
    Input Text    id:last-name     Doe
    Click Element    id:continue
    Element Should Be Visible    class:error-button

Checkout with all fields empty
    Successful login
    Way to Checkout
    Click Element    id:continue
    Element Should Be Visible    class:error-button

Too long first name
    Successful login
    Way to Checkout
    # Generate a long name with 100 characters
    ${long_name}=    Evaluate    "A" * 100
    Input Text    id:first-name    ${long_name}
    Input Text    id:last-name     Doe
    Input Text    id:postal-code   12345
    Click Element    id:continue

Special characters in name
    Successful login
    Way to Checkout
    Input Text    id:first-name    John@Doe!
    Input Text    id:last-name     Doe#123
    Input Text    id:postal-code   12345
    Click Element    id:continue

Only numbers in name
    Successful login
    Way to Checkout
    Input Text    id:first-name    12345
    Input Text    id:last-name     67890
    Input Text    id:postal-code   12345
    Click Element    id:continue

Cancel checkout
    Successful login
    Way to Checkout
    Click Element    id:cancel
    Element Should Be Visible    class:cart_list

Successful checkout with valid data
    Successful login
    Way to Checkout
    Input Text    id:first-name    John
    Input Text    id:last-name     Doe
    Input Text    id:postal-code   12345
    Click Element    id:continue
    Element Should Be Visible    class:checkout_summary_container

*** Keywords ***
Way to Checkout
    Click Element    id:add-to-cart-sauce-labs-backpack
    Click Element    class:shopping_cart_link
    Click Element    id:checkout
