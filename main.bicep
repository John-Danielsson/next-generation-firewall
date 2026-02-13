param networkInterfaces_DMZ_name string
param networkInterfaces_LAN_name string
param networkInterfaces_WAN_name string
param routeTables_dmz_route_name string
param sshPublicKeys_AzureSSH_name string
param virtualMachines_vm_dmz_name string
param sshPublicKeys_vm_ngfw_key_name string
param virtualNetworks_vnet_ngfw_name string
param routeTables_internal_route_name string
param virtualMachines_vm_internal_name string
param networkInterfaces_vm_dmz_nic_name string
param storageAccounts_ngfwdiagstorage_name string
param networkSecurityGroups_vm_dmz_nsg_name string
param networkInterfaces_vm_internal_nic_name string
param networkSecurityGroups_firewall_nsg_name string
param virtualMachines_vm_opnsense_firewall_name string
param networkSecurityGroups_vm_internal_nsg_name string
param schedules_shutdown_computevm_vm_dmz_name string
param schedules_shutdown_computevm_vm_internal_name string
param publicIPAddresses_vm_opnsense_firewall_PublicIP_name string

resource sshPublicKeys_AzureSSH_name_resource 'Microsoft.Compute/sshPublicKeys@2024-11-01' = {
  name: sshPublicKeys_AzureSSH_name
  location: 'westus2'
  properties: {
    publicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGNSx8aLDOxp3ArtWnCTK6QrHWTQK1jTrGwMLgOHDw05i6S7dOqYGFtjoki72cZcPkLg2GU5qzeDxJZbjwoRQwzddE8mSLXrO3EaqAhb4VCyDbX4jQZSsNVfczR+u7fXo6pfMBMxvQoBwTmQ4nYxTd1AYJUwSNKh+1CVTIi6O3GZQce0W4Hw2keuKRqnSWABAMz+7Riu0vEWXS3xTB3ApM98eTyNhAni7yH9ehnUj740BVHTYv+0DYnlsdUlJPW/xEGAbV4FKN8L00IQ+DZC/4YnVSpmlmcwIaLM7VuYhE+p6yI4FfLVUhJEHZJgTo6zGRvzCf0gNtZFcxEHwetuwQrdOL216nP6cU8ytb9E+xxRu1SStwaAiiLPaR2Ud4NjNODz7ieJwlCHXxu7ozpB/iZqIRXeASEdtGVIDIHO+I+RbsSDbLK0BtWlg9z9QAdAdr6z4xnFJYmvPTQY+B02UieKslgrn5d4YOyjPxNaUgAq64RAs9BhrasGXDAKJA6H0= generated-by-azure'
  }
}

resource sshPublicKeys_vm_ngfw_key_name_resource 'Microsoft.Compute/sshPublicKeys@2024-11-01' = {
  name: sshPublicKeys_vm_ngfw_key_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  properties: {
    publicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGNSx8aLDOxp3ArtWnCTK6QrHWTQK1jTrGwMLgOHDw05i6S7dOqYGFtjoki72cZcPkLg2GU5qzeDxJZbjwoRQwzddE8mSLXrO3EaqAhb4VCyDbX4jQZSsNVfczR+u7fXo6pfMBMxvQoBwTmQ4nYxTd1AYJUwSNKh+1CVTIi6O3GZQce0W4Hw2keuKRqnSWABAMz+7Riu0vEWXS3xTB3ApM98eTyNhAni7yH9ehnUj740BVHTYv+0DYnlsdUlJPW/xEGAbV4FKN8L00IQ+DZC/4YnVSpmlmcwIaLM7VuYhE+p6yI4FfLVUhJEHZJgTo6zGRvzCf0gNtZFcxEHwetuwQrdOL216nP6cU8ytb9E+xxRu1SStwaAiiLPaR2Ud4NjNODz7ieJwlCHXxu7ozpB/iZqIRXeASEdtGVIDIHO+I+RbsSDbLK0BtWlg9z9QAdAdr6z4xnFJYmvPTQY+B02UieKslgrn5d4YOyjPxNaUgAq64RAs9BhrasGXDAKJA6H0= generated-by-azure'
  }
}

resource networkSecurityGroups_firewall_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: networkSecurityGroups_firewall_nsg_name
  location: 'westus2'
  properties: {
    securityRules: [
      {
        name: 'AllowSSH'
        id: networkSecurityGroups_firewall_nsg_name_AllowSSH.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          description: 'Allow SSH from management IP'
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '67.185.64.82/32'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'AllowOutboundInternet'
        id: networkSecurityGroups_firewall_nsg_name_AllowOutboundInternet.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          description: 'Allow outbound to internet for updates and resolution'
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'Internet'
          access: 'Allow'
          priority: 120
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'AllowHTTPS'
        id: networkSecurityGroups_firewall_nsg_name_AllowHTTPS.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          description: 'Allow HTTPS from management IP for OPNsense GUI'
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '67.185.64.82/32'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_vm_dmz_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: networkSecurityGroups_vm_dmz_nsg_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  properties: {
    securityRules: [
      {
        name: 'AllowHTTPSOutboundThroughFirewall'
        id: networkSecurityGroups_vm_dmz_nsg_name_AllowHTTPSOutboundThroughFirewall.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          description: 'Allow HTTPS outbound to Internet (routed through firewall via UDR)'
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '10.0.2.0/24'
          destinationAddressPrefix: 'Internet'
          access: 'Allow'
          priority: 110
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'AllowSSHFromFirewall'
        id: networkSecurityGroups_vm_dmz_nsg_name_AllowSSHFromFirewall.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          description: 'Allow SSH inbound from firewall\'s DMZ IP for management'
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '10.0.2.4'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'DenyAllInbound'
        id: networkSecurityGroups_vm_dmz_nsg_name_DenyAllInbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          description: 'Deny all other inbound'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 4096
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'DenyAllOutbound'
        id: networkSecurityGroups_vm_dmz_nsg_name_DenyAllOutbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 4095
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_vm_internal_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: networkSecurityGroups_vm_internal_nsg_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  properties: {
    securityRules: [
      {
        name: 'AllowHTTPSFromDMZ'
        id: networkSecurityGroups_vm_internal_nsg_name_AllowHTTPSFromDMZ.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          description: 'Allow HTTPS from DMZ'
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '10.0.2.0/24'
          destinationAddressPrefix: '10.0.3.0/24'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'AllowSSHFromFirewall'
        id: networkSecurityGroups_vm_internal_nsg_name_AllowSSHFromFirewall.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          description: 'Allow SSH inbound from firewall\'s LAN IP for management'
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '10.0.3.4'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'DenyAllInbound'
        id: networkSecurityGroups_vm_internal_nsg_name_DenyAllInbound.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          description: 'Deny all other inbound'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 4096
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddresses_vm_opnsense_firewall_PublicIP_name_resource 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: publicIPAddresses_vm_opnsense_firewall_PublicIP_name
  location: 'westus2'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.94.224.31'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource routeTables_dmz_route_name_resource 'Microsoft.Network/routeTables@2024-07-01' = {
  name: routeTables_dmz_route_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'default'
        id: routeTables_dmz_route_name_default.id
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '10.0.2.4'
        }
        type: 'Microsoft.Network/routeTables/routes'
      }
    ]
  }
}

resource routeTables_internal_route_name_resource 'Microsoft.Network/routeTables@2024-07-01' = {
  name: routeTables_internal_route_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'default'
        id: routeTables_internal_route_name_default.id
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '10.0.3.4'
        }
        type: 'Microsoft.Network/routeTables/routes'
      }
    ]
  }
}

resource storageAccounts_ngfwdiagstorage_name_resource 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: storageAccounts_ngfwdiagstorage_name
  location: 'westus2'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_0'
    allowBlobPublicAccess: false
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource schedules_shutdown_computevm_vm_dmz_name_resource 'microsoft.devtestlab/schedules@2018-09-15' = {
  name: schedules_shutdown_computevm_vm_dmz_name
  location: 'westus2'
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: '2000'
    }
    timeZoneId: 'Pacific Standard Time'
    notificationSettings: {
      status: 'Enabled'
      timeInMinutes: 30
      emailRecipient: 'johnaugustd@gmail.com'
      notificationLocale: 'en'
    }
    targetResourceId: virtualMachines_vm_dmz_name_resource.id
  }
}

resource schedules_shutdown_computevm_vm_internal_name_resource 'microsoft.devtestlab/schedules@2018-09-15' = {
  name: schedules_shutdown_computevm_vm_internal_name
  location: 'westus2'
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: '2000'
    }
    timeZoneId: 'Pacific Standard Time'
    notificationSettings: {
      status: 'Enabled'
      timeInMinutes: 30
      emailRecipient: 'johnaugustd@gmail.com'
      notificationLocale: 'en'
    }
    targetResourceId: virtualMachines_vm_internal_name_resource.id
  }
}

resource networkInterfaces_DMZ_name_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: networkInterfaces_DMZ_name
  location: 'westus2'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_DMZ_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.2.4'
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: virtualNetworks_vnet_ngfw_name_dmz_subnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: true
    disableTcpStateTracking: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_LAN_name_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: networkInterfaces_LAN_name
  location: 'westus2'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_LAN_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.3.4'
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: virtualNetworks_vnet_ngfw_name_internal_subnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: true
    disableTcpStateTracking: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkSecurityGroups_firewall_nsg_name_AllowHTTPS 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_firewall_nsg_name}/AllowHTTPS'
  properties: {
    description: 'Allow HTTPS from management IP for OPNsense GUI'
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '67.185.64.82/32'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_firewall_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_internal_nsg_name_AllowHTTPSFromDMZ 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_vm_internal_nsg_name}/AllowHTTPSFromDMZ'
  properties: {
    description: 'Allow HTTPS from DMZ'
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '10.0.2.0/24'
    destinationAddressPrefix: '10.0.3.0/24'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_internal_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_dmz_nsg_name_AllowHTTPSOutboundThroughFirewall 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_vm_dmz_nsg_name}/AllowHTTPSOutboundThroughFirewall'
  properties: {
    description: 'Allow HTTPS outbound to Internet (routed through firewall via UDR)'
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '10.0.2.0/24'
    destinationAddressPrefix: 'Internet'
    access: 'Allow'
    priority: 110
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_dmz_nsg_name_resource
  ]
}

resource networkSecurityGroups_firewall_nsg_name_AllowOutboundInternet 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_firewall_nsg_name}/AllowOutboundInternet'
  properties: {
    description: 'Allow outbound to internet for updates and resolution'
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'Internet'
    access: 'Allow'
    priority: 120
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_firewall_nsg_name_resource
  ]
}

resource networkSecurityGroups_firewall_nsg_name_AllowSSH 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_firewall_nsg_name}/AllowSSH'
  properties: {
    description: 'Allow SSH from management IP'
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '67.185.64.82/32'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_firewall_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_dmz_nsg_name_AllowSSHFromFirewall 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_vm_dmz_nsg_name}/AllowSSHFromFirewall'
  properties: {
    description: 'Allow SSH inbound from firewall\'s DMZ IP for management'
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '10.0.2.4'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 120
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_dmz_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_internal_nsg_name_AllowSSHFromFirewall 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_vm_internal_nsg_name}/AllowSSHFromFirewall'
  properties: {
    description: 'Allow SSH inbound from firewall\'s LAN IP for management'
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '10.0.3.4'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 120
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_internal_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_dmz_nsg_name_DenyAllInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_vm_dmz_nsg_name}/DenyAllInbound'
  properties: {
    description: 'Deny all other inbound'
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Deny'
    priority: 4096
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_dmz_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_internal_nsg_name_DenyAllInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_vm_internal_nsg_name}/DenyAllInbound'
  properties: {
    description: 'Deny all other inbound'
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Deny'
    priority: 4096
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_internal_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_dmz_nsg_name_DenyAllOutbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_vm_dmz_nsg_name}/DenyAllOutbound'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Deny'
    priority: 4095
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_dmz_nsg_name_resource
  ]
}

resource routeTables_dmz_route_name_default 'Microsoft.Network/routeTables/routes@2024-07-01' = {
  name: '${routeTables_dmz_route_name}/default'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: '10.0.2.4'
  }
  dependsOn: [
    routeTables_dmz_route_name_resource
  ]
}

resource routeTables_internal_route_name_default 'Microsoft.Network/routeTables/routes@2024-07-01' = {
  name: '${routeTables_internal_route_name}/default'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: '10.0.3.4'
  }
  dependsOn: [
    routeTables_internal_route_name_resource
  ]
}

resource storageAccounts_ngfwdiagstorage_name_default 'Microsoft.Storage/storageAccounts/blobServices@2025-01-01' = {
  parent: storageAccounts_ngfwdiagstorage_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_ngfwdiagstorage_name_default 'Microsoft.Storage/storageAccounts/fileServices@2025-01-01' = {
  parent: storageAccounts_ngfwdiagstorage_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_ngfwdiagstorage_name_default 'Microsoft.Storage/storageAccounts/queueServices@2025-01-01' = {
  parent: storageAccounts_ngfwdiagstorage_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_ngfwdiagstorage_name_default 'Microsoft.Storage/storageAccounts/tableServices@2025-01-01' = {
  parent: storageAccounts_ngfwdiagstorage_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource virtualMachines_vm_dmz_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_vm_dmz_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D4s_v3'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_vm_dmz_name}OSDisk'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_vm_dmz_name}OSDisk')
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm_dmz_name
      adminUsername: 'azureuser'
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGNSx8aLDOxp3ArtWnCTK6QrHWTQK1jTrGwMLgOHDw05i6S7dOqYGFtjoki72cZcPkLg2GU5qzeDxJZbjwoRQwzddE8mSLXrO3EaqAhb4VCyDbX4jQZSsNVfczR+u7fXo6pfMBMxvQoBwTmQ4nYxTd1AYJUwSNKh+1CVTIi6O3GZQce0W4Hw2keuKRqnSWABAMz+7Riu0vEWXS3xTB3ApM98eTyNhAni7yH9ehnUj740BVHTYv+0DYnlsdUlJPW/xEGAbV4FKN8L00IQ+DZC/4YnVSpmlmcwIaLM7VuYhE+p6yI4FfLVUhJEHZJgTo6zGRvzCf0gNtZFcxEHwetuwQrdOL216nP6cU8ytb9E+xxRu1SStwaAiiLPaR2Ud4NjNODz7ieJwlCHXxu7ozpB/iZqIRXeASEdtGVIDIHO+I+RbsSDbLK0BtWlg9z9QAdAdr6z4xnFJYmvPTQY+B02UieKslgrn5d4YOyjPxNaUgAq64RAs9BhrasGXDAKJA6H0= generated-by-azure'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_dmz_nic_name_resource.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: 'https://${storageAccounts_ngfwdiagstorage_name}.blob.core.windows.net/'
      }
    }
    priority: 'Spot'
    evictionPolicy: 'Deallocate'
    billingProfile: {
      maxPrice: json('0.2')
    }
  }
  dependsOn: [
    storageAccounts_ngfwdiagstorage_name_resource
  ]
}

resource virtualMachines_vm_internal_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_vm_internal_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D4s_v3'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_vm_internal_name}OSDisk'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_vm_internal_name}OSDisk')
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm_internal_name
      adminUsername: 'azureuser'
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGNSx8aLDOxp3ArtWnCTK6QrHWTQK1jTrGwMLgOHDw05i6S7dOqYGFtjoki72cZcPkLg2GU5qzeDxJZbjwoRQwzddE8mSLXrO3EaqAhb4VCyDbX4jQZSsNVfczR+u7fXo6pfMBMxvQoBwTmQ4nYxTd1AYJUwSNKh+1CVTIi6O3GZQce0W4Hw2keuKRqnSWABAMz+7Riu0vEWXS3xTB3ApM98eTyNhAni7yH9ehnUj740BVHTYv+0DYnlsdUlJPW/xEGAbV4FKN8L00IQ+DZC/4YnVSpmlmcwIaLM7VuYhE+p6yI4FfLVUhJEHZJgTo6zGRvzCf0gNtZFcxEHwetuwQrdOL216nP6cU8ytb9E+xxRu1SStwaAiiLPaR2Ud4NjNODz7ieJwlCHXxu7ozpB/iZqIRXeASEdtGVIDIHO+I+RbsSDbLK0BtWlg9z9QAdAdr6z4xnFJYmvPTQY+B02UieKslgrn5d4YOyjPxNaUgAq64RAs9BhrasGXDAKJA6H0= generated-by-azure'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_internal_nic_name_resource.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: 'https://${storageAccounts_ngfwdiagstorage_name}.blob.core.windows.net/'
      }
    }
    priority: 'Spot'
    evictionPolicy: 'Deallocate'
    billingProfile: {
      maxPrice: json('0.2')
    }
  }
  dependsOn: [
    storageAccounts_ngfwdiagstorage_name_resource
  ]
}

resource networkInterfaces_vm_dmz_nic_name_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: networkInterfaces_vm_dmz_nic_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_dmz_nic_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.2.5'
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: virtualNetworks_vnet_ngfw_name_dmz_subnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_vm_dmz_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_vm_internal_nic_name_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: networkInterfaces_vm_internal_nic_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_internal_nic_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.3.5'
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: virtualNetworks_vnet_ngfw_name_internal_subnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_vm_internal_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource virtualNetworks_vnet_ngfw_name_dmz_subnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_vnet_ngfw_name}/dmz-subnet'
  properties: {
    addressPrefixes: [
      '10.0.2.0/24'
    ]
    routeTable: {
      id: routeTables_dmz_route_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_ngfw_name_resource
  ]
}

resource virtualNetworks_vnet_ngfw_name_internal_subnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_vnet_ngfw_name}/internal-subnet'
  properties: {
    addressPrefixes: [
      '10.0.3.0/24'
    ]
    routeTable: {
      id: routeTables_internal_route_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_ngfw_name_resource
  ]
}

resource virtualNetworks_vnet_ngfw_name_wan_subnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_vnet_ngfw_name}/wan-subnet'
  properties: {
    addressPrefixes: [
      '10.0.1.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_firewall_nsg_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_ngfw_name_resource
  ]
}

resource storageAccounts_ngfwdiagstorage_name_default_bootdiagnostics_vmdmz_2918fa38_f970_4b52_84a7_31b4fd66ead4 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-01-01' = {
  parent: storageAccounts_ngfwdiagstorage_name_default
  name: 'bootdiagnostics-vmdmz-2918fa38-f970-4b52-84a7-31b4fd66ead4'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_ngfwdiagstorage_name_resource
  ]
}

resource storageAccounts_ngfwdiagstorage_name_default_bootdiagnostics_vminterna_25ddd4ca_b7f3_491e_a319_c7519b8daf66 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-01-01' = {
  parent: storageAccounts_ngfwdiagstorage_name_default
  name: 'bootdiagnostics-vminterna-25ddd4ca-b7f3-491e-a319-c7519b8daf66'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_ngfwdiagstorage_name_resource
  ]
}

resource storageAccounts_ngfwdiagstorage_name_default_bootdiagnostics_vmopnsens_e6cbf565_83b6_46aa_b047_1fd0a794c359 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-01-01' = {
  parent: storageAccounts_ngfwdiagstorage_name_default
  name: 'bootdiagnostics-vmopnsens-e6cbf565-83b6-46aa-b047-1fd0a794c359'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_ngfwdiagstorage_name_resource
  ]
}

resource networkInterfaces_WAN_name_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: networkInterfaces_WAN_name
  location: 'westus2'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_WAN_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.1.4'
          privateIPAllocationMethod: 'Static'
          publicIPAddress: {
            id: publicIPAddresses_vm_opnsense_firewall_PublicIP_name_resource.id
          }
          subnet: {
            id: virtualNetworks_vnet_ngfw_name_wan_subnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: true
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_firewall_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource virtualNetworks_vnet_ngfw_name_resource 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: virtualNetworks_vnet_ngfw_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'dmz-subnet'
        id: virtualNetworks_vnet_ngfw_name_dmz_subnet.id
        properties: {
          addressPrefixes: [
            '10.0.2.0/24'
          ]
          routeTable: {
            id: routeTables_dmz_route_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'internal-subnet'
        id: virtualNetworks_vnet_ngfw_name_internal_subnet.id
        properties: {
          addressPrefixes: [
            '10.0.3.0/24'
          ]
          routeTable: {
            id: routeTables_internal_route_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'wan-subnet'
        id: virtualNetworks_vnet_ngfw_name_wan_subnet.id
        properties: {
          addressPrefixes: [
            '10.0.1.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_firewall_nsg_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualMachines_vm_opnsense_firewall_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_vm_opnsense_firewall_name
  location: 'westus2'
  tags: {
    project: 'ngfw-lab'
    environment: 'dev'
  }
  plan: {
    name: 'opnsense-be-2019'
    product: 'opnsense'
    publisher: 'decisosalesbv'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D8s_v3'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'decisosalesbv'
        offer: 'opnsense'
        sku: 'opnsense-be-2019'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_vm_opnsense_firewall_name}OSDisk'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_vm_opnsense_firewall_name}OSDisk')
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_vm_opnsense_firewall_name
      adminUsername: 'azureuser'
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGNSx8aLDOxp3ArtWnCTK6QrHWTQK1jTrGwMLgOHDw05i6S7dOqYGFtjoki72cZcPkLg2GU5qzeDxJZbjwoRQwzddE8mSLXrO3EaqAhb4VCyDbX4jQZSsNVfczR+u7fXo6pfMBMxvQoBwTmQ4nYxTd1AYJUwSNKh+1CVTIi6O3GZQce0W4Hw2keuKRqnSWABAMz+7Riu0vEWXS3xTB3ApM98eTyNhAni7yH9ehnUj740BVHTYv+0DYnlsdUlJPW/xEGAbV4FKN8L00IQ+DZC/4YnVSpmlmcwIaLM7VuYhE+p6yI4FfLVUhJEHZJgTo6zGRvzCf0gNtZFcxEHwetuwQrdOL216nP6cU8ytb9E+xxRu1SStwaAiiLPaR2Ud4NjNODz7ieJwlCHXxu7ozpB/iZqIRXeASEdtGVIDIHO+I+RbsSDbLK0BtWlg9z9QAdAdr6z4xnFJYmvPTQY+B02UieKslgrn5d4YOyjPxNaUgAq64RAs9BhrasGXDAKJA6H0= generated-by-azure'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_WAN_name_resource.id
          properties: {
            primary: true
          }
        }
        {
          id: networkInterfaces_LAN_name_resource.id
          properties: {
            primary: false
          }
        }
        {
          id: networkInterfaces_DMZ_name_resource.id
          properties: {
            primary: false
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: 'https://${storageAccounts_ngfwdiagstorage_name}.blob.core.windows.net/'
      }
    }
    priority: 'Spot'
    evictionPolicy: 'Deallocate'
    billingProfile: {
      maxPrice: json('0.2')
    }
  }
  dependsOn: [
    storageAccounts_ngfwdiagstorage_name_resource
  ]
}
