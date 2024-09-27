# Démo GitOps 
Le but de cette démo est de démontrer la méthodologie [GitOps](https://www.redhat.com/en/topics/devops/what-is-gitops-workflow) en utilisant la suite [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) sur Azure Kubernetes Service. 

## Motivation
Le but de l'exercice était de déterminer si une approche GitOps pouvait améliorer les opérations chez Nexus. Les principaux gains potentiels étaient les suivants : 

* Permettre aux devs de gérer leur infra avec des outils et des pratiques qu'ils/elles maitrisent déjà (Git)
* Enrichir l'IaC en y rajoutant l'état des nos environnements (plutôt que seulement la recette)
* Réduire les pipelines procédurales à maintenir en inverstant le contrôle

## Conclusion
Le résultat de l'analysis était négatif. 

### Faible adjacence avec les pratiques existentes de Nexus
Il serait très difficile d'adopter cette pratique de manière significative sans passer unilatéralemnet à Kubernetes comme plateforme cible, ou minimalement à un système dérivé tel que Azure Container Apps, et celà demandrait une quantité de refactoring et d'entraînement de personnel suffisament majeure pour représenter un changement de paradigme organisationnel. 

### Ne remplace pas le besoin pour l'IaC
L'introduction de Kubernetes dans le mélange permettrait de réduire la quantité de ressources Azure à déployer et maintenir, mais le cluster K8s lui-même et ses dépendences doivent quand même être gérés par IaC. Au final, on rajouterait une technologie additionnelle dans notre stack, ce qui réduit la proposition de valeur.

### Intégration difficile avec Azure
Il n'existait pas au moment du projet de recettes Bicep pour le déploiement d'un cluster AKS avec ArgoCD et ses dépendences. Il existe un template Bicep pour *Flux*, mais celui-ci manquait largement de flexibilité au niveau de la configuration. 

Pour réaliser un déploiement par IaC réellement idempotent, il aurait fallu dans les deux cas maintenir des scripts et des intégrations *custom*, comme par exemple des déploiements *Helm* déclaratifs tel qu'

### Immaturité des technologies
ArgoCD est une plateforme stable et mature, mais certains des systèmes connexes qui permettent notamment de déployer des environnements de Pull Request, ou de mettre ajour une image OCI automatiquement, sont encore en développement actif et n'ont pas de version stable ou n'avaient pas de version stable au moment de cete analyse. 

## Arborescence du projet
* `.github` : Les actions GitHub qui construisent et publient les images Docker pour le frontend et le backend.
* `backend` : Une simple application ASP.NET Core
* `doc` : Diapositive de présentation, sous format [marp](https://marp.app/)
* `frontend` : Une simple application React
* `helm` : Les templates Helm pour le frontend et le backend
* `infra` : Les définitions Bicep permettant de provisionner un cluster AKS avec un registre de contenants
