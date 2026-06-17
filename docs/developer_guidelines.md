# Lineamientos Generales del Desarrollador

## **1. Introducción General**

[1.1 Propósito del documento](programming/0.1.introduction/01.1.purpose.md)

[1.2 Alcance (qué equipos aplica: desarrollo, análisis, QA si corresponde)](programming/0.1.introduction/01.2.scope.md)

[1.3 Responsabilidades de los roles involucrados](programming/0.1.introduction/01.3.roles.md)

[1.4 Cómo mantener actualizado este documento](programming/0.1.introduction/01.4.maintaining.md)

[1.5. Configuración e Instalación para Montar el Entorno de Desarrollo](programming/0.1.introduction/01.5.instalation.md)

---

## **2. Estándares de Estilo y Calidad de Código**

[2.1 Lineamientos generales de estilo](https://github.com/dotnet/runtime/blob/main/docs/coding-guidelines/coding-style.md)

2.2 Uso oficial de `.editorconfig`
- [Editorconfig oficial](https://github.com/scisa-mx/org-guidelines/blob/main/.editorconfig)
- Asegurate de tener una copia en el root de tu aplicativo (“El _root_ del aplicativo es el directorio principal donde reside todo el código fuente, configuraciones y archivos esenciales del proyecto.”) para que se apliquen los cambios en automatico en visualstudio

[2.3 Convenciones de nombres](programming/0.2.code_standards/2.3.naming_conventions.md)

[2.4 Estructura de proyectos y solución](programming/0.2.code_standards/2.4.project_structure.md)

2.5 Comentarios, documentación y XML docs
- Metodos publicos con `<summary>`
- [Tu codigo deberia hablar por si mismo.](programming/0.2.code_standards/2.5.autodocs.md)

[2.6 Políticas sobre _code smells_ y _refactoring_](programming/0.2.code_standards/2.6.refactoring.md)

[2.7 Documentación basada en BDD](programming/0.2.code_standards/2.7.bdd_documentation.md)


---

## **3. Librerías, Dependencias y Paquetería**

[3.1 Uso de librerías de terceros](programming/0.3.dependencies/03.1.third_party_libraries.md)

[3.2 Evaluación y aprobación de nuevas dependencias](programming/0.3.dependencies/03.2.dependency_approval.md)

[3.3 Versionado y actualización de paquetes (NuGet, npm, etc.)](programming/0.3.dependencies/03.3.package_versioning.md)

[3.4 Políticas de seguridad respecto a dependencias externas](programming/0.3.dependencies/03.4.dependency_security.md)

[3.5 Cómo publicar un paquete privado NuGet para uso interno de SCISA](https://stackoverflowteams.com/c/scisa/questions/633/634#634)

[3.6 Cómo configuro mi ambiente para usar paquetes con NuGet locales](https://stackoverflowteams.com/c/scisa/questions/633/634#634)

---

## **4. Principios y Buenas Prácticas de Desarrollo**

[4.1 DRY](programming/0.4.good_practices/04.1.dry.md)

[4.2 SOLID](programming/0.4.good_practices/04.2.SOLID.md)

[4.3 KISS](programming/0.4.good_practices/04.3.KISS.md)

[4.4 Manejo de errores y excepciones](programming/0.4.good_practices/04.4.exceptions.md)

[4.5 Logs y observabilidad](programming/0.4.good_practices/04.5.logs.md)

[4.6 Manejo de configuración y secretos](programming/0.4.good_practices/04.6.secretos-variables.md)

4.7 Si vas a comentar código. Mejor eliminalo

4.8 [Evita el IF](programming/0.4.good_practices/04.avoid_ifs.md)

4.9 Como manejar la deuda tecnica

4.10 Inmutabilidad de clases

---

## **5. Metodología de Trabajo y Flujo de Desarrollo**

5.1 Flujo para trabajar _features_

https://stackoverflowteams.com/c/scisa/questions/540
https://docs.google.com/document/d/1IAbVGCFkRElbTYEHVtHr7cEV0uk7yXZJbShKS5bvPmo/edit?tab=t.0
https://docs.google.com/document/d/1-1xcl9-mmfmeSbTMRmmJmyUuW-LRAeo_fiilwK06c4s/edit?tab=t.0

> Aqui lo mas importante es identificar claramente desde donde vas a partir para realizar tu trabajo

> Revisa bien antes de subir tus cambios

> Envia el PR hacia donde se esta integrando (Por default es development)

5.2 Flujo para trabajar _bugfixes_ y _hotfixes_

https://stackoverflowteams.com/c/scisa/questions/540

> Aqui lo mas importante es identificar claramente en QUE version se va aplicar el FIX. Esto
Para no enviar cosas que el cliente NO espera. Unicamente LO reportado

> Revisa bien antes de subir tus cambios. Envia el PR hacia donde se esta integrando (Por default es el branch de donde estas trabajando)

[5.3 Definition of Ready (DoR)](programming/0.5.collaborative_work/05.3.DoR.md)

[5.4 Definition of Done (DoD)](programming/0.5.collaborative_work/05.5.DoD.md)

5.5 Pair programming y revisiones colaborativas

[5.6 Prioridad y urgencia: cómo decidir](programming/0.5.collaborative_work/05.8.priorities.md)

[5.7 Proceso de documentación mínima requerida](programming/0.5.collaborative_work/05.6.min_docs.md)

[5.8 Estándar de documentación (features BDD, manuales de usuario, ADRs)](programming/0.5.collaborative_work/05.9.standard_docs.md)

[5.9 Manuales de usuario: estándar y ciclo de vida](programming/0.5.collaborative_work/05.10.user_manual_standard.md)

5.10 Revisiones Colaborativas

[5.10.1 Que revisar al hacer un PR](https://docs.google.com/document/d/1-1xcl9-mmfmeSbTMRmmJmyUuW-LRAeo_fiilwK06c4s/edit?tab=t.0)

[5.11 Checklist de propuesta](programming/0.5.collaborative_work/05.11.proposal_checklist.md)

[5.14 Estándar de pre-análisis para propuestas](programming/0.5.collaborative_work/05.14.pre_analysis_standard.md)

[5.12 Gateway de entrega](programming/0.5.collaborative_work/05.12.delivery_gateway.md)

[5.13 KPI de entregas — Tasa de fallos](programming/0.5.collaborative_work/05.13.delivery_kpi.md)

---

## **6. Versionamiento y Control de Código**

[6.1 Convenciones de ramas (Gitflow)](https://stackoverflowteams.com/c/scisa/questions/540)

6.3 [Reglas para commits, mensajes y atomicidad](programming/0.6.git/06.3.commits_rules.md)

6.4 [Pull Requests: formato, checklist, aprobaciones](programming/0.6.git/06.4.pullrequest.md)

6.5 [Merging, rebase, squash: cuándo aplicar cada uno](programming/0.6.git/06.5.merge_rebase_squash.md)

6.6 [Protección y roles en repositorios](programming/0.6.git/06.6.repository_roles.md)

---

## **7. Integración Continua, Entrega y Deployments**

7.1 [Pipeline de CI/CD](programming/0.7.repositories/07.1.pipelines_and_ci_cd.md)

7.2 [Reglas para releases](programming/0.7.repositories/07.2.releases.md)

7.3 [Versionamiento semántico o propio](programming/0.7.repositories/07.3.semantic_versioning.md)

7.4 [Pruebas automáticas mínimas requeridas](programming/0.7.repositories/07.4.minimum_automated_tests.md)

7.5 [Validación previa y posterior al deploy](programming/0.7.repositories/07.5.Pre_and_postdeployment_validation.md)

7.6 Gestión de _feature flags_

7.7 [Estándar de wiki por cliente (ambientes on-premise, versiones, manuales)](programming/0.7.repositories/07.7.client_wiki_standard.md)

7.8 [Manejo de subdominios (patrón canónico, proceso de solicitud, ciclo de vida)](programming/0.7.repositories/07.8.subdomain_management.md)

---

## **8. Gestión de Scripts, Migraciones y Base de Datos**

> Sección pendiente de documentar.

---

## **9. Seguridad y Compliance**

9.1 [Lineamientos de seguridad en código](programming/0.9.security.md/09.1.security_guidelines.md)

9.2 [Manejo de credenciales y secretos](programming/0.9.security.md/09.2.variables_secrets.md)

9.3 [Validaciones y sanitización de datos](programming/0.9.security.md/09.3.validation_and_sanitization.md)

9.4 OWASP Top 10 (aplicado a la organización)

9.5 Revisión de dependencias vulnerables

---

## **10. Comunicación, Colaboración y Expectativas Personales**

10.1 Regla: _“Investiga, acierta y no asumas — pregunta mejor”_

10.2 Comunicación con analistas

10.3 Comunicación con QA

10.4 Códigos de conducta en pull requests

10.5 Tiempo de respuesta esperado

---

## **11. Capacitaciones, Aprendizaje y Crecimiento**

11.1 Ligas de capacitación interna

11.2 Mentoring y acompañamiento

11.3 Requerimientos mínimos de actualización trimestral

11.4 Rutas de aprendizaje por nivel (Junior, Mid, Senior)

---

## **12. Herramientas y Entorno de Desarrollo Estándar**

12.1 [Configuración oficial del IDE (Rider, VS, VS Code…)](./programming/0.12.ide/012.1.ide_config.md)

12.2 Extensiones aprobadas

12.3 Configuración de linters, analizadores y herramientas de calidad

12.4 Estándares de entornos locales (contenedores, versiones de SDK, etc.)

---

## **13. Anexos**

13.1 [Glosario](./programming/0.13.templates/013.1.glossary.md)

13.2 P[lantillas de PR](./programming/0.13.templates/013.2.pr_templates.md)

13.3 [Plantillas de commits](./programming/0.13.templates/013.3.commits_templates.md)

13.4 [Plantillas de documentación de feature](./programming/0.13.templates/013.4.feature_template.md)

13.5 Ejemplos de buenas y malas prácticas
