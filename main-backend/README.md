# Main Backend

## Подготовка
В зависимости от режима запуска, создать .development.env или .production.env, исходя из примера в .env.sample

## Запуск приложения
```
npm i
npm run start:dev (Unix)
npm run start:dev:win (Win)
```

## Управление миграциями
Для запуска миграций нужно изменить ./db/typeorm.config.ts и запустить
```
npm run migration:run
```

## API
После локального запуска проекта, доступно по пути http://localhost:8080/swagger 
