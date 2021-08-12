*** Settings ***
Resource         ../resource/Resource.robot
Test Setup       Abrir navegador
Test Teardown    fechar Navegador

# SETUP ele roda keyword antes da suite ou antes de um teste
# TEARDOWN ele roda keyword depois de uma suite ou um teste


*** Test Case ***
Caso de teste 01: Pesquisar produto existente
    Acessar página home do site
    Digitar o nome de produto "Blouse" no campo de pesquisa
    Clicar no botão de pesquisa
    Conferir se o produto "Blouse" foi listado no site

Caso de teste 02: Pesquisar produto não existente
    Acessar página home do site
    Digitar o nome de produto "itemNãoExistente" no campo de pesquisa
    Clicar no botão de pesquisa
    Conferir mensagem de erro "No results were found for your search "itemNãoExistente""



*** Keywords ***
