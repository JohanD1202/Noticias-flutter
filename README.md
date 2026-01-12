Aplicación móvil de noticias desarrollada en Flutter, siguiendo principios de Arquitectura Limpia y un enfoque modular. Permite consultar las noticias en tiempo real usando NewsAPI, ofreciendo una experiencia moderna, fluida y personalizable

# *Características principales*

# *Consumo de API REST `NewsAPI`*
* Se muestran noticias según la categoria:
  * General
  * Business
  * Science
  * Entertainment
  * Sport
  * Technology
  * Health

# *Búsqueda de noticias*

* La búsqueda está implementada con SearchDelegate y cuenta con:
  * Debounce usando Timer
  * Streams para resultados y loading
  * No ejecuta búsquedas innecesarias

# *Persistencia de datos*
* Tema claro/oscuro persistido con `shared_preferences`
* Noticias guardadas usando `IsarDB`

# *Tecnologías y Arquitectura*
* Flutter
* `Riverpod` para gestión de estado
* Arquitectura Limpia
* API de `NewsAPI` para noticias
* Compartir las noticias con `share_plus`
* Uso de `webview_flutter` para leer las noticias en la web sin salir de la app
* UI Responsiva
* Animaciones fluídas con `Hero`

# Configuración del proyecto

1. Copia el archivo `.env.template` y renómbralo como `.env`
2. Configura tus llaves


https://github.com/user-attachments/assets/7c1a65c8-4054-4b7d-b799-45302775acaf

https://github.com/user-attachments/assets/4d67c77a-8116-405e-b408-9037120b7603

https://github.com/user-attachments/assets/d5d72600-7ce8-48d5-912f-7fefdf1bcaf9

https://github.com/user-attachments/assets/e133011b-0dec-4945-92da-d1075b8eda4d



