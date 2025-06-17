
## ✅ Requerimientos Funcionales

### 1. Registro e inicio de sesión
- Autenticación por correo, número telefónico o redes sociales (Google/Facebook).
- Recuperación de contraseña.

### 2. Perfil del usuario
- Datos personales básicos (nombre, correo, foto, teléfono).
- Métodos de pago asociados.
- Historial de alquileres.

### 3. Geolocalización y mapa interactivo
- Mostrar estaciones de bicicletas cercanas o ubicaciones de bicicletas disponibles.
- Rutas sugeridas (opcional).

### 4. Alquiler de bicicleta
- Escaneo de código QR o NFC para desbloquear la bicicleta.
- Registro del inicio del viaje.
- Cronómetro y tarifa en tiempo real.

### 5. Finalizar viaje
- Registro de ubicación al devolver la bicicleta.
- Cálculo automático del costo.
- Notificación de viaje finalizado.

### 6. Notificaciones
- Push notifications para recordar la finalización de viaje, promociones, etc.
- Confirmaciones de alquiler y pago.

### 7. Soporte y reportes
- Reporte de bicicletas en mal estado.
- Acceso a soporte en tiempo real o a través de un formulario.

### 8. Roles de usuario
- Rol de administrador para gestión de flota, reportes y monitoreo.
- Rol de usuario final para el uso estándar de la aplicación.

---

## ⚙️ Requerimientos No Funcionales

- **Disponibilidad:** Alta disponibilidad, sobre todo en horarios pico.
- **Usabilidad:** Interfaz amigable, sencilla y adaptada a distintos tipos de usuario.
- **Rendimiento:** Baja latencia en operaciones clave (alquiler, geolocalización).
- **Escalabilidad:** Soporte para crecer en usuarios y ubicaciones sin rediseñar todo.

---

## 🚲 Opciones a futuro

- **Pagos:** Integración con plataformas como Stripe, PayPal, Google Pay, etc. y facturación automática.
- **Panel administrativo web** para monitorear el estado de la flota.
- **Gamificación opcional:** premios por número de viajes, retos mensuales, etc.
- **Estadísticas personales:** distancia recorrida, emisiones de CO₂ ahorradas, etc.
- **Modo offline:** permitir continuar un viaje si se pierde la conexión.
