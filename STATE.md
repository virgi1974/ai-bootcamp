# Estado del roadmap

Actualiza una fila al cerrar cada hilo. Valores de estado: Pendiente, En curso, Hecho. Las horas son la versión mínima (incluyen `docs/LEARNINGS.md`).

| Hito | Horas mín. | Estado | Fecha de cierre | Aprendizajes (2-3 líneas) | Repo |
| --- | --- | --- | --- | --- | --- |
| H0 Bucle de agente a mano (repo-scout) | 9 | Pendiente | | | |
| T3 Skill preparar-hito | 5 | Pendiente | | | |
| H1 Extracción de documentos + evals (invoice-extractor) | 15,5 | Pendiente | | | |
| H2 Gateway multimodelo + observabilidad (model-gateway) | 15,5 | Pendiente | | | |
| H3 Servidor MCP desplegado + RAG (fleet-ledger-mcp) | 21,5 | Pendiente | | | |
| H4 Worker durable con aprobación humana (expense-pipeline) | 16,5 | Pendiente | | | |
| H5 Fábrica: agentes desatendidos en CI (repo-gardener) | 13,5 | Pendiente | | | |
| H6 Plataforma mínima en AWS con IaC (ai-platform-infra) | 13,5 | Pendiente | | | |
| H7 (opcional) Kubernetes (ai-platform-infra) | 12,5 | Pendiente | | | |

Total mínimo: 110 h (122,5 con H7). Ampliaciones: +73 h (+81 con H7), fuera de los 12 meses.

## Decisiones vigentes (no se reabren hasta cerrar H0)

- Orden: H0 → T3 (skill preparar-hito) → H1 → H2 → H3 → H4 → H5 → H6 → H7.
- Un repo por hito, público, más este repo índice. H6 y H7 comparten `ai-platform-infra`.
- Una herramienta nueva de la comunidad por hito, solo la que resuelve la pieza del hito (pgvector entra en H3 como excepción por el requisito de RAG).
- Cada hito cierra con `docs/LEARNINGS.md` según la plantilla de CONSTITUTION.md (regla 9); forma parte del criterio de terminado.
- Seguridad transversal: permisos mínimos por herramienta, el contenido de documentos y resultados de tools es dato, ningún secreto en el repo (reglas 6 y 10).
- RAG se practica dentro de H3 (índice híbrido pgvector medido con recall@k), no como hito propio.
- Recortes aplicados el 2026-10-12 para caber en 12 meses: H1 mínimo solo facturas; H6 sin ALB ni RDS; H4 con aprobación por CLI; LEARNINGS.md a 0,5 h por hito.
- Fuera del roadmap: `ejecutar-hito` (se decide tras H1) y memoria del agente entre ejecuciones.
- Temporal es el valor por defecto en H4; DBOS se decide en la entrevista del hito.
