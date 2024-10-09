*** Settings ***
Library    RequestsLibrary

Suite Setup    Create Tokem

*** Variables ***
${API_BASE_URL}    https://www.advantageonlineshopping.com
&{body_login}    email=jonathan.jose@inmetrics.com.br    
...  loginPassword=Jj12345
...  loginUser=jonathan.silva


*** Test Cases ***
Buscar Produto
    [Documentation]    Testa a busca de um produto via API.
    ${HEADERS}   Create Dictionary   Accept=*/*  Authorization=Bearer ${TOKEN}
    
    ${params}=  Create Dictionary  name=HP Pavilion 15t Touch Laptop   quantityPerEachCategory=-1
    ${response}=    RequestsLibrary.GET   headers=${HEADERS}  url=${API_BASE_URL}/catalog/api/v1/products/search  params=${params}
    Should Be Equal As Strings    ${response.status_code}    200
    BuiltIn.Length Should Be  ${response.json()}  1


Atualizar Imagem de Produto
    [Documentation]   Fazer - Atualiza a imagem de um produto via API.
    
    log  Bearer ${TOKEN}
    Set Local Variable  ${SOURCE}          source
    Set Local Variable  ${COLOR}           red
    Set Local Variable  ${PRODUCT_ID}      15
    Set Local Variable  ${IMAGE_PATH}      Sem título.jpg

    ${PRODUTO}  Get Info Produto  ${PRODUCT_ID}
    Log  ${PRODUTO}

    ${HEADERS}   Create Dictionary   Accept=*/*  Authorization=Bearer ${TOKEN}  Content-Type=multipart/form-data
    ${FILE}=    Create Dictionary    file=@img.jpg;type=image/jpeg
    ${params}=  Create Dictionary    product_id=${PRODUCT_ID}
    ${response}=    RequestsLibrary.POST
    ...  headers=${HEADERS}
    ...  url=${API_BASE_URL}/catalog/api/v1/product/image/${userId}/${SOURCE}/${COLOR}
    ...  params=${params}
    ...  files=${FILE}
    Should Be Equal As Strings    ${response.status_code}    200

    ${PRODUTO}  Get Info Produto  ${PRODUCT_ID}
    Log  ${PRODUTO}


*** Keywords ***
Create Tokem
    ${HEADERS}   Create Dictionary   Content-Type=application/json  Accept=*/*
    # RequestsLibrary.Create Session    alias=advantage    url=${API_BASE_URL}  headers=${HEADERS}
    ${auth_response}=    RequestsLibrary.POST  headers=${HEADERS}  url=${API_BASE_URL}/accountservice/accountrest/api/v1/login    json=${body_login}
    Should Be Equal As Strings    ${auth_response.status_code}    200
    ${json_return}  BuiltIn.Set Variable  ${auth_response.json()}[statusMessage]
    Set Suite Variable  ${userId}  ${json_return}[userId]
    Set Suite Variable  ${token}  ${json_return}[token]
    # RETURN    ${json_return}[token]

Get Info Produto
    [Arguments]  ${ID_produto}
    ${HEADERS}   Create Dictionary   Accept=*/*  Authorization=Bearer ${TOKEN}
    ${params}=  Create Dictionary  name=HP Pavilion 15t Touch Laptop   quantityPerEachCategory=-1
    ${response}=    RequestsLibrary.GET   headers=${HEADERS}  url=${API_BASE_URL}/catalog/api/v1/products/${ID_produto}
    Should Be Equal As Strings    ${response.status_code}    200
    RETURN  ${response.json()}