# Bankly API Integration

Esta é uma biblioteca Ruby para integração com a API da Bankly, focada em operações PIX.

## Como instalar e executar localmente

Execute no terminal:

```bash
$ docker-compose run web bash
$ bin/rails console
```

## Uso

### Exemplo Completo de Fluxo PIX

O exemplo abaixo demonstra o fluxo completo para criar e gerenciar uma cobrança PIX:

```ruby
# 1. Primeiro, buscar uma conta PIX existente
pix_account = Kobana::V2::PixAccounts::Fetcher.call(id: "019935f3-078b-71ed-ac1c-433739ecd858")

# 2. Criar uma nova cobrança PIX usando a conta encontrada
pix_create = Kobana::V2::Pix::Creator.call(payload: { 
  amount: 10,
  payer: {
    document_number: "542.041.790-10",
    name: "John Doe",
    email: "john.doe@example.com"
  },
  pix_account_uid: pix_account.uid,
  expire_at: 3.hours.since.iso8601
})

# 3. Consultar a cobrança PIX criada
pix = Kobana::V2::Pix::Fetcher.call(id: pix_create.uid)
```

### Detalhamento das Operações

#### Consultar uma Conta PIX

Para consultar informações de uma conta PIX existente:

```ruby
Kobana::V2::PixAccounts::Fetcher.call(id: "019935f3-078b-71ed-ac1c-433739ecd858")
```

#### Criar uma Cobrança PIX

Para criar uma nova cobrança PIX:

```ruby
payload = {
  amount: 10.0,
  payer: {
    document_number: "542.041.790-10",
    name: "John Doe",
    email: "john.doe@example.com"
  },
  pix_account_uid: "019935f3-078b-71ed-ac1c-433739ecd858",
  expire_at: 3.hours.since.iso8601
}

Kobana::V2::Pix::Creator.call(payload: payload)
```

O método retorna um objeto `Kobana::V2::PixEntity` com os seguintes atributos:

| Atributo | Tipo | Descrição | Exemplo |
|----------|------|-----------|---------|
| id | Integer | ID interno da cobrança | 14399 |
| uid | String | Identificador único da cobrança | "01993bca-e157-71c1-9736-690107651b3b" |
| txid | String | Identificador da transação PIX | "bd88c815799bab828e24f2b676070a89" |
| status | String | Status atual da cobrança | "opened" |
| registration_status | String | Status do registro da cobrança | "confirmed" |
| pix_account_id | Integer | ID da conta PIX associada | 558 |
| pix_account_uid | String | Identificador único da conta PIX | "019935f3-078b-71ed-ac1c-433739ecd858" |
| kind | String | Tipo da cobrança | "instant" |
| created_at | String | Data de criação | "2025-09-11T23:39:35-03:00" |
| updated_at | String | Data da última atualização | "2025-09-11T23:41:37-03:00" |
| expire_at | DateTime | Data de expiração (opcional) | "2025-09-15T10:03:56-03:00" |
| canceled_at | DateTime | Data de cancelamento (opcional) | nil |
| registered_at | DateTime | Data de registro | "2025-09-11T23:41:37-03:00" |
| amount | Float | Valor da cobrança | 10.0 |

##### Status Possíveis

- Status da Cobrança (`status`):
  - `opened`: Cobrança aberta aguardando pagamento
  - `paid`: Cobrança paga
  - `cancelled`: Cobrança cancelada
  - `expired`: Cobrança expirada

- Status do Registro (`registration_status`):
  - `pending`: Registro pendente
  - `confirmed`: Registro confirmado
  - `failed`: Falha no registro

#### Consultar uma Cobrança PIX

Para consultar uma cobrança PIX existente:

```ruby
Kobana::V2::Pix::Fetcher.call(id: "01993bca-e157-71c1-9736-690107651b3b")
```

## Tratamento de Erros

A biblioteca lança `Kobana::V2::Base::InvalidRequestError` quando a API retorna erros. Sempre trate estas exceções em seu código:

```ruby
begin
  pix_create = Kobana::V2::Pix::Creator.call(payload: payload)
rescue Kobana::V2::Base::InvalidRequestError => e
  puts "Erro na requisição: #{e.message}"
end
```

## Licença

Esta gem está disponível como código aberto sob os termos da [Licença MIT](https://opensource.org/licenses/MIT).
