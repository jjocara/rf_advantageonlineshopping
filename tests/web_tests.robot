*** Settings ***
Library    SeleniumLibrary

Suite Setup    Abrir Browser

*** Variables ***
${TIMEOUT}  30s
${URL}    https://advantageonlineshopping.com/#/
${USERNAME}    jonathan.silva
${PASSWORD}    Jj12345


&{PRODUTO}    nome=HP ENVY - 17T TOUCH LAPTOP    quantidade=1


*** Test Cases ***
Test01
    Login
    Buscar Produto

test02
    Adicionar Produto ao Carrinho

test03
    Validar Produto no Carrinho


Cenário: Busca e adição de produto ao carrinho
    Dado que estou na página de login
    Quando eu fizer login com credenciais válidas
    E eu buscar pelo produto "${PRODUTO.nome}"
    E eu adicionar o produto ao carrinho
    Então o produto deve estar no carrinho na tela de pagamento

*** Keywords ***
Dado que estou na página de login
    Go To    ${URL}

Quando eu fizer login com credenciais válidas
    Login

E eu buscar pelo produto "${PRODUTO.nome}"
    Buscar Produto

E eu adicionar o produto ao carrinho
    Adicionar Produto ao Carrinho

Então o produto deve estar no carrinho na tela de pagamento
    Validar Produto no Carrinho

###########


Abrir Browser
    Open Browser    ${URL}    chrome
    Set Selenium Timeout   ${TIMEOUT}
    Maximize Browser Window

Login
    [Documentation]    Faz login no Advantage Online Shopping com credenciais válidas.
    Click If Element Is Visible    xpath=//a[@id='hrefUserIcon']  # Clica no ícone de usuário
    Input Text If Element Is Visible    name=username    ${USERNAME}  # Insere o nome de usuário
    Input Text If Element Is Visible    name=password    ${PASSWORD}  # Insere a senha
    Click If Element Is Visible    id=sign_in_btn  # Clica no botão de login
    Wait Until Page Contains    ${USERNAME}  # Verifica se o nome de usuário está na página

Buscar Produto
    Click If Element Is Visible    id=menuSearch
    # Set Selenium Speed	0.5 seconds
    Input Text If Element Is Visible    id=autoComplete    ${PRODUTO.nome}
    # Wait Until Element Contains   //div[@id="output"]//a  ${PRODUTO}
    BuiltIn.Sleep  3
    Click If Element Is Visible    //div[@id="output"]//a[@class="product ng-scope"]//*[contains(text(),'${PRODUTO.nome}')]
    Wait Until Element Contains    //*[@id="Description"]/h1  ${PRODUTO.nome}
    Capture Page Screenshot

Adicionar Produto ao Carrinho
    Click If Element Is Visible    //button[@name="save_to_cart"]
    Wait Until Element Contains    //*[@id="product"]/td[2]/a/h3  ${PRODUTO.nome}
    Capture Page Screenshot

Validar Produto no Carrinho
    Click If Element Is Visible    xpath=//a[@id='shoppingCartLink']
    Wait Until Page Contains    SHOPPING CART
    Wait Until Page Contains    ${PRODUTO.nome}
    Capture Page Screenshot


#############
Wait loader
    SeleniumLibrary.Wait Until Element Is Enabled  //login-modal//div[@class="loader" and @style="display: none; opacity: 0;"]
    # SeleniumLibrary.Wait Until Element Is Visible    id="virtualFooter"  #xpath=//div[@class='loader']
    BuiltIn.Sleep  0.5

Click If Element Is Visible
    [Documentation]  Aguarda o elemento ficar visivel, depois realiza o Click
    [Arguments]  ${ELEMENT}
    SeleniumLibrary.Wait Until Element Is Visible  ${ELEMENT}
    SeleniumLibrary.Wait Until Element Is Enabled  ${ELEMENT}
	BuiltIn.Sleep  0.5
	BuiltIn.Run Keyword And Ignore Error  Set Focus To Element  ${ELEMENT}
    Wait loader
    # SeleniumLibrary.Mouse Over  ${ELEMENT}
	SeleniumLibrary.Click Element  ${ELEMENT}

Input Text If Element Is Visible
    [Documentation]  Aguarda o elemento ficar visivel, depois realiza o Input
    [Arguments]  ${ELEMENT}  ${TEXT}
    SeleniumLibrary.Wait Until Element Is Visible  ${ELEMENT}
    SeleniumLibrary.Wait Until Element Is Enabled  ${ELEMENT}
	BuiltIn.Sleep  0.5
	BuiltIn.Run Keyword And Ignore Error  Set Focus To Element  ${ELEMENT}
    Wait loader
	SeleniumLibrary.Input Text  ${ELEMENT}  ${TEXT}