param clusterName string

@allowed([ 'Free', 'Standard', 'Premium' ])
param pricingTier string = 'Free'

param location string = resourceGroup().location
param dnsPrefix string
param agentCount int = 3
param agentVMSize string = 'standard_d2s_v3'
param linuxAdminUsername string
param sshRSAPublicKey string

resource cluster 'Microsoft.ContainerService/managedClusters@2023-10-02-preview' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'Base'
    tier: pricingTier
  }
  properties: {
    dnsPrefix: dnsPrefix
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: agentCount
        vmSize: agentVMSize
        osType: 'Linux'
        mode: 'System'
      }
    ]
    linuxProfile: {
      adminUsername: linuxAdminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshRSAPublicKey
          }
        ]
      }
    }
    ingressProfile: {
      webAppRouting: {
        enabled: true
      }
    }
  }
}

output kubeletPrincipalId string = cluster.properties.identityProfile.kubeletIdentity.objectId
