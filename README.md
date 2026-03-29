
# Projet IF36 : Counter-Strike 2

<div style="text-align: justify;">
<div align="center">
    <img src="https://www.pcworld.com/wp-content/uploads/2023/04/Counter-Strike-2.jpg?quality=50&strip=all" width="500" style="margin-bottom: 20px;">

</div>

## Table des Matières

- [Introduction](#introduction)
- [Information générale concernant Counter-Strike 2](#information-generale-concernant-counter---strike-2)
- [Données](#donnees)
- [Schema de la base de données](#schema-de-la-base-de-donnees)
- [Plan d'analyse](#plan-danalyse)
- [Glossaire](#glossaire)


# Introduction

&nbsp;&nbsp;&nbsp;&nbsp; Bienvenue dans les coulisses de Counter-Strike 2.
Les fichiers .dem, ces boîtes noires du jeu, ne sont pas de simples replays : ce sont des flux de données brutes, enregistrant chaque tick du serveur avec la précision d’un horloger suisse. Ici, CS2 n’est pas qu’une question de réflexes, c’est un générateur de données, où chaque poulet sacrifié sur Inferno, chaque "Have Fun" lancé dans le chat, et chaque millimètre de déplacement est méticuleusement archivé.

&nbsp;&nbsp;&nbsp;&nbsp;**Notre mission ?** Nous allons analyser cet amas de données pour répondre a certaines questions. Par exemple décrypter si la politesse est une stratégie gagnante : un "Have Fun" dans le chat, est-ce un buff de victoire ou juste une prière avant de se faire one-tap ? Ou encore trancher la plus grande superstition de l’e-sport : sacrifier des poulets sur Inferno, est-ce un rituel sacré ou juste une façon de polluer notre base de données avec des cadavres de volailles ?

&nbsp;&nbsp;&nbsp;&nbsp;**L’objectif final ?** Transformer ce chaos binaire en visualisations percutantes. Heatmaps des zones de décès, efficacité des équipements en fonction de l’économie, impact psychologique d’un clutch… Bref, donner un sens visuel à des milliers de ticks invisibles, pour révéler les schémas cachés derrière chaque victoire.

>**En résumé** : On va prouver que derrière chaque "GG", chaque "EZ", et chaque poulet explosé, il y a une donnée qui attend d’être exploitée. 

</div>

<br>

## Information générale concernant Counter-Strike 2

> [Voici une vidéo qui explique de manière brève le jeu](https://www.youtube.com/watch?v=2S6vYJl6nkA)

<br>

#### Structure d'une partie
&nbsp;&nbsp;&nbsp;&nbsp; Une partie se déroule en 24 rounds maximum. La première équipe qui remporte 13 rounds gagne la partie.
Changement de camp : Après 12 rounds, les équipes inversent leurs rôles.

> **Prolongations** : En cas d'égalité 12-12, des prolongations sont jouées pour départager les équipes.*

#### Objectifs par camp
- **Terroristes (T)** : Ils doivent soit poser la bombe sur l'un des deux sites et la faire exploser, soit éliminer tous les joueurs de l'équipe adverse.

- **Contre-Terroristes (CT)** : Ils doivent empêcher la pose de la bombe, désamorcer la bombe si elle est posée, ou éliminer tous les joueurs adverses avant la fin du temps imparti.

#### Gestion économique
Chaque action *(victoire, défaite, élimination, pose/désamorçage de bombe)* rapporte de l'argent.

- **Achat** : Au début de chaque round, les joueurs utilisent cet argent pour acheter des armes, des protections (gilets/casques) et des grenades.
- **Stratégie** : Si l'équipe n'a pas assez d'argent, elle peut décider de faire un round "Eco" (acheter peu ou rien) pour économiser et pouvoir acheter de l'équipement complet au round suivant.

#### Déroulement d'un round
Un round dure 1 minute et 55 secondes avec :

- **Phase d'achat** : 15 secondes au début pour s'équiper.
- **Phase de jeu** basé sur les objectifs de chaque camps
- **L'explosion ou le temps** : Si la bombe est posée, le chronomètre passe à 40 secondes. Les CT doivent alors désamorcer la bombe avant qu'elle n'explose.


<br>

## Données


### Type de données

<div style="text-align: justify;">

&nbsp;&nbsp;&nbsp;&nbsp; Notre dataset s'appuie sur les **fichiers de démo (.dem)** de Counter-Strike 2, qui permettent une reconstitution fidèle de chaque match. Ces fichiers enregistrent l'intégralité des données de jeu : de l'évolution du score aux déplacements précis des joueurs, incluant même les interactions avec l'environnement comme les mouvements des poulets. Grâce à ces archives, le moteur de jeu est capable de rejouer chaque action avec une précision absolue pour l'analyse.

> C'est cette précision qui justifie notre choix d'exploiter ce format de données.

</div> <br>

### Provenance des données

<div style="text-align: justify;">
<img src="https://static.wikia.nocookie.net/counter-strike-global-offensive/images/9/98/HLTV_-_logo.png/revision/latest?cb=20200118123847&path-prefix=pl" align="right" width="200" style="margin-left: 20px; margin-bottom: 20px;">

&nbsp;&nbsp;&nbsp;&nbsp; Nos fichiers demo proviennent du site **[HLTV](https://www.hltv.org/)**. C'est le site de référence mondial dédié à l'actualité, aux statistiques et à la couverture compétitive de Counter-Strike. Il propose notamment des classements d'équipes faisant autorité, des retransmissions de matchs en direct et une base de données exhaustive sur la scène professionnelle.

</div> <br>

Ici on a 522 demo files enregistrés avec :

<div style="display:flex; justify-content : center; align-content:center;">

| Nombre d'échantillon |  Nom de la map | Radar | Aperçu |
|---------|-----------|----|----|
| 103 |	de_mirage | <img src=".\images\maps\cs2\radars\de_mirage.png" width = 200> | <img src=".\images\maps\cs2\thumbnails\de_mirage.png" width = 200> 
| 51 |	de_overpass | <img src=".\images\maps\cs2\radars\de_overpass.png" width = 200> | <img src=".\images\maps\cs2\thumbnails\de_overpass.png" width = 200> 
| 37 |	de_anubis | <img src=".\images\maps\cs2\radars\de_anubis.png" width = 200> | <img src=".\images\maps\cs2\thumbnails\de_anubis.png" width = 200> 
| 61 |	de_inferno | <img src=".\images\maps\cs2\radars\de_inferno.png" width = 200> | <img src=".\images\maps\cs2\thumbnails\de_inferno.png" width = 200> 
| 10 |	de_train | <img src=".\images\maps\cs2\radars\de_train.png" width = 200> | <img src=".\images\maps\cs2\thumbnails\de_train.png" width = 200>  
| 95 |	de_ancient | <img src=".\images\maps\cs2\radars\de_ancient.png" width = 200> | <img src=".\images\maps\cs2\thumbnails\de_ancient.png" width = 200> 
| 79 |	de_nuke | <img src=".\images\maps\cs2\radars\de_nuke.png" width = 200> | <img src=".\images\maps\cs2\thumbnails\de_nuke.png" width = 200>  
| 86 |	de_dust2 |  <img src=".\images\maps\cs2\radars\de_dust2.png" width = 200> | <img src=".\images\maps\cs2\thumbnails\de_dust2.png" width = 200> 

</div>
<br>

> Nous conservons la possibilité d'enrichir continuellement cette base de données au cours du semestre en relançant notre pipeline, ou en croisant nos résultats avec une [API pour HLTV](https://hltv-api.vercel.app/) afin d'intégrer des statistiques avancées sur les performances des joueurs.

### Structure du Pipeline de Données

<div style="text-align: justify;">

Le traitement de nos données suit un flux automatisé divisé en trois étapes clés :

1.  **Collecte :** Récupération des archives `.rar` contenant les fichiers sources (*demos*) depuis les serveurs de **[HLTV](https://www.hltv.org/)**. *Chaque archive correspond à un match enregistrer par HLTV.*

2.  **Extraction :** Décompression des archives pour isoler les fichiers **.dem**, formats bruts des données de match.

3.  **Analyse et Stockage :** Utilisation de l'outil **[CSDM (CS Demo Manager)](https://cs-demo-manager.com/)** pour parser (analyser) les fichiers. Ce logiciel extrait les événements de jeu (kills, positions, économie) afin de les structurer et de les injecter directement dans notre base de données **PostgreSQL**. 

4. **Déploiement et Accessibilité :** Mise à disposition des données via un conteneur **PostgreSQL** couplé à l'interface d'administration **CloudBeaver**.  **[Accéder à l'interface](http://if36.collineos.ovh/)**

<br>

> **À propos de CSDM :** C'est une solution open-source de référence permettant de traduire le binaire complexe des fichiers démo en données lisibles et exploitables pour l'analyse statistique ou le replay.


> **Note technique :** Afin d'assurer la compatibilité avec l'environnement serveur (Linux/CLI), il a été nécessaire d'extraire l'exécutable binaire de **CSDM** de sa version graphique initiale pour permettre son exécution en ligne de commande sur notre distribution.

</div>

<br>


## Schema de la base de données

> Pour voir l'ensemble des liens entre les tables : [schema-bdd](schema-bdd.png)

<div style="display:flex; justify-content : center; align-content:center; flex-direction:column">

### Données générales sur les parties

<div style="margin:20px">


**demos**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **checksum** | `varchar` | Identifiant unique de la partie, souvent un hash ou une somme de contrôle pour vérifier l'intégrité du fichier. |
 | **name** | `varchar` | Nom du fichier demo : *Contient généralement les noms des équipes ou un identifiant personnalisé pour la partie.* |
 | **game** | `varchar` | Nom du jeu associé au fichier demo : *Toujours "CS2" (Counter-Strike 2).* |
 | **source** | `varchar` | Source du fichier demo : *Toujours "valve", indiquant que le fichier provient des serveurs officiels Valve.* |
 | **type** | `varchar` | Type de démonstration : *Toujours "GOTV" (Game Observer Television), utilisé pour les replays.* |
 | **date** | `timestamptz` | Date et heure de création ou d'enregistrement du fichier demo. |
 | **map_name** | `varchar` | Nom de la carte sur laquelle la partie a été jouée (ex: "de_dust2", "de_mirage"). |
 | **tick_count** | `int4` | Nombre total de ticks enregistrés dans le fichier demo : *Un tick est une unité de temps dans le moteur du jeu.* |
 | **tickrate** | `float8` | Fréquence des ticks par seconde : *Détermine la précision des événements enregistrés (ex: 64 ou 128 ticks/seconde).* |
 | **framerate** | `float8` | Nombre d'images par seconde (FPS) du replay. |
 | **duration** | `float8` | Durée totale de la partie en secondes. |
 | **server_name** | `varchar` | *Inutile* : Nom du serveur où la partie a été jouée. |
 | **client_name** | `varchar` | *Inutile* : Nom du client ou du joueur ayant enregistré le demo. |
 | **network_protocol** | `int4` | *Inutile* : Version du protocole réseau utilisé pendant la partie. |
 | **build_number** | `int4` | *Inutile* : Numéro de build du jeu au moment de l'enregistrement. |
 | **share_code** | `varchar` | *Inutile* : Code de partage pour accéder au replay via des plateformes tierces (ex: Faceit, ESEA). |

</div>

<div style="margin:20px">


**maps** 
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de la carte dans la base de données. |
 | **name** | `varchar` | Nom de la carte (ex: "de_dust2", "de_inferno", "de_mirage"). |
 | **game** | `varchar` | Version du jeu associée à la carte : *Peut être "CSGO" ou "CS2".* |
 | **position_x** | `int4` | Coordonnée X pour le positionnement de la minicarte : *Utilisé pour l'affichage visuel.* |
 | **position_y** | `int4` | Coordonnée Y pour le positionnement de la minicarte : *Utilisé pour l'affichage visuel.* |
 | **scale** | `float4` | Échelle de la minicarte : *Détermine la taille et le zoom pour l'affichage.* |
 | **threshold_z** | `int4` | Seuil Z pour le mapping : *Utilisé pour distinguer les niveaux de hauteur sur la minicarte (ex: étages, sous-sols).* |

</div>

<div style="margin:20px">


**matches** 
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **checksum** | `varchar` | Identifiant unique de la partie, équivalent à un ID. |
 | **demo_path** | `varchar` | Chemin d'accès ou URL vers le fichier demo de la partie. |
 | **game_type** | `int4` | Type de partie : *Toujours égal à 0 (uniquement des parties compétitives dans ce contexte).* |
 | **game_mode** | `int4` | Mode de jeu : *Toujours égal à 0 (uniquement des parties avec pose de bombe, ex: "Defuse").* |
 | **game_mode_str** | `varchar` | Mode de jeu sous forme de chaîne : *Toujours égal à "casual" (dépend d'informations externes au fichier demo).* |
 | **is_ranked** | `bool` | Indique si la partie est classée : *Toujours égal à false (dépend d'informations externes au fichier demo).* |
 | **kill_count** | `int4` | Nombre total de kills dans la partie. |
 | **death_count** | `int4` | Nombre total de morts dans la partie. |
 | **assist_count** | `int4` | Nombre total d'assistances dans la partie. |
 | **shot_count** | `int4` | Nombre total de tirs effectués pendant la partie. |
 | **analyze_date** | `timestamptz` | Date et heure à laquelle la partie a été analysée. |
 | **winner_name** | `varchar` | Nom de l'équipe ou du joueur gagnant. |
 | **winner_side** | `int2` | Côté du gagnant : *Égal à 3 (Terroristes) ou 2 (Contre-Terroristes).* |
 | **overtime_count** | `int4` | Nombre de prolongations jouées pendant la partie. |
 | **max_rounds** | `int4` | Nombre maximum de rounds prévus : *Toujours égal à 24 (standard pour les parties compétitives).* |
 | **has_vac_live_ban** | `bool` | *Inutile* : Indique si un joueur a été banni par VAC Live pendant la partie. |

</div>

<div style="margin:20px">

**rounds** 
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du round dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique de la partie (checksum) à laquelle ce round appartient. |
 | **number** | `int4` | Numéro du round dans la partie. |
 | **start_tick** | `int4` | Tick de début du round. |
 | **start_frame** | `int4` | Frame de début du round. |
 | **freeze_time_end_tick** | `int4` | Tick de fin du temps de gel (freeze time). |
 | **freeze_time_end_frame** | `int4` | Frame de fin du temps de gel (freeze time). |
 | **end_tick** | `int4` | Tick de fin du round. |
 | **end_frame** | `int4` | Frame de fin du round. |
 | **end_officially_tick** | `int4` | Tick de fin officielle du round (peut inclure des délais supplémentaires). |
 | **end_officially_frame** | `int4` | Frame de fin officielle du round (peut inclure des délais supplémentaires). |
 | **team_a_name** | `varchar` | Nom de l'équipe A. |
 | **team_b_name** | `varchar` | Nom de l'équipe B. |
 | **team_a_score** | `int4` | Score de l'équipe A à la fin du round. |
 | **team_b_score** | `int4` | Score de l'équipe B à la fin du round. |
 | **team_a_side** | `int2` | Côté de l'équipe A : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **team_b_side** | `int2` | Côté de l'équipe B : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **team_a_start_money** | `int4` | Argent disponible pour l'équipe A au début du round. |
 | **team_b_start_money** | `int4` | Argent disponible pour l'équipe B au début du round. |
 | **team_a_equipment_value** | `int4` | Valeur totale de l'équipement acheté par l'équipe A pendant le round. |
 | **team_b_equipment_value** | `int4` | Valeur totale de l'équipement acheté par l'équipe B pendant le round. |
 | **team_a_money_spent** | `int4` | Argent dépensé par l'équipe A pendant le round. |
 | **team_b_money_spent** | `int4` | Argent dépensé par l'équipe B pendant le round. |
 | **team_a_economy_type** | `varchar` | Type d'économie de l'équipe A (ex: "full buy", "eco", "force buy"). |
 | **team_b_economy_type** | `varchar` | Type d'économie de l'équipe B (ex: "full buy", "eco", "force buy"). |
 | **duration** | `int4` | Durée totale du round en secondes. |
 | **end_reason** | `int2` | Raison de la fin du round (ex: 1 pour victoire des Terroristes, 2 pour victoire des Contre-Terroristes, etc.). |
 | **winner_name** | `varchar` | Nom de l'équipe gagnante du round. |
 | **winner_side** | `int2` | Côté de l'équipe gagnante : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **overtime_number** | `int4` | Numéro de la prolongation si le round fait partie d'une overtime. |

</div>


<div style="margin:20px">

**teams**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de l'équipe dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie à laquelle cette équipe participe. |
 | **name** | `varchar` | Nom de l'équipe. |
 | **current_side** | `int2` | Côté actuel de l'équipe : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **score** | `int4` | Score total de l'équipe à la fin de la partie. |
 | **score_first_half** | `int4` | Score de l'équipe à la fin de la première mi-temps. |
 | **score_second_half** | `int4` | Score de l'équipe à la fin de la deuxième mi-temps. |
 | **letter** | `varchar` | Lettre attribuée à l'équipe (ex: "A" ou "B") pour la différencier dans la partie. |

</div>

<div style="margin:20px">

**kills**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du kill dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où le kill a eu lieu. |
 | **round_number** | `int4` | Numéro du round pendant lequel le kill a été enregistré. |
 | **tick** | `int4` | Tick précis auquel le kill a eu lieu. |
 | **frame** | `int4` | Frame précise à laquelle le kill a eu lieu. |
 | **killer_steam_id** | `varchar` | Identifiant Steam du joueur ayant effectué le kill. |
 | **killer_name** | `varchar` | Nom du joueur ayant effectué le kill. |
 | **killer_team_name** | `varchar` | Nom de l'équipe du tueur. |
 | **killer_side** | `int2` | Côté du tueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **victim_steam_id** | `varchar` | Identifiant Steam du joueur victime. |
 | **victim_name** | `varchar` | Nom du joueur victime. |
 | **victim_team_name** | `varchar` | Nom de l'équipe de la victime. |
 | **victim_side** | `int2` | Côté de la victime : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **assister_steam_id** | `varchar` | Identifiant Steam du joueur ayant assisté au kill (si applicable). |
 | **assister_name** | `varchar` | Nom du joueur ayant assisté au kill (si applicable). |
 | **assister_team_name** | `varchar` | Nom de l'équipe de l'assistant (si applicable). |
 | **assister_side** | `int2` | Côté de l'assistant : *2 pour Contre-Terroristes, 3 pour Terroristes (si applicable).* |
 | **is_headshot** | `bool` | Indique si le kill est un headshot. |
 | **is_assisted_flash** | `bool` | Indique si le kill a été assisté par un flashbang. |
 | **penetrated_objects** | `int4` | Nombre d'objets traversés par le tir (ex: murs, caisses). |
 | **killer_x** | `float8` | Coordonnée X du tueur au moment du kill. |
 | **killer_y** | `float8` | Coordonnée Y du tueur au moment du kill. |
 | **killer_z** | `float8` | Coordonnée Z du tueur au moment du kill. |
 | **is_killer_airbone** | `bool` | Indique si le tueur était en l'air (sautant) au moment du kill. |
 | **is_killer_blinded** | `bool` | Indique si le tueur était aveuglé (par un flashbang) au moment du kill. |
 | **victim_x** | `float8` | Coordonnée X de la victime au moment du kill. |
 | **victim_y** | `float8` | Coordonnée Y de la victime au moment du kill. |
 | **victim_z** | `float8` | Coordonnée Z de la victime au moment du kill. |
 | **is_victim_airbone** | `bool` | Indique si la victime était en l'air (sautant) au moment du kill. |
 | **is_victim_blinded** | `bool` | Indique si la victime était aveuglée (par un flashbang) au moment du kill. |
 | **is_victim_inspecting_weapon** | `bool` | Indique si la victime était en train d'inspecter son arme au moment du kill. |
 | **assister_x** | `float8` | Coordonnée X de l'assistant au moment du kill (si applicable). |
 | **assister_y** | `float8` | Coordonnée Y de l'assistant au moment du kill (si applicable). |
 | **assister_z** | `float8` | Coordonnée Z de l'assistant au moment du kill (si applicable). |
 | **weapon_name** | `varchar` | Nom de l'arme utilisée pour le kill. |
 | **weapon_type** | `varchar` | Type de l'arme utilisée (ex: "Rifle", "Pistol", "Knife"). |
 | **is_killer_controlling_bot** | `bool` | Indique si le tueur contrôlait un bot au moment du kill. |
 | **is_victim_controlling_bot** | `bool` | Indique si la victime était un bot contrôlé au moment du kill. |
 | **is_assister_controlling_bot** | `bool` | Indique si l'assistant contrôlait un bot au moment du kill (si applicable). |
 | **is_trade_kill** | `bool` | Indique si ce kill fait partie d'un échange de kills (trade kill). |
 | **is_trade_death** | `bool` | Indique si ce kill est une mort échangée (trade death). |
 | **is_trough_smoke** | `bool` | Indique si le tir a traversé de la fumée. |
 | **is_no_scope** | `bool` | Indique si le kill a été effectué sans viseur (no scope). |
 | **distance** | `float8` | Distance entre le tueur et la victime au moment du kill. |

</div>

<div style="margin:20px">

**shots**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du tir dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où le tir a été effectué. |
 | **round_number** | `int4` | Numéro du round pendant lequel le tir a été effectué. |
 | **tick** | `int4` | Tick précis auquel le tir a été effectué. |
 | **frame** | `int4` | Frame précise à laquelle le tir a été effectué. |
 | **weapon_name** | `varchar` | Nom de l'arme utilisée pour le tir. |
 | **weapon_id** | `varchar` | Identifiant unique de l'arme dans le jeu. |
 | **projectile_id** | `varchar` | Identifiant unique du projectile tiré (si applicable). |
 | **player_steam_id** | `varchar` | Identifiant Steam du joueur ayant tiré. |
 | **player_side** | `int2` | Côté du joueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **player_name** | `varchar` | Nom du joueur ayant tiré. |
 | **player_team_name** | `varchar` | Nom de l'équipe du joueur. |
 | **is_player_controlling_bot** | `bool` | Indique si le joueur contrôlait un bot au moment du tir. |
 | **x** | `float8` | Coordonnée X du joueur au moment du tir. |
 | **y** | `float8` | Coordonnée Y du joueur au moment du tir. |
 | **z** | `float8` | Coordonnée Z du joueur au moment du tir. |
 | **player_velocity_x** | `float8` | Vitesse du joueur sur l'axe X au moment du tir. |
 | **player_velocity_y** | `float8` | Vitesse du joueur sur l'axe Y au moment du tir. |
 | **player_velocity_z** | `float8` | Vitesse du joueur sur l'axe Z au moment du tir. |
 | **player_yaw** | `float8` | Angle de rotation horizontale (yaw) du joueur au moment du tir. |
 | **player_pitch** | `float8` | Angle de rotation verticale (pitch) du joueur au moment du tir. |
 | **recoil_index** | `float8` | Index de recul de l'arme au moment du tir (influe sur la précision). |
 | **aim_punch_angle_x** | `float8` | Angle de perturbation de la visée (aim punch) sur l'axe X, dû au recul ou à des dégâts subis. |
 | **aim_punch_angle_y** | `float8` | Angle de perturbation de la visée (aim punch) sur l'axe Y, dû au recul ou à des dégâts subis. |
 | **view_punch_angle_x** | `float8` | Angle de perturbation de la vue (view punch) sur l'axe X, souvent causé par des explosions ou des impacts. |
 | **view_punch_angle_y** | `float8` | Angle de perturbation de la vue (view punch) sur l'axe Y, souvent causé par des explosions ou des impacts. |

</div>

<div style="margin:20px">

**damages**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du dégât infligé dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où le dégât a été infligé. |
 | **round_number** | `int4` | Numéro du round pendant lequel le dégât a été infligé. |
 | **tick** | `int4` | Tick précis auquel le dégât a été infligé. |
 | **frame** | `int4` | Frame précise à laquelle le dégât a été infligé. |
 | **health_damage** | `int4` | Quantité de dégâts infligés à la santé de la victime. |
 | **armor_damage** | `int4` | Quantité de dégâts infligés à l'armure de la victime. |
 | **victim_new_health** | `int4` | Santé restante de la victime après avoir subi le dégât. |
 | **victim_armor** | `int4` | Quantité d'armure de la victime avant le dégât. |
 | **victim_new_armor** | `int4` | Quantité d'armure restante de la victime après le dégât. |
 | **is_victim_controlling_bot** | `bool` | Indique si la victime contrôlait un bot au moment du dégât. |
 | **hitgroup** | `int2` | Groupe de touchés (hitgroup) : *1 pour tête, 2 pour torse, 3 pour estomac, 4 pour bras, 5 pour jambes.* |
 | **weapon_name** | `varchar` | Nom de l'arme utilisée pour infliger le dégât. |
 | **weapon_type** | `varchar` | Type de l'arme utilisée (ex: "Rifle", "Pistol", "Knife", "Grenade"). |
 | **attacker_steam_id** | `varchar` | Identifiant Steam du joueur ayant infligé le dégât. |
 | **attacker_side** | `int2` | Côté de l'attaquant : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **attacker_team_name** | `varchar` | Nom de l'équipe de l'attaquant. |
 | **is_attacker_controlling_bot** | `bool` | Indique si l'attaquant contrôlait un bot au moment du dégât. |
 | **victim_steam_id** | `varchar` | Identifiant Steam de la victime. |
 | **victim_side** | `int2` | Côté de la victime : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **victim_team_name** | `varchar` | Nom de l'équipe de la victime. |
 | **weapon_unique_id** | `varchar` | Identifiant unique de l'arme dans le jeu ayant infligé le dégât. |

</div>

<div style="margin:20px">

**chat_messages**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du message dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où le message a été envoyé. |
 | **round_number** | `int4` | Numéro du round pendant lequel le message a été envoyé. |
 | **tick** | `int4` | Tick précis auquel le message a été envoyé. |
 | **frame** | `int4` | Frame précise à laquelle le message a été envoyé. |
 | **message** | `varchar` | Contenu textuel du message envoyé dans le chat. |
 | **sender_steam_id** | `varchar` | Identifiant Steam de l'expéditeur du message. |
 | **sender_name** | `varchar` | Nom de l'expéditeur du message. |
 | **sender_is_alive** | `bool` | Indique si l'expéditeur était en vie au moment de l'envoi du message. |
 | **sender_side** | `int2` | Côté de l'expéditeur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |

</div>



<div style="margin:20px">

**clutches**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du clutch dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où le clutch a eu lieu. |
 | **round_number** | `int4` | Numéro du round pendant lequel le clutch s'est produit. |
 | **tick** | `int4` | Tick précis auquel le clutch a commencé. |
 | **frame** | `int4` | Frame précise à laquelle le clutch a commencé. |
 | **clutcher_name** | `varchar` | Nom du joueur réalisant le clutch. |
 | **clutcher_steam_id** | `varchar` | Identifiant Steam du joueur réalisant le clutch. |
 | **won** | `bool` | Indique si le clutch a été remporté par le joueur. |
 | **side** | `int2` | Côté du joueur en clutch : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **opponent_count** | `int4` | Nombre d'adversaires restants au début du clutch. |
 | **has_clutcher_survived** | `bool` | Indique si le joueur a survécu à la fin du clutch. |
 | **clutcher_kill_count** | `int4` | Nombre de kills réalisés par le joueur pendant le clutch. |

</div>

### Données sur les joueurs


<div style="margin:20px">

**players** 
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du joueur dans la base de données pour cette partie. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie. |
 | **steam_id** | `varchar` | Identifiant Steam du joueur. |
 | **index** | `int2` | Index du joueur dans la partie (position dans la liste des joueurs). |
 | **team_name** | `varchar` | Nom de l'équipe du joueur. |
 | **name** | `varchar` | Nom du joueur. |
 | **kill_count** | `int4` | Nombre total de kills du joueur pendant la partie. |
 | **death_count** | `int4` | Nombre total de morts du joueur pendant la partie. |
 | **assist_count** | `int4` | Nombre total d'assistances du joueur pendant la partie. |
 | **kill_death_ratio** | `float4` | Ratio kills/morts du joueur. |
 | **headshot_count** | `int4` | Nombre total de headshots réalisés par le joueur. |
 | **headshot_percentage** | `float4` | Pourcentage de headshots parmi les kills du joueur. |
 | **damage_health** | `int4` | Total des dégâts infligés à la santé des adversaires. |
 | **damage_armor** | `int4` | Total des dégâts infligés à l'armure des adversaires. |
 | **first_kill_count** | `int4` | Nombre de fois où le joueur a réalisé le premier kill d'un round. |
 | **first_death_count** | `int4` | Nombre de fois où le joueur est mort en premier dans un round. |
 | **mvp_count** | `int4` | Nombre de fois où le joueur a été MVP (Most Valuable Player) d'un round. |
 | **average_damage_per_round** | `float4` | Moyenne des dégâts infligés par round. |
 | **average_kill_per_round** | `float4` | Moyenne de kills par round. |
 | **average_death_per_round** | `float4` | Moyenne de morts par round. |
 | **utility_damage_per_round** | `float4` | Moyenne des dégâts infligés par les utilitaires (grenades, etc.) par round. |
 | **rank_type** | `int4` | *Donnée non renseignée* : Type de rang du joueur (ex: compétitif, wingman). |
 | **rank** | `int4` | *Donnée non renseignée* : Rang actuel du joueur. |
 | **old_rank** | `int4` | *Donnée non renseignée* : Ancien rang du joueur avant la partie. |
 | **wins_count** | `int4` | Nombre total de victoires du joueur. |
 | **bomb_planted_count** | `int4` | Nombre de bombes posées par le joueur. |
 | **bomb_defused_count** | `int4` | Nombre de bombes désamorçées par le joueur. |
 | **hostage_rescued_count** | `int4` | *Inutile* : Nombre d'otages sauvés (mode non pertinent pour CS2 compétitif). |
 | **score** | `int4` | Score total du joueur à la fin de la partie. |
 | **kast** | `float4` | Pourcentage de rounds où le joueur a tué, assisté, survécu ou échangé un kill. |
 | **hltv_rating** | `float4` | *Donnée liée au site HLTV* : Note calculée par HLTV reflétant la performance globale. |
 | **hltv_rating_2** | `float4` | *Donnée liée au site HLTV* : Variante ou mise à jour du HLTV rating. |
 | **utility_damage** | `int4` | Total des dégâts infligés par les utilitaires (grenades, etc.). |
 | **trade_kill_count** | `int4` | Nombre de kills échangés (trade kills) par le joueur. |
 | **trade_death_count** | `int4` | Nombre de morts échangées (trade deaths) du joueur. |
 | **first_trade_kill_count** | `int4` | Nombre de fois où le joueur a réalisé le premier kill d'un échange. |
 | **first_trade_death_count** | `int4` | Nombre de fois où le joueur est mort en premier lors d'un échange. |
 | **one_kill_count** | `int4` | Nombre de rounds avec exactement un kill. |
 | **two_kill_count** | `int4` | Nombre de rounds avec exactement deux kills. |
 | **three_kill_count** | `int4` | Nombre de rounds avec exactement trois kills. |
 | **four_kill_count** | `int4` | Nombre de rounds avec exactement quatre kills. |
 | **five_kill_count** | `int4` | Nombre de rounds avec exactement cinq kills (ace). |
 | **inspect_weapon_count** | `int4` | Nombre de fois où le joueur a inspecté son arme. |
 | **color** | `int4` | Couleur associée au joueur (pour l'affichage ou l'interface). |
 | **crosshair_share_code** | `varchar` | Code de partage du crosshair du joueur. |

</div>

<div style="margin:20px">

**player_buys**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de l'achat dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où l'achat a été effectué. |
 | **round_number** | `int4` | Numéro du round pendant lequel l'achat a été effectué. |
 | **tick** | `int4` | Tick précis auquel l'achat a été effectué. |
 | **frame** | `int4` | Frame précise à laquelle l'achat a été effectué. |
 | **player_steam_id** | `varchar` | Identifiant Steam du joueur ayant effectué l'achat. |
 | **player_name** | `varchar` | Nom du joueur ayant effectué l'achat. |
 | **weapon_name** | `varchar` | Nom de l'arme ou de l'équipement acheté. |
 | **weapon_type** | `varchar` | Type de l'arme ou de l'équipement acheté (ex: "Rifle", "Pistol", "Grenade", "Equipment"). |
 | **weapon_unique_id** | `varchar` | Identifiant unique de l'arme ou de l'équipement dans le jeu. |
 | **has_refunded** | `bool` | Indique si l'achat a été remboursé (annulé) par le joueur. |

</div>

<div style="margin:20px">


**player_economies**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de l'économie du joueur pour ce round dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie. |
 | **round_number** | `int4` | Numéro du round concerné. |
 | **player_steam_id** | `varchar` | Identifiant Steam du joueur. |
 | **player_name** | `varchar` | Nom du joueur. |
 | **player_side** | `int2` | Côté du joueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **start_money** | `int4` | Argent disponible pour le joueur au début du round. |
 | **money_spent** | `int4` | Argent dépensé par le joueur pendant le round. |
 | **equipement_value** | `int4` | Valeur totale de l'équipement acheté par le joueur pendant le round. |
 | **type** | `varchar` | Type d'économie du joueur pour ce round (ex: "full buy", "eco", "force buy", "semi-eco"). |
</div>


<div style="margin:20px">

**player_blinds**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de l'éblouissement dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où l'éblouissement a eu lieu. |
 | **round_number** | `int4` | Numéro du round pendant lequel l'éblouissement a eu lieu. |
 | **tick** | `int4` | Tick précis auquel l'éblouissement a commencé. |
 | **frame** | `int4` | Frame précise à laquelle l'éblouissement a commencé. |
 | **duration** | `float8` | Durée totale de l'éblouissement en secondes. |
 | **flasher_steam_id** | `varchar` | Identifiant Steam du joueur ayant lancé le flashbang. |
 | **flasher_name** | `varchar` | Nom du joueur ayant lancé le flashbang. |
 | **flasher_side** | `int2` | Côté du joueur ayant lancé le flashbang : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **is_flasher_controlling_bot** | `int2` | Indique si le joueur ayant lancé le flashbang contrôlait un bot. |
 | **flashed_steam_id** | `varchar` | Identifiant Steam du joueur ébloui. |
 | **flashed_name** | `varchar` | Nom du joueur ébloui. |
 | **flashed_side** | `int2` | Côté du joueur ébloui : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **is_flashed_controlling_bot** | `bool` | Indique si le joueur ébloui contrôlait un bot. |


</div>

<div style="margin:20px">

**player_positions**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de la position du joueur dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie. |
 | **round_number** | `int4` | Numéro du round concerné. |
 | **tick** | `int4` | Tick précis auquel la position a été enregistrée. |
 | **frame** | `int4` | Frame précise à laquelle la position a été enregistrée. |
 | **steam_id** | `varchar` | Identifiant Steam du joueur. |
 | **name** | `varchar` | Nom du joueur. |
 | **team_name** | `varchar` | Nom de l'équipe du joueur. |
 | **side** | `int2` | Côté du joueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **x** | `float8` | Coordonnée X de la position du joueur. |
 | **y** | `float8` | Coordonnée Y de la position du joueur. |
 | **z** | `float8` | Coordonnée Z de la position du joueur. |
 | **yaw** | `float4` | Angle de rotation horizontale (yaw) du joueur. |
 | **is_alive** | `bool` | Indique si le joueur est en vie. |
 | **is_blinded** | `bool` | Indique si le joueur est ébloui (par un flashbang). |
 | **is_airborne** | `bool` | Indique si le joueur est dans les airs (saut, chute). |
 | **is_ducking** | `bool` | Indique si le joueur est accroupi. |
 | **is_walking** | `bool` | Indique si le joueur est en train de marcher (et non de courir). |
 | **is_scoped** | `bool` | Indique si le joueur utilise le viseur de son arme. |
 | **active_weapon_name** | `varchar` | Nom de l'arme active du joueur. |
 | **health** | `int4` | Points de vie actuels du joueur. |
 | **armor** | `int4` | Points d'armure actuels du joueur. |
 | **has_helmet** | `bool` | Indique si le joueur porte un casque. |
 | **has_defuse_kit** | `bool` | Indique si le joueur possède un kit de désamorçage (side CT uniquement). |
 | **equipment_value** | `int4` | Valeur totale de l'équipement actuel du joueur. |
 | **money** | `int4` | Argent actuel du joueur. |

</div>

<div style="margin:20px">

**steam_accounts**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **steam_id** | `varchar` | Identifiant Steam unique du compte. |
 | **name** | `varchar` | Nom d'utilisateur ou pseudonyme du compte Steam. |
 | **avatar** | `varchar` | URL ou chemin vers l'avatar du compte. |
 | **last_ban_date** | `timestamptz` | Date et heure du dernier bannissement (VAC, jeu, communauté). |
 | **is_community_banned** | `bool` | Indique si le compte est banni de la communauté Steam. |
 | **has_private_profile** | `bool` | Indique si le profil Steam est privé. |
 | **vac_ban_count** | `int4` | Nombre total de bannissements VAC (Valves Anti-Cheat) sur le compte. |
 | **game_ban_count** | `int4` | Nombre total de bannissements de jeu (hors VAC). |
 | **economy_ban** | `varchar` | Statut du bannissement économique (ex: "none", "probation", "banned"). |
 | **creation_date** | `timestamptz` | Date et heure de création du compte Steam. |
 | **created_at** | `timestamp` | Date et heure de création de l'entrée dans la base de données. |
 | **updated_at** | `timestamp` | Date et heure de la dernière mise à jour de l'entrée dans la base de données. |
</div>

### Données sur les bombes

<div style="margin:20px">

**bombs_defused**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du désamorçage dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où la bombe a été désamorcée. |
 | **round_number** | `int4` | Numéro du round pendant lequel la bombe a été désamorcée. |
 | **tick** | `int4` | Tick précis auquel la bombe a été désamorcée. |
 | **frame** | `int4` | Frame précise à laquelle la bombe a été désamorcée. |
 | **site** | `varchar` | Site de désamorçage (ex: "A", "B"). |
 | **defuser_steam_id** | `varchar` | Identifiant Steam du joueur ayant désamorcé la bombe. |
 | **defuser_name** | `varchar` | Nom du joueur ayant désamorcé la bombe. |
 | **is_defuser_controlling_bot** | `bool` | Indique si le joueur contrôlait un bot au moment du désamorçage. |
 | **x** | `float8` | Coordonnée X de la position du désamorçage. |
 | **y** | `float8` | Coordonnée Y de la position du désamorçage. |
 | **z** | `float8` | Coordonnée Z de la position du désamorçage. |
 | **ct_alive_count** | `int4` | Nombre de Contre-Terroristes en vie au moment du désamorçage. |
 | **t_alive_count** | `int4` | Nombre de Terroristes en vie au moment du désamorçage. |

</div>

<div style="margin:20px">

**bombs_defuse_start**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du début de désamorçage dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où le désamorçage a commencé. |
 | **round_number** | `int4` | Numéro du round pendant lequel le désamorçage a commencé. |
 | **tick** | `int4` | Tick précis auquel le désamorçage a commencé. |
 | **frame** | `int4` | Frame précise à laquelle le désamorçage a commencé. |
 | **defuser_steam_id** | `varchar` | Identifiant Steam du joueur ayant commencé à désamorcer la bombe. |
 | **defuser_name** | `varchar` | Nom du joueur ayant commencé à désamorcer la bombe. |
 | **is_defuser_controlling_bot** | `bool` | Indique si le joueur contrôlait un bot au moment du début du désamorçage. |
 | **x** | `float8` | Coordonnée X de la position du début de désamorçage. |
 | **y** | `float8` | Coordonnée Y de la position du début de désamorçage. |
 | **z** | `float8` | Coordonnée Z de la position du début de désamorçage. |

</div>

<div style="margin:20px">

**bombs_exploded**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de l'explosion de bombe dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où la bombe a explosé. |
 | **round_number** | `int4` | Numéro du round pendant lequel la bombe a explosé. |
 | **tick** | `int4` | Tick précis auquel la bombe a explosé. |
 | **frame** | `int4` | Frame précise à laquelle la bombe a explosé. |
 | **site** | `varchar` | Site où la bombe a explosé (ex: "A", "B"). |
 | **planter_steam_id** | `varchar` | Identifiant Steam du joueur ayant posé la bombe. |
 | **planter_name** | `varchar` | Nom du joueur ayant posé la bombe. |
 | **is_planter_controlling_bot** | `bool` | Indique si le joueur contrôlait un bot au moment de la pose de la bombe. |
 | **x** | `float8` | Coordonnée X de la position de l'explosion. |
 | **y** | `float8` | Coordonnée Y de la position de l'explosion. |
 | **z** | `float8` | Coordonnée Z de la position de l'explosion. |

</div>

<div style="margin:20px">

**bombs_plant_start**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du début de pose de bombe dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où la pose de bombe a commencé. |
 | **round_number** | `int4` | Numéro du round pendant lequel la pose de bombe a commencé. |
 | **tick** | `int4` | Tick précis auquel la pose de bombe a commencé. |
 | **frame** | `int4` | Frame précise à laquelle la pose de bombe a commencé. |
 | **site** | `varchar` | Site où la bombe est en train d'être posée (ex: "A", "B"). |
 | **planter_steam_id** | `varchar` | Identifiant Steam du joueur posant la bombe. |
 | **planter_name** | `varchar` | Nom du joueur posant la bombe. |
 | **is_planter_controlling_bot** | `bool` | Indique si le joueur contrôlait un bot au moment du début de la pose. |
 | **x** | `float8` | Coordonnée X de la position du début de pose. |
 | **y** | `float8` | Coordonnée Y de la position du début de pose. |
 | **z** | `float8` | Coordonnée Z de la position du début de pose. |

</div>

<div style="margin:20px">

**bombs_planted**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de la pose de bombe dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où la bombe a été posée. |
 | **round_number** | `int4` | Numéro du round pendant lequel la bombe a été posée. |
 | **tick** | `int4` | Tick précis auquel la bombe a été posée. |
 | **frame** | `int4` | Frame précise à laquelle la bombe a été posée. |
 | **site** | `varchar` | Site où la bombe a été posée (ex: "A", "B"). |
 | **planter_steam_id** | `varchar` | Identifiant Steam du joueur ayant posé la bombe. |
 | **planter_name** | `varchar` | Nom du joueur ayant posé la bombe. |
 | **is_planter_controlling_bot** | `bool` | Indique si le joueur contrôlait un bot au moment de la pose. |
 | **x** | `float8` | Coordonnée X de la position de la bombe posée. |
 | **y** | `float8` | Coordonnée Y de la position de la bombe posée. |
 | **z** | `float8` | Coordonnée Z de la position de la bombe posée. |

</div>



### Données sur les équipements ( Grenades, Smoke, Inferno )

<div style="margin:20px">

**smokes_start**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du début de fumée dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où la fumée a été lancée. |
 | **round_number** | `int4` | Numéro du round pendant lequel la fumée a été lancée. |
 | **tick** | `int4` | Tick précis auquel la fumée a été lancée. |
 | **frame** | `int4` | Frame précise à laquelle la fumée a été lancée. |
 | **thrower_steam_id** | `varchar` | Identifiant Steam du joueur ayant lancé la fumée. |
 | **thrower_name** | `varchar` | Nom du joueur ayant lancé la fumée. |
 | **thrower_team_name** | `varchar` | Nom de l'équipe du joueur ayant lancé la fumée. |
 | **thrower_side** | `int2` | Côté du joueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **thrower_velocity_x** | `float8` | Vitesse du lanceur sur l'axe X au moment du lancer. |
 | **thrower_velocity_y** | `float8` | Vitesse du lanceur sur l'axe Y au moment du lancer. |
 | **thrower_velocity_z** | `float8` | Vitesse du lanceur sur l'axe Z au moment du lancer. |
 | **thrower_yaw** | `float8` | Angle de rotation horizontale (yaw) du lanceur au moment du lancer. |
 | **thrower_pitch** | `float8` | Angle de rotation verticale (pitch) du lanceur au moment du lancer. |
 | **grenade_id** | `varchar` | Identifiant unique de la grenade fumée dans le jeu. |
 | **projectile_id** | `varchar` | Identifiant unique du projectile (fumée) dans le jeu. |
 | **x** | `float8` | Coordonnée X de la position de départ de la fumée. |
 | **y** | `float8` | Coordonnée Y de la position de départ de la fumée. |
 | **z** | `float8` | Coordonnée Z de la position de départ de la fumée. |

</div>

<div style="margin:20px">

**decoys_start**
   Col leur | Type | Commentaire |
 |----------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du début de leurre dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où le leurre a été lancé. |
 | **round_number** | `int4` | Numéro du round pendant lequel le leurre a été lancé. |
 | **tick** | `int4` | Tick précis auquel le leurre a été lancé. |
 | **frame** | `int4` | Frame précise à laquelle le leurre a été lancé. |
 | **thrower_steam_id** | `varchar` | Identifiant Steam du joueur ayant lancé le leurre. |
 | **thrower_name** | `varchar` | Nom du joueur ayant lancé le leurre. |
 | **thrower_team_name** | `varchar` | Nom de l'équipe du joueur ayant lancé le leurre. |
 | **thrower_side** | `int2` | Côté du joueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **thrower_velocity_x** | `float8` | Vitesse du lanceur sur l'axe X au moment du lancer. |
 | **thrower_velocity_y** | `float8` | Vitesse du lanceur sur l'axe Y au moment du lancer. |
 | **thrower_velocity_z** | `float8` | Vitesse du lanceur sur l'axe Z au moment du lancer. |
 | **thrower_yaw** | `float8` | Angle de rotation horizontale (yaw) du lanceur au moment du lancer. |
 | **thrower_pitch** | `float8` | Angle de rotation verticale (pitch) du lanceur au moment du lancer. |
 | **grenade_id** | `varchar` | Identifiant unique de la grenade leurre dans le jeu. |
 | **projectile_id** | `varchar` | Identifiant unique du projectile (leurre) dans le jeu. |
 | **x** | `float8` | Coordonnée X de la position de départ du leurre. |
 | **y** | `float8` | Coordonnée Y de la position de départ du leurre. |
 | **z** | `float8` | Coordonnée Z de la position de départ du leurre. |

</div>

<div style="margin:20px">

**flashbangs_explode**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de l'explosion du flashbang dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où le flashbang a explosé. |
 | **round_number** | `int4` | Numéro du round pendant lequel le flashbang a explosé. |
 | **tick** | `int4` | Tick précis auquel le flashbang a explosé. |
 | **frame** | `int4` | Frame précise à laquelle le flashbang a explosé. |
 | **thrower_steam_id** | `varchar` | Identifiant Steam du joueur ayant lancé le flashbang. |
 | **thrower_name** | `varchar` | Nom du joueur ayant lancé le flashbang. |
 | **thrower_team_name** | `varchar` | Nom de l'équipe du joueur ayant lancé le flashbang. |
 | **thrower_side** | `int2` | Côté du joueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **thrower_velocity_x** | `float8` | Vitesse du lanceur sur l'axe X au moment du lancer. |
 | **thrower_velocity_y** | `float8` | Vitesse du lanceur sur l'axe Y au moment du lancer. |
 | **thrower_velocity_z** | `float8` | Vitesse du lanceur sur l'axe Z au moment du lancer. |
 | **thrower_yaw** | `float8` | Angle de rotation horizontale (yaw) du lanceur au moment du lancer. |
 | **thrower_pitch** | `float8` | Angle de rotation verticale (pitch) du lanceur au moment du lancer. |
 | **grenade_id** | `varchar` | Identifiant unique de la grenade flashbang dans le jeu. |
 | **projectile_id** | `varchar` | Identifiant unique du projectile (flashbang) dans le jeu. |
 | **x** | `float8` | Coordonnée X de la position de l'explosion du flashbang. |
 | **y** | `float8` | Coordonnée Y de la position de l'explosion du flashbang. |
 | **z** | `float8` | Coordonnée Z de la position de l'explosion du flashbang. |

</div>

<div style="margin:20px">

**grenade_bounces**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du rebond de grenade dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où la grenade a rebondi. |
 | **round_number** | `int4` | Numéro du round pendant lequel la grenade a rebondi. |
 | **tick** | `int4` | Tick précis auquel la grenade a rebondi. |
 | **frame** | `int4` | Frame précise à laquelle la grenade a rebondi. |
 | **grenade_name** | `varchar` | Nom de la grenade (ex: "flashbang", "smoke", "hegrenade", "decoy"). |
 | **thrower_steam_id** | `varchar` | Identifiant Steam du joueur ayant lancé la grenade. |
 | **thrower_name** | `varchar` | Nom du joueur ayant lancé la grenade. |
 | **thrower_team_name** | `varchar` | Nom de l'équipe du joueur ayant lancé la grenade. |
 | **thrower_side** | `int2` | Côté du joueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **thrower_velocity_x** | `float8` | Vitesse du lanceur sur l'axe X au moment du lancer. |
 | **thrower_velocity_y** | `float8` | Vitesse du lanceur sur l'axe Y au moment du lancer. |
 | **thrower_velocity_z** | `float8` | Vitesse du lanceur sur l'axe Z au moment du lancer. |
 | **thrower_yaw** | `float8` | Angle de rotation horizontale (yaw) du lanceur au moment du lancer. |
 | **thrower_pitch** | `float8` | Angle de rotation verticale (pitch) du lanceur au moment du lancer. |
 | **grenade_id** | `varchar` | Identifiant unique de la grenade dans le jeu. |
 | **projectile_id** | `varchar` | Identifiant unique du projectile (grenade) dans le jeu. |
 | **x** | `float8` | Coordonnée X de la position du rebond. |
 | **y** | `float8` | Coordonnée Y de la position du rebond. |
 | **z** | `float8` | Coordonnée Z de la position du rebond. |

</div>

<div style="margin:20px">

**grenade_positions**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de la position de la grenade dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où la position de la grenade a été enregistrée. |
 | **round_number** | `int4` | Numéro du round pendant lequel la position a été enregistrée. |
 | **tick** | `int4` | Tick précis auquel la position a été enregistrée. |
 | **frame** | `int4` | Frame précise à laquelle la position a été enregistrée. |
 | **grenade_name** | `varchar` | Nom de la grenade (ex: "flashbang", "smoke", "hegrenade", "decoy"). |
 | **thrower_steam_id** | `varchar` | Identifiant Steam du joueur ayant lancé la grenade. |
 | **thrower_name** | `varchar` | Nom du joueur ayant lancé la grenade. |
 | **thrower_team_name** | `varchar` | Nom de l'équipe du joueur ayant lancé la grenade. |
 | **thrower_side** | `int2` | Côté du joueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **thrower_velocity_x** | `float8` | Vitesse du lanceur sur l'axe X au moment du lancer. |
 | **thrower_velocity_y** | `float8` | Vitesse du lanceur sur l'axe Y au moment du lancer. |
 | **thrower_velocity_z** | `float8` | Vitesse du lanceur sur l'axe Z au moment du lancer. |
 | **thrower_yaw** | `float8` | Angle de rotation horizontale (yaw) du lanceur au moment du lancer. |
 | **thrower_pitch** | `float8` | Angle de rotation verticale (pitch) du lanceur au moment du lancer. |
 | **grenade_id** | `varchar` | Identifiant unique de la grenade dans le jeu. |
 | **projectile_id** | `varchar` | Identifiant unique du projectile (grenade) dans le jeu. |
 | **x** | `float8` | Coordonnée X de la position de la grenade. |
 | **y** | `float8` | Coordonnée Y de la position de la grenade. |
 | **z** | `float8` | Coordonnée Z de la position de la grenade. |

</div>

<div style="margin:20px">

**grenade_projectiles_destroy**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de la destruction du projectile de grenade dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où le projectile a été détruit. |
 | **round_number** | `int4` | Numéro du round pendant lequel le projectile a été détruit. |
 | **tick** | `int4` | Tick précis auquel le projectile a été détruit. |
 | **frame** | `int4` | Frame précise à laquelle le projectile a été détruit. |
 | **grenade_name** | `varchar` | Nom de la grenade (ex: "flashbang", "smoke", "hegrenade", "decoy"). |
 | **thrower_steam_id** | `varchar` | Identifiant Steam du joueur ayant lancé la grenade. |
 | **thrower_name** | `varchar` | Nom du joueur ayant lancé la grenade. |
 | **thrower_team_name** | `varchar` | Nom de l'équipe du joueur ayant lancé la grenade. |
 | **thrower_side** | `int2` | Côté du joueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **thrower_velocity_x** | `float8` | Vitesse du lanceur sur l'axe X au moment du lancer. |
 | **thrower_velocity_y** | `float8` | Vitesse du lanceur sur l'axe Y au moment du lancer. |
 | **thrower_velocity_z** | `float8` | Vitesse du lanceur sur l'axe Z au moment du lancer. |
 | **thrower_yaw** | `float8` | Angle de rotation horizontale (yaw) du lanceur au moment du lancer. |
 | **thrower_pitch** | `float8` | Angle de rotation verticale (pitch) du lanceur au moment du lancer. |
 | **grenade_id** | `varchar` | Identifiant unique de la grenade dans le jeu. |
 | **projectile_id** | `varchar` | Identifiant unique du projectile (grenade) dans le jeu. |
 | **x** | `float8` | Coordonnée X de la position de destruction du projectile. |
 | **y** | `float8` | Coordonnée Y de la position de destruction du projectile. |
 | **z** | `float8` | Coordonnée Z de la position de destruction du projectile. |

</div>

<div style="margin:20px">

**he_grenades_explode**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de l'explosion de la grenade HE dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où la grenade HE a explosé. |
 | **round_number** | `int4` | Numéro du round pendant lequel la grenade HE a explosé. |
 | **tick** | `int4` | Tick précis auquel la grenade HE a explosé. |
 | **frame** | `int4` | Frame précise à laquelle la grenade HE a explosé. |
 | **thrower_steam_id** | `varchar` | Identifiant Steam du joueur ayant lancé la grenade HE. |
 | **thrower_name** | `varchar` | Nom du joueur ayant lancé la grenade HE. |
 | **thrower_team_name** | `varchar` | Nom de l'équipe du joueur ayant lancé la grenade HE. |
 | **thrower_side** | `int2` | Côté du joueur : *2 pour Contre-Terroristes, 3 pour Terroristes.* |
 | **thrower_velocity_x** | `float8` | Vitesse du lanceur sur l'axe X au moment du lancer. |
 | **thrower_velocity_y** | `float8` | Vitesse du lanceur sur l'axe Y au moment du lancer. |
 | **thrower_velocity_z** | `float8` | Vitesse du lanceur sur l'axe Z au moment du lancer. |
 | **thrower_yaw** | `float8` | Angle de rotation horizontale (yaw) du lanceur au moment du lancer. |
 | **thrower_pitch** | `float8` | Angle de rotation verticale (pitch) du lanceur au moment du lancer. |
 | **grenade_id** | `varchar` | Identifiant unique de la grenade HE dans le jeu. |
 | **projectile_id** | `varchar` | Identifiant unique du projectile (grenade HE) dans le jeu. |
 | **x** | `float8` | Coordonnée X de la position de l'explosion. |
 | **y** | `float8` | Coordonnée Y de la position de l'explosion. |
 | **z** | `float8` | Coordonnée Z de la position de l'explosion. |

</div>

<div style="margin:20px">

**inferno_positions**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de la position de l'incendie (inferno) dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où l'incendie a été enregistré. |
 | **round_number** | `int4` | Numéro du round pendant lequel l'incendie a été enregistré. |
 | **tick** | `int4` | Tick précis auquel la position de l'incendie a été enregistrée. |
 | **frame** | `int4` | Frame précise à laquelle la position de l'incendie a été enregistrée. |
 | **thrower_steam_id** | `varchar` | Identifiant Steam du joueur ayant lancé la grenade incendiaire (molotov/incendiary). |
 | **thrower_name** | `varchar` | Nom du joueur ayant lancé la grenade incendiaire. |
 | **unique_id** | `varchar` | Identifiant unique de l'incendie dans le jeu. |
 | **convex_hull_2d** | `varchar` | Représentation 2D de la zone couverte par l'incendie (souvent sous forme de polygone ou de liste de points). |
 | **x** | `float8` | Coordonnée X de la position centrale ou de référence de l'incendie. |
 | **y** | `float8` | Coordonnée Y de la position centrale ou de référence de l'incendie. |
 | **z** | `float8` | Coordonnée Z de la position centrale ou de référence de l'incendie. |
</div>

<div style="margin:20px">

**smokes_start**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique du début de la fumée dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où la fumée a commencé. |
 | **round_number** | `int4` | Numéro du round pendant lequel la fumée a commencé. |
 | **tick** | `int4` | Tick précis auquel la fumée a commencé. |
 | **frame** | `int4` | Frame précise à laquelle la fumée a commencé. |
 | **thrower_steam_id** | `varchar` | Identifiant Steam du joueur ayant lancé la fumée. |
 | **grenade_id** | `varchar` | Identifiant unique de la grenade fumée dans le jeu. |
 | **projectile_id** | `varchar` | Identifiant unique du projectile (fumée) dans le jeu. |
 | **x** | `float8` | Coordonnée X de la position de départ de la fumée. |
 | **y** | `float8` | Coordonnée Y de la position de départ de la fumée. |
 | **z** | `float8` | Coordonnée Z de la position de départ de la fumée. |

</div>





### Données sur les poulets


<div style="margin:20px">

**chicken_deaths**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de la mort d'un poulet dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où le poulet est mort. |
 | **round_number** | `int4` | Numéro du round pendant lequel le poulet est mort. |
 | **tick** | `int4` | Tick précis auquel le poulet est mort. |
 | **frame** | `int4` | Frame précise à laquelle le poulet est mort. |
 | **killer_steam_id** | `varchar` | Identifiant Steam du joueur ayant tué le poulet. |
 | **weapon_name** | `varchar` | Nom de l'arme utilisée pour tuer le poulet. |

</div>

<div style="margin:20px">

**chicken_positions**
   Colonne | Type | Commentaire |
 |---------|------|-------------|
 | **id** | `bigserial` | Identifiant unique de la position du poulet dans la base de données. |
 | **match_checksum** | `varchar` | Identifiant unique (checksum) de la partie où la position du poulet a été enregistrée. |
 | **round_number** | `int4` | Numéro du round pendant lequel la position a été enregistrée. |
 | **tick** | `int4` | Tick précis auquel la position a été enregistrée. |
 | **frame** | `int4` | Frame précise à laquelle la position a été enregistrée. |
 | **x** | `float8` | Coordonnée X de la position du poulet. |
 | **y** | `float8` | Coordonnée Y de la position du poulet. |
 | **z** | `float8` | Coordonnée Z de la position du poulet. |

</div>


</div>

---
### Prise de position concernant la base de données

Nous avons retiré des tables vides générées par CSDM :

- steam_account_overrides
- steam_account_tags
- hostage_rescued
- faceit_accounts
- faceit_match_players
- faceit_match_teams
- hostage_pick_up_start
- hostage_picked_up
- hostage_positions
- round_tags
- round_comments
- renown_accounts
- player_comments
- ignored_steam_accounts
- faceit_matches
- comments
- checksum_tags
- 5eplay_accounts
- demo_paths
- download_history

*Certaines de ces tables vides étaient à prévoir car nos demo files ne contiennent que des parties compétitives avec bombe, donc sans otages.*

De plus certaines tables ne sont pas utiles elle servent simplement au fonctionnement de l'application :
- tags
- timestamps
- migrations
- cameras

<br>

> On peut identifier des sous-groupes qui correspondent aux rounds joués dans une certaine map.


<br>

---

## Plan d'analyse

*Notre plan d’analyse est découpé en plusieurs parties, chacune ayant leur propre but et domaines d’analyse.*

On retrouve:

**Les stratégies**
**Les relations**
**Les analyses sur le temps**
**Les probabilités**
**Les questions liés aux équipes**


### Les stratégies
*Ici, les stratégies sont étudiés pour savoir lesquelles font gagner le plus souvent*

Les données comparées pourraient inclure : la position moyenne des joueurs, les armes achetées, la position de la pose de la bombe, la position des kills, la gestion des rounds eco, sur quel site on désamorce le plus la bombe, une équipe utilise-t-elle plus de bombes smoke ou explosive… 
…donc toute donnée pouvant refléter une quelconque stratégie. 
Cela pourra ensuite être comparé au taux de victoire de chaque stratégie.

- L'économie détermine-t-elle vraiment l'issue d'un round ? -> Hypothèse : un "full buy" bat presque toujours un "eco". On croisera team_a_economy_type / team_b_economy_type avec winner_side dans la table rounds. 

- Est ce qu'on a le même pourcentage de win lors d'un round eco lorsqu'on est en défense et en attaque ? ->

- Les équipes qui "tradent" mieux (is_trade_kill) gagnent-elles plus de rounds ? ->

- Sur chaque map, quel site mène le plus souvent à la victoire des T ? ->

- Les smokes posées près des sites de bombe augmentent-elles le taux de victoire des T ? ->


### Les relations
*Le but de ce type d’analyse est de discerner des relations entre les variables, permettant ainsi de prédire l’une en fonction de l’autre.*

- La grenade est-elle plus utilisée par les terro ou les CT ?

- Les 20% avec le moins de kills vs avec le plus de kills, qui tue le plus de poulet ? ->(comparaison)

- Sur quels endroits de la map il y a le plus de kills ? -> (distribution)

- Quel côté (T ou CT) a un avantage structurel selon les maps ? -> On s'attend à trouver des asymétries selon les cartes (ex : Inferno traditionnellement favorable aux T). On comparera winner_side par map_name 

- Envoyer "Have Fun" / "GG" / "EZ" en début de partie influence-t-il le résultat ? -> On filtrera chat_messages sur des mots-clés, puis on croisera avec winner_name dans matches.

- Tuer un poulet sur Inferno est-il corrélé à la victoire du round ? -> On filtrera chicken_deaths sur de_inferno, on associera les rounds correspondants via match_checksum + round_number, puis on regardera winner_side.

- Le premier kill d'un round est-il décisif ?  ->

- Est-ce que les joueurs toxiques (ceux qui insultent dans le chat) ont de meilleures ou de moins bonnes performances? -> On filtrera chat_messages sur des mots-clés, puis on croisera avec winner_name dans matches. 

- Une équipe qui domine la première mi-temps maintient-elle son avantage après le changement de camp ? ->

- Plus un joueur fait de dégâts par round, plus son KD est élevé ? ->



### Les analyses sur le temps
*Ces analyses permettent une compréhension sur le temps de l’évolution des tendances (certaines de ces questions risquent de ne pas avoir de réponse possible au vu la forme des données, ie limité dans le temps).*

- Les techniques de jeu ont-elles évolué au cours du temps ? -> (évolution des métas)

- Quelles armes sont les plus utilisées ? -> (comparaison)

- Quels ont été les maps les plus populaires ? Pourquoi ? -> (nombre d’action spectaculaire, richesse des stratégies)

- Quelles ont été les équipes gagnant le plus de matchs ? Pourquoi ? -> (changement des joueurs, changement des stratégies, changement du coach)



###  Les probabilités
*Chaque variable étudiée ici permet d’observer sa distribution ou sa probabilité pour proposer une prédiction de la valeur suite de cette même variable, ou d’une autre, correlée.*


- Quelle est la probabilité de gagner un clutch (pourcentage pour chaque nombre de joueur: 1v5, 1v4, etc) ? -> probabilité

- Où meurt-on le plus sur chaque map ? -> On utilisera les coordonnées victim_x, victim_y de la table kills. probabilité



### Les questions liés aux équipes

Cette sesction est particulière, car après réflection, nous avons considéré que la réalisation de visualisation sur les questions relevants des équipes, et notamment leurs stratégies, serait trop compliqués à mettre en place. 
En effet, la majorité des parties lancés sont anonymes, donc non-traçable dans l'idée de faire un suivi de ces dernières; de plus cela nécessiterait (dans le cas des stratégies) de pouvoir reconstituer les parties via leurs données de jeu, afin de manuellement déterminer la/les stratégie.s utilisée.s, puis faire une études de ces nouvelles données.

Ainsi vous trouverez en dessous un echantillon de questions auquels nous n'apporterons pas de réponses:

- Un joueur gagne-t-il plus dans une équipe qu’une autre ? Si oui, quels sont les facteurs qui influencent le potentiel d’un joueur à bien jouer ou non

- Y a t-il des maps qui favorisent certaines équipes ? (certaines équipes sont plus à l’aise sur certaines map)

- Les équipes ont-elles des stratégies différentes ?

- Quelles sont les meilleures stratégies ?



### Problèmes possibles ?

Notre banque de données est plutôt longue, ce qui est un avantage, mais requiert donc une organisation méticuleuse pour bien être exploitée.
Notre base de données possède beaucoup d'entrées, mais sur une temporalité limitée; si l'on souhaite faire des études sur la durée, cela peut amener des complications liés à la récupération de données, quoi que faisable.

Aussi, les termes techniques du jeu pourraient mettre des barrières à ceux n’étant pas familier avec le jeu ou ne le connaissant que peu, ainsi nous avons pris la liberté de réaliser un glossaire des termes les moins explicites.

Les données ne concernant que le pro play, aucun résultat n'est généralisable à l'utilisation dite classique du jeu.

<br>

----
## Annexes


### Glossaire

- **Traded** : Un joueur est considéré comme "tradé" lorsqu'il meurt, mais qu'un coéquipier élimine immédiatement son tueur.

- **Tick** : L'unité de mesure de la fréquence de rafraîchissement du serveur. Le serveur met à jour l'état du jeu (position des joueurs, tirs, etc.) à un intervalle régulier.

- **Frame** : Une image unique affichée par l'écran.

- **Decoy** : Une grenade leurre.

- **Clutch** : Une situation de jeu où un joueur se retrouve seul face à plusieurs adversaires. Réussir le "clutch" signifie remporter la manche malgré l'infériorité numérique.

- **Pistol Round** : Le tout premier round de chaque mi-temps (round 1 et round 13). Tout le monde commence avec 800$ et uniquement des pistolets. La victoire ici est cruciale car elle donne un avantage financier immédiat pour les rounds suivants.

- **Eco (Economy Round)** : Un round où l'équipe dépense le moins d'argent possible (souvent 0$) afin d'économiser pour le round suivant. Le but est de pouvoir acheter un équipement complet (fusils, grenades, kevlar) plus tard.

- **Full Eco** : Identique à l'Eco, mais plus strict. Les joueurs n'achètent absolument rien, pas même un pistolet, afin de garantir une accumulation maximale de fonds pour le round d'après.

- **Full Buy** : L'opposé de l'Eco. L'équipe dépense une grande partie de son argent pour s'équiper au mieux : fusil d'assaut principal (AK-47 ou M4), kevlar + casque, et une série complète de grenades.

- **Force-buy** : Une situation où l'équipe décide d'acheter tout ce qu'elle peut, même si le budget est incomplet, pour tenter de gagner un round important alors que les finances sont fragiles. C'est un pari risqué pour tenter de briser l'économie adverse.

<br>

> Nous nous gardons le droit d'enrichir ce glossaire au fur et à mesure de nos analyses

<br>

<div align="center">
    
[Retour en haut](#-Projet-IF36--Counter---Strike-2)

</div>

