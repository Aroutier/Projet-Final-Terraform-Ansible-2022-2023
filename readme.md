# Projet-Final-Terraform-Ansible-2022-2023

## Niveau 1

Pour cette première partie sur Terraform, nous devons créer nos instances. 

Afin de cloisonner les dépendances, on travaillera dans un workspace terraform à part que nous appellerons terraform_workspace :

`terraform workspace new terraform_workspace`

Ensuite on crée le fichier de configuration Terraform **providers.tf** qui définit les exigences de version pour Terraform. Il spécifie que la version requise de Terraform est « >= 0.14.0 » et définit également les fournisseurs à utiliser dans le script, OpenStack, OVH et Local.

on saisit la commande : `terraform init`


