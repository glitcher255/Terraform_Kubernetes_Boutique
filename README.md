![UI](/screenshots/Flame_port.png)
![dashboard](/screenshots/azure_dashboard_flame.png)
# AKS Microservices Observability Demo

Production-grade Kubernetes deployment of Google's Online Boutique microservices demo on Azure AKS with a full observability stack.

## Features

- **Custom Helm Deployment**: Reverse-engineered Online Boutique with no official Helm charts
- **Prometheus & Grafana**: Metrics collection and dashboards
- **Tempo with OpenTelemetry**: Distributed tracing operational on frontend service
- **Loki (Partial)**: Logging integration underway
- **Azure VMSS**: Node autoscaling enabled with default settings
- **Terraform Infrastructure**: Full IaC deployment pipeline

## Architecture Overview

|    Component     |      Technology         |
|------------------|-------------------------|
| Kubernetes       | Azure AKS               |
| Infrastructure   | Terraform               |
| Observability    | Prometheus, Grafana     |
| Distributed Tracing | OpenTelemetry, Tempo |
| Logging          | Loki                    |
| Microservices    | Google Online Boutique  |

## Notable Accomplishments

- Helmified Online Boutique manually (no official Helm charts available)
- Extracted and implemented hidden environment variables for tracing:
  - `ENABLE_TRACING`
  - `COLLECTOR_SERVICE_ADDR`
- Integrated OpenTelemetry to Tempo for distributed tracing
- Deployed Prometheus and Grafana for resource monitoring
- Enabled traces on frontend service (ongoing expansion planned)

## Known Gaps

- Distributed tracing active only on frontend service
- Loki integration incomplete
- No Prometheus alerting rules configured
- VMSS autoscaling active but unmanaged (default scaling)

## Next Steps

- Expand OpenTelemetry instrumentation to all microservices
- Complete Loki setup for centralized logging
- Implement robust Prometheus alerting
- Fine-tune VMSS autoscaling policies
- Improve production hardening (RBAC, resource limits, network policies)

## Why This Project Stands Out

- Real-world troubleshooting experience with incomplete, undocumented systems
- Debugged misaligned OpenTelemetry, Tempo, and Helm configurations
- Built observability pipeline from scratch in AKS
- Simulates production-level challenges with tracing, logging, and metrics

---

This project demonstrates practical Kubernetes observability skills beyond basic tutorials. Developed to showcase resilience in debugging, reverse engineering, and deploying cloud-native monitoring solutions.

---

*Additional documentation for advanced observability configuration, Helm charts, and alerting setup to follow.*