*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books
Library         RequestsLibrary
Library         Collections

*** Variable ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}      id=15             title=Book 15             pageCount=1500
&{BOOK_201}     ID=201
...             Title=Meu novo Book
...             Description=Meu novo livro conta coisas fantásticas
...             PageCount=523
...             Excerpt=Meu Novo livro é massa
...             PublishDate=2018-04-26T17:58:14.765Z
&{BOOK_150}     ID=150
...             Title=Book 150 alterado
...             Description=Descrição do book 150 alteada
...             PageCount=600
...             Excerpt=Resumo do book 150 alteado
...             PublishDate=2017-04-26T15:58:14.765Z


*** Keywords ***
####SETUP E TEARDOWNS
Conectar a minha API
    Create Session    fakeAPI    ${URL_API}
    ${HEADERS}     Create Dictionary    content-type=application/json
    Set Suite Variable    ${HEADERS}

#### Ações
Requisitar todos os livros
    ${RESPOSTA}    GET On Session    fakeAPI    Books
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}    GET On Session    fakeAPI    Books/${ID_LIVRO}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Cadastrar um novo livro
    ${RESPOSTA}    POST On Session   fakeAPI    Books
    ...                           data={ "id": 17,  "title": "tester",  "description": "tester",  "pageCount": 17,  "excerpt": "tester",  "publishDate": "2000-08-16T14:47:17.810Z"}
    ...                           headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Alterar o livro "${ID_LIVRO}"
    ${RESPOSTA}    Put Request    fakeAPI    Books/${ID_LIVRO}
    ...                           data={"ID": ${BOOK_150.ID},"Title": "${BOOK_150.Title}","Description": "${BOOK_150.Description}","PageCount": ${BOOK_150.PageCount},"Excerpt": "${BOOK_150.Excerpt}","PublishDate": "${BOOK_150.PublishDate}"}
    ...                           headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Excluir o livro "${ID_LIVRO}"
    ${RESPOSTA}    Delete Request    fakeAPI    Books/${ID_LIVRO}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}


#### Conferências
Conferir o status code
    [Arguments]      ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]    ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}     ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros
    Length Should Be      ${RESPOSTA.json()}     ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro 15
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id              ${BOOK_15.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title           ${BOOK_15.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount       ${BOOK_15.pageCount}
    Should Not Be Empty    ${RESPOSTA.json()["description"]}
    Should Not Be Empty    ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty    ${RESPOSTA.json()["publishDate"]}

Conferir se retorna todos os dados cadastrados do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}

Conferir se retorna todos os dados alterados do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}

Conferir livro
    [Arguments]     ${ID_LIVRO}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id              ${BOOK_${ID_LIVRO}.ID}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title           ${BOOK_${ID_LIVRO}.Title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    description     ${BOOK_${ID_LIVRO}.Description}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount       ${BOOK_${ID_LIVRO}.PageCount}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    excerpt         ${BOOK_${ID_LIVRO}.Excerpt}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    publishDate     ${BOOK_${ID_LIVRO}.PublishDate}

Conferir se excluiu o livro "${ID_LIVRO}"
    Should Be Empty     ${RESPOSTA.content}