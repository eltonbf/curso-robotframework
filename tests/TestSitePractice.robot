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

Caso de teste 03: Listar Produtos
    Acessar página home do site
    Passar o mouse por cima da categoria "Women" no menu principal superior de categorias.
    Clicar na sub categoria "Summer Dresses"

Caso de teste 04: Adicionar Produtos no Carrinho
    Acessar página home do site
    Digitar o nome de produto "t-shirt" no campo de pesquisa
    Clicar no botão de pesquisa
    Clicar no botão "Add to cart" do produto
    Clicar no botão "Proceed to checkout"

Caso de teste 05: Remover Produtos
    Acessar página home do site
    Adicionar o produto "t-shirt" no carrinho
    Clicar no ícone carrinho de compras no menu superior direito
    Clicar no botão de remoção de produtos (delete) no produto do carrinho


Caso de teste 06: Adicionar Cliente
    Acessar página home do site
    Clicar no botão superior direito “Sign in”
    Inserir um e-mail válido
    Clicar no botão "Create na account".
    Preencher os campos obrigatórios
    Clicar em "Register" para finalizar o cadastro

*** Keywords ***
