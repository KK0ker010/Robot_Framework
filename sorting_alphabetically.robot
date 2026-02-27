*** Settings ***
Library    Selenium2Library
Library    Collections
Resource    login_keyword.robot

*** Test Cases ***
    # A-Z rendezés
    # Z-Arendezés
    # Ár szerint növekvő
    # Ár szerint csökkenő

Sorting Z to A
    Successful login
    Click Element    locator=//*[@class="product_sort_container"]
    Sleep    time_=1s
    Click Element    locator=//*[@id="header_container"]/div[2]/div/span/select/option[2]
    ${product_names}=    Get All Product names
    Verify Z to A    ${product_names}
    Close Browser

Sorting A to Z
    Successful login
    Click Element    locator=//*[@class="product_sort_container"]
    Sleep    time_=1s
    Click Element    locator=//*[@id="header_container"]/div[2]/div/span/select/option[1]
    ${product_names}=    Get All Product names
    Verify A to Z    ${product_names}
    Close Browser

Sorting price by DESC
    Successful login
    Click Element    locator=//*[@class="product_sort_container"]
    Sleep    time_=1s
    Click Element    locator=//*[@id="header_container"]/div[2]/div/span/select/option[4]
    ${product_prices}=    Get All products prices
    Verify price DESC    ${product_prices}
    Close Browser

Sorting price by ASC
    Successful login
    Click Element    locator=//*[@class="product_sort_container"]
    Sleep    time_=1s
    Click Element    locator=//*[@id="header_container"]/div[2]/div/span/select/option[3]
    ${product_prices}=    Get All products prices
    Verify price ASC    ${product_prices}
    Close Browser

*** Keywords ***
Get All Product names
    ${products}=    Create List
    @{product_elements}=    Get WebElements    locator=//*[@class="invetory_item_name"]
    FOR    ${element}    IN    @{product_elements}
        ${product_name}=    Get Text    locator=${element}
        Append To List    ${products}    ${product_name}
    END
    RETURN    @{products}

Get All products prices
    ${products}=    Create List
    @{product_elements}=    Get WebElements    locator=//*[@class="invetory_item_price"]
    FOR    ${element}    IN    @{product_elements}
        ${product_price}=    Get Text    locator=${element}
        ${product_price}=    Remove Tags    $
        Append To List    ${products}    ${product_price}
    END
    RETURN    @{products}


Verify Z to A
    [Arguments]    ${product_names}
    ${length}=    Get Length    item=${product_names}
    FOR    ${index}    IN RANGE   0    ${length}-1
        ${current}=    Get From List    ${product_names}    ${index}
        ${next}=    Get From List    ${product_names}    ${index+1}

        Should Be True    condition=${current} >= ${next}    msg=Product is not Z to A order
    END

Verify A to Z
    [Arguments]    ${product_names}
    ${length}=    Get Length    item=${product_names}
    FOR    ${index}    IN RANGE   0    ${length}-1
        ${current}=    Get From List    ${product_names}    ${index}
        ${next}=    Get From List    ${product_names}    ${index+1}

        Should Be True    condition=${current} <= ${next}    msg=Product is not A to Z order
    END
    
Verify price DESC
    [Arguments]    ${product_prices}
    ${length}=    Get Length    item=${product_prices}
    FOR    ${index}    IN RANGE   0    ${length}-1
        ${current}=    Get From List    ${product_prices}    ${index}
        ${next}=    Get From List    ${product_prices}    ${index+1}

        Should Be True    condition=${current} >= ${next}
    END

Verify price ASC
    [Arguments]    ${product_prices}
    ${length}=    Get Length    item=${product_prices}
    FOR    ${index}    IN RANGE   0    ${length}-1
        ${current}=    Get From List    ${product_prices}    ${index}
        ${next}=    Get From List    ${product_prices}    ${index+1}

        Should Be True    condition=${current} <= ${next}
    END