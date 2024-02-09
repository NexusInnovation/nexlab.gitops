param location string = resourceGroup().location
param sshRSAPublicKey string

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
