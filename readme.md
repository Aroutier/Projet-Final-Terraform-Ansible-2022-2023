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
Les groupes sont « front », « backend1 », « backend2 » et « backend3 ». Au sein de chaque groupe, il existe plusieurs hôtes définis à l’aide de variables telles que `${front}`, `${instance_grav_first}` et `${instance_sbg_first}`. Les informations de connexion pour chaque hôtes incluent le nom d’utilisateur (debian) et s’il faut utiliser become (True) pour exécuter les commandes avec des privilèges élevés. De plus, le groupe « backend3 » a une variable IpPrive avec `${frontPrivée}` qui va être utilisée dans les playbooks.

### Myprojet.tf

Il nous faut maintenant configurer les ressources OpenStack à l'aide du script Terraform **Myprojet.tf**, dans lequel je définis comment deployer nos instances. 

Plus précisément, ce script crée trois types de ressources :

> Deux paires de clés nommées « Keypair_GRA11 » et « Keypair_SBG5 » en utilisant le fournisseur OpenStack « openstack.ovh » et la clé publique à partir du fichier « ~/.ssh/id_rsa.pub ».

> Trois instances
•	« Instance_Backend_GRA11 » avec la clé « Keypair_GRA11 »
•	« Instance_Backend_SBG5 » avec la clé « Keypair_SBG5 »
•	« Instance_Front » dans la région GRA11, avec la clé « Keypair_GRA11 »

> Une ressource réseau privée nommée « ovh_cloud_project_network_private » avec certains attributs tels que service_name, project_id et région.
Les instances sont connectées au réseau « Ext-Net » par défaut et au réseau privé créé. Les instances ont également un attribut « depends_on » qui fait référence à la ressource « ovh_cloud_project_network_private_subnet.subnet ».

### infrastructure_deployement.yml

Ce playbook Ansible exécute une série de tâches sur différents groupes d’hôtes. 

> La première tâche, « Partie pour récupérer les facts du groupe1 depuis localhost », récupère des informations sur les hôtes du groupe « backend1 » et s’exécute sur le groupe d’hôtes « front ». 

> La tâche suivante, « Installer et configurer une page Web de chaton », installe et configure le serveur Web Nginx sur le groupe d’hôtes « backend1 », y compris la mise à jour des référentiels de paquets, l’installation de Nginx, le démarrage du service Nginx et la configuration d’une page Web « chaton » à l’aide d’un modèle.

> « Installer et configurer docker », installe et configure Docker sur le groupe d’hôtes « backend2 », y compris l’installation des paquets système requis, l’ajout de la clé apt Docker GPG, l’ajout du référentiel Docker, la mise à jour d’apt et l’installation de Docker-CE, l’installation de docker-compose et l’exécution d’un conteneur à l’aide de la commande « docker-compose up -d » dans un dossier spécifique.
 
> « Partie pour récupérer les facts du groupe2 depuis localhost », est similaire à la première tâche et récupère des informations sur les hôtes du groupe « backend2 » et s’exécute sur le groupe d’hôtes « front ».

> La dernière tâche, « Installer et configurer haproxy », installe et configure HAProxy sur le groupe d’hôtes « frontaux », y compris l’installation de HAProxy, la copie du fichier de configuration HAProxy à partir d’un modèle et le redémarrage du service HAProxy.



Ces fichiers étant configurés, nous pouvons enfin déployer nos instances.

Pour déployer nos instances on lance la commande `source ~/openrc.sh` à la racine de notre session.

¨Puis, dans eductive22@master:~/tp-wordpress-eductive22/config/terraform$ , on saisit la commande `terraform apply` (on demandera de saisir la value, rentrer yes).

Afin de provisionser les machines et de se connceter en ssh, on lance la commande `ansible-playbook infrastructure_deployement.yml -i inventory.yml`.

 Nous pouvons ajouter l'extension `--ssh-common-args='-o StrictHostKeyChecking=no'` à la commande pour autoriser automatiquement les fingerprints.
 
 Nos instances sont bien montés.
 
 ![image](https://user-images.githubusercontent.com/105780244/212196657-fc25255e-cca6-4b52-9594-d549367b2ac7.png)

 
 ![image](https://user-images.githubusercontent.com/105780244/212196350-cc6d459d-a4a6-445c-be91-ced7f9214fca.png)








