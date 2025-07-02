# 🚀 AKS Microservices Observability Demo

**Production-grade Kubernetes deployment of Google's Online Boutique microservices demo on Azure AKS with a full observability stack — deployed end-to-end via Terraform.**

<p align="center">
  <img src="/screenshots/boutique_sc1.png" alt="Online Boutique UI" width="600"/>
</p>

---

## 🌟 Project Highlights

✅ **One-Command Deployment** — Entire Kubernetes stack deployed with a single `terraform apply`  
✅ **Helm-Based Installation** — Manually Helmified Online Boutique microservices and observability stack  
✅ **End-to-End Observability** — Metrics, distributed tracing, and partial logging operational  
✅ **Real-World Troubleshooting** — Overcame undocumented configs, hidden variables, and Helm challenges  

---

## 📸 Screenshots

| Online Boutique UI                           | Prometheus Metrics                           | OpenTelemetry Traces (Tempo)                |
|----------------------------------------------|----------------------------------------------|---------------------------------------------|
| ![UI](/screenshots/boutique_sc1.png)          | ![Prometheus](/screenshots/boutique_sc3.png)   | ![Traces](/screenshots/boutique_sc2.png)  |

---

## 🏗️ Technical Stack

| **Component**         | **Technology**                     |
|-----------------------|------------------------------------|
| Infrastructure        | Terraform (Single apply pipeline) |
| Kubernetes            | Azure AKS with VMSS autoscaling   |
| Microservices Demo    | Google Online Boutique (manual Helm charts) |
| Metrics & Dashboards  | Prometheus, Grafana               |
| Distributed Tracing   | OpenTelemetry, Tempo              |
| Logging               | Loki (partial integration)        |

---

## 📦 Features

- Manually created Helm charts for Online Boutique (no official charts exist)
- Extracted hidden environment variables for observability:
  - `ENABLE_TRACING`
  - `COLLECTOR_SERVICE_ADDR`
- OpenTelemetry traces operational on all supported services via Tempo
- Prometheus and Grafana deployed for cluster and service monitoring
- Terraform provisions:
  - AKS Cluster with default VMSS autoscaling
  - Kubernetes resources
  - Helm releases for all services and observability stack

---

## ⚙️ Known Gaps
  
⚠️ Loki logging stack incomplete  
⚠️ No Prometheus alert rules configured yet

---

## 🚧 Next Steps

- Finalize Loki logging integration  
- Implement production-grade Prometheus alerting  
- Enhance AKS security: RBAC, resource limits, network policies  

---

## 🎯 Why This Project Stands Out

- Practical experience reverse-engineering real-world microservices without documentation  
- Overcame Helm and OpenTelemetry misconfigurations in a complex AKS environment  
- Built an observability stack from scratch simulating production-level challenges  
- Demonstrates expertise in Kubernetes, Helm, Terraform, and observability tooling  

---

## 📝 Quick Start

```bash
# Deploy entire infrastructure, microservices, and observability stack
terraform init
terraform apply -auto-approve
