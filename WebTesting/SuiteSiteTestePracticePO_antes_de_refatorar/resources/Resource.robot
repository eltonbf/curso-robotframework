*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${BROWSER}      chrome
${URL}          http://automationpractice.com

*** Keywords ***
#### Setup e Teardown
Abrir navegador
    Open Browser        about:blank   ${BROWSER}

Fechar navegador
    Close Browser

#### Ações





# Clicar em "Sign in"
#     Click Element    xpath=//*[@id="header"]//*[@class="login"][contains(text(),"Sign in")]

# Informar um e-mail válido
#     Wait Until Element Is Visible   id=email_create
#     ${EMAIL}                        Generate Random String
#     Input Text                      id=email_create    ${EMAIL}@testerobot.com

# Clicar em "Create an account"
#     Click Button    id=SubmitCreate

# Preencher os dados obrigatórios
#     Wait Until Element Is Visible   xpath=//*[@id="account-creation_form"]//h3[contains(text(),"Your personal information")]
#     Click Element                   id=id_gender2
#     Input Text                      id=customer_firstname    May
#     Input Text                      id=customer_lastname     Fernandes
#     Input Text                      id=passwd                123456
#     Input Text                      id=address1              Rua Framework, Bairro Robot
#     Input Text                      id=city                  Floripa
#     Set Focus To Element            id=id_state
#     ### No firefox ocorreu problema ao achar o listbox State, então coloquei um if para esperar
#     ### pelo elemento quando for firefox
#     Run Keyword If    '${BROWSER}'=='firefox'  Wait Until Element Is Visible   id=id_state
#     Select From List By Index       id=id_state              9
#     Input Text                      id=postcode              12345
#     Input Text                      id=phone_mobile          99988877

# Submeter cadastro
#     Click Button    submitAccount

#### Conferências
# Conferir se o cadastro foi efetuado com sucesso
#     Wait Until Element Is Visible    xpath=//*[@id="center_column"]/p
#     Element Text Should Be           xpath=//*[@id="center_column"]/p
#     ...    Welcome to your account. Here you can manage all of your personal information and orders.
#     Element Text Should Be           xpath=//*[@id="header"]/div[2]//div[1]/a/span    May Fernandes

