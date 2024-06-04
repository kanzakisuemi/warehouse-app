# Sistema de Galpões
TreinaDev 12 - Campus Code
## 🧭 Descrição
Aplicação desenvolvida utilizando metodologia TDD, durante e para o TreinaDev. Feito em paralelo ao conteúdo do curso.
## 🧷 Funcionalidades
- Galpões
  - Detalhes (mostra: nome, cidade, área em metros quadrados, endereço, cep, detalhes, seção de itens em estoque e seção de saída de itens com formulário) 
  - Listagem (mostra: nome, código, cidade e área em metros quadrados)
  - Cadastro (registra: nome, descrição, código, endereço, cidade, dep e área em metros quadrados)
  - Edição (edita: nome, descrição, código, endereço, cidade, dep e área em metros quadrados)
- Fornecedores
  - Detalhes (mostra: nome da marca, nome corporativo, cidade, email, endereço, cep e cnpj)
  - Listagem (mostra: nome da marca e cidade)
  - Cadastro (registra: nome corporativo, nome da marca, cnpj, endereço, cidade, cep e email)
  - Edição (edita: nome corporativo, nome da marca, cnpj, endereço, cidade, cep e email)
- Produtos (🔒 usuário deve estar autenticado para acessar essas funcionalidades)
  - Detalhes (mostra: nome, nome da marca do fornecedor, peso, largura, altura, profundidade e sku) 
  - Listagem (mostra: nome e fornecedor)
  - Cadastro (registra: nome, peso, largura, altura, profundidade, SKU e fornecedor)
- Pedidos (🔒 usuário deve estar autenticado para acessar essas funcionalidades)
  - Busca (retorna pedidos que atendem aos parametros) 
  - Detalhes (mostra: código do pedido, nome da marca do fornecedor, código do galpão, nome do galpão, nome do demandante, email do demandante, data prevista de entrega, status)
  - Listagem (mostra: nome da marca fornecedor e galpão destino)
  - Cadastro (data prevista, nome da marca fornecedor, galpão destino)
  - Edição (edita: data prevista, nome da marca fornecedor, galpão destino)
- Autenticação
  - Contém funcionalidades padrão da autenticação com Devise
  - Usuário possui apenas email e senha
## ⚙️ Dependências
### Sistema
- ruby "3.1.2"
- rails "~> 7.0.6"
### Testes
- rspec-rails
- capybara
### Autenticação
- devise
## 🚀 Rodando localmente
depois de instalar a versão correta do Rails e do Ruby
comece clonando o repositório
```
git clone git clone git@github.com:kanzakisuemi/warehouse-app.git
```
instale as demais dependências e prepare o banco de dados
```
bin/setup
```
inicialize o servidor
```
rails s
```
### Teste as funcionalidades
```
rspec
```
para testes de sistema
```
rspec spec/system
```
para testes de requisição
```
rspec spec/requests
```
para testes de modelo
```
rspec spec/models
```



