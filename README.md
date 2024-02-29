# Weather Forecasts App
Esta aplicación de pronóstico del tiempo te permite obtener información meteorológica para diversas ciudades tales como, temperatura máximas y mínimas. Utiliza dos servicios para obtener los datos: Reservamos Service para obtener las coordenadas de las ciudades y Open Weather Service para obtener el pronóstico del tiempo.

## Funcionalidades
- **Consulta de Pronóstico del Tiempo:** Ingresa una o varias ciudades para obtener el pronóstico del tiempo.
- **Búsqueda de Ciudades:** Puedes buscar ciudades por nombres completos (por ejemplo, "Monterrey") o abreviados (por ejemplo, "MTY").
- **Manejo de Errores:** Si hay un error de comunicación con alguna de las APIs, se mostrará un mensaje de error para informar al usuario.

## Instalación
1. Clonar el Repositorio:
```bash
git clone https://github.com/tu_usuario/weather_forecasts_app.git
```
2. Instalar Dependencias:

```bash
cd weather_forecasts_app
bundle install
```

3. Ejecutar la Aplicación:
```bash
rails server
```

## Uso
1. Visita la página de inicio *(/weather_forecasts/new)* para ingresar las ciudades de las que deseas obtener el pronóstico del tiempo.
2. Ingresa una o varias ciudades **separadas por comas** en el campo de entrada. Ejemplo: "Guadalajara, MTY, Cancun"
3. Haz clic en el botón "Submit" para obtener el pronóstico del tiempo.
4. Se mostrará automáticamente el pronóstico del tiempo para las ciudades ingresadas en la página de resultados *(/weather_forecasts)*.

- Nota: Antes de acceder a la página de resultados *(/weather_forecasts)*, asegúrate de haber ingresado al menos una ciudad en la página de inicio *(/weather_forecasts/new)*. De lo contrario, se te redirigirá de vuelta a la página de inicio con un mensaje de alerta.

## Requisitos
- Ruby 2.7.4
- Ruby on Rails 6.1.7.7

## Pruebas
Se han incluido pruebas funcionales para el controlador WeatherForecasts para garantizar el correcto funcionamiento de la aplicación.

Para ejecutar las pruebas, puedes usar el siguiente comando:
```bash
rails test
```

## Contribuciones
Las contribuciones son bienvenidas. Si encuentras errores o mejoras potenciales, ¡abre un issue o envía una pull request!

Desarrollado por: [Serlle Rosales] - [https://github.com/Serlle]