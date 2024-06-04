# Sistema de Galpões
TreinaDev 12 - Campus Code
## 🧭 Descrição
Aplicação Ruby on Rails proposta pelo TreinaDev desenvolvida utilizando metodologia TDD.
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
