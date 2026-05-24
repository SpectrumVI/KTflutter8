# Flutter Clean Architecture + BLoC

Учебный Flutter-проект, демонстрирующий **Clean Architecture** в связке с **BLoC** паттерном управления состоянием.

## 📐 Архитектура

```
lib/
├── core/
│   ├── error/
│   │   ├── failures.dart         # Failure-классы (ServerFailure, NetworkFailure)
│   │   └── exceptions.dart       # Exception-классы
│   ├── network/
│   │   └── api_client.dart       # HTTP-клиент
│   └── usecases/
│       └── usecase.dart          # Базовый абстрактный UseCase
│
├── features/
│   └── posts/
│       ├── data/                 # DATA LAYER
│       │   ├── datasources/
│       │   │   └── post_remote_datasource.dart
│       │   ├── models/
│       │   │   └── post_model.dart
│       │   └── repositories/
│       │       └── post_repository_impl.dart
│       │
│       ├── domain/               # DOMAIN LAYER (бизнес-логика, чистый Dart)
│       │   ├── entities/
│       │   │   └── post.dart
│       │   ├── repositories/
│       │   │   └── post_repository.dart   # Абстракция
│       │   └── usecases/
│       │       ├── get_posts.dart
│       │       └── get_post_by_id.dart
│       │
│       └── presentation/         # PRESENTATION LAYER
│           ├── bloc/
│           │   ├── posts_bloc.dart
│           │   ├── posts_event.dart
│           │   ├── posts_state.dart
│           │   ├── post_detail_bloc.dart
│           │   ├── post_detail_event.dart
│           │   └── post_detail_state.dart
│           ├── pages/
│           │   ├── posts_page.dart
│           │   └── post_detail_page.dart
│           └── widgets/
│               ├── post_card.dart
│               ├── error_widget.dart
│               └── loading_shimmer.dart
│
├── injection_container.dart      # Dependency Injection (GetIt)
└── main.dart
```

## 🔑 Ключевые принципы

### Clean Architecture (3 слоя)
| Слой | Назначение | Зависимости |
|------|-----------|-------------|
| **Domain** | Бизнес-логика, сущности, абстракции | Ничего (чистый Dart) |
| **Data** | Работа с данными, реализации | Domain |
| **Presentation** | UI, BLoC | Domain |

### BLoC Pattern
- **Event** → входящее событие (пользователь нажал кнопку, страница открылась)
- **BLoC** → обрабатывает event, вызывает usecase
- **State** → результат (Loading / Loaded / Error)

### Either (dartz)
Все usecase возвращают `Either<Failure, T>` — вместо исключений:
```dart
// Успех
return Right(posts);
// Ошибка
return Left(ServerFailure('message'));
```

## 🚀 Запуск

```bash
flutter pub get
flutter run
```

## 🧪 Тесты

```bash
# Сгенерировать моки
dart run build_runner build

# Запустить тесты
flutter test
```

## 📦 Зависимости

| Пакет | Назначение |
|-------|-----------|
| `flutter_bloc` | BLoC паттерн |
| `equatable` | Сравнение объектов |
| `get_it` | Dependency Injection |
| `dartz` | Either (функциональное программирование) |
| `http` | HTTP-запросы |

## 📁 Локальные данные

Приложение использует локальный JSON-файл с постами про еду:
- `assets/data/food_posts.json` — список постов
- детальная страница открывается по `id` из этого же файла
