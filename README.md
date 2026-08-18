# Cobox Studio

Panel de gestión de proyectos para el equipo de Cobox, sincronizado en tiempo real entre todos los dispositivos vía Supabase.

## Desplegar en Netlify

1. Sube esta carpeta a un repositorio de GitHub (todo el contenido, tal cual).
2. En Netlify: **Add new site → Import an existing project → conecta el repo de GitHub**.
3. Configuración de build:
   - **Build command:** dejar vacío
   - **Publish directory:** `.` (la raíz del repo)
4. Deploy. No hace falta nada más — es HTML/JS puro, sin backend propio, todo se conecta directo a Supabase desde el navegador.

## Ya está conectado a Supabase

El archivo `index.html` ya trae la URL del proyecto de Supabase y la clave pública ("publishable key") de Cobox Studio. Esa clave es pública **a propósito** — es normal y seguro que quede visible en el código.

⚠️ **Modelo de seguridad:** no hay código de acceso ni login de ningún tipo — cualquiera que abra el link de la app entra directo y puede ver/editar todo. La única protección es que el link no se comparta fuera del equipo. Las políticas de la base de datos (Row Level Security) solo permiten leer/escribir esa fila exacta del tablero, así que aunque alguien encuentre la clave pública, no puede listar ni tocar nada más — pero el link en sí debe tratarse como privado.

Si en algún momento necesitas recrear todo desde cero en un proyecto de Supabase nuevo:

1. Crea el proyecto en [supabase.com](https://supabase.com).
2. Corre el archivo `supabase-setup.sql` de esta carpeta en el SQL Editor.
3. Copia el **Project URL** y la **clave "publishable"** (Settings → API) y reemplázalas en `index.html`, cerca del inicio de la etiqueta `<script>`, en las constantes `SUPABASE_URL` y `SUPABASE_KEY`.

## Cómo funciona la sincronización

- Cualquiera abre el link → clic en "Entrar al estudio" → ya está dentro del tablero. Sin código, sin correo, sin nada que recordar.
- Los cambios se guardan automáticamente ~0.5 segundos después de editar, y se transmiten en tiempo real a todos los que tengan el tablero abierto (sin recargar la página).
- El botón "Actualizar / Sincronizar" fuerza una relectura completa desde la nube.

## Fotos (Moodboard, Antes/Después)

Las imágenes no se suben dentro de la app — se pega el link de la carpeta de Drive correspondiente en el campo de cada sección, y desde ahí se abren.
