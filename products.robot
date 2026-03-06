*** Settings ***
Library    Selenium2Library
Library    Collections
Resource    login_keyword.robot

*** Test Cases ***
#3. Termékrészletek:

#Termék oldal megnyitása - név alapján
#Termék oldal megnyitása - kép alapján
#Termék információk ellenőrzése - név  (ugyaz-e?)
#Termék információk ellenőrzése - ár (ugyaz-e?)
#Termék információk ellenőrzése - leírás        (egyáltalán megjelenik-e?)
#Termék információk ellenőrzése - kép    (egyáltalán megjelenik-e?)
#Vissza navigáció - Back to products gomb

Open product by its name and check it and the its picture
    Successful login
    ${how_many_products}=    Get Element Count    class:inventory_item_name
    FOR    ${index}    IN RANGE    0    ${how_many_products}
    Check product information    //*[@id="item_${index}_title_link"]/div    //*[@id="inventory_item_container"]/div/div/div[2]/div[1]    ${index}
    END

*** Keywords ***
Check product information
    [Arguments]    ${product_id}    ${product_on_page_id}    ${index}

    ${product}=    Get Text    ${product_id}
    ${image_src}=    Get Element Attribute    //*[@id="item_${index}_img_link"]/img    src
    ${product_price}=    Get Text    //*[@id="item_${index}_title_link"]/ancestor::div[@class="inventory_item"]//div[@class="inventory_item_price"]

    Click Element    //*[@id="item_${index}_title_link"]/div
    Click Element    id:back-to-products
    Click Element    //*[@id="item_${index}_img_link"]/img

    ${product_on_page}=    Get Text    ${product_on_page_id}
    ${image_src_page}=    Get Element Attribute    class:inventory_details_img    src
    ${product_price_page}=    Get Text    class:inventory_details_price    

    Should Be Equal    ${product}    ${product_on_page}
    Should Be Equal    ${image_src}    ${image_src_page}
    Should Be Equal    ${product_price}    ${product_price_page}
    Element Should Be Visible   class:inventory_details_desc
    Element Should Be Visible   class:inventory_details_img


    Click Element    id:back-to-products