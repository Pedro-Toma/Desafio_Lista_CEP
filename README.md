# DIO_Lista_CEP

### Funcionalidade
Consulta um cep inserido pelo usuáio ao clicar no botão de pesquisa e inserir um cep válido. Os CEPs são mostrados no formato de lista, tendo a possibilidade de alterar o conteúdo deles e mandar atualizar no banco de dados.

### Como foi desenvolvido?
Foi criada uma página para consulta e display da lista de CEPs. A consulta foi feita utilizando a API do site ViaCEP. O armazenamento dos CEPs em lista está na classe CEP criada no site Back4App que serve como host de um banco de dados para a aplicação. O repositório de CEP, tem as seguintes funções: consultarCEP (ViaCEP), obterRegistros (Back4App - CEP), consultarRegisro (Back4App - CEP, com query), salvarRegistro (Back4App - CEP), atualizarRegistro (Back4App - CEP) e removerRegistro (Back4App - CEP). Além disso foi utilizada a biblioteca Dio para fazer as requisições http, com as credenciais necessárias para acessar a classe CEP no host Back4App e as credenciais e BaseUrl foram colocadas em um arquivo .env (não enviado ao git).

### Tecnologia Utilizada
- Dart
