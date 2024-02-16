param acrName string
param location string = resourceGroup().location
param principalId string

@allowed([ 'Basic' ])
param acrSku string = 'Basic'

// Role built-in
var acrPush = '8311e382-0749-4cb8-b61a-304f252e45ec'

resource acr 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: false
  }
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, principalId, acrPush)
  scope: acr
  properties: {
    roleDefinitionId: acrPush
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}
