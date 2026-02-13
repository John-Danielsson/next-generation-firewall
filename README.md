# Azure NGFW Lab with OPNsense

## Project Description

This project demonstrates a basic Next-Generation Firewall (NGFW) lab setup in Azure using OPNsense as the firewall appliance. It showcases cybersecurity concepts such as network segmentation, traffic routing through a virtual appliance, Network Security Groups (NSGs) for access control, User-Defined Routes (UDRs) for forcing traffic through the firewall, spot instances for cost optimization, auto-shutdown schedules for lab efficiency, and diagnostic storage. The deployment is implemented via an Azure Resource Manager (ARM) template.

This is an ongoing project as part of my transition from software engineering to cybersecurity. It aims to provide a secure, segmented environment with a DMZ for public-facing services and an internal subnet for protected resources.

## Prerequisites

- An Azure subscription.
- Azure CLI or PowerShell installed for deployment.
- An SSH public key for VM access (generated via `ssh-keygen` or Azure).
- Basic knowledge of Azure networking and security.

## Deployment Instructions

1. **Prepare Parameters**: Update the ARM template (`template.json`) with your values, such as management IP, email for notifications, and SSH key.

2. **Deploy via Azure CLI**:
   ```
   az deployment group create --resource-group <your-resource-group> --template-file template.json --parameters emailAddress=<your-email> sshPublicKey='<your-public-key>' managementIpAddress=<your-ip>
   ```

3. **Post-Deployment**:
   - Access the OPNsense GUI via the public IP (output: `firewallPublicIp`) at https://<public-ip> (default credentials: root/opnsense).
   - Configure firewall rules in OPNsense to allow traffic (e.g., NAT, outbound rules).
   - SSH to DMZ/internal VMs from the firewall for management.

Note: This template uses spot VMs, so monitor for evictions. Auto-shutdown is enabled at 8 PM PST with notifications.

## Overview of Implementation

The ARM template deploys a secure network topology in Azure:

- **Virtual Network (VNet)**: A single VNet (`vnet-ngfw`) with three subnets:
  - WAN subnet (10.0.1.0/24): Hosts the firewall's public-facing interface with a public IP.
  - DMZ subnet (10.0.2.0/24): For semi-public resources like web servers.
  - Internal subnet (10.0.3.0/24): For protected internal resources.

- **Firewall VM**: An OPNsense appliance VM (`vm-opnsense-firewall`) with three NICs (WAN, DMZ, LAN). It acts as the NGFW, inspecting and routing traffic. Deployed as a spot instance (Standard_D8s_v3) for cost savings, with IP forwarding enabled.

- **Test VMs**: Two Ubuntu VMs:
  - DMZ VM (`vm-dmz`, 10.0.2.5): Simulates public-facing services.
  - Internal VM (`vm-internal`, 10.0.3.5): Simulates backend resources.

- **Routing (UDRs)**: Route tables force all outbound traffic from DMZ and internal subnets to the firewall (next hop: firewall's DMZ/LAN IPs).

- **Security (NSGs)**:
  - Firewall NSG: Allows SSH/HTTPS from management IP, outbound to internet.
  - DMZ NSG: Allows SSH from firewall, HTTPS outbound to internet (routed via firewall), denies all else.
  - Internal NSG: Allows SSH from firewall, HTTPS from DMZ, denies all else.

- **Cost and Management Features**:
  - Spot instances with max price limits and deallocation on eviction.
  - Auto-shutdown schedules for all VMs with email notifications.
  - Boot diagnostics stored in a storage account for troubleshooting.

The template uses recent API versions for security and compatibility. All resources are tagged for organization (`project: ngfw-lab`, `environment: dev`).

## Architecture Diagram

Here's a basic ASCII representation of the architecture:

```
Azure NGFW Lab Architecture

Internet
  |
Public IP
  |
WAN Subnet (10.0.1.0/24)
  |
OPNsense Firewall VM (3 NICs: WAN 10.0.1.4, DMZ 10.0.2.4, LAN 10.0.3.4)
  /     \
DMZ Subnet (10.0.2.0/24)   Internal Subnet (10.0.3.0/24)
  |                           |
DMZ VM (10.0.2.5)           Internal VM (10.0.3.5)
UDR to Firewall             UDR to Firewall
NSG: Allow SSH from FW,     NSG: Allow SSH from FW,
     Allow HTTPS Out,           Allow HTTPS from DMZ,
     Deny All                   Deny All

Diagnostics Storage
Auto-Shutdown Schedules
```

## Threat Model

This section outlines potential threats and mitigations based on the lab's architecture. It follows a basic STRIDE model (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege) tailored to Azure NGFW setups.

### Key Assets
- Firewall VM: Controls all traffic.
- DMZ VM: Exposed services (e.g., web).
- Internal VM: Sensitive data/resources.
- VNet/Subnets: Network isolation.
- Public IP: Entry point.

### Potential Threats and Mitigations
1. **External Attacks on Public IP (e.g., DDoS, Brute Force)**:
   - Threat: Unauthorized access to firewall GUI/SSH or DoS.
   - Mitigation: NSG restricts inbound to management IP only (SSH/HTTPS). Use Azure DDoS Protection (not enabled here; add for prod). Spot instances can be evicted but deallocated to save state.

2. **Lateral Movement from DMZ to Internal**:
   - Threat: Compromised DMZ VM attacks internal resources.
   - Mitigation: Internal NSG allows only specific traffic (HTTPS from DMZ, SSH from firewall). No direct internet access; all routed through firewall. OPNsense rules can further filter (configure post-deploy).

3. **Traffic Bypass (e.g., Direct Outbound from Subnets)**:
   - Threat: VMs evade firewall inspection.
   - Mitigation: UDRs force 0.0.0.0/0 to firewall IPs. NSGs deny unauthorized outbound.

4. **Insider Threats or Misconfiguration**:
   - Threat: Accidental exposure via broad rules.
   - Mitigation: Least-privilege NSGs (deny-all default). Tags for auditing. Auto-shutdown reduces exposure time.

5. **Spot Eviction**:
   - Threat: Unexpected downtime during tests.
   - Mitigation: Deallocation policy preserves resources. Monitor via diagnostics. For prod, use on-demand VMs.

6. **Data Disclosure (e.g., Diagnostics Logs)**:
   - Threat: Unauthorized access to boot diagnostics.
   - Mitigation: Storage account with encryption and private access (no public blobs).

This is a high-level model. For a complete analysis, use tools like Microsoft Threat Modeling Tool. In production, integrate Azure Security Center for continuous monitoring.

## Future Work
- Add Azure Bastion for secure management access.
- Integrate Azure Firewall or WAF for advanced threat protection.
- Implement monitoring with Azure Monitor/Log Analytics.
- Automate OPNsense configuration via scripts.
- Expand to hybrid setup with on-premises simulation.

Contributions welcome! Feel free to fork and improve.