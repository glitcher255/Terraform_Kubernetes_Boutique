# 🔥 Flame + Azure VMSS Monitoring Project

This project deploys a **Linux VM Scale Set** on Azure with full monitoring and a reverse-proxied **Flame dashboard** front-end. It's designed to show production-grade telemetry.

---

![UI](/screenshots/Flame_port.png)
![dashboard](/screenshots/azure_dashboard_flame.png)
## 🧱 Architecture Overview

- **VMSS** (Virtual Machine Scale Set)  
  Auto-scaling enabled based on CPU usage.

- **Monitoring Stack:**
  - **Azure Monitor Agent (AMA)**
  - **Data Sources**:
    - Performance metrics (CPU, memory, disk)
    - Syslog events
    - AzureDiagnostics logs
  - **Data Sink**: Log Analytics Workspace

- **Frontend:**
  - [Flame](https://github.com/pawelmalak/flame) dashboard
  - Running on port 5005
  - **NGINX** reverse proxy forwards root (port 80) to Flame to avoid port clutter

---

## 📊 Azure Monitor Dashboard

Monitoring is visualized through a custom Azure Dashboard:

- VM-level performance: CPU, memory, disk
- Syslog + NSG log count
- Auth failures (security insight)
- Agent uptime and VM instance count

---

## 💻 Flame Dashboard (Frontend)

NGINX routes root traffic to Flame (no exposed port 5005). Flame UI includes:

- Quick access bookmarks
- Custom app tiles (optional)
- Live-updating homepage (not real-time metrics)


---

## ⚙️ Tech Stack

- Terraform (modular, IaC)
- Azure (VMSS, Log Analytics, Monitor, Networking)
- GitHub Actions (CI/CD)
- NGINX
- Flame (Docker)

---

## ⚠️ Notes

- Auto-scaling works.
- Monitoring is real.
- Alerts work.

---

## 🧪 How to Run

1. Clone repo  
2. Configure Terraform backend and variables
3. Configure TF_TOKEN_app_terraform_io with your TF Auth Key
4. Run GitHub Actions (or `terraform apply`)
5. Access Flame via public IP (HTTP, port 80)


---

## 📂 Structure

/modules/

vm/

networking/

monitoring/

dcr/

.github/

workflows/

flame/

docker-compose.yml

nginx.conf

main.tf

outputs.tf

