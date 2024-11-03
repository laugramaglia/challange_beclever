# Challenge Flutter: Beclever

## Descripción

[Breve descripción del challenge y sus objetivos principales]

## Requisitos Previos 📋

Antes de comenzar, asegúrate de tener instalado:

- Flutter SDK (versión 3.24.4 o superior)
- Dart SDK (versión 3.5.4 o superior)
- Android Studio / XCode
- Un editor de código (VS Code recomendado)

## Configuración del Entorno 🔧

### 1. Clonar el Repositorio

```bash
git clone https://github.com/laugramaglia/challange_beclever.git
cd challange_beclever
```

### 2. Instalar Dependencias

Ejecuta el siguiente comando en la raíz del proyecto:

```bash
flutter pub get
```

## Ejecutar el Proyecto 🚀

### Modo Debug

```bash
flutter run
```

### Modo Release

```bash
flutter run --release
```

### Seleccionar Dispositivo Específico

1. Lista los dispositivos disponibles:

```bash
flutter devices
```

2. Ejecuta en un dispositivo específico:

```bash
flutter run -d [ID-DISPOSITIVO]
```

## Estructura del Proyecto 📁

```
lib/
├── core/
|   └── config/
│   |      ├── bloc/
│   |      └── router/
│   ├── network/
│   ├── theme/
│   ├── usecases/
│   └── utils/
├── features/
│   ├── feature1/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── feature2/
└── main.dart
```

## Pruebas ⚡

### Ejecutar Pruebas Unitarias

```bash
flutter test
```

## Recursos Adicionales 📚

- [Desafio doc](https://github.com/laugramaglia/challange_beclever/blob/main/desafio_tecnico_flutter.pdf)
- [Flow](https://www.figma.com/board/rpzAS6p1D3mqQT93OpgS3U/Untitled?node-id=0-1&t=auQkuDylpfKw3aSO-1)
