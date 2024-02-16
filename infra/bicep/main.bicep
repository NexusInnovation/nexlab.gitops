param location string = resourceGroup().location
param sshRSAPublicKey string
param githubServicePrincipalId string

module cluster './cluster.bicep' = {
  name: 'nexlab-flux-demo-cluster'
  params: {
    clusterName: 'nexlab-flux-demo-cluster'
    location: location
    dnsPrefix: 'nexlab-flux-demo'
    pricingTier: 'Free'
    agentCount: 2
    linuxAdminUsername: 'nexlab-admin'
    sshRSAPublicKey: sshRSAPublicKey
  }
}

module containerRegistry './containerRegistry.bicep' = {
  name: 'nexlab-flux-demo-registry'
  params: {
    acrName: 'nexlabfluxdemo'
    location: location
    acrSku: 'Basic'
    principalId: githubServicePrincipalId
  }
}
