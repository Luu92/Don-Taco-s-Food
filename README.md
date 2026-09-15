# 🌮 Don Tacos Food

Aplicación móvil desarrollada en **Flutter** para la gestión de pedidos de la taquería **Don Tacos**.

El proyecto forma parte de un trabajo de tesis cuyo objetivo es diseñar y desarrollar una solución que permita digitalizar parte del proceso de pedidos de la taquería, facilitando a los comensales la consulta de la carta, selección de alimentos, gestión del carrito, registro de direcciones y seguimiento de sus pedidos.

Actualmente, la aplicación se encuentra en una etapa de **demo funcional en ambiente controlado**, utilizando servicios locales y datos simulados mientras se realiza la integración con los microservicios desarrollados con Spring Boot.

---

## 📱 Funcionalidades

Actualmente la aplicación permite:

- Inicio de sesión del comensal.
- Registro de nuevos comensales.
- Recuperación y actualización de contraseña.
- Consulta de categorías de alimentos.
- Consulta de la carta de alimentos.
- Filtrado y ordenamiento de alimentos.
- Selección de cantidades.
- Gestión del carrito de compra.
- Incrementar y disminuir cantidades de productos.
- Eliminar productos del carrito.
- Vaciar el carrito.
- Aplicación de promoción 2x1 para tacos al pastor.
- Registro y administración de direcciones de entrega.
- Selección de una dirección para realizar el pedido.
- Definición de una dirección principal.
- Validación simulada de la zona de cobertura.
- Validación del consumo mínimo requerido para entrega.
- Generación de pedidos.
- Registro de comentarios adicionales para el pedido.
- Consulta del historial de pedidos.
- Consulta del detalle de cada pedido.
- Seguimiento del estado del pedido.
- Confirmación de entrega por parte del comensal.
- Consulta y modificación de información del perfil.
- Cierre de sesión.

---

## 🚚 Flujo del pedido

Una vez generado, el pedido pasa por diferentes estados durante su procesamiento.

```text
Pedido realizado
      ↓
Pendiente
      ↓
Aceptado
      ↓
En preparación
      ↓
Listo
      ↓
En camino
      ↓
Confirmación del comensal
      ↓
Entregado
```

La taquería administra el procesamiento del pedido hasta marcarlo como **Enviado**.

Cuando el pedido llega al domicilio y se encuentra en este estado, la aplicación habilita al comensal un control deslizable para confirmar que recibió su pedido.

Una vez confirmada la recepción, el pedido cambia al estado **Entregado**, concluyendo el flujo.

---

## 🛒 Reglas de negocio

La aplicación contempla diferentes reglas correspondientes al funcionamiento de la taquería.

### Pedido mínimo

Para solicitar el servicio de entrega a domicilio, el pedido debe alcanzar un consumo mínimo de:

**$200 MXN**

### Cargo por servicio

Los pedidos con entrega a domicilio contemplan un cargo adicional de:

**$20 MXN**

### Dirección de entrega

El comensal debe registrar y seleccionar una dirección válida antes de poder realizar un pedido.

Las direcciones pueden ser administradas desde el perfil del usuario y una de ellas puede establecerse como dirección principal.

### Cobertura de entrega

La demo realiza una validación de cobertura mediante **códigos postales permitidos**.

Esta validación permite simular la zona de servicio de la taquería dentro del ambiente controlado de pruebas.

### Promoción 2x1

Los **Tacos al Pastor** cuentan con una promoción 2x1.

La cantidad seleccionada por el comensal representa las unidades pagadas, mientras que la cantidad preparada considera las unidades adicionales correspondientes a la promoción.

Por ejemplo:

```text
Cantidad pagada:    3
Cantidad preparada: 6
```

El importe del pedido se calcula utilizando únicamente la cantidad pagada.

### Confirmación de entrega

La taquería puede administrar el pedido hasta el estado **Enviado**.

La confirmación final de entrega corresponde al comensal.

Cuando el pedido se encuentra en estado `Enviado`, el comensal puede utilizar el control de confirmación disponible en el detalle del pedido.

Después de confirmar la recepción, el estado cambia a:

```text
Entregado
```

---

## 🛠️ Tecnologías utilizadas

### Aplicación móvil

- Flutter
- Dart
- Provider
- Material Design
- Android

### Backend

El backend del sistema se encuentra desarrollado mediante:

- Java
- Spring Boot
- API REST
- PostgreSQL
- Arquitectura basada en microservicios

Actualmente, la aplicación móvil utiliza servicios locales simulados para determinadas operaciones mientras se realiza la integración completa con el backend.

---

## 🏗️ Arquitectura de la aplicación

El proyecto Flutter se encuentra organizado principalmente por funcionalidades.

```text
lib/
├── core/
│   ├── constants/
│   └── theme/
│
├── features/
│   ├── auth/
│   ├── alimentos/
│   ├── carrito/
│   ├── direcciones/
│   ├── menu/
│   ├── pedidos/
│   └── perfil/
│
└── main.dart
```

Cada funcionalidad puede contener sus propios:

```text
models/
providers/
screens/
services/
widgets/
```

La aplicación utiliza **Provider** para administrar el estado y mantener separada la lógica de negocio de las interfaces de usuario.

De manera general, se sigue una estructura similar a:

```text
Screen
   ↓
Provider
   ↓
Service
   ↓
Backend / Datos simulados
```

---

## 🎨 Identidad visual

La aplicación utiliza la identidad visual de **Don Tacos Food**.

Se implementaron:

- Logotipo de la taquería.
- Icono personalizado de la aplicación.
- Nombre visible `Don Tacos Food`.
- Paleta de colores centralizada.
- Tema global de Flutter.
- Componentes visuales reutilizables.
- Diálogos de confirmación.
- Estados vacíos personalizados.
- Navegación mediante barra inferior.

Los estilos generales se encuentran centralizados principalmente en:

```text
core/
├── constants/
│   └── app_sizes.dart
│
└── theme/
    ├── app_colors.dart
    └── app_theme.dart
```

---

## 📦 Instalación del proyecto

Para ejecutar el proyecto es necesario tener instalado Flutter y un dispositivo Android físico o virtual disponible.

Primero se deben instalar las dependencias:

```bash
flutter pub get
```

Posteriormente se puede ejecutar la aplicación mediante:

```bash
flutter run
```

---

## 🤖 Generar APK

Para generar una versión APK de la aplicación:

```bash
flutter build apk --release
```

Flutter genera normalmente el archivo en:

```text
build/app/outputs/flutter-apk/app-release.apk
```

El APK puede instalarse en dispositivos Android compatibles para realizar las pruebas de la demo.

---

## 🧪 Estado actual del proyecto

> **Demo funcional / ambiente controlado**

La aplicación permite demostrar el flujo principal de interacción del comensal y el proceso de generación y seguimiento de pedidos.

---

## ⚠️ Limitaciones actuales

La versión actual corresponde a un prototipo funcional y presenta algunas limitaciones:

- No cuenta con una pasarela de pagos en línea.
- Algunas operaciones todavía utilizan servicios locales simulados.
- La información simulada puede perderse al reiniciar la aplicación.
- La cobertura de entrega se valida mediante códigos postales y no mediante distancia geográfica real.
- No existe integración con servicios de SMS o correo electrónico para notificaciones.
- La aplicación no se encuentra desplegada actualmente como una solución productiva.

Estas características podrán ser ampliadas durante futuras etapas del proyecto.

---

## 🔮 Trabajo futuro

Entre las mejoras consideradas para versiones posteriores se encuentran:

- Integración completa con los microservicios.
- Persistencia de pedidos mediante PostgreSQL.
- Autenticación mediante backend.
- Validación geográfica de cobertura mediante coordenadas.
- Cálculo de distancia respecto a la taquería.
- Mejoras en las notificaciones de los pedidos.
- Despliegue de los servicios en infraestructura de producción.
- Mejoras en la administración de direcciones.
- Implementación de nuevas promociones.
- Ranking de alimentos basado en las ventas registradas.

---

## 🎓 Contexto académico

Este proyecto fue desarrollado como parte de un trabajo de tesis enfocado en el diseño y desarrollo de una aplicación móvil utilizando una arquitectura basada en microservicios.

El caso práctico corresponde a la taquería **Don Tacos**, permitiendo aplicar los conceptos y tecnologías estudiados a un escenario de negocio real.

El sistema está compuesto principalmente por:

```text
Aplicación móvil para comensales
              ↓
        Microservicios
              ↓
          Base de datos

              ↕

Panel web para la administración
       de la taquería
```

La aplicación móvil representa la interfaz utilizada por los comensales, mientras que el panel administrativo permite gestionar diferentes aspectos de la operación de la taquería.
