# Démo GitOps 
Le but de cette démo est de démontrer la méthodologie [GitOps](https://www.redhat.com/en/topics/devops/what-is-gitops-workflow) en utilisant la suite [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) sur Azure Kubernetes Service. 

## Arborescence
* `.github` : Les actions GitHub qui construisent et publient les images Docker pour le frontend et le backend.
* `backend` : Une simple application ASP.NET Core
* `doc` : Diapositive de présentation, sous format [marp](https://marp.app/)
* `frontend` : Une simple application React
* `helm` : Les templates Helm pour le frontend et le backend
* `infra` : Les définitions Bicep permettant de provisionner un cluster AKS avec un registre de contenants
