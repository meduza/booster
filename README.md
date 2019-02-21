# Booster

Инсталяция и запуск приложения:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Откройте [`localhost:4000`](http://localhost:4000) в вашем браузере.


# API

API работает по протоколу HTTP. Обмен данными проиcходит в виде JSON структур. При обращении к API, в заголовке нужно явно указать "Content-type": "application/json"

### Основной URL
Все  запросы к API включают основной URL:
```
http://localhost:4000/api
```
### API.Endpoints

* [API.Reports](#reports)
* [API.Devices](#devices)
* [API.Experiments](#experiments)

### WEB.Endpoint
* [Web.Reports](#web_reports)

#### Reports
```
  GET /reports
```
Возвращает статистику по экспериментам, колличество устройств, распределение устройств по опциям. Пример ответа:
```javascript
{
    "data": [
        {
            "experiment_id": 2,
            "key": "price",
            "options": {
                "10": 4,
                "20": 2,
                "50": 1
            },
            "total_devices": 7
        },
        {
            "experiment_id": 1,
            "key": "button_color",
            "options": {
                "#0000FF": 2,
                "#00FF00": 4,
                "#FF0000": 2
            },
            "total_devices": 8
        }
    ]
}
````


#### Devices
```
GET /device/experiments
```
Принимает запрос от устройства на доступные AB эксперименты. В случае, если устройство было ранее зарегистрированно, ему будет возвращен списом экспериментов и опций, которое оно получило при первом обращении, если устройство обращается впервые, оно получит список всех доступных экспериментов на данный момент с опциями, распределенными в процентной вариативности. В любом случае, при успешном запросе, структура ответа будет примерно следующая:

```javascript
{
    "data": [
        {
            "key": "button_color",
            "value": "#00FF00"
        },
        {
            "key": "price",
            "value": "10"
        }
    ]
}
```

Для корректного ответа требует наличия в HTTP Header параметра "Device-token". В противном случае, возвращает ошибку:

```javascript
{
    "error": "device_token_not_found"
}
```


#### Experiments
```
GET /experiments
```
Возвращает список всех доступных AB экспериментов с опциями. Пример ответа:
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

Пример ответа в случае ошибки:
```javascript
{
    "errors": {
        "key": [
            "has already been taken"
        ]
    }
}
```

#### Web.reports
При http запросе доступна статистика в html формате.
```
http://localhost:4000
```
