# Projet-Final-Terraform-Ansible-2022-2023

## Niveau 1

Pour cette première partie sur Terraform, nous devons créer nos instances. 

Afin de cloisonner les dépendances, on travaillera dans un workspace terraform à part que nous appellerons terraform_workspace :

`terraform workspace new terraform_workspace`

### providers.tf

Ensuite on crée le fichier de configuration Terraform **providers.tf** qui définit les exigences de version pour Terraform. 
Ce fichier spécifie que la version requise de Terraform est « >= 0.14.0 » et définit également les fournisseurs à utiliser dans le script, OpenStack, OVH et Local. 
Il configure également le fournisseur OpenStack pour OVHcloud en spécifiant l’URL d’authentification, le nom de domaine et un alias.
Le bloc « provider » définit le fournisseur de la ressource, ainsi, le fournisseur pour openstack est OVHcloud.

on saisit la commande : `terraform init`

Notre Terraform est à présent initialisé.

On passe à présent à la configuration du fichier

