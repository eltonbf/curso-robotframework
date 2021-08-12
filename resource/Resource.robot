*** Settings ***
Library       SeleniumLibrary

*** Variable ***
${URL}        http://automationpractice.com
${BROWSER}    chrome


*** Keywords ***
### Setup e Terdown
Abrir navegador
    Open browser                     ${URL}                                                                                                ${BROWSER}

Fechar navegador
    Close browser

### Passo a Passo
Acessar página home do site
    Title Should Be                  My Store

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text                       id=search_query_top                                                                                   ${PRODUTO}

Clicar no botão de pesquisa
    Click Element                    name=submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element Is Visible    css=#center_column > h1
    Page Should Contain Image        xpath=//*[@id="center_column"]//*[@src="http://automationpractice.com/img/p/7/7-home_default.jpg"]
    Page Should Contain Link         xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUTO}")]

Conferir mensagem de erro "${MENSAGEM_ALERTA}"
    Wait Until Element Is Visible    xpath=//*[@id="center_column"]/h1
    Page Should Contain Element      xpath=//*[@id="center_column"]/p[@class='alert alert-warning']                                        ${MENSAGEM_ALERTA}
