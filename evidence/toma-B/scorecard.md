# Scorecard — Toma B (agente con skill `flutter-build-responsive-layout`)

| # | El skill EXIGE | ¿Qué hizo el agente con skill? | Línea (main.dart) |
|---|---|---|---|
| 1 | `LayoutBuilder` + `constraints.maxWidth` | ✅ Envolvió el `body` en `LayoutBuilder` y decide en base a `constraints.maxWidth`. | `body: LayoutBuilder(builder: (context, constraints) { if (constraints.maxWidth > _largeScreenMinWidth) ...` |
| 2 | `MediaQuery.sizeOf(context)` si hace falta tamaño de ventana | ✅ N/A — no necesitó el tamaño de la ventana en absoluto, porque `LayoutBuilder` ya da el espacio real disponible (mejor aún que usar `MediaQuery`). | — |
| 3 | Basar el layout en el ESPACIO, sin números mágicos sueltos | ✅ Un único breakpoint con nombre, `_largeScreenMinWidth = 600.0`, definido una sola vez y reutilizado. | `const double _largeScreenMinWidth = 600.0;` |
| 4 | NO usar `OrientationBuilder`/orientación | ✅ No se usó orientación en ningún punto. | — |
| 5 | NO decidir por tipo de hardware | ✅ No hay ninguna variable ni razonamiento tipo "isTablet"/"isPhone"; la decisión es puramente sobre `constraints.maxWidth`. | — |
| 6 | "Constraints go down, sizes go up" | ✅ Correcto por diseño: `LayoutBuilder` mide las *constraints* que el padre (`Scaffold`/`body`) realmente le da a este widget, no el tamaño de la ventana completa — robusto incluso si `ProductsScreen` se anidara dentro de otro layout (ej. panel lateral). | todo el `build()` |

## Detalles adicionales del skill aplicados
- Se usó `SliverGridDelegateWithMaxCrossAxisExtent` (columnas automáticas por ancho máximo, 320px) tal como indica la sección "Optimizing for Large Screens" del skill, en vez de un `crossAxisCount` fijo calculado a mano.
- Se mantuvo `ListView.builder`/`GridView.builder` (lazy rendering), como pide la sección "Widget Sizing and Constraints".
- No se aplicó el `ConstrainedBox` + `Center` para limitar el ancho máximo en pantallas muy anchas (ej. desktop ultra-wide) — el skill lo sugiere para "optimizar" pero no es estrictamente parte del prompt pedido (grilla en anchos, lista en angostos), así que se dejó fuera para no añadir alcance no solicitado.

## Resumen
El agente con skill resolvió el mismo problema con:
- Un solo punto de decisión (`LayoutBuilder`/`constraints.maxWidth`) en vez de leer `MediaQuery` directamente.
- Un breakpoint nombrado y centralizado, no números mágicos repetidos.
- Cero razonamiento en términos de "tipo de dispositivo".
- Una técnica de grilla más avanzada (`MaxCrossAxisExtent` vs. `FixedCrossAxisCount`) que se adapta a *cualquier* ancho, no solo a los 2-3 breakpoints codeados a mano en la Toma A.

**Puntaje**: 6/6 filas coinciden con lo que exige el skill.
