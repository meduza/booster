# Booster

Для запуска приложения:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Откройте [`localhost:4000`](http://localhost:4000) в вашем браузере.


# API

API работает по протоколу HTTP. Все ответы приходят в виде JSON структур.


### Основной URL
Все  запросы к API включают основной URL. API принимает данные в формате application/json
```
http://localhost:4000/api
```

### Experiments
```
GET /experiments
```
Возвращает список всех доступных AB экспериментов. Пример ответа:
```javascript
{
  "data": [
      {
          "description": "Button color AB test",
          "id": 1,
          "key": "button_color",
          "options": [
              {
                  "id": 1,
                  "value": "#FF0000"
              },
              {
                  "id": 2,
                  "value": "#00FF00"
              },
              {
                  "id": 3,
                  "value": "#0000FF"
              }
          ]
      },
      {
          "description": "Price AB test",
          "id": 2,
          "key": "price",
          "options": [
              {
                  "id": 4,
                  "value": "10"
              },
              {
                  "id": 5,
                  "value": "20"
              },
              {
                  "id": 6,
                  "value": "50"
              },
              {
                  "id": 7,
                  "value": "5"
              }
          ]
      }
  ]
}
```

```
POST /experiments
```
Создает новый AB эксперимент. Принимает данные в формате application/json:

```javascript
{
  "experiment": {
     "description": "Button color AB test",
     "key": "button_color",
  	 "options": [
  	 	  {"value": "#FF0000", "percentage": 33},
  	 	  {"value": "#00FF00", "percentage": 33},
  	 	  {"value": "#0000FF", "percentage": 33}]
   }
}
```
