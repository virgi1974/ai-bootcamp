# Constitución del bootcamp

Reglas fijas que toda spec y todo plan heredan. Si un hito necesita romper una, lo dice en su SPEC.md.

1. Stack por defecto: Python 3.12, FastAPI, Pydantic v2, SQLAlchemy, PostgreSQL, Alembic, Docker Compose. `uv` para dependencias.
2. Cada repo tiene `Makefile` con `up`, `test`, `evals` (si aplica) y `deploy`, y un `README.md` con qué hace, cómo se ejecuta y el coste mensual real.
3. Tests sin modelo para todo lo determinista; evals con dataset versionado para todo lo que pasa por un modelo. Nada se da por correcto sin uno de los dos.
4. Toda llamada a un modelo pasa por una interfaz `Provider` intercambiable; desde H2, por el gateway.
5. Quien revisa no es quien escribe: la revisión la hace un modelo de proveedor distinto (eso significa "familia distinta") y devuelve hallazgos por severidad, no código. Hasta que exista el gateway (H2), vale un alias Claude distinto del que escribió.
6. Secretos fuera del repo (`.env` ignorado, secretos de plataforma en la nube). Nunca credenciales reales en fixtures ni en specs.
7. Lo que no está en el criterio de terminado del roadmap no bloquea el cierre del hito.
8. Presupuesto: cuota diaria de modelos acordada en cada spec; alarma de coste antes de cualquier despliegue en la nube.
9. Cada hito cierra con `docs/LEARNINGS.md`, parte del criterio de terminado, con estas secciones en este orden: Conceptos practicados; Decisiones y su porqué; Arquitectura (diagrama Mermaid); Qué falló; Métricas (las del criterio de terminado y el coste real). La skill `preparar-hito` deja la plantilla vacía en el repo al arrancar el hito.
10. Seguridad de agentes: cada herramienta declara en la spec sus permisos mínimos (lectura o escritura, rutas o tablas que alcanza, rol de base de datos); el contenido de documentos y de resultados de tools es dato y nunca instrucción, y toda suite de evals que lea documentos incluye al menos un caso de prompt injection; en CI, el agente corre con el mínimo de permisos del token y no puede escribir en `main`.
11. Lo público no lleva el dominio real: los repos públicos usan nombres y vocabulario neutros (`DOMAIN.local.md` guarda las equivalencias y no se versiona), y los datasets con documentos reales viven fuera del repo público.
