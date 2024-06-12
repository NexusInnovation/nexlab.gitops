param location string = resourceGroup().location
param sshRSAPublicKey string

module cluster './cluster.bicep' = {
  name: 'nexlab-gitops-demo-cluster'
  params: {
    clusterName: 'nexlab-gitops-demo-cluster'
    location: location
    dnsPrefix: 'nexlab-gitops-demo'
    pricingTier: 'Free'
    agentCount: 3
    agentVMSize: 'standard_b2pts_v2'
    linuxAdminUsername: 'nexlab-admin'
    sshRSAPublicKey: sshRSAPublicKey
  }
}

module containerRegistry './containerRegistry.bicep' = {
  name: 'nexlab-gitops-demo-registry'
  params: {
    acrName: 'nexlabgitopsdemo'
    location: location
    acrSku: 'Basic'
    kubeletPrincipalId: cluster.outputs.kubeletPrincipalId
  }
}
