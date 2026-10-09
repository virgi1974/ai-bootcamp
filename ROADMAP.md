# Roadmap: de usar agentes a construir sistemas con IA (backend)

Oct 8, 2026 

## 0. Cómo usar este documento

Este documento es el contrato entre hilos: cada hito se ejecuta en un hilo nuevo de Claude Code, y al cerrarlo actualizas una fila de la tabla de estado. Nada más se edita salvo que una decisión cambie.

1. Para empezar un hito, abre un hilo nuevo y pega su prompt de arranque (sección 3). Cuando exista la skill `preparar-hito` (sección 7), el prompt se reduce a `/preparar-hito H<n>`.
2. El hilo produce una spec y un plan; el código vive en un repo público propio por hito (o un monorepo `ai-bootcamp` con una carpeta por hito, si prefieres un solo portfolio).
3. Un hito cuenta como hecho cuando se cumple su criterio de terminado, no cuando el código "funciona". La ampliación opcional no bloquea el siguiente hito.
4. Si vas más lento, el orden no cambia: solo se desplaza la fecha. Si en algún momento sobra tiempo, haz una ampliación, no un hito nuevo.
5. Regla de dominios: lo de la flota se desarrolla y despliega con tu GitHub personal, tus créditos de API y tu Ollama; nunca con la cuenta de Fever. Lo de Fever (sección 6) usa la cuenta de Fever y solo toca repos y procesos del equipo. Excepción acordada el 2026-10-09: el setup genérico (skill preparar-hito, repo índice ai-bootcamp, H0) se hace en el portátil de trabajo con la cuenta de Fever; para ello ROADMAP.md se exporta con términos neutros (flota, ledger, documentos de operación), los hitos de dominio (H1, H3, H4) se ejecutan con login personal o API key personal, y los secretos del dominio no se guardan en ese equipo.

**Por dónde empezar y en qué repos** (revisado el 2026-10-09)

- H0 primero, en un repo nuevo: cero dependencias, 7 h, y produce el bucle que reutilizan todos los demás hitos.
- W1 (Fever) justo después y antes de H1: 4-6 h, usa herramientas que ya tienes (skills, Cowork, Slack, repos del equipo), da visibilidad pronto y resuelve cuanto antes la duda de permisos con el admin.
- H1 en el dominio flota: ahí tienes datos reales (fotos de contador del vehículo, tickets de plataforma A, facturas) y una necesidad real; es el único sitio donde las evals tienen verdad de referencia propia.
- Repos: uno dedicado por hito, público, con su CI y su despliegue, más un repo índice `ai-bootcamp` con `ROADMAP.md`, `STATE.md` y enlaces; es lo que lee la skill `preparar-hito`. El monorepo solo si quieres un único README de portfolio; cuesta más en CI y despliegue por hito.
- Orden revisado: H0 → W1 → H1 → H2 → W2 (en paralelo con H2-H3) → H3 → H4 → H5 → H6 → H7.

**Radar semanal** (del hilo T2, 2026-10-09): una routine los viernes con cuenta personal que produce 20 líneas en seis bloques fijos: novedades para H0-H7, releases de lo que ya usas (Agent SDK, MCP SDK, LiteLLM, DBOS o Temporal), patrones nuevos, descartados, decisión y no confirmado. Criterio de inclusión: resuelve un problema de un hito, tiene actividad verificable en los últimos 90 días y no solapa con algo ya evaluado. Las cifras de estrellas no se usan como señal: la primera ejecución las leyó mal.

**Tabla de estado** (actualízala tú al cerrar cada hilo; valores de estado: Pendiente, En curso, Hecho)

| Hito | Estado | Fecha de cierre | Aprendizajes (2-3 líneas) | Repo |
| --- | --- | --- | --- | --- |
| H0 Bucle de agente a mano | Pendiente |  |  |  |
| H1 Extracción de facturas + evals | Pendiente |  |  |  |
| H2 Gateway multimodelo + observabilidad | Pendiente |  |  |  |
| H3 Servidor MCP desplegado | Pendiente |  |  |  |
| H4 Worker durable con aprobación humana | Pendiente |  |  |  |
| H5 Fábrica: agentes en CI y routines | Pendiente |  |  |  |
| H6 Plataforma mínima en AWS con IaC | Pendiente |  |  |  |
| H7 (opcional) Kubernetes | Pendiente |  |  |  |
| W1 Victoria rápida en Fever | Pendiente |  |  |  |
| W2 Piloto AGENTS.md | Pendiente |  |  |  |

## 1. Punto de partida y competencias objetivo

El hueco a cerrar no es de ML sino de ingeniería de sistemas no deterministas: el mercado pide backend Python con agentes, evals y observabilidad, y tú ya tienes el backend. En un estudio de 3.647 ofertas de 198 empresas (datos de 2026-08-05) aparecen APIs/backend en el 82% de las empresas, agentes en el 81%, observabilidad en el 78%, evals en el 68% y RAG solo en el 40%; el ML clásico (entrenamiento distribuido, 35%) queda por debajo ([aijobprep](https://aijobprep.app/ai-engineer-skills), 2026-08-05). Eso confirma el mapa y las 17 ofertas de tu análisis previo.

**Dónde estás hoy (lo que me has dicho)**

- Avanzado como usuario: varias sesiones de Claude Code en paralelo, Cowork para procesos personales.
- Principiante como constructor: una integración de API en un backend; nunca un bucle de agente, herramientas con contrato, evals, servidor MCP ni worker agéntico.
- Ollama y OpenCode instalados, apenas usados, lentos.

**Competencias objetivo, ligadas al mapa y a las ofertas**

| Competencia | Pieza del mapa | Señal en ofertas (empresas que la mencionan, mismo estudio) | Hito que la cubre |
| --- | --- | --- | --- |
| Bucle de agente y herramientas con contrato (el "harness") | 1. Dentro del producto | Agentes 81% | H0, H1 |
| Evals de comportamiento probabilístico | Plataforma de agentes | Evals 68%; "evaluar y mejorar calidad del modelo" 87% | H1, H5 |
| Evaluación de soluciones y revisión cruzada: no dar por buena una respuesta; otro modelo revisa lo que uno implementa | Plataforma de agentes / fábrica | Mismo 87%; revisión por agente en Stripe Minions y Ramp Inspect (tu mapa) | H1, H5, skill `preparar-hito` |
| Extracción de documentos con modelos | 1 y 3 | Se pide como "LLMs en producción", no como OCR | H1 |
| Gateway multimodelo, fallback, coste, modelos locales | 5. Gateway | Claude API 38%, OpenAI API 26%, Gemini 15%; vLLM 19%; Ollama no entra en el top 40 | H2 |
| Observabilidad de ejecuciones | Plataforma de agentes | Observabilidad 78%; OpenTelemetry/Grafana 16% | H2, H6 |
| Servidor MCP con OAuth | 2. Interfaz para agentes externos | MCP 29% | H3 |
| Ejecución durable y aprobación humana | 3. Workers asíncronos | Temporal 16%; sistemas distribuidos 62% | H4 |
| Fábrica: agentes en CI y en la nube; memoria del agente entre ejecuciones | 4. Fábrica de desarrollo | CI/CD 54%; Claude Code 20% | H5 (memoria como ampliación) |
| Despliegue: Docker, IaC, AWS, Kubernetes | Transversal | AWS 61%, Kubernetes 60%, Docker 47%, Terraform 37% | H3, H6, H7 |

**Dos matices que cambian tus supuestos**

1. Multiproveedor sí; modelos locales, menos de lo que pensabas. Las ofertas nombran varias APIs de modelo (Claude, OpenAI, Gemini) y guías de contratación citan la abstracción multiproveedor como prueba de entrevista ([ayautomate](https://www.ayautomate.com/blog/ai-engineer-skills-2026), 2026). Lo que se pide en "modelos locales" es servirlos con vLLM o similar (inferencia optimizada, 57%), no Ollama. Conclusión: Ollama vale como proveedor barato de desarrollo y como práctica de "el mismo código con otro backend"; no lo trates como competencia de portfolio en sí misma.
2. Las evals pesan más que el RAG. El plan no incluye RAG como hito propio; aparece como herramienta dentro de otros hitos si hace falta.

## 2. Roadmap en tabla resumen

Siete hitos obligatorios suman 91 h de versión mínima; a 3,5 h/semana son 26 semanas de construcción, y con un 40% de lectura y fricción quedan en unos 9 meses. Las ampliaciones (+66 h) y el hito opcional de Kubernetes llevan el total a los 12 meses. Cabe sin recortar.

| Hito | Pieza del mapa | Proyecto | Horas mín. | Ampliación | Escalón de despliegue |
| --- | --- | --- | --- | --- | --- |
| H0 | Bucle de agente + herramientas con contrato | `repo-scout`: agente CLI que responde preguntas sobre un repo con 3 herramientas (listar, leer, grep) | 7 | +4 (Ollama como segundo proveedor) | 0 Local |
| H1 | Extracción de documentos + evals | `invoice-extractor`: facturas de gasto de la flota a JSON validado, con dataset y suite de evals | 14 | +10 (mensajes de WhatsApp como segundo documento; juez LLM) | 0 Local |
| H2 | Gateway multimodelo + observabilidad y coste | `model-gateway`: proxy con Anthropic, un proveedor OpenAI-compatible y Ollama; fallback, cuotas, trazas y coste por petición | 12 | +8 (caché semántica; panel de coste) | 0 Local |
| H3 | Servidor MCP (interfaz para agentes externos) | `fleet-ledger-mcp`: herramientas y recursos de lectura sobre la base de ganancias, transporte HTTP, autenticación | 12 | +10 (OAuth 2.1 con un IdP) | 1 PaaS (Fly.io) |
| H4 | Worker asíncrono, ejecución durable, aprobación humana | `expense-pipeline`: cola → extracción (H1) → clasificación → revisión humana de lo dudoso → subida determinista a la asesoría y al Excel | 18 | +12 (reintentos con compensación; panel de revisión) | 1 PaaS o 1b VPS |
| H5 | Fábrica: agentes desatendidos en CI y routines | `repo-gardener`: claude-code-action en PR + workflow programado que ejecuta las evals de H1 y abre PR con el informe; Agent SDK como worker por cron | 12 | +8 (routine con conectores; agente de triage de issues) | CI (GitHub Actions) |
| H6 | Plataforma de agentes mínima en AWS con IaC | Redespliegue de `model-gateway` + `fleet-ledger-mcp` en ECS Fargate con Terraform; secretos, IAM, alarmas de coste | 16 | +10 (Temporal y worker en AWS; CI de infraestructura) | 2 AWS |
| H7 (opcional) | Operación en Kubernetes | El mismo stack en k3s con Helm chart propio y rollout | 12 | +8 (HPA; GitOps con Argo CD) | 3 Kubernetes |
| Total |  |  | 91 (103 con H7) | +66 (+74) |  |

**Comprobación de cobertura** (punto 4 de la tarea): bucle y contratos → H0; evals → H1 y H5; servidor MCP → H3; worker durable con aprobación → H4; extracción con modelos → H1; gateway multimodelo con Ollama → H2 (ampliación de H0 lo adelanta); observabilidad y coste → H2 y H6; fábrica desatendida → H5. Todas cubiertas.

## 3. Ficha por hito

Cada ficha tiene los mismos campos. La política de delegación de cada prompt de arranque usa tres niveles: `haiku` para listar y leer, `sonnet` para investigar documentación y redactar, y el modelo de la sesión (`inherit`, hoy Opus o Fable) para diseño y revisión. Verifica siempre el modelo real con `/tasks` mientras corre el subagente.

### H0. Bucle de agente a mano: `repo-scout`

- **Pieza:** bucle de agente y herramientas con contrato (dentro del producto).
- **Qué aprender:** la anatomía del bucle (modelo → tool\_use → ejecutar → tool\_result → repetir hasta parar), el esquema JSON de cada herramienta y el criterio de parada. Recursos: [Building effective agents](https://www.anthropic.com/research/building-effective-agents) (Anthropic, dic. 2024, conceptual); [Tool use overview](https://docs.claude.com/en/docs/agents-and-tools/tool-use/overview) (docs oficiales); [Writing tools for agents](https://www.anthropic.com/engineering/writing-tools-for-agents) (Anthropic, 2025); tu propio documento de "un agente es un servicio cuyo flujo decide un modelo".
- **Proyecto, versión mínima (6-8 h):** CLI en Python sin framework: `anthropic` SDK, bucle propio, tres herramientas (`list_files`, `read_file`, `grep`) definidas con Pydantic que generan su JSON schema, límite de 15 iteraciones, log de cada llamada a un fichero JSONL. Pregunta de prueba: "¿dónde se valida el NIF en este repo?".
- **Ampliación (+4 h):** mismo bucle contra Ollama (endpoint OpenAI-compatible) con un `Provider` intercambiable; medir latencia y aciertos entre Haiku y un modelo local.
- **Escalón:** 0 Local (sin Docker todavía; `uv` o `venv`).
- **Criterio de terminado:** 5 preguntas sobre un repo de \~50 ficheros contestadas correctamente en menos de 10 iteraciones cada una; el log JSONL muestra las llamadas; `make test` pasa con tests de las tres herramientas (sin modelo).
- **Qué demuestra:** que entiendes el bucle sin esconderlo tras un framework; es la pregunta de entrevista más común en roles Applied AI.
- **Al trabajo:** el mismo bucle con `read_file`/`grep` sobre un repo de Fever es la base del auditor de AGENTS.md (W2, sección 6).
- **Prompt de arranque:**

```markdown
Lee el roadmap (sección 3, H0) en <enlace al doc>. Entrevístame con 3-5 preguntas con respuesta propuesta (repo de prueba, proveedor, estructura) y escribe la spec de `repo-scout` lista para ejecutarla en Claude Code: objetivo, estructura de ficheros, contratos de las 3 herramientas, bucle, logging, tests y criterio de terminado.
<delegacion>
- En paralelo, un subagente `haiku` lista y lee el repo de prueba y devuelve: ficheros clave (máx. 10) + 3 preguntas candidatas de evaluación.
- Un subagente `sonnet` lee la doc de tool use de Anthropic y devuelve: formato exacto de tool_use/tool_result y 3 reglas de diseño de herramientas (máx. 15 líneas).
- Diseño y revisión final en la sesión principal (`inherit`).
- Comprueba en /tasks que cada subagente corre con el modelo pedido; si no, dímelo antes de usar su resultado.
</delegacion>
```

### H1. Extracción de documentos y evals: `invoice-extractor`

- **Pieza:** extracción de documentos con modelos + evals de comportamiento probabilístico + revisión cruzada.
- **Qué aprender:** salida estructurada validada con Pydantic, entrada de PDF e imagen, diseño de un dataset de evaluación, métricas por campo (exactitud, tolerancia numérica), cuándo usar un juez LLM y cómo hacer que un segundo modelo revise al primero. Recursos: [Your AI product needs evals](https://hamel.dev/blog/posts/evals/) (Hamel Husain); [evals-skills](https://github.com/hamelsmu/evals-skills) (Husain, 2026-03-03, skills para que Claude Code te ayude a montar evals); [PDF support](https://docs.claude.com/en/docs/build-with-claude/pdf-support) (docs oficiales); [Evaluating AI Agents](https://www.deeplearning.ai/short-courses/) (DeepLearning.AI, corto) o [promptfoo](https://www.promptfoo.dev/docs/intro) si prefieres evals declarativas; [Inspect AI](https://github.com/UKGovernmentBEIS/inspect_ai) (UK AISI) si quieres un framework de evals de agentes con datasets, scorers y sandboxes (radar T2, 2026-10-09).
- **Proyecto, versión mínima (14 h):** servicio FastAPI + CLI que recibe un documento (PDF o foto) de tres tipos que ya manejas: factura de gasto, foto del contador del vehículo al cierre de turno y ticket de plataforma A (los dos últimos los suben los conductores a los grupos de WhatsApp y tu conexión local ya los descarga). Devuelve el modelo tipado de cada tipo (`Invoice`, `MeterReading`, `plataforma ATicket`); validación determinista por tipo (base+IVA=total ±0,02, NIF válido, totales del turno coherentes con los datos de plataforma A/plataforma B); dataset de 30-40 documentos reales anonimizados con su JSON esperado; `make evals` que imprime exactitud por campo y coste por documento; resultados guardados por versión de prompt y modelo. Sustituye al agente con OCR que tienes hoy.
- **Ampliación (+10 h):** revisión cruzada: un segundo modelo (otra familia, o local) revisa las extracciones de confianza baja y se mide cuánto corrige; juez LLM para `categoria`; comparación Haiku vs Sonnet vs modelo local de visión en la misma suite.
- **Escalón:** 0 Local, primer `docker-compose.yml` (API + Postgres).
- **Criterio de terminado:** exactitud ≥ 90% en los campos de importe, fecha y NIF/identificador sobre el dataset, por tipo de documento; una tabla de resultados por modelo en el README; un fallo conocido documentado y cubierto por un caso de eval.
- **Qué demuestra:** eval literacy, que las guías de contratación citan como la señal número uno de experiencia real ([digitalapplied](https://www.digitalapplied.com/blog/ai-developer-hiring-skills-that-matter-2026), 2026), y el hábito de no dar por buena la salida de un modelo.
- **Al trabajo:** el harness de evals (dataset + métricas + tabla por versión) se reutiliza tal cual para cualquier prompt del equipo; es lo primero que puedes ofrecer cuando alguien meta IA en un proyecto de Fever.
- **Prompt de arranque:**

```markdown
Lee el roadmap (sección 3, H1) y el estado de H0. Entrevístame (máx. 5 preguntas con propuesta: formatos de factura, dónde están las muestras, categorías de gasto) y escribe la spec de `invoice-extractor` para Claude Code: modelo de datos, pipeline, validación, formato del dataset, métricas, `make evals`, estructura de repo y criterio de terminado.
<delegacion>
- Paralelo: `haiku` inventaría la carpeta de facturas de muestra y devuelve tipos, tamaños y 5 casos difíciles (máx. 20 líneas).
- Paralelo: `sonnet` lee la doc de PDF support y de structured outputs y devuelve límites (tamaño, páginas, coste) y el patrón recomendado (máx. 20 líneas).
- `sonnet` redacta el borrador de spec; la sesión principal (`inherit`) lo revisa contra el criterio de terminado y lo corrige.
- Verifica el modelo de cada subagente en /tasks.
</delegacion>
```

### H2. Gateway multimodelo y observabilidad: `model-gateway`

- **Pieza:** gateway hacia los modelos (enrutado, fallback, cuotas, coste) + observabilidad de ejecuciones.
- **Qué aprender:** qué resuelve un gateway (una URL para N proveedores, claves centralizadas, fallback, límites), trazas con OpenTelemetry y la convención GenAI, coste por token y por petición. Recursos: [LiteLLM proxy](https://docs.litellm.ai/docs/simple_proxy) (referencia de qué hace un gateway); [OpenTelemetry GenAI semantic conventions](https://opentelemetry.io/docs/specs/semconv/gen-ai/); [Langfuse self-hosting](https://langfuse.com/self-hosting) o [Arize Phoenix](https://docs.arize.com/phoenix) como backend de trazas; [Envoy AI Gateway](https://aigateway.envoyproxy.io/) para ver la versión "infra" (CNCF, ago. 2025, citada en tu mapa).
- **Proyecto, versión mínima (12 h):** decisión primero: desplegar LiteLLM y configurarlo, o escribir un proxy propio en FastAPI. Recomendación: proxy propio y pequeño (es portfolio) que expone `/v1/chat/completions`, enruta por nombre lógico (`cheap`, `smart`, `local`) a Anthropic, un OpenAI-compatible y Ollama, hace fallback si el primero falla, aplica una cuota diaria en euros y emite una traza OTel por petición con tokens y coste. H0 y H1 pasan a llamar al gateway.
- **Ampliación (+8 h):** caché exacta y semántica; panel de coste por proyecto en Grafana o en Langfuse.
- **Escalón:** 0 Local, Compose con gateway + Ollama + Langfuse + Postgres (Langfuse y no Phoenix: es lo que usa Fever, según el inventario T1).
- **Criterio de terminado:** `invoice-extractor` ejecuta su suite de evals a través del gateway; al apagar el proveedor primario el fallback entra sin cambiar código del cliente; cada petición aparece en el backend de trazas con coste; la cuota diaria corta las peticiones al superarse.
- **Qué demuestra:** multiproveedor y modelos locales como skill (lo que piden las ofertas), observabilidad (78% de empresas) y conciencia de coste.
- **Al trabajo:** Fever ya tiene gateway LiteLLM con clave y presupuesto por agente y trazas en Langfuse (inventario T1, 2026-10-09); lo que llevas es saber pedir una clave con presupuesto para tu servicio y leer sus trazas, no proponer el gateway.
- **Prompt de arranque:**

```markdown
Lee el roadmap (H2) y el estado de H0-H1. Entrevístame (máx. 4 preguntas con propuesta: proxy propio o LiteLLM, backend de trazas, cuota) y escribe la spec de `model-gateway` para Claude Code: API, tabla de enrutado, fallback, cuota, instrumentación OTel, Compose, tests con proveedores simulados y criterio de terminado.
<delegacion>
- Paralelo: `haiku` lee H0 y H1 y devuelve los puntos de llamada al modelo que hay que redirigir (fichero:línea, máx. 15).
- Paralelo: `sonnet` lee la doc de LiteLLM y de OTel GenAI y devuelve: 5 funciones mínimas de un gateway y los atributos OTel obligatorios (máx. 25 líneas).
- `sonnet` redacta la spec; `inherit` revisa el diseño de fallback y cuota.
- Verifica modelos en /tasks.
</delegacion>
```

### H3. Servidor MCP desplegado: `fleet-ledger-mcp`

- **Pieza:** interfaz para agentes externos (MCP con audiencia propia).
- **Qué aprender:** las tres primitivas (tools, resources, prompts), transporte stdio frente a HTTP streamable, autenticación y el Inspector. Recursos: [Introduction to MCP](https://anthropic.skilljar.com/introduction-to-model-context-protocol) y [MCP: Advanced Topics](https://anthropic.skilljar.com/) (Anthropic Academy, gratis, Python); [especificación MCP](https://modelcontextprotocol.io/specification) (revisión vigente, incluye autorización); [python-sdk](https://github.com/modelcontextprotocol/python-sdk); [MCP: Build Rich-Context AI Apps](https://www.deeplearning.ai/courses/mcp-build-rich-context-ai-apps-with-anthropic) (DeepLearning.AI, con despliegue remoto).
- **Proyecto, versión mínima (12 h):** servidor MCP en Python sobre la base de ganancias de la flota: tools de lectura (`earnings_by_driver`, `earnings_by_period`, `pending_invoices`), un resource por conductor, un prompt de "resumen mensual"; transporte HTTP streamable con bearer token; probado con el Inspector y conectado a Claude Desktop y a Claude Code; desplegado en Fly.io con Dockerfile y secretos de plataforma.
- **Ampliación (+10 h):** OAuth 2.1 con Keycloak (el IdP del gateway MCP de Fever, con RBAC por tool) siguiendo la sección de autorización de la especificación; una tool de escritura con confirmación.
- **Escalón:** 1 PaaS (Fly.io). Primer despliegue en la nube del plan.
- **Criterio de terminado:** desde Claude Desktop, la pregunta "¿cuánto facturó cada conductor el mes pasado?" se responde con datos reales vía MCP contra la URL pública; sin token la petición falla con 401; README con el diagrama cliente-servidor y el coste mensual.
- **Qué demuestra:** MCP (29% de las ofertas) en su forma de producción (remoto y autenticado), no el tutorial local.
- **Al trabajo:** el patrón "MCP de lectura sobre un dominio" es exportable a cualquier servicio de Fever (consultas de soporte, estado de un proceso) y lo consume Claude Code o Cowork sin cambiar el servicio.
- **Prompt de arranque:**

```markdown
Lee el roadmap (H3) y el estado de H0-H2. Entrevístame (máx. 4 preguntas con propuesta: esquema de la base de ganancias, tools de lectura, autenticación) y escribe la spec de `fleet-ledger-mcp` para Claude Code: primitivas, transporte, auth, Dockerfile, despliegue en Fly.io, pruebas con el Inspector y criterio de terminado.
<delegacion>
- Paralelo: `haiku` lee el esquema de la base de ganancias y devuelve tablas, columnas clave y 5 consultas útiles (máx. 20 líneas).
- Paralelo: `sonnet` lee la especificación MCP (transportes y autorización) y la doc de Fly.io para Python y devuelve: requisitos de HTTP streamable, opciones de auth y pasos de despliegue (máx. 25 líneas).
- `sonnet` redacta la spec; `inherit` revisa la superficie de herramientas (pocas y claras) y la seguridad.
- Verifica modelos en /tasks.
</delegacion>
```

### H4. Worker durable con aprobación humana: `expense-pipeline`

- **Pieza:** workers asíncronos y back-office (evento → agente decide → lo dudoso a revisión humana), ejecución durable.
- **Qué aprender:** workflows y activities en Temporal, señales para esperar a un humano, reintentos e idempotencia, y la política "solo revisión primero, autonomía después" del Ramp Policy Agent de tu mapa. Recursos: [Temporal 101 en Python](https://learn.temporal.io/courses/temporal_101/python/) (gratis); [Temporal docs: signals y human-in-the-loop](https://docs.temporal.io/develop/python/message-passing); el caso Block + Temporal (may. 2026, en tu mapa); patrón "human in the loop" de [Building effective agents](https://www.anthropic.com/research/building-effective-agents); [DBOS Transact](https://github.com/dbos-inc/dbos-transact-py) como alternativa ligera a Temporal: workflows durables sobre tu propio Postgres, sin servidor aparte (radar T2; decide Temporal o DBOS en la entrevista del hito: Temporal es lo que nombran las ofertas, DBOS encaja mejor en tu stack).
- **Proyecto, versión mínima (18 h):** workflow mensual: (1) activity determinista que recoge facturas de plataforma A y plataforma B (tus scripts de Playwright) y las facturas de gasto de una carpeta; (2) activity que llama a `invoice-extractor` vía gateway; (3) reglas deterministas clasifican; lo que no pasa (confianza baja, proveedor nuevo, importe atípico) se envía a revisión; (4) el workflow espera una señal de aprobación (una página web mínima o un comando CLI); (5) activities deterministas suben a la asesoría (Emitidas/Recibidas) y escriben el Excel. Reintentos por activity; un fallo a mitad no repite subidas ya hechas.
- **Ampliación (+12 h):** panel de revisión con historial y motivo de la decisión; compensación si una subida falla a mitad; métricas de "porcentaje automatizado" por mes. Ampliación opcional adicional (+6 h, acordada el 2026-10-09): el mismo pipeline montado en n8n autoalojado en el VPS (webhook → extracción llamando a la API de H1 → nodo de aprobación humana → subida), comparado con la versión en código en una tabla de 6 filas: tiempo de construcción, trazabilidad, reintentos, tests, coste y qué pasa cuando cambia el formato de un documento. n8n es fair-code (Sustainable Use License, gratis para uso interno autoalojado); si no se hace aquí, queda como ejercicio corto al final del roadmap solo por conocer la herramienta.
- **Escalón:** 1 PaaS (Fly.io con Temporal Cloud en su capa gratuita, si sigue existiendo) o 1b VPS Hetzner con Temporal autoalojado en Compose. Decide en la entrevista del hito según precio actual.
- **Criterio de terminado:** un cierre de mes real pasa de principio a fin con al menos una factura en revisión humana; matar el worker a mitad y reiniciarlo no duplica ninguna subida; el porcentaje de facturas que no necesitaron revisión está en el README.
- **Qué demuestra:** el patrón más demandado en back-office (Temporal en el 16% de empresas, sistemas distribuidos en el 62%) y la madurez de meter un modelo sin perder el control.
- **Al trabajo:** cualquier proceso de Fever con "un humano decide los casos raros" (conciliaciones, revisiones de contenido, alertas) tiene esta forma; sabrás proponer la versión "solo revisión" primero.
- **Prompt de arranque:**

```markdown
Lee el roadmap (H4) y el estado de H1-H3. Entrevístame (máx. 5 preguntas con propuesta: Temporal autoalojado o Cloud, canal de aprobación, reglas de "dudoso", frecuencia) y escribe la spec de `expense-pipeline` para Claude Code: workflow y activities, señales, idempotencia, integración con scripts de Playwright existentes, despliegue y criterio de terminado.
<delegacion>
- Paralelo: `haiku` lee los scripts de Playwright de plataforma A/plataforma B/asesoría y devuelve: entradas, salidas y efectos secundarios de cada uno (máx. 20 líneas).
- Paralelo: `sonnet` lee Temporal 101 y la doc de signals/retries en Python y devuelve: estructura mínima de workflow+activities, cómo esperar a un humano y 3 trampas de idempotencia (máx. 25 líneas).
- `sonnet` redacta la spec; `inherit` revisa los límites de autonomía (qué nunca se sube sin aprobación).
- Verifica modelos en /tasks.
</delegacion>
```

### H5. Fábrica: agentes desatendidos en CI y routines: `repo-gardener`

- **Pieza:** fábrica de desarrollo (agentes disparados por CI, tickets o calendario, en sandboxes efímeros).
- **Qué aprender:** las tres vías oficiales y qué autenticación exige cada una: (a) [claude-code-action](https://github.com/anthropics/claude-code-action) en GitHub Actions, con token de suscripción (`claude setup-token`) o API key; (b) [Routines](https://code.claude.com/docs/en/routines) (`/schedule`, sesiones cloud por calendario, API o eventos de GitHub; solo con suscripción claude.ai y Claude Code on the web habilitado; un admin de Team/Enterprise puede desactivarlas); (c) [Agent SDK en Python](https://code.claude.com/docs/en/agent-sdk/overview), que exige API key (Anthropic no permite aplicar límites de claude.ai a productos construidos sobre el SDK). También el [modo headless](https://code.claude.com/docs/en/headless) (`claude -p`). Patrones y ejemplos (radar T2): [Ralph Wiggum](https://ghuntley.com/ralph/) (post de jul. 2025: bucle externo que relanza el agente con el mismo prompt hasta cumplir un criterio; su autor lo desaconseja sobre bases de código existentes), el [AGENTS.md de Prowler](https://github.com/prowler-cloud/prowler/blob/master/AGENTS.md) como ejemplo real en un monorepo, y [compound-engineering](https://github.com/everyinc/compound-engineering-plugin) (skills para que cada tarea deje el repo mejor preparado para la siguiente).
- **Proyecto, versión mínima (12 h):** en el repo de `invoice-extractor`: (1) workflow que ejecuta `make evals` en cada PR y publica la tabla de resultados como comentario; (2) `claude-code-action` que responde a `@claude` en PRs con revisión de los prompts cambiados; (3) workflow programado semanal (cron de Actions) que corre un script con el Agent SDK (API key personal) para detectar deriva entre README y código y abrir un PR con la corrección. Sandbox: el runner de Actions.
- **Ampliación (+8 h):** una routine en claude.ai/code/routines con el conector de GitHub para la misma auditoría, y comparar coste y límites con la vía de Actions; agente de triage que etiqueta issues nuevas.
- **Escalón:** CI (GitHub Actions). Es el escalón "nube" sin servidor propio.
- **Criterio de terminado:** un PR que empeora la exactitud de una eval recibe un comentario automático con la tabla antes/después; el cron semanal ha abierto al menos un PR real; en el README hay una tabla "vía / autenticación / coste del mes".
- **Qué demuestra:** que sabes meter un agente en un pipeline con límites (permisos, coste, qué puede tocar), que es exactamente lo que hacen Stripe Minions y Spotify Honk a otra escala.
- **Al trabajo:** es la plantilla de la victoria rápida W1 (sección 6): el mismo workflow programado con la cuenta de Fever sobre un repo del equipo.
- **Prompt de arranque:**

```markdown
Lee el roadmap (H5) y el estado de H1 y H2. Entrevístame (máx. 4 preguntas con propuesta: qué repo, token de suscripción o API key en Actions, qué puede modificar el agente) y escribe la spec de `repo-gardener` para Claude Code: los 3 workflows, permisos mínimos del GITHUB_TOKEN, secretos, script del Agent SDK, límites de coste y criterio de terminado.
<delegacion>
- Paralelo: `haiku` lee `.github/` y el Makefile del repo y devuelve: jobs existentes y comandos de evals (máx. 15 líneas).
- Paralelo: `sonnet` lee el README de claude-code-action, la doc de Routines y la del Agent SDK y devuelve una tabla vía/autenticación/triggers/límites (máx. 25 líneas, con fecha de la doc).
- `sonnet` redacta la spec; `inherit` revisa permisos y riesgos (qué pasa si el agente hace push a main).
- Verifica modelos en /tasks.
</delegacion>
```

### H6. Plataforma de agentes mínima en AWS con IaC

- **Pieza:** plataforma de agentes (runtime, registro de herramientas, observabilidad) vista como infraestructura; escalón AWS.
- **Qué aprender:** Terraform (o CDK en Python) para ECS Fargate, secretos en SSM/Secrets Manager, IAM mínimo, alarmas de presupuesto, y cómo apagar todo con un comando. Recursos: [Terraform AWS provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs); [AWS ECS Fargate getting started](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/getting-started-fargate.html); [AWS CDK Python](https://docs.aws.amazon.com/cdk/v2/guide/work-with-cdk-python.html) si prefieres código sobre HCL; [Fargate vs Lambda](https://dev.to/dspv/aws-fargate-vs-lambda-when-does-lambda-stop-being-cheaper-5b1p) (2026) para elegir runtime por carga.
- **Proyecto, versión mínima (16 h):** `model-gateway` y `fleet-ledger-mcp` desplegados en ECS Fargate (una tarea pequeña cada uno) tras un ALB, Postgres en RDS mínimo o en contenedor con volumen EFS, secretos fuera del repo, trazas enviadas a un backend (Langfuse en Fargate o un SaaS gratuito), presupuesto AWS con alarma a 20 $, `terraform apply` y `terraform destroy` reproducibles.
- **Ampliación (+10 h):** `expense-pipeline` y Temporal en AWS; pipeline de infraestructura en GitHub Actions con `plan` en PR y `apply` manual.
- **Escalón:** 2 AWS con IaC. Presupuesta 15-30 $/mes mientras dure el hito y destruye al terminar.
- **Criterio de terminado:** desde cero, `terraform apply` levanta todo en menos de 20 minutos y `destroy` lo deja a 0 $; Claude Desktop se conecta al MCP en AWS; el coste real del mes está en el README.
- **Qué demuestra:** AWS (61%) y Terraform (37%) aplicados a servicios de IA, no un tutorial de EC2.
- **Al trabajo:** entender el IaC y el IAM de Fever para proponer dónde vive una automatización (Lambda por cron, tarea Fargate, runner de CI).
- **Prompt de arranque:**

```markdown
Lee el roadmap (H6) y el estado de H2-H5. Entrevístame (máx. 4 preguntas con propuesta: Terraform o CDK, RDS o contenedor, región, tope de gasto) y escribe la spec del despliegue en AWS para Claude Code: módulos, recursos, secretos, red mínima, alarmas, Makefile con apply/destroy y criterio de terminado.
<delegacion>
- Paralelo: `haiku` lee los Dockerfiles y Compose de H2 y H3 y devuelve puertos, variables de entorno y volúmenes (máx. 15 líneas).
- Paralelo: `sonnet` lee la doc de ECS Fargate y del provider de Terraform y devuelve: recursos mínimos para 2 servicios + base de datos y estimación de coste con precios de hoy (máx. 25 líneas, con fecha).
- `sonnet` redacta la spec; `inherit` revisa IAM y los puntos donde el coste puede dispararse.
- Verifica modelos en /tasks.
</delegacion>
```

### H7 (opcional). Operación en Kubernetes

- **Pieza:** operación de la plataforma; escalón 3.
- **Qué aprender:** pods, deployments, services, ingress, secrets, Helm. Recursos: [k3s](https://docs.k3s.io/) (cluster en un VPS en minutos); [Kubernetes basics](https://kubernetes.io/docs/tutorials/kubernetes-basics/); [Helm docs](https://helm.sh/docs/); [kind](https://kind.sigs.k8s.io/) para hacerlo en local sin coste.
- **Proyecto, versión mínima (12 h):** chart Helm propio con gateway, MCP y Postgres; despliegue en k3s en un VPS Hetzner (o kind en local); rollout de una nueva versión del gateway sin cortar el servicio.
- **Ampliación (+8 h):** HPA sobre el gateway; GitOps con Argo CD.
- **Escalón:** 3 Kubernetes.
- **Criterio de terminado:** `helm upgrade` despliega una versión nueva con cero errores en las peticiones durante el rollout; README con el diagrama del cluster.
- **Qué demuestra:** Kubernetes (60%) aplicado a tus propios servicios; se recorta sin remordimientos si vas lento.
- **Al trabajo:** leer los manifests de Fever con criterio.
- **Prompt de arranque:**

```markdown
Lee el roadmap (H7) y el estado de H6. Entrevístame (máx. 3 preguntas: k3s en VPS o kind local, qué servicios, GitOps sí/no) y escribe la spec del chart Helm y del despliegue para Claude Code, con criterio de terminado.
<delegacion>
- Paralelo: `haiku` lee el Terraform de H6 y devuelve la lista de servicios, puertos y secretos a migrar (máx. 15 líneas).
- Paralelo: `sonnet` lee la doc de k3s y Helm y devuelve la estructura mínima del chart y 3 errores típicos de rollout (máx. 20 líneas).
- `sonnet` redacta; `inherit` revisa.
- Verifica modelos en /tasks.
</delegacion>
```

## 4. Escalera de despliegue

Cuatro escalones, uno nuevo cada dos hitos; coste total previsto por debajo de 15 €/mes salvo en el escalón AWS. Los precios son de las fuentes citadas (septiembre-octubre de 2026) y cambian; comprueba antes de contratar.

| Escalón | Entra en | Plataforma propuesta | Coste aproximado | Por qué este y no otro |
| --- | --- | --- | --- | --- |
| 0. Local | H0-H2 | Docker Compose en tu Mac (Postgres, gateway, Ollama, Langfuse o Phoenix, Temporal dev-server) | 0 € | Es tu entorno actual; Compose con 5-6 servicios ya es práctica de operación |
| 1. PaaS barato | H3-H4 | Fly.io (Machines por segundo, Dockerfile obligatorio); alternativa Railway si prefieres UX | Fly.io: shared-cpu-1x 256 MB desde 2,19 $/mes; con 1 GB unos 8 $/mes; Railway Hobby 5 $/mes + uso ([Fly.io learn](https://fly.io/learn/docker-hosting/), 2026-09; [bex.co](https://bex.co/blog/2026/09/18/railway-render-flyio-pricing-census-hetzner-flat-rate), 2026-09-18) | Fly.io es el suelo más barato para un servicio siempre encendido y obliga a Dockerfile, que es lo que quieres practicar; Render tiene capa gratuita pero duerme a los 15 min, mal para un servidor MCP |
| 1b. VPS flat (opcional) | H4 si Temporal no cabe en PaaS | Hetzner CX22/CX23 (2 vCPU, 4 GB) con Coolify o Compose | unos 4,5-5 €/mes, 20 TB de tráfico incluidos ([bex.co](https://bex.co/blog/2026/09/06/railway-vs-render-vs-flyio-reaudit), 2026-09-06); Hetzner subió precios hasta 3x en junio de 2026 ([bex.co](https://bex.co/blog/2026/09/19/paas-pricing-shakeup-ledger-render-heroku-hetzner), 2026-09-19) | Una caja flat aloja worker + Temporal + Postgres por el precio de una Machine; menos "serverless", más operación real |
| 2. AWS con IaC | H6 | ECS Fargate (una tarea pequeña) + RDS o Postgres en contenedor + EventBridge/Lambda para cron, todo en Terraform o CDK | Fargate 0,04048 $/vCPU-h + 0,004445 $/GB-h (us-east-1, verificado junio 2026): una tarea de 0,25 vCPU / 0,5 GB siempre encendida son unos 9 $/mes ([fortem.dev](https://dev.to/dspv/aws-fargate-vs-lambda-when-does-lambda-stop-being-cheaper-5b1p), 2026); Lightsail Containers desde 7 $/mes fijo ([AWS Community](https://community.aws/posts/lightsail-vs-aws-compute-comparing-costs-with-aws-pricing-calculator)); Lambda para cron breve cae dentro de la capa gratuita | AWS aparece en el 61% de las empresas del estudio; Terraform en el 37%. El objetivo del escalón es el IaC y el IAM, no el servicio concreto. Presupuesta 15-30 $/mes mientras dure el hito y apaga al terminar |
| 3. Kubernetes (opcional) | H7 | k3s en un VPS Hetzner o kind en local; Helm chart propio | 5 €/mes (VPS) o 0 € (kind) | Kubernetes está en el 60% de las ofertas pero es el escalón con peor relación horas/valor para un portfolio de agentes; por eso es opcional y va último |

**Reglas de la escalera**

- No todo proyecto sube todos los escalones. El gateway (H2) y el servidor MCP (H3) son los que viajan: se despliegan en PaaS en H3 y se redespliegan en AWS en H6.
- Cada escalón añade una capa de operación: 0 logs locales → 1 logs y secretos de plataforma → 2 IAM, VPC mínima y coste → 3 Helm y rollout.
- Cada repo lleva un `Makefile` o `justfile` con `up`, `test`, `evals`, `deploy`; es lo primero que mira un entrevistador.

## 5. Clasificación de la casuística de la flota

Solo dos piezas justifican un modelo: la extracción de facturas de gasto y la lectura de mensajes libres de los conductores. El resto es scraping, reglas y hojas de cálculo, y ya lo tienes resuelto en parte.

| Pieza | Grupo | Motivo | Papel en el plan |
| --- | --- | --- | --- |
| Ingresos y facturas de plataforma A | Código determinista | Portal con estructura fija; ya tienes scripts de Playwright que descargan facturas y resúmenes fiscales. Un modelo solo añadiría coste y fallos aleatorios | Infraestructura de apoyo: fuente de datos del worker (H4) |
| Ingresos de plataforma B | Código determinista | Mismo caso: extracción ya automatizada con Playwright | Apoyo: fuente de datos del worker (H4) y del servidor MCP (H3) |
| Descarga de las imágenes que los conductores suben a los grupos de WhatsApp | Código determinista | Ya existe tu conexión local que conecta y descarga; es ingesta, no decisión | Apoyo: entrada de H1 (dataset) y de H4 (disparador del flujo) |
| Extracción de datos de fotos de contador del vehículo y tickets de plataforma A | IA justificada | Imágenes con formatos variables (pantallas de contador del vehículo, tickets de app) que hoy procesa un agente con OCR; es extracción estructurada con validación detrás (el total del turno debe cuadrar con plataforma A/plataforma B). Mismo problema que las facturas | Práctica principal de H1 (dos de los tres tipos de documento) y entrada de H4 |
| OCR y extracción de facturas de gasto (combustible, taller, seguro, tasas) | IA justificada | Proveedores y formatos variables, PDFs e imágenes, campos que hay que normalizar (NIF, base, IVA, fecha, categoría); validación determinista (cuadre base+IVA=total, NIF válido) | Práctica principal de H1 (tercer tipo de documento) y entrada de H4 |
| Clasificación de un gasto dudoso y decisión de subirlo o no | IA justificada, con aprobación humana | Hay casos que no cubren reglas fijas (una factura mixta, un proveedor nuevo, un importe atípico). Un modelo propone y lo dudoso pasa a revisión; es el patrón Ramp Policy Agent del mapa | Práctica principal de H4 (worker durable + aprobación) |
| Subida mensual al portal de la asesoría (Emitidas / Recibidas) | Código determinista | La carpeta destino se sabe por el origen del documento (ingreso → Emitidas, gasto → Recibidas); la subida es un flujo de navegador fijo | Apoyo: último paso del worker (H4), ejecutado por Playwright tras la aprobación |
| Envío automático de mensajes a los conductores | No merece la pena | La API oficial (WhatsApp Business Platform) exige cuenta de empresa y plantillas aprobadas; las librerías no oficiales arriesgan el bloqueo del número. Dos conductores no justifican el coste | Fuera del plan |
| Excel compartido con los conductores | Código determinista | Escritura de filas conocidas desde tu app de ganancias (openpyxl o la API de Google Sheets) | Apoyo: salida del worker (H4) |
| Preguntas en lenguaje natural sobre ganancias ("cuánto hizo X en marzo") | No merece la pena como producto; sí como demo | Las preguntas son pocas y conocidas; una vista en la app las resuelve. Como ejercicio técnico, exponer la base de datos de ganancias por MCP cuesta poco y enseña el patrón | Demo del servidor MCP (H3): herramientas de lectura sobre tu base de ganancias |

Comprobación pedida: ninguna pieza clasificada como determinista se usa como práctica de IA; las de apoyo entran en H3 y H4 solo como fuentes y salidas de datos.

## 6. Track para aplicarlo al trabajo

El inventario T1 (2026-10-09) cambia el track: Fever ya tiene gateway LiteLLM con presupuesto por agente, Langfuse, gateway MCP con Keycloak, reglas y skills distribuidas desde `fever-ai-rules` y workflows `ai-review` / `pr-autofix` en unos 50 repos. Lo que aporta valor no es construir esas piezas sino adoptarlas en los repos de tu equipo y cubrir el hueco que tiene: agentes con revisión humana sobre alertas y procesos (pieza 3), de los que solo hay dos casos en la empresa (`firefighter` de transactional-api y `qa-bot` de Data). Orden del track: W1 tras H0, W2 en paralelo con H2-H3, W4 tras H3, W3 tras H4.

**Reglas de separación (tu preocupación de ayer)**

- Cuenta de Fever: solo repos, canales y procesos de Fever. Ningún prompt, nombre de repo ni dato del dominio flota pasa por ella.
- Credenciales personales (GitHub personal, créditos de API, Ollama): todo el roadmap H0-H7.
- Antes de la primera routine o workflow con la cuenta de Fever, pregunta al admin si Claude Code on the web y Routines están habilitados y si la suscripción puede usarse en GitHub Actions; la doc dice que un Owner puede desactivarlo ([feature availability](https://code.claude.com/docs/en/feature-availability), [routines](https://code.claude.com/docs/en/routines)). Si no está permitido, la vía es un workflow de GitHub Actions con API key corporativa, o seguir en Cowork con schedule, que ya funciona.

**W1. Victoria rápida (4-6 h): adoptar la fábrica existente en un repo de tu equipo**

1. Elige el repo de tu equipo con más PRs al mes y sin señales de IA (el inventario T1 lista cuáles las tienen).
2. PR a `fever-ai-rules` con `agentic_harness/config/repos/<repo>.yaml` (`stack: python`, `repo`, `skills`) y una línea en `jenkins/sync-targets.yaml`; valida con `make list-repos && make generate-test && make preview-sync`. Lo revisa @Feverup/ai; confirma antes con ellos que el stack python sirve para FastAPI (T4, 2026-10-09).
3. Tras el merge, Jenkins abre el PR en tu repo con `.claude/` y `.cursor/` con sufijo `-fever`; revísalo y mérgealo. No se edita a mano en el consumidor.
4. Copia el caller `ai-review.yml` de b2b-iam (24 líneas, llama a `fever-ai-action/orchestrator.yml@main`, secreto `CURSOR_API_KEY` opcional).
5. Mide dos semanas: PRs revisados, correcciones aceptadas, falsos positivos, minutos ahorrados. Preséntalo al equipo con esa tabla. Hecho cuando corre dos semanas sin intervención y hay tabla.
6. W1b (después, 3-4 h): `pr-autofix` (caller `gh-actions/pr-autofix.yml@master`); exige `orch up <servicio>` funcionando, secreto `AWS_BEARER_TOKEN_BEDROCK` de DevEx, principal `svc:htt-<repo>` y label `ai-autofix`. Tu routine de `pr-aprobados` solo si aporta algo que `ai-review` no cubre.

No he podido leer las dos skills (viven en tu Mac); si me pegas sus `SKILL.md`, concreto el paso 2.

**W2. Piloto de repo preparado para agentes (8-12 h, en paralelo con H2-H3)**

- Candidato propuesto: `compliance-italy-staging-e2e-api` o `ith-env`, por ser pequeños y de bajo riesgo; `compliance-italy` ya tiene AGENTS.md y sirve de referencia, no de piloto. Si ninguno convence, repo nuevo.
- Base: las reglas y skills de `fever-ai-rules` (no partir de cero); encima, un `README.md` por módulo principal con entradas, salidas y lo que cuelga por debajo (tu idea de módulos con interfaz pequeña).
- Medida: toma 5 tareas típicas del repo y compáralas con y sin los mapas (iteraciones de Claude Code, ficheros leídos, aciertos a la primera). `repo-scout` (H0) te sirve para contar ficheros leídos.
- Propuesta al equipo: un PR con los mapas y la tabla de medida; si convence, propón el mapa por módulo como convención en `fever-ai-rules`.

**W4. MCP de un servicio de tu equipo en el gateway de Fever (6-8 h, tras H3)**

- Servidor MCP de solo lectura sobre compliance-italy o ITH (estado de homologaciones, últimos errores, configuración vigente) con FastMCP, siguiendo el patrón de search-api y data-reporting-api, registrado en `data-fever-mcp` con Keycloak y autorización por tool.
- Hecho cuando alguien del equipo lo consulta desde Claude Code o Cowork sin tocar el servicio y el catálogo del gateway lo lista.
- Es H3 aplicado a Fever: mismo código, otro IdP.

**W3. Firefighter-lite para las alertas de tu equipo (10-14 h, tras H4)**

- Forma acordada tras T4 (2026-10-09): una routine de `data-lola` en `routines/<equipo>/` (JSON con prompt, model, trigger cron o event, `enabled:false` al entregar), con `llm_key` propio, MCP de solo lectura (`dd_*` de data-fever-mcp) y diseño "propone, no ejecuta": alerta → triage → diagnóstico y acción propuesta en Slack o Jira; la acción la ejecuta una persona.
- Lola no tiene patrón de aprobación humana (existe el estado `waiting_for_confirmation` pero no consta cómo se activa). Pregunta a data-platform por ese estado y por el CODEOWNERS de la subcarpeta antes de construir una confirmación propia. La espera de señal "de verdad" se practica en H4.
- Hecho cuando ha tratado 20 alertas reales y hay una tabla con acierto de la causa propuesta y tiempo hasta la primera acción.
- Es H4 aplicado a Fever y la pieza que tu equipo no tiene: el proyecto con más visibilidad del track.

**Fiabilidad del inventario T1**: "en uso" significa push reciente, no uso real; la huella de agente está infracontada; el hilo no pudo verificar en `/tasks` que los subagentes corrieran en Haiku. Antes de W1 confirma con el equipo propietario que los workflows copiados siguen vigentes.

**Qué lleva cada hito a Fever**

| Hito | Aportación en Fever | Cuándo |
| --- | --- | --- |
| H0 | Auditor de AGENTS.md: cuenta qué lee un agente para resolver una tarea | Con W2 |
| H1 | Harness de evals con datasets y resultados en Langfuse, compatible con `data-ai-llm-as-a-judge` | Cuando alguien meta IA en un proyecto |
| H2 | Saber pedir una clave LiteLLM con presupuesto para tu servicio y leer sus trazas y coste en Langfuse | Tras H2 |
| H3 | W4: MCP de un servicio del equipo en `data-fever-mcp` | Tras H3 |
| H4 | W3: firefighter-lite con revisión humana para las alertas del equipo | Tras H4 |
| H5 | W1: adopción de `fever-ai-rules`, `ai-review` y `pr-autofix`; después, contribuir una skill al harness de Fever | W1 y tras H5 |
| H6 | Dónde vive una automatización en la infraestructura de Fever (Actions con Bedrock, `data-lola`, k8s-manifests) | Tras H6 |

## 7. Especificación de la skill `preparar-hito`

La skill sustituye al prompt de arranque: con `/preparar-hito H3` la sesión principal lee el roadmap y el estado, lanza la investigación en subagentes baratos, te entrevista y deja una spec y un plan de ejecución en el repo del hito. Antes de construirla, lee cuatro cosas (radar T2, 2026-10-09): las plantillas de [spec-kit](https://github.com/github/spec-kit) para la estructura de la spec, [superpowers](https://github.com/obra/superpowers) para el diseño de skills componibles, [ejemplo-harness-subagentes](https://github.com/betta-tech/ejemplo-harness-subagentes) para verificación y estado en disco, y el [material L2 de DeepLearning.AI](https://github.com/https-deeplearning-ai/sc-agent-skills-files/blob/main/L2/reading_material_2.md) que distingue skills, MCP, tools y subagentes. OpenSpec y agent-skills se descartan por solapar con los anteriores. Se construye después de validar este roadmap, como skill de usuario en `~/.claude/skills/preparar-hito/SKILL.md` con sus subagentes en `~/.claude/agents/`.

**Relación con los comandos internos de Fever** (revisados el 2026-10-09; viven en `compliance-italy/.claude/commands`): regla acordada: los comandos internos se usan en todo lo que vive en el ecosistema de Fever (W1, W2, propuestas al equipo), siempre como copia adaptada a cada repo; en los hitos personales se usan workflows y herramientas de la comunidad para compararlos, con el límite de una herramienta nueva por hito y solo la que resuelve la pieza de ese hito (H1 evals-skills o Inspect AI; H2 LiteLLM como referencia; H3 MCP SDK e Inspector; H4 DBOS o Temporal; H5 superpowers o spec-kit como workflow completo). La skill \`preparar-hito\` es diseño propio que toma de cada uno lo que sigue:

| Comando interno | Se usa en | Adaptación |
| --- | --- | --- |
| `spec-engineer-lite` | Pasos 3-5 de `preparar-hito`: entrevista, reto de respuestas vagas, `SPEC.md` de una página (Goal, Expected Behavior, Edge Cases, Out of Scope, Open Questions) escrita sección a sección | `AskQuestion` → `AskUserQuestion`; cada pregunta lleva respuesta propuesta con razón (regla "propose, don't ask" del team-lead) y el usuario decide; se añade la investigación previa por subagentes, que el comando no tiene |
| `spec-engineer` (plantilla de 10 secciones) | Solo H4 y H6 | Igual que el lite; secciones de riesgos y monitorización obligatorias |
| `team-lead` | Skill hermana `ejecutar-hito`: lee `SPEC.md` y `PLAN.md`, descompone en paquetes paralelos y delega | `.cursor/agents/` → `.claude/agents/` con `model:` por subagente: `explore` → haiku; `implementer`, `tester`, `migrations-manager` → sonnet; `principal-engineer` → inherit; `code-reviewer` → familia distinta del implementador |
| `code-review` | `hito-revisor` | Se conserva el formato Critical / Recommended / Optional; se añade la regla de modelo distinto del que implementó |

De spec-kit se toma solo la idea de un fichero `CONSTITUTION.md` por repo con las reglas fijas (stack, tests, qué no tocar), que ninguno de los cuatro comandos cubre. Los ficheros originales son de Fever: en `ai-bootcamp` se reescriben con palabras propias y no se copian a repos públicos.

**Entrada**

- Argumento obligatorio: identificador del hito (`H0`…`H7`, `W1`, `W2`).
- Fichero `ROADMAP.md` (export en Markdown de este documento) y `STATE.md` (tabla de estado) en el directorio raíz del portfolio; si falta alguno, la skill lo pide y para.
- Opcional: ruta a material del hito (carpeta de facturas, scripts existentes).

**Pasos**

1. Leer `ROADMAP.md` (solo la ficha del hito y las de los hitos anteriores marcados como hechos) y `STATE.md`. Extraer: pieza, recursos, versión mínima, ampliación, criterio de terminado y política de delegación de la ficha.
2. Lanzar en paralelo tres subagentes (abajo): inventario de ficheros, investigación de documentación y comprobación de precios/versiones. Esperar sus resúmenes.
3. Entrevista: como mucho 5 preguntas, cada una con respuesta propuesta derivada de los resúmenes; una ronda, dos si la primera deja contradicciones.
4. Redactar `SPEC.md` (subagente redactor) con: objetivo, alcance mínimo y ampliación, arquitectura, contratos, tests, evals si aplica, despliegue, criterio de terminado verbatim del roadmap, y una sección `<fuera_de_alcance>`.
5. Revisión (sesión principal): contrastar `SPEC.md` con el criterio de terminado y con las restricciones del roadmap (horas, escalón, regla de dominios); corregir.
6. Redactar `PLAN.md`: tareas ordenadas de 1-2 h cada una, con la primera marcada como "hoy", y la política de delegación para la ejecución del hito (qué tareas puede hacer un subagente `haiku` o `sonnet` y qué queda en la sesión principal).
7. Salida: resumen de 10 líneas en el chat y recordatorio de actualizar `STATE.md` al cerrar.

**Salida**

- `SPEC.md` y `PLAN.md` en el repo del hito.
- `RESEARCH.md` con los resúmenes de los subagentes y la fecha de cada documento consultado.
- Resumen en chat con las decisiones tomadas en la entrevista.

**Política de delegación**

| Subtarea | Subagente (fichero en `~/.claude/agents/`) | Modelo | Herramientas | Se lanza | Devuelve a la sesión principal |
| --- | --- | --- | --- | --- | --- |
| Inventario de ficheros y scripts | `hito-inventario` | `haiku` | Read, Glob, Grep | Paso 2, en paralelo | Máx. 20 líneas: ficheros clave, entradas/salidas, 5 casos difíciles; sin pegar contenido |
| Investigación de documentación del hito | `hito-docs` | `sonnet` | WebFetch, WebSearch, Read | Paso 2, en paralelo | Máx. 30 líneas: por recurso, URL, fecha vista, 3-5 hechos que condicionan la spec, y una línea "contradice al roadmap: sí/no" |
| Precios y versiones (plataforma, SDKs, modelos) | `hito-precios` | `haiku` | WebFetch, WebSearch | Paso 2, en paralelo | Máx. 10 líneas: tabla servicio / precio / fecha de la fuente |
| Redacción de `SPEC.md` y `PLAN.md` | `hito-redactor` | `sonnet` | Read, Write, Edit | Paso 4 y 6, secuencial | Ruta de los ficheros + 5 líneas con las decisiones de diseño que tomó |
| Revisión cruzada de la spec y, durante la ejecución del hito, de cada tarea terminada | `hito-revisor` | Familia distinta del redactor: `opus` o `fable` cuando el redactor es `sonnet`; nunca el mismo alias | Read, Grep, Bash (solo tests) | Paso 5 y al cerrar cada tarea de `PLAN.md` | Máx. 15 líneas: hallazgos por severidad (bloqueante / debe / podría), sin reescribir código |
| Decisión final sobre los hallazgos | sesión principal | `inherit` (Opus/Fable) | todas | Paso 5 | No aplica |

Reglas de la política:

- Los subagentes de investigación nunca escriben en el repo; solo el redactor escribe.
- Quien revisa no es quien escribe: el revisor usa un modelo de familia distinta del redactor y nunca recibe el razonamiento del redactor, solo el resultado y el criterio de terminado. Desde H2, cuando hay gateway, la revisión puede ir a otro proveedor o a un modelo local a través del gateway.
- Ningún resumen supera el máximo de líneas indicado; si un subagente necesita más, enlaza a un fichero en `RESEARCH.md`.
- Cada subagente devuelve en su primera línea `modelo_previsto: <alias>` y, si puede leerlo de su entorno, el modelo real; la sesión principal lo contrasta.
- Se asigna el modelo por el campo `model:` del frontmatter de cada subagente, no por parámetro en la invocación, para que la precedencia documentada (invocación → frontmatter → `CLAUDE_CODE_SUBAGENT_MODEL` → modelo principal) no dependa de lo que decida el modelo en cada llamada ([sub-agents](https://code.claude.com/docs/en/sub-agents), doc vigente).

**Cómo comprobar que cada subagente corrió con el modelo previsto**

1. Durante la ejecución, `tú (no el modelo: /tasks es un comando de usuario, corrección del hilo T4) abres /tasks y lees el modelo en la fila de cada subagente (Claude Code v2.1.242 o posterior). La skill solo puede pedir al subagente que autodeclare su modelo en la primera línea`.
2. Después, `grep -o '"model":"[^"]*"' ~/.claude/projects/<proyecto>/<sesión>/subagents/agent-*.jsonl | sort | uniq -c`; la skill incluye este comando en `PLAN.md` como paso de verificación.
3. Un hook `SubagentStart` en `settings.json` que registre `agent_type` y fecha en un fichero, para auditar sin abrir transcripciones.

**Problemas conocidos que la skill debe tener en cuenta**

- Un alias de la misma familia que el modelo principal (por ejemplo `opus` con la sesión en Opus) se resuelve al modelo exacto de la sesión, no a la versión del alias ([sub-agents](https://code.claude.com/docs/en/sub-agents)).
- Antes de v2.1.251, `CLAUDE_CODE_SUBAGENT_MODEL` pisaba el frontmatter y el parámetro de invocación; con `inherit` en esa variable, v2.1.177 ignoraba el modelo pedido por llamada ([issue #68392](https://github.com/anthropics/claude-code/issues/68392)). La skill comprueba que la variable no está definida, o que está `CLAUDE_CODE_SUBAGENT_MODEL_FORCE` solo cuando se quiere forzar un modelo a todos.
- El subagente integrado Explore pasó de Haiku a heredar el modelo principal ([issue #72940](https://github.com/anthropics/claude-code/issues/72940)); para exploración barata, define un subagente propio llamado `Explore` con `model: haiku`.
- Se han reportado subagentes facturados a Sonnet con sesión en Haiku ([issue #73634](https://claudeissues.com/issue/73634-bug-subagent-tasks-set-and-billed-to-sonnet-5-despite-haiku-set-as-session-model), jul. 2026): de ahí la verificación por transcripción.
- Los subagentes consumen los mismos límites de uso que la sesión principal; con suscripción, cuatro subagentes en paralelo gastan cuota cuatro veces más rápido.

## 8. Lo que no he podido confirmar

Separo lo verificado en fuentes abiertas de lo que es interpretación o supuesto. Fecha de la investigación: 2026-10-08 y 2026-10-09.

**Verificado leyendo la fuente**

- Configuración y precedencia de modelo en subagentes de Claude Code, `/tasks`, `CLAUDE_CODE_SUBAGENT_MODEL(_FORCE)`, consumo de límites: [sub-agents](https://code.claude.com/docs/en/sub-agents).
- Qué exige suscripción (Routines, cloud sessions) y qué funciona con API key (GitHub Actions, Agent SDK): [feature availability](https://code.claude.com/docs/en/feature-availability).
- Agent SDK exige API key y Anthropic no permite usar límites de claude.ai en productos sobre el SDK: [agent-sdk overview](https://code.claude.com/docs/en/agent-sdk/overview).
- Estudio de 3.647 ofertas (porcentajes por empresa) y tarifas de PaaS, Hetzner y Fargate: enlaces en las secciones 1 y 4.

**Solo visto en resultados de búsqueda (no abrí la página)**

- Que `claude-code-action` acepta `claude_code_oauth_token` de `claude setup-token` y que una organización puede bloquear el uso de la suscripción en Claude Code (PR de trigger.dev, mayo 2026; issue #1053 de claude-code-action). Compruébalo en el README de la action antes de H5.
- Que Explore pasó a heredar el modelo principal (issue #72940) y el reporte de facturación a Sonnet con sesión en Haiku (issue #73634).
- Los enlaces a recursos de aprendizaje de H0, H2, H4, H6 y H7 (docs de tool use, PDF support, LiteLLM, OTel GenAI, Temporal, Terraform, k3s, Helm) son URLs que conozco pero no he abierto hoy; si alguna ha cambiado, la skill `preparar-hito` lo detectará en su paso de investigación.

**Supuestos que dependen de ti o de Fever**

- Si tu organización tiene habilitados Claude Code on the web y Routines, y si permite la suscripción en GitHub Actions. Sin esto, W1 va por Cowork o por API key corporativa.
- Qué ve un admin de Team/Enterprise de tus sesiones y routines; no lo he investigado. La regla de dominios de la sección 0 te protege sin depender de la respuesta.
- Precio y capa gratuita de Temporal Cloud en 2026; no verificado. H4 decide entre Cloud y autoalojado con el precio del día.
- Que 10 € de créditos cubren H0-H2 con Haiku y modelos locales; es una estimación. H2 añade la cuota diaria precisamente para medirlo.
- El contenido de `dependabot-morning` y `pr-aprobados` y el estado real de `compliance-italy-staging-e2e-api`, `fever-siae-smart-card-server` e `ith-env`; no tengo acceso a tu Mac.

**Interpretaciones mías, no evidencia**

- Que Ollama no cuenta como skill de portfolio y vLLM sí: se basa en que Ollama no aparece en el top 40 de herramientas del estudio y vLLM sí (19%); es un único estudio sesgado a empresas grandes de EE. UU.
- La elección de Fly.io sobre Railway y de proxy propio sobre LiteLLM: son decisiones de aprendizaje, no de mercado.
- Las horas por hito: estimaciones para alguien de tu perfil con Claude Code; revísalas tras H0 y H1 y corrige el total.
