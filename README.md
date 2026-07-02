# RappiMovies

Ejercicio técnico desarrollado para una entrevista de **Mobile Engineer en RappiPay**.

Es una app de películas que consume la API de [The Movie DB (TMDB)](https://www.themoviedb.org/documentation/api), construida con Flutter siguiendo una arquitectura por capas (`data` / `domain` / `presentation`) y manejo de estado con Riverpod.

## Funcionalidades

- Listado de películas **populares** y **mejor calificadas**, con paginación infinita.
- Detalle de película: sinopsis, calificación, fecha de estreno, duración, géneros y elenco.
- Búsqueda de películas en tiempo real.
- Manejo de errores de red con feedback visual (sin conexión, timeout, servidor caído, etc.) y reintento.
- Loading states con skeletons animados.
- Tema y colores centralizados (`AppColors` / `AppTheme`).
- Textos centralizados con [slang](https://pub.dev/packages/slang), preparados para soportar múltiples idiomas.

## Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `^3.8.0` (Dart incluido)
- Un API Key de [TMDB](https://www.themoviedb.org/settings/api) (gratuita, requiere crear cuenta)

## Configuración

1. Clonar el repositorio:
   ```bash
   git clone <url-del-repo>
   cd rappi_themoviedb
   ```

2. Instalar dependencias:
   ```bash
   flutter pub get
   ```

3. Crear el archivo de variables de entorno a partir del template:
   ```bash
   cp .env.template .env
   ```
   Y completar `.env` con tu API Key de TMDB:
   ```
   THE_MOVIEDB_KEY=tu_api_key_aqui
   ```

4. Generar el código (freezed, json_serializable, riverpod_generator, slang):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. Ejecutar la app:
   ```bash
   flutter run
   ```

## Tests

```bash
flutter test
```

## Posibles mejoras a implementar

- **Offline-first**: persistir localmente los listados y detalles de películas (por ejemplo con
  [Drift](https://pub.dev/packages/drift), [Hive](https://pub.dev/packages/hive) o
  [Isar](https://pub.dev/packages/isar)) para permitir el uso de la app sin conexión y reducir
  llamadas de red innecesarias.

## Uso de IA

Se utilizó Claude Code como herramienta de apoyo a lo largo del desarrollo, principalmente para:

- **Aceleración mecánica en la construcción de UI**: escritura de widgets repetitivos o de
  boilerplate una vez definida la estructura y el comportamiento deseado, así como ajustes
  visuales puntuales (espaciados, tamaños, alineaciones) que de otra forma tomarían varias
  iteraciones manuales de prueba y error.
- **Apoyo en la toma de decisiones de dependencias de terceros**: comparar alternativas antes
  de incorporar paquetes al proyecto (por ejemplo, `slang` para i18n).
- **Validación de cobertura de tests**: verificar si los casos de prueba ya implementados
  eran suficientes, y confirmar la correcta aplicación del patrón Given-When-Then en cada test.
- **Refactors de escalabilidad**: centralización de colores y tema (`AppColors` / `AppTheme`)
  y migración de los textos de la UI a i18n con [slang](https://pub.dev/packages/slang),
  incluyendo la búsqueda y el mapeo de valores hardcodeados antes de refactorizar.
- **Clasificación de errores de red**: apoyo para identificar los distintos tipos de excepción
  de Dio (timeout, sin conexión, códigos de estado HTTP) y traducirlos a mensajes de error
  claros para el usuario.
- Redacción de este README.

Las decisiones de arquitectura, la lógica de negocio y el diseño de la solución fueron
realizados por mí. La IA se usó como acelerador y como segunda opinión en puntos puntuales,
no para diseñar el proyecto.
