# NearbyEats

App móvil en Flutter para encontrar el restaurante más conveniente para un grupo, calculando un puntaje de viabilidad según la ubicación geográfica de cada colaborador.

## Funcionalidades

- **Autenticación**: inicio de sesión con JWT contra el backend.
- **Restaurantes**: listado con detalle (cocina, precio, horario, dirección).
- **Favoritos**: marca restaurantes favoritos, guardados en el dispositivo.
- **Grupos**: crea grupos de colegas/amigos.
- **Colaboradores**: agrega personas a un grupo con su dirección.
- **Cálculo de viabilidad**: elige un restaurante y obtén un puntaje (0-100) basado en la distancia promedio y la dispersión geográfica de los colaboradores del grupo.
- **Términos y Condiciones**: disponibles desde la pantalla de login.

## Requisitos

- Flutter SDK
- Un emulador o dispositivo Android/iOS conectado

## Cómo correr el proyecto

```bash
flutter pub get
flutter run
```

> En un emulador Android, si necesitas apuntar a un backend corriendo en tu máquina local, usa `http://10.0.2.2:PUERTO` en vez de `localhost`.

## Otros comandos útiles

```bash
flutter analyze     # Lint
flutter test        # Tests
flutter build apk   # Build de Android
```

## Arquitectura

El proyecto sigue Domain-Driven Design. Cada feature en `lib/features/` está organizada en:

```
domain/          # Entidades y contratos de repositorio
infrastructure/  # Modelos e implementaciones de repositorio (Dio)
presentation/    # Providers (Riverpod), pantallas y widgets
```

Features actuales: `auth`, `restaurants`, `groups`, `colleagues`, `calculations`, `legal`.

Navegación con `go_router` (`lib/core/router/app_router.dart`), estado con `flutter_riverpod`, HTTP con `dio`, persistencia local con `shared_preferences`.

## Backend

La app consume una API REST (.NET) cuya URL base está configurada en `lib/core/constants/api_constants.dart`.
