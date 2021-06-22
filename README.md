<h2> Paynow - TreinaDev 06 - Etapa 1 </h2>
<br>

#### Este projeto consiste em desenvolver uma plataforma de pagamentos para gerenciar produtos, meios de pagamentos, cobranças e informações de clientes de empresas cadastradas.
<br>

#### O projeto foi desenvolvido utilizando Trello, [link aqui](https://trello.com/b/ZFZNSuCu/paynow)
---
<br>

### Principais tecnologias Utilizadas:

✓ Ruby ✓ Rails ✓ Rspec ✓ Capybara ✓ Devise ✓ HTML ✓ CSS ✓

---
<br>

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

<br>

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

<br>

## API

#### Os funcionarios das empresas cadastradas devem adicionar seus clientes via API utilizando o token de suas empresas:
<br>

### Dados para adicionar clientes:

```
Rota:  POST http://127.0.0.1:3000/api/v1/clients

Input:

{
	"client": {
	"name": "Ana",
	"surname": "Sá",
	"cpf": "129.640.270-30",
  "company_token": "82f4c64d233829eacb11"
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

<br>

### Dados para adicionar cobranças separados por meios de pagamento:

```
Para Pix

Rota: POST http://127.0.0.1:3000/api/v1/pix_billings

Input:

  {
    pix_billing: {
      company_token: "537feeacadd8f3623a50",
      product_token: "0bd859a3a7a77c56880a",
      client_token: "2b52d13ad6afeafb711c",
      client_name: "maria",
      client_surname: "silva",
      client_cpf: "173.097.520-82",
      payment_method: "Pix MP"
    }
  }

```

```
Para Boleto(em desenvolvimento)

Rota: POST http://127.0.0.1:3000/api/v1/pix_billings

Input:

  {
    billet_billing: {
      company_token: "537feeacadd8f3623a50",
      product_token: "0bd859a3a7a77c56880a",
      client_token: "2b52d13ad6afeafb711c",
      client_name: "maria",
      client_surname: "silva",
      client_cpf: "173.097.520-82",
      payment_method: "Boleto Itau",
      zip_code: "13214701",
      state: "sp",
      city: "sao paulo",
      street: "Rua Uva Isabel",
      house_number: "123",
      complement: "casa"
    }
  }

```

```
Para cartão de crédito(em desenvolvimento)

Rota: POST http://127.0.0.1:3000/api/v1/card_billings

Input:

  {
    card_billing: {
      company_token: "537feeacadd8f3623a50",
      product_token: "0bd859a3a7a77c56880a",
      client_token: "2b52d13ad6afeafb711c",
      client_name: "maria",
      client_surname: "silva",
      client_cpf: "173.097.520-82",
      payment_method: "Cartão Vis",
      client_card_number: "5237827889175873",
      client_card_name: "maria s",
      client_card_code: "969"
    }
  }

```

```
Output para todos os *inputs* em caso de sucesso:

  {
      message: "Cobrança gerada com sucesso!"
  }

```

```
Output para todos os *inputs* em caso de falha:

  {
      "message": "Dados inválidos"
  }

```

