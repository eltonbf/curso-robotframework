*** Settings ***
Library        SeleniumLibrary
Library        String

*** Variable ***
${URL}         http://automationpractice.com
${BROWSER}     chrome
&{PESSOA}      nome=Elton                       ultimonome=John                                                       senha=12345    dia=17       mes=12     ano=2000    trabalho=Facebook    celular=2345678
&{ENDERECO}    rua=PioXII                       cidade=Osasco                                                         estado=7       cep=06243    pais=21

*** Keywords ***
### Setup e Terdown
Abrir navegador
    Open browser                                                   ${URL}                                                                                                ${BROWSER}
    #Set Selenium Speed               0.5 seconds

Fechar navegador
    Close browser

### Passo a Passo
Acessar página home do site
    Title Should Be                                                My Store

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text                                                     id=search_query_top                                                                                   ${PRODUTO}

Clicar no botão de pesquisa
    Click Element                                                  name=submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element Is Visible                                  css=#center_column > h1
    Page Should Contain Image                                      xpath=//*[@id="center_column"]//*[@src="http://automationpractice.com/img/p/7/7-home_default.jpg"]
    Page Should Contain Link                                       xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUTO}")]

Conferir mensagem de erro "${MENSAGEM_ALERTA}"
    Wait Until Element Is Visible                                  xpath=//*[@id="center_column"]/h1
    Page Should Contain Element                                    xpath=//*[@id="center_column"]/p[@class='alert alert-warning']                                        ${MENSAGEM_ALERTA}

Passar o mouse por cima da categoria "${CATEGORIA}" no menu principal superior de categorias.
    Mouse Over                                                     xpath=//*[@id="block_top_menu"]//a[@title='Women']
    Page Should Contain Element                                    xpath=//*[@id="block_top_menu"]//a[@title='Tops']

Clicar na sub categoria "${SUBCATEGORIA}"
    Click Element                                                  xpath=//*[@id="block_top_menu"]//a[@title='${SUBCATEGORIA}']
    Page Should Contain Element                                    xpath=//*[@id="center_column"]/h1/span[1]

Clicar no botão "${ADDTOCART}" do produto
    Wait Until Element Is Visible                                  xpath=//*[@id="center_column"]//a[@class='product-name']
    Mouse Over                                                     xpath=//*[@id="center_column"]//a[@class='product-name']
    Wait Until Element Is Visible                                  xpath=//*[@id="center_column"]//a[@title='Add to cart']
    Click Element                                                  xpath=//*[@id="center_column"]//a[@title='Add to cart']

Clicar no botão "${CHECKOUT}"
    Wait Until Element Is Visible                                  css=a.btn.btn-default.button.button-medium
    Click Element                                                  css=a.btn.btn-default.button.button-medium
    Page Should Contain Element                                    xpath=//*[@id="cart_title"]
    Page Should Contain Element                                    xpath=//*[@id="product_1_1_0_0"]//p[@class='product-name']

Adicionar o produto "${PRODUTO}" no carrinho
    Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Clicar no botão de pesquisa
    Clicar no botão "Add to Cart" do produto
    Clicar no botão "Proceed to checkout"


Clicar no ícone carrinho de compras no menu superior direito
    Wait Until Element Is Visible                                  xpath=//*[@id="header"]//a[@title="View my shopping cart"]
    Click Element                                                  xpath=//*[@id="header"]//a[@title="View my shopping cart"]

Clicar no botão de remoção de produtos (delete) no produto do carrinho
    Page Should Contain Element                                    xpath=//*[@id="cart_title"]
    Click Element                                                  xpath=//*[@title="Delete"]
    Page Should Contain Element                                    xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]                                        Your shopping cart is empty.

Clicar no botão superior direito “${BTNSIGN}”
    Wait Until Element Is Visible                                  xpath=//*[@id="header"]//a[@class="login"]
    Click Element                                                  xpath=//*[@id="header"]//a[@class="login"]
    Page Should Contain Element                                    xpath=//h1[contains(text(),'Authentication')]

Criar um e-mail customizado
    [Arguments]     ${NOME}     ${SOBRENOME}
    ${STR_ALEATORIA}        Generate Random String
    ${CUSTOM_EMAIL}         Set Variable        ${NOME}${SOBRENOME}${STR_ALEATORIA}@teste.com
    [Return]                ${CUSTOM_EMAIL}

Inserir um e-mail válido
    Wait Until Element Is Visible                                  id=email_create
    ${EMAIL}                         Criar um e-mail customizado  ${PESSOA.nome}  ${PESSOA.ultimonome}
    Input Text                       xpath=//*[@id="email_create"]                         ${EMAIL}


Clicar no botão "${CRIARCONTA}".
    Click Element                                                  xpath=//*[@id="SubmitCreate"]

Preencher os campos obrigatórios
    Wait Until Element Is Visible                                  xpath=//*[@id="noSlide"]//h1[contains(text(),'Create an account')]
    Select Radio Button                                            id_gender                                                                                             id_gender1
    Input Text                                                     xpath=//*[@id="customer_firstname"]                                                                   ${PESSOA.nome}
    Input Text                                                     xpath=//*[@id="customer_lastname"]                                                                    ${PESSOA.ultimonome}
    Input Password                                                 xpath=//*[@id="passwd"]                                                                               ${PESSOA.senha}
    Select From List By Value                                      xpath=//*[@id="days"]                                                                                 ${PESSOA.dia}
    Select From List By Value                                      xpath=//*[@id="months"]                                                                               ${PESSOA.mes}
    Select From List By Value                                      xpath=//*[@id="years"]                                                                                ${PESSOA.ano}
    Input Text                                                     xpath=//*[@id="firstname"]                                                                            ${PESSOA.nome}
    Input Text                                                     xpath=//*[@id="lastname"]                                                                             ${PESSOA.ultimonome}
    Input Text                                                     xpath=//*[@id="company"]                                                                              ${PESSOA.trabalho}
    Input Text                                                     xpath=//*[@id="address1"]                                                                             ${ENDERECO.rua}
    Input Text                                                     xpath=//*[@id="city"]                                                                                 ${ENDERECO.cidade}
    Select From List By Value                                      xpath=//*[@id="id_state"]                                                                             ${ENDERECO.estado}
    Input Text                                                     xpath=//*[@id="postcode"]                                                                             ${ENDERECO.cep}
    Select From List By Value                                      xpath=//*[@id="id_country"]                                                                           ${ENDERECO.pais}
    Input Text                                                     xpath=//*[@id="phone_mobile"]                                                                         ${PESSOA.celular}


Clicar em "${REGISTER}" para finalizar o cadastro
    Click Element                                                  xpath=//*[@id="submitAccount"]
    Page Should Contain Element                                    xpath=//*[@id="center_column"]//h1[contains(text(),'My account')]
