# Démo GitOps 
# BootStrap phase 1 
(Outlines simplifiées à raffiner plus tard)

Créer une répo GitHub

## Créer et configurer un compte RBAC pour GitHub
On peut créer les credentials sans assignation de rôle et passer l'id au template bicep

https://learn.microsoft.com/en-us/azure/container-instances/container-instances-github-action?tabs=userlevel

## Déployer le template Bicep 
AKS demande la clé publique d'une keypair pour l'accès aux nodes par SSH. C'est rarement nécessaire mais au besoin en générer une et la mettre dans un password manager.

https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-cli

## Pointer kubectl vers le cluster AKS 
https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-get-credentials
