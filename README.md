<h2> Paynow - TreinaDev 06 - Etapa 1 </h2>

#### Este projeto consiste em desenvolver uma plataforma de pagamentos para gerenciar produtos, meios de pagamentos, cobranças e informações de clientes de empresas cadastradas.


#### O projeto foi desenvolvido utilizando Trello, [link aqui](https://trello.com/b/ZFZNSuCu/paynow)
---

### Principais tecnologias Utilizadas:

✓ Ruby ✓ Rails ✓ Rspec ✓ Capybara ✓ Devise ✓ HTML ✓ CSS ✓

---

## Executando o projeto:

```
No terminal, clone o projeto:

git clone git@github.com:faalbuquerque/paynow.git
```

```
Entre na pasta do projeto:

cd paynow
```

```
Configure o projeto:

bundle install && yarn install && rails db:migrate
```

```
Execute o projeto:

rails s
```

```
Opcional, povoe o banco de dados com seeds, para testes

rails db:seed
````

### Dados para testes(Seeds):
```
Para se logar como empresa administradora do sistema: Paynow

Login de admin(1): maria_admin@paynow.com
                   Senha: 123456

Login de admin(2): joao_admin@paynow.com
                   Senha: 123456

```
---

```
Para se logar como empresa que utiliza o sistema:

Login de admin da empresa: admin_company@company.com
                           Senha: 123456

Login de funcionário da empresa: user_company@company.com
                                 Senha: 123456

```

## API

#### Os funcionarios das empresas cadastradas devem adicionar seus clientes via API utilizando o token de suas empresas:

### Dados para adicionar clientes:

```
Rota:  POST http://127.0.0.1:3000/api/v1/clients

Input:

{
  "client": {
              "name": "Ana",
              "surname": "Sá",
              "cpf": "129.640.270-30",
              "company_token": "a94f3afac6f28848783f"
            }
}


Output em caso de sucesso:
{
  "name": "Ana",
  "surname": "Sá",
  "cpf": "129.640.270-30"
}


Output em caso de falha:
{
  "message": "parâmetros inválidos"
}

```

#### Os funcionarios das empresas cadastradas podem adicionar cobranças de seus clientes utilizando o token da sua empresa, o token do produto envolvido na transação, o meio de pagamento escolhido e os dados do cliente final para emissão da cobrança.


### Dados para adicionar cobranças separadas por meios de pagamento:

```
Para Pix

Rota: POST http://127.0.0.1:3000/api/v1/pix_billings

Input:

  {
    "pix_billing": {
      "company_token": "a94f3afac6f28848783f",
      "product_token": "16ab79eb59f06a07b08e",
      "client_token": "e7bda828ea1d64cf1a54",
      "client_name": "maria",
      "client_surname": "silva",
      "client_cpf": "173.097.520-82",
      "payment_method": "Pix MP"
    }
  }

```

```
Para Boleto
Rota: POST http://127.0.0.1:3000/api/v1/billet_billings

Input:

  {
    "billet_billing": {
      "company_token": "a94f3afac6f28848783f",
      "product_token": "16ab79eb59f06a07b08e",
      "client_token": "e7bda828ea1d64cf1a54",
      "client_name": "maria",
      "client_surname": "silva",
      "client_cpf": "173.097.520-82",
      "payment_method": "Boleto Itau",
      "zip_code": "13214701",
      "state": "sp",
      "city": "sao paulo",
      "street": "Rua Uva Isabel",
      "house_number": "123",
      "complement": "casa"
    }
  }

```

```
Para cartão de crédito

Rota: POST http://127.0.0.1:3000/api/v1/card_billings

Input:

  {
    "card_billing": {
      "company_token": "a94f3afac6f28848783f",
      "product_token": "16ab79eb59f06a07b08e",
      "client_token": "e7bda828ea1d64cf1a54",
      "client_name": "maria",
      "client_surname": "silva",
      "client_cpf": "173.097.520-82",
      "payment_method": "Cartão Vis",
      "client_card_number": "5237827889175873",
      "client_card_name": "maria s",
      "client_card_code": "969"
    }
  }

```

```
Output em caso de sucesso:

  {
    "message": "Cobrança gerada com sucesso!"
    "token: "...aqui token da cobranca gerada..."
  }

```

```
Output em caso de falha:

  {
    "message": "Dados inválidos"
  }

```
