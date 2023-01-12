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

### variables.tf

On passe à présent à la configuration du fichier **variables.tf** qui permet la déclaration de variables Terraform. 
Ces variables sont utilisées dans le script Terraform pour définir des ressources, telles que la région des instances, le nombre d’instances, le nom des instances, le nom du service et les détails du VLAN.


### inventory.tmpl

Dorénavant, il nous faut spécifier un groupe d’hôtes et les informations de connexion pour chaque hôtes dans le fichier d’inventaire Ansible **inventory.tmpl**.
Les groupes sont « front », « backend1 », « backend2 » et « backend3 ». Au sein de chaque groupe, il existe plusieurs hôtes définis à l’aide de variables telles que ${front}, ${instance_grav_first} et ${instance_sbg_first}. Les informations de connexion pour chaque hôtes incluent le nom d’utilisateur (debian) et s’il faut utiliser become (True) pour exécuter les commandes avec des privilèges élevés. De plus, le groupe « backend3 » a une variable IpPrive avec ${frontPrivée} qui va être utilisée dans les playbooks.

### Myprojet.tf

Il nous faut maintenant configurer les ressources OpenStack à l'aide du script Terraform **Myprojet.tf**. 

Plus précisément, ce script crée trois types de ressources :

--> aire de clés : le script crée deux paires de clés nommées « Keypair_GRA11 » et « Keypair_SBG5 » en utilisant le fournisseur OpenStack « openstack.ovh » et la clé publique à partir du fichier « ~/.ssh/id_rsa.pub ».
2.	Instance : le script crée trois instances
•	« Instance_Backend_GRA11 » avec un compte de « var.i » et la paire de touches « Keypair_GRA11 »
•	« Instance_Backend_SBG » avec un compte de « var.i » et la paire de touches « Keypair_SBG5 »
•	« Instance_Front » avec un compte de 1, dans la région GRA11, et la paire de clés « Keypair_GRA11 »
3.	Réseau : le script crée une ressource réseau privée nommée « ovh_cloud_project_network_private » avec certains attributs tels que service_name, project_id et région.
Les instances sont connectées au réseau « Ext-Net » par défaut et au réseau privé créé. Les instances ont également un attribut « depends_on » qui fait référence à la ressource « ovh_cloud_project_network_private_subnet.subnet ».







