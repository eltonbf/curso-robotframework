*** Settings ***
Documentation       Exemplo de uso de variaveis como argumento

*** Variable ***
&{PESSOA}           nome=Elton      email=teste@teste.com       idade=12        sexo=Masculino

*** Test Case ***
Caso de teste de exemplo 01
    Uma keyword qualquer 01

*** Keywords ***
Uma keyword qualquer 01
    Uma subkeyword com argumentos       ${PESSOA.nome}      ${PESSOA.email}
    ${MENSAGEM_ALERTA}      Uma subkeyword com retorno   ${PESSOA.nome}     ${PESSOA.idade}
    Log     ${MENSAGEM_ALERTA}

Uma subkeyword com argumentos
    [Arguments]         ${NOME_USUARIO}     ${EMAIL_USUARIO}
    Log                 Nome usuario: ${NOME_USUARIO}
    Log                 Email: ${EMAIL_USUARIO}

Uma subkeyword com retorno
    [Arguments]         ${NOME_USUARIO}     ${IDADE_USUARIO}
    ${MENSAGE}          Set Variable If     ${IDADE_USUARIO}<18     Não autorizado! O usuario ${NOME_USUARIO} é menor de idade!