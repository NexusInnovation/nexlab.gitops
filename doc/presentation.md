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
# GitOps ![width:50px](https://git-scm.com/images/logos/downloads/Git-Icon-1788C.png)
Une philosophie de gestion des opérations visant à établir Git comme source unique de vérité pour le code autant que l'infra. 

## Avantages théoriques
* Permettre aux devs de gérer leur infra avec des outils et des pratiques qu'ils/elles maitrisent déjà (Git)
* Enrichir l'IaC en y rajoutant *l'état* des nos environnements
* Réduire les pipelines procédurales à maintenir

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

Le projet ArgoCD offre aussi quelques outils additionnels : 

* Image Updater : Permet de faire du *polling* sur un registre de contenants comme ACR et automatiquement mettre à jour les contenants sur K8s.
* Pull Request Generator : Permet de réagir aux créations, mises à jours et complétions de *pull requests* dans un SCMaaS comme GitHub ou Azure DevOps. On peut s'en servir pour créer des environnement éphémères lors de l'ouverture d'une PR et de les supprimer lors de la fermeture par exemple. 

ArgoCD est conçu pour être déployé sur un cluster Kubernetes. Il peut gérer plusieurs clusters à la fois. 

---
# Helm ![width:50px](https://helm.sh/img/helm.svg)
Helm est un moteur de *templating* pour les ressources Kubernetes. Il permet de déployer des applications sur un cluster Kubernetes comme on le fait avec un *package manager*. 

ArgoCD supporte Helm comme source de vérité pour notre application. Nous nous en servirons pour cette démo. 

---
# Bicep ![width:50px](https://ms-azuretools.gallerycdn.vsassets.io/extensions/ms-azuretools/vscode-bicep/0.25.53/1707769602999/Microsoft.VisualStudio.Services.Icons.Default)
ArgoCD ne gère pas les resources *cloud* directement. On doit donc provisionner le cluster avec Bicep. 

![width:500px center](https://i.kym-cdn.com/entries/icons/original/000/012/468/shakeee.jpg)

---
# Aperçu des répos
## nexlab.gitops.app
* Un backend ASP.NET Core
* Un frontend React
* Une pipeline de CI pour chaque livrable qui bâtit un container et le posse sur ACR 
* Une template *Helm* pour chaque livrable avec un fichier *values* pour l'environnement de dev principal

## nexlab.gitops.infra
* Templates bicep
* * Cluster AKS
* * Azure Container Registry

---
# Observations
Le tout semble fonctionner assez bien, mais il existe plusieurs problèmes qui rendent l'adoption de cette pratique difficile et potentiellement inadéquate.

---
## Problème de l'oeuf et de la poule
![width:500px center](https://clockwise.software/img/blog/solve-the-chicken-and-egg-problem/header-background.webp)

K8s est notre environnement cible, mais ArgoCD ne gère pas de ressources cloud. Il faut donc un minimum de Bicep pour *bootstrapper* le tout, et il faut soit les gérer à bras, soit réintroduire les pipelines d'infra et toute la complexité qui s'y attache.

---
## Bootstrapping difficile
Il est aussi difficile d'automatiser la configuration du cluster pour par exemple y installer ArgoCD lui-même, et possiblement impossible de le faire de manière idempotente. 

Le processus nécessite beaucoup d'interventions manuelles, et de gestion de principaux et de permissions pour que les diverse composantes puissent se parler.

*Overall*, pour tirer profit de cette approche, il faut assumer la permanence de la solution.

---
## Éparpillement des responsabilités
On voit aussi une perte de clareté dans la hiérarchie des concepts. Dans le SaasTemplate existant, la répo Git et ses pipelines gèrent tout du début à la fin ou presque. Avec la solution démontrée ici, une partie existe dans Git, et une autre dans ArgoCD, et les deux sont maintenus en tandem.

*Celà étant dit*, on peut régler une partie du problème en gérant les ressources ArgoCD à partir de Git, et en gérant un système ArgoCD organisationnel. 

---
## Technologie immature 
ArgoCD est une techno plutôt stable, mais ce n'est pas le cas pour *Image Updater* qui est toujours en mode preview.

---
## Nécessite un changement majeur de paradigme
Comme déterminé plus tôt, ce n'est pas vraiment réaliste de mettre en place la méthodologie GitOps sans aussi adopter Kubernetes et tout ce qui en découle. 