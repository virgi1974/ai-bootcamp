# Constitución del bootcamp

Reglas fijas que toda spec y todo plan heredan. Si un hito necesita romper una, lo dice en su SPEC.md.

1. Stack por defecto: Python 3.12, FastAPI, Pydantic v2, SQLAlchemy, PostgreSQL, Alembic, Docker Compose. `uv` para dependencias.
2. Cada repo tiene `Makefile` con `up`, `test`, `evals` (si aplica) y `deploy`, y un `README.md` con qué hace, cómo se ejecuta y el coste mensual real.
3. Tests sin modelo para todo lo determinista; evals con dataset versionado para todo lo que pasa por un modelo. Nada se da por correcto sin uno de los dos.
4. Toda llamada a un modelo pasa por una interfaz `Provider` intercambiable; desde H2, por el gateway.
5. Quien revisa no es quien escribe: la revisión la hace un modelo de familia distinta y devuelve hallazgos por severidad, no código.
6. Secretos fuera del repo (`.env` ignorado, secretos de plataforma en la nube). Nunca credenciales reales en fixtures ni en specs.
7. Lo que no está en el criterio de terminado del roadmap no bloquea el cierre del hito.
8. Presupuesto: cuota diaria de modelos acordada en cada spec; alarma de coste antes de cualquier despliegue en la nube.
