# funcio_permuta_1

Aplicación en Flutter para una **tienda de productos**, con categorías **Body Care**, **Skin Care** y **High Care**.

---

## Credenciales por defecto

Para probar la aplicación, puedes usar las siguientes credenciales:

- **Usuario:** admin@example.com
- **Contraseña:** admin123

> Estas credenciales son solo para pruebas.

---

## Funcionalidades principales

- Registro e inicio de sesión de usuarios.
- Gestión de perfil: editar información, cambiar contraseña, subir imagen de perfil.
- Navegación principal con **Bottom Navigation Bar**:
    - Productos por categorías.
    - Carrito de compras: añadir, eliminar o modificar productos.
    - Historial de pedidos.
- Finalización de compra: introducir teléfono y dirección, resumen de precios y confirmación de pedido.
- Pantallas informativas:
    - Términos y condiciones.
    - Política de privacidad.
    - Información de la app.

---

## Arquitectura básica

- Flutter + Dart.
- Páginas principales en `pages/`.
- Modelos en `models/` (User, Product, Order).
- Repositorios simulados en `services/` para manejar usuarios, carrito y pedidos.
- Recursos estáticos (imágenes) en `assets/images/`.

---

## Estructura de carpetas
lib/
   core/ # Colores, estilos y constantes
   models/ # User, Product, Order
   pages/ # Pantallas de la app
   services/ # Repositorios simulados
assets/
   images/ # Imágenes de la app
