---
marp: true
paginate: true
---

<style>
img[alt~="center"] {
  display: block;
  margin: 0 auto;
}
</style>

![bg left:30% 70%](https://argo-cd.readthedocs.io/en/stable/assets/logo.png)
# GitOps avec ArgoCD
Frédéric Laurier-Montpetit
Nexus Innovations
2024

---
# Contèxte et motivation
La norme chez Nexus est de gérer les divers concepts de Azure directement avec Bicep.

Les gens en charge de l'IaC sont principalement des développeurs, et non des spécialistes DevOps ou des sysadmin.

Y aurait-il moyen de réduire, d'accélérer ou de simplifier ce travail pour passer plus de temps sur l'applicatif?

---
# GitOps ![width:50px](https://git-scm.com/images/logos/downloads/Git-Icon-1788C.png)
Une philosophie de gestion d'infra visant à établir Git comme source unique de vérité pour le code autant que l'infra. 

## Pourquoi adopter cette philosophie?
* Permettre à nos devs de gérer leur infra avec des outils et des pratiques qu'ils/elles maitrisent déjà
* Enrichir l'IaC en y rajoutant *l'état* des nos environnements
* Réduire ou éliminer les pipelines procédurales

---
# Envergure de la démo
Exemples de ce qu'on aimerait démontrer : 
* CI et CD sans pipelines (IoC complet)
* Création d'un environnement de "preview" lors de la création d'une PR qui touche au code
* Mise à jour de staging après le merge d'une PR qui touche au code
* Mise à jour de la production en manipulant la répo "infra"

---
# Éventail des technologies

---
# Kubernetes ![width:50px](https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Kubernetes_logo_without_workmark.svg/2109px-Kubernetes_logo_without_workmark.svg.png)
Un système d'orchetration de contenants OCI. Il gère le cycle de vie des *workloads* exécutés dans des contenants, ainsi que leur environnement d'exécution en partie ou en totalité.

K8s est, dans le cadre de ce démo, notre *plateforme cible*.

---
# Est-ce que GitOps nécessite absolument d'utiliser Kubernetes?
![width:300px center](https://i.kym-cdn.com/photos/images/newsfeed/001/650/747/aaf.png)

**Réponse sérieuse** : Non, mais il faudrait aller chercher une grosse partie de la valeur ailleurs, et on perdrait beaucoup des outils et du savoir développés par la communauté "cloud native". 

---
# ArgoCD ![width:50px](https://argo-cd.readthedocs.io/en/stable/assets/logo.png)
Un outil de livraison continue pour Kubernetes. Sa tâche est d'observer ce qui se passe dans la répo Git contenant l'état demandé du système, et de *réconcilier* le cluster Kubernetes avec cet état. 

Au delà des concepts de Git, ArgoCD peut aussi réagir à ce qui se passe sur un SCMaaS (eg GitHub, AzDo) comme la création ou le *merge* d'une PR, la création d'une nouvelle répo, etc. 


---
# Helm ![width:50px](https://helm.sh/img/helm.svg)
Le "package manager" pour Kubernetes. Helm permet de facilement déployer des applications sur un cluster, avec un minimum de configuration.

ArgoCD peut se servir de Helm pour déployer notre application, ainsi que ses dépendances au besoin.

---
# Bicep ![width:50px](https://ms-azuretools.gallerycdn.vsassets.io/extensions/ms-azuretools/vscode-bicep/0.25.53/1707769602999/Microsoft.VisualStudio.Services.Icons.Default)
Argo gère le cluster sur lequel il est déployé. Pour la gestion des clusters AKS eux-mêmes et des autres ressources Azure, il faut quelque chose de plus "low level". 

Terraform pourrait être utilisé ici, mais dans le cadre de cette démo on reste avec Bicep, dans le but de pouvoir *flexer* notre savoir acquis. 

![width:500px center](https://i.kym-cdn.com/entries/icons/original/000/012/468/shakeee.jpg)