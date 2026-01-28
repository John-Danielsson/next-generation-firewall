# Next Generation Firewall
Next Generation Firewall (NGFW) in Azure


## Architecture Diagram
This architecture implements a low-cost Azure-based NGFW using forced routing, network segmentation, and inline IDS/IPS inspection. All ingress and egress traffic is routed through a hardened Linux firewall VM for inspection, logging, and enforcement.

[Diagram link (draw.io)](https://drive.google.com/file/d/1GzHfVvaeyj8GKEafl2CrX_aQ6iitcfYn/view?usp=sharing)

## Threat Model

Assets
- Azure Virtual Network
- Azure Ubuntu VM

Threat Actors
- Opportunistic scanners/bots
- Cyber criminals
- Misconfigured internal systems

Threats
- Data exfiltration
- Unauthorized access
- Lateral movement
- Port scanning

Mitigations
- Forced routing
- Firewall rules
- Network segmentation
- Logging and alerting

## Firewall Rule Table

| Firewall Name | Protocol | Port # | Source | Rule |
| -------- | -------- | -------- | -------- | -------- |
| Firewall NSG | TCP | 22 | Public IP | Allow |
| Firewall NSG | TCP | 443 | 0.0.0.0/0 | Allow |
| Internal NSG | TCP | 443 | 10.0.1.0/24 | Allow |
| Internal NSG | TCP | 22 | 10.0.1.0/24 | Allow |

## Sample Alerts (JSON)
```
{}
```


## Screenshots of Azure routes + NSGs



## Cost Breakdown

