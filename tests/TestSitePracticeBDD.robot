*** Settings ***
Resource         ../resource/Resource.robot
Test Setup       Abrir navegador
Test Teardown    Fechar navegador

*** Variable ***
${URL}           http://automationpractice.com
${BROWSER}       chrome

*** Test Case ***
Cenário 01: Pesquisar produto existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "Blouse"
    Então o produto "Blouse" deve ser listado na página de resultado da busca

Cenário 02: Pesquisar produto não existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "itemNãoExistente"
    Então a página deve exibir a mensagem "No results were found for your search "itemNãoExistente""

*** Keywords ***

Dado que estou na página home do site
    Acessar página home do site

Quando eu pesquisar pelo produto "${PRODUTO}"
    Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Clicar no botão de pesquisa

Então o produto "${PRODUTO}" deve ser listado na página de resultado da busca
    Conferir se o produto "${PRODUTO}" foi listado no site

Então a página deve exibir a mensagem "${MENSAGEM_ALERTA}"
    Conferir mensagem de erro "${MENSAGEM_ALERTA}"