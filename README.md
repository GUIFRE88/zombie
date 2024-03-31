# Projeto ZOMBIE, a humnidade está por um fio !

## Para utilizar o projeto apenas faça o clone desse repositório e siga os passos abaixo:

### 1 - Entrar na pasta zombie
### 2 - Fazer o build do projeto com `docker compose build`
### 3 - Iniciar a aplicaação `docker compose up`
### 4 - Entrar no bash `docker compose run zombie bash`
### 4.1 - Rodar o comando `rails db:create` dentro do bash
### 4.2 - Rodas as migrations `rails db:migrate` dentro do bash
### 4.3 - Para rodas os testes utilize `bundle exec rspec` dentro do 


## Rotas da API

### 1 - Usuários (user)

#### 1.1 - Criar um usuário (create user)

Para criar um novo usuário, envie uma solicitação **POST** para a rota `http://0.0.0.0:3000/users` com o seguinte **BODY**:

```json
{
  "name": "User 2",
  "age": 30,
  "gender": "M",
  "latitude": 40.7128,
  "longitude": -74.006
}
```

#### 1.2 - Listar usuários (index users)

Para listar os usuários envie uma solicitação **GET** para a rota `http://0.0.0.0:3000/users?page=1` com o **BODY** vazio.

```json
{}
```

Obs. É possivel selecionar qual pagina deseja trazer basta passar o parametro **page** na url.

#### 1.3 - Listar um usuário (show user)

Para listar apenas um usuário envie uma solicitação **GET** para a rota `http://0.0.0.0:3000/users/1` passando o **ID** do usuário desejado na url e com o **BODY** vazio.

```json
{}
```

#### 1.4 - Alterar um usuário (update user)

Para alterar um usuário, envie uma solicitação **PUT** para a rota `http://0.0.0.0:3000/users/1` passando o **ID** do usuário que sofrerá a alteração com o seguinte **BODY**:

```json
{
"age":40
}

```

Obs. Poderá ser enviado os demais campos do usuário para alteração.

#### 1.5 - Excluir um usuário (delete user)

Para listar apenas um usuário envie uma solicitação **DELETE** para a rota `http://0.0.0.0:3000/users/1` passando o **ID** do usuário desejado na url e com o **BODY** vazio.

```json
{}
```


### 2 - Inventário (inventory)

#### 2.1 - Adicionar um item no inventáro (create inventory)

Para adicionar um item no iventário do usuário, envie uma solicitação **POST** para a rota `http://0.0.0.0:3000/inventories` com o seguinte **BODY**:

```json
{
"item":"munição",
"user_id":1,
"quantity": 100
}

```

Obs. Os valores do item são `água, comida, munição e `



### 3 - Marcar um usuário como infectado (mark infected)

### 4 - Escambo (exchanges)

### 5 - Relatório (reports)

