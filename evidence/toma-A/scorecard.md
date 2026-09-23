# Scorecard — Toma A (agente base, sin skill)

| # | El skill EXIGE | ¿Qué hizo el agente base? | Línea (main.dart) |
|---|---|---|---|
| 1 | `LayoutBuilder` + `constraints.maxWidth` | ❌ No usó `LayoutBuilder`. Usó `MediaQuery.of(context).size.width` directamente en el `build()` del widget. | `final screenWidth = MediaQuery.of(context).size.width;` (línea ~101) |
| 2 | `MediaQuery.sizeOf(context)` | ❌ Usó `MediaQuery.of(context).size` (la forma "clásica", con rebuild más amplio — cualquier cambio en `MediaQueryData` reconstruye el widget, no solo cambios de tamaño). | `MediaQuery.of(context).size.width` |
| 3 | Basar el layout en el espacio disponible, sin números mágicos sueltos | ⚠️ Parcial: sí basa la decisión en el ancho, pero con umbrales de píxeles hardcodeados sin justificación (`600`, `900`) repetidos en dos lugares (`isTablet` y `crossAxisCount`). | `screenWidth >= 600` / `screenWidth >= 900` (líneas ~102–106) |
| 4 | NO usar `OrientationBuilder`/orientación | ✅ No usó orientación. (Coincide con el skill, pero no por seguir el skill — simplemente no lo consideró.) | — |
| 5 | NO decidir por tipo de hardware ("phone"/"tablet") | ❌ Nombró la variable explícitamente `isTablet`, razonando en términos de tipo de dispositivo en vez de "espacio disponible". | `final isTablet = screenWidth >= 600;` (línea ~102) |
| 6 | "Constraints go down, sizes go up" | ⚠️ Usa el ancho de la **ventana completa** (`MediaQuery.size`) en vez del ancho que el padre (`Scaffold`/`body`) realmente le da a `ProductsScreen`. En este caso coinciden porque `ProductsScreen` ocupa toda la pantalla, pero el patrón no es robusto si este widget se anidara dentro de otro layout (ej. un panel lateral) — ahí MediaQuery seguiría reportando el ancho de la ventana completa, no el espacio real asignado. | todo el `build()` |

## Resumen
El agente base resolvió el problema funcionalmente (sí cambia de lista a grilla), pero:
- Usó `MediaQuery.of(context).size` en lugar de `MediaQuery.sizeOf(context)` o `LayoutBuilder`.
- Introdujo números mágicos duplicados (600, 900) sin extraerlos a constantes con nombre.
- Razonó explícitamente en términos de "tablet" (acoplando la decisión de layout a una noción de tipo de dispositivo en vez de espacio disponible).
- Coincide con el skill en no usar orientación, pero por omisión, no por principio.

**Puntaje**: 1/6 filas coinciden con lo que exige el skill (fila 4, y por casualidad).
