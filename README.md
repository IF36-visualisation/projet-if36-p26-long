# Projet IF36 : Counter-Strike 2

# Introduction

&nbsp;&nbsp;&nbsp;&nbsp; Bienvenue dans les coulisses de Counter-Strike 2.
Les fichiers .dem, ces boîtes noires du jeu, ne sont pas de simples replays : ce sont des flux de données brutes, enregistrant chaque tick du serveur avec la précision d’un horloger suisse. Ici, CS2 n’est pas qu’une question de réflexes, c’est un générateur de données, où chaque poulet sacrifié sur Inferno, chaque "Have Fun" lancé dans le chat, et chaque millimètre de déplacement est méticuleusement archivé.

&nbsp;&nbsp;&nbsp;&nbsp;**Notre mission ?** Nous allons analyser cet amas de données pour répondre a certaines questions. Par exemple décrypter si la politesse est une stratégie gagnante : un "Have Fun" dans le chat, est-ce un buff de victoire ou juste une prière avant de se faire one-tap ? Ou encore trancher la plus grande superstition de l’e-sport : sacrifier des poulets sur Inferno, est-ce un rituel sacré ou juste une façon de polluer notre base de données avec des cadavres de volailles ?

&nbsp;&nbsp;&nbsp;&nbsp;**L’objectif final ?** Transformer ce chaos binaire en visualisations percutantes. Heatmaps des zones de décès, efficacité des équipements en fonction de l’économie, impact psychologique d’un clutch… Bref, donner un sens visuel à des milliers de ticks invisibles, pour révéler les schémas cachés derrière chaque victoire.

>**En résumé** : On va prouver que derrière chaque "GG", chaque "EZ", et chaque poulet explosé, il y a une donnée qui attend d’être exploitée. 


<br>

## Information générale concernant Counter-Strike 2

#### Structure d'une partie
Une partie se déroule en 24 rounds maximum. La première équipe qui remporte 13 rounds gagne la partie.
Changement de camp : Après 12 rounds, les équipes inversent leurs rôles.

*Prolongations : En cas d'égalité 12-12, des prolongations sont jouées pour départager les équipes.*

#### Objectifs par camp
- **Terroristes (T)** : Ils doivent soit poser la bombe sur l'un des deux sites et la faire exploser, soit éliminer tous les joueurs de l'équipe adverse.

- **Contre-Terroristes (CT)** : Ils doivent empêcher la pose de la bombe, désamorcer la bombe si elle est posée, ou éliminer tous les joueurs adverses avant la fin du temps imparti.

#### Gestion économique
Chaque action (victoire, défaite, élimination, pose/désamorçage de bombe) rapporte de l'argent.

- **Achat** : Au début de chaque round, les joueurs utilisent cet argent pour acheter des armes, des protections (gilets/casques) et des grenades.
- **Stratégie** : Si l'équipe n'a pas assez d'argent, elle peut décider de faire un round "Eco" (acheter peu ou rien) pour économiser et pouvoir acheter de l'équipement complet au round suivant.

#### Déroulement d'un round
Un round dure environ 1 minute 55 secondes.

Phase d'achat : 15 secondes au début pour s'équiper.

L'explosion ou le temps : Si la bombe est posée, le chronomètre passe à 40 secondes. Les CT doivent alors désamorcer la bombe avant qu'elle n'explose.



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

*Les données sont stockées sous la forme :*

<div style="display:flex; justify-content : center; align-content:center; flex-wrap:wrap">

<div style="margin:20px">


**demos** : *Informations générales concernant le demo file*
| Colonne | Type | Commentaire |
|---------|------|------|
| **checksum** | `varchar` | Equivaut à l'identifiant de la partie |
| **name** | `varchar` | Nom du fichier : *Contient les équipes*|
| **game** | `varchar` | Toujours égale à CS2|
| **source** | `varchar` | Toujours égale à valve |
| **type** | `varchar` | Toujours égale à GOTV |
| **date** | `timestamptz` |  |
| **map_name** | `varchar` | |
| **tick_count** | `int4` | |
| **tickrate** | `float8` | |
| **framerate** | `float8` | |
| **duration** | `float8` | |
| **server_name** | `varchar` | *Inutile* |
| **client_name** | `varchar` |  *Inutile* |
| **network_protocol** | `int4` | *Inutile* |
| **build_number** | `int4` | *Inutile* |
| **share_code** | `varchar` | *Inutile* |

</div>

<div style="margin:20px">


**maps** : *Informations pour les cartes*
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` | |
| **name** | `varchar` | |
| **game** | `varchar` | CSGO / CS2 |
| **position_x** | `int4` | Information pour la mapping de la minicarte |
| **position_y** | `int4` | Information pour la mapping de la minicarte |
| **scale** | `float4` | Information pour la mapping de la minicarte |
| **threshold_z** | `int4` | Information pour la mapping de la minicarte |

</div>

<div style="margin:20px">


**matches** : *Informations relatives à une partie*
| Colonne | Type | Commentaire |
|---------|------|------|
| **checksum** | `varchar` | Equivalent de l'id |
| **demo_path** | `varchar` |
| **game_type** | `int4` | Toujours éagle à 0 ( Ici nous n'avons que des partie compétitive ) |
| **game_mode** | `int4` | Toujours égale à 0 ( Ici nous n'avons que des partie avec pose de bombe ) |
| **game_mode_str** | `varchar` | Toujours égale à casual (Dépend d'informations externe au demo file) |
| **is_ranked** | `bool` | Toujours égale à false (Dépend d'informations externe au demo file) |
| **kill_count** | `int4` |
| **death_count** | `int4` |
| **assist_count** | `int4` |
| **shot_count** | `int4` |
| **analyze_date** | `timestamptz` |
| **winner_name** | `varchar` |
| **winner_side** | `int2` | Egale à 3 ou 2 ( Correspond ... ) |
| **overtime_count** | `int4` |
| **max_rounds** | `int4` | Toujours égale à 24 |
| **has_vac_live_ban** | `bool` | *Inutile* |

</div>

<div style="margin:20px">


**players** : *Informations diverses sur le joueur en fin de partie*
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **steam_id** | `varchar` |
| **index** | `int2` |
| **team_name** | `varchar` |
| **name** | `varchar` |
| **kill_count** | `int4` |
| **death_count** | `int4` |
| **assist_count** | `int4` |
| **kill_death_ratio** | `float4` |
| **headshot_count** | `int4` |
| **headshot_percentage** | `float4` |
| **damage_health** | `int4` |
| **damage_armor** | `int4` |
| **first_kill_count** | `int4` |
| **first_death_count** | `int4` |
| **mvp_count** | `int4` | Most valuable player  |
| **average_damage_per_round** | `float4` |
| **average_kill_per_round** | `float4` |
| **average_death_per_round** | `float4` |
| **utility_damage_per_round** | `float4` |
| **rank_type** | `int4` | *Donnée non renseignée* |
| **rank** | `int4` | *Donnée non renseignée* |
| **old_rank** | `int4` | *Donnée non renseignée* |
| **wins_count** | `int4` |
| **bomb_planted_count** | `int4` |
| **bomb_defused_count** | `int4` |
| **hostage_rescued_count** | `int4` | *Inutile* |
| **score** | `int4` |
| **kast** | `float4` | Kill / Assist / Survived / Traded : Valorise le fait de ne par mourir inutilement|
| **hltv_rating** | `float4` | *Donnée lié au site* |
| **hltv_rating_2** | `float4` | *Donnée lié au site* |
| **utility_damage** | `int4` |
| **trade_kill_count** | `int4` |
| **trade_death_count** | `int4` |
| **first_trade_kill_count** | `int4` |
| **first_trade_death_count** | `int4` |
| **one_kill_count** | `int4` |
| **two_kill_count** | `int4` |
| **three_kill_count** | `int4` |
| **four_kill_count** | `int4` |
| **five_kill_count** | `int4` |
| **inspect_weapon_count** | `int4` |
| **color** | `int4` |
| **crosshair_share_code** | `varchar` |

</div>

<div style="margin:20px">

**rounds** : *Informations relatives aux rounds*
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **number** | `int4` |
| **start_tick** | `int4` |
| **start_frame** | `int4` |
| **freeze_time_end_tick** | `int4` |
| **freeze_time_end_frame** | `int4` |
| **end_tick** | `int4` |
| **end_frame** | `int4` |
| **end_officially_tick** | `int4` |
| **end_officially_frame** | `int4` |
| **team_a_name** | `varchar` |
| **team_b_name** | `varchar` |
| **team_a_score** | `int4` |
| **team_b_score** | `int4` |
| **team_a_side** | `int2` |
| **team_b_side** | `int2` |
| **team_a_start_money** | `int4` |
| **team_b_start_money** | `int4` |
| **team_a_equipment_value** | `int4` |
| **team_b_equipment_value** | `int4` |
| **team_a_money_spent** | `int4` |
| **team_b_money_spent** | `int4` |
| **team_a_economy_type** | `varchar` |
| **team_b_economy_type** | `varchar` |
| **duration** | `int4` |
| **end_reason** | `int2` |
| **winner_name** | `varchar` |
| **winner_side** | `int2` |
| **overtime_number** | `int4` |
</div>

<div style="margin:20px">


**player_economies**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **player_steam_id** | `varchar` |
| **player_name** | `varchar` |
| **player_side** | `int2` |
| **start_money** | `int4` |
| **money_spent** | `int4` |
| **equipement_value** | `int4` |
| **type** | `varchar` |
</div>


<div style="margin:20px">

**steam_accounts**
| Colonne | Type | Commentaire |
|---------|------|------|
| **steam_id** | `varchar` |
| **name** | `varchar` |
| **avatar** | `varchar` |
| **last_ban_date** | `timestamptz` |
| **is_community_banned** | `bool` |
| **has_private_profile** | `bool` |
| **vac_ban_count** | `int4` |
| **game_ban_count** | `int4` |
| **economy_ban** | `varchar` |
| **creation_date** | `timestamptz` |
| **created_at** | `timestamp` |
| **updated_at** | `timestamp` |
</div>

<div style="margin:20px">

**bombs_defused**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **site** | `varchar` |
| **defuser_steam_id** | `varchar` |
| **defuser_name** | `varchar` |
| **is_defuser_controlling_bot** | `bool` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |
| **ct_alive_count** | `int4` |
| **t_alive_count** | `int4` |

</div>

<div style="margin:20px">

**kills**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **killer_steam_id** | `varchar` |
| **killer_name** | `varchar` |
| **killer_team_name** | `varchar` |
| **killer_side** | `int2` |
| **victim_steam_id** | `varchar` |
| **victim_name** | `varchar` |
| **victim_team_name** | `varchar` |
| **victim_side** | `int2` |
| **assister_steam_id** | `varchar` |
| **assister_name** | `varchar` |
| **assister_team_name** | `varchar` |
| **assister_side** | `int2` |
| **is_headshot** | `bool` |
| **is_assisted_flash** | `bool` |
| **penetrated_objects** | `int4` |
| **killer_x** | `float8` |
| **killer_y** | `float8` |
| **killer_z** | `float8` |
| **is_killer_airbone** | `bool` |
| **is_killer_blinded** | `bool` |
| **victim_x** | `float8` |
| **victim_y** | `float8` |
| **victim_z** | `float8` |
| **is_victim_airbone** | `bool` |
| **is_victim_blinded** | `bool` |
| **is_victim_inspecting_weapon** | `bool` |
| **assister_x** | `float8` |
| **assister_y** | `float8` |
| **assister_z** | `float8` |
| **weapon_name** | `varchar` |
| **weapon_type** | `varchar` |
| **is_killer_controlling_bot** | `bool` |
| **is_victim_controlling_bot** | `bool` |
| **is_assister_controlling_bot** | `bool` |
| **is_trade_kill** | `bool` |
| **is_trade_death** | `bool` |
| **is_trough_smoke** | `bool` |
| **is_no_scope** | `bool` |
| **distance** | `float8` |

</div>

<div style="margin:20px">

**smokes_start**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **thrower_steam_id** | `varchar` |
| **thrower_name** | `varchar` |
| **thrower_team_name** | `varchar` |
| **thrower_side** | `int2` |
| **thrower_velocity_x** | `float8` |
| **thrower_velocity_y** | `float8` |
| **thrower_velocity_z** | `float8` |
| **thrower_yaw** | `float8` |
| **thrower_pitch** | `float8` |
| **grenade_id** | `varchar` |
| **projectile_id** | `varchar` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**shots**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **weapon_name** | `varchar` |
| **weapon_id** | `varchar` |
| **projectile_id** | `varchar` |
| **player_steam_id** | `varchar` |
| **player_side** | `int2` |
| **player_name** | `varchar` |
| **player_team_name** | `varchar` |
| **is_player_controlling_bot** | `bool` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |
| **player_velocity_x** | `float8` |
| **player_velocity_y** | `float8` |
| **player_velocity_z** | `float8` |
| **player_yaw** | `float8` |
| **player_pitch** | `float8` |
| **recoil_index** | `float8` |
| **aim_punch_angle_x** | `float8` |
| **aim_punch_angle_y** | `float8` |
| **view_punch_angle_x** | `float8` |
| **view_punch_angle_y** | `float8` |

</div>

<div style="margin:20px">

**damages**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **health_damage** | `int4` |
| **armor_damage** | `int4` |
| **victim_new_health** | `int4` |
| **victim_armor** | `int4` |
| **victim_new_armor** | `int4` |
| **is_victim_controlling_bot** | `bool` |
| **hitgroup** | `int2` |
| **weapon_name** | `varchar` |
| **weapon_type** | `varchar` |
| **attacker_steam_id** | `varchar` |
| **attacker_side** | `int2` |
| **attacker_team_name** | `varchar` |
| **is_attacker_controlling_bot** | `bool` |
| **victim_steam_id** | `varchar` |
| **victim_side** | `int2` |
| **victim_team_name** | `varchar` |
| **weapon_unique_id** | `varchar` |

</div>

<div style="margin:20px">

**chat_messages**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **message** | `varchar` |
| **sender_steam_id** | `varchar` |
| **sender_name** | `varchar` |
| **sender_is_alive** | `bool` |
| **sender_side** | `int2` |

</div>

<div style="margin:20px">

**player_buys**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **player_steam_id** | `varchar` |
| **player_name** | `varchar` |
| **weapon_name** | `varchar` |
| **weapon_type** | `varchar` |
| **weapon_unique_id** | `varchar` |
| **has_refunded** | `bool` |

</div>

<div style="margin:20px">

**clutches**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **clutcher_name** | `varchar` |
| **clutcher_steam_id** | `varchar` |
| **won** | `bool` |
| **side** | `int2` |
| **opponent_count** | `int4` |
| **has_clutcher_survived** | `bool` |
| **clutcher_kill_count** | `int4` |

</div>

<div style="margin:20px">

**bombs_defuse_start**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **defuser_steam_id** | `varchar` |
| **defuser_name** | `varchar` |
| **is_defuser_controlling_bot** | `bool` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**bombs_exploded**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **site** | `varchar` |
| **planter_steam_id** | `varchar` |
| **planter_name** | `varchar` |
| **is_planter_controlling_bot** | `bool` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**bombs_plant_start**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **site** | `varchar` |
| **planter_steam_id** | `varchar` |
| **planter_name** | `varchar` |
| **is_planter_controlling_bot** | `bool` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**bombs_planted**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **site** | `varchar` |
| **planter_steam_id** | `varchar` |
| **planter_name** | `varchar` |
| **is_planter_controlling_bot** | `bool` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**chicken_deaths**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **killer_steam_id** | `varchar` |
| **weapon_name** | `varchar` |

</div>

<div style="margin:20px">

**chicken_positions**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**decoys_start**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **thrower_steam_id** | `varchar` |
| **thrower_name** | `varchar` |
| **thrower_team_name** | `varchar` |
| **thrower_side** | `int2` |
| **thrower_velocity_x** | `float8` |
| **thrower_velocity_y** | `float8` |
| **thrower_velocity_z** | `float8` |
| **thrower_yaw** | `float8` |
| **thrower_pitch** | `float8` |
| **grenade_id** | `varchar` |
| **projectile_id** | `varchar` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**teams**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **name** | `varchar` |
| **current_side** | `int2` |
| **score** | `int4` |
| **score_first_half** | `int4` |
| **score_second_half** | `int4` |
| **letter** | `varchar` |

</div>

<div style="margin:20px">

**flashbangs_explode**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **thrower_steam_id** | `varchar` |
| **thrower_name** | `varchar` |
| **thrower_team_name** | `varchar` |
| **thrower_side** | `int2` |
| **thrower_velocity_x** | `float8` |
| **thrower_velocity_y** | `float8` |
| **thrower_velocity_z** | `float8` |
| **thrower_yaw** | `float8` |
| **thrower_pitch** | `float8` |
| **grenade_id** | `varchar` |
| **projectile_id** | `varchar` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**grenade_bounces**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **grenade_name** | `varchar` |
| **thrower_steam_id** | `varchar` |
| **thrower_name** | `varchar` |
| **thrower_team_name** | `varchar` |
| **thrower_side** | `int2` |
| **thrower_velocity_x** | `float8` |
| **thrower_velocity_y** | `float8` |
| **thrower_velocity_z** | `float8` |
| **thrower_yaw** | `float8` |
| **thrower_pitch** | `float8` |
| **grenade_id** | `varchar` |
| **projectile_id** | `varchar` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**grenade_positions**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **grenade_name** | `varchar` |
| **thrower_steam_id** | `varchar` |
| **thrower_name** | `varchar` |
| **thrower_team_name** | `varchar` |
| **thrower_side** | `int2` |
| **thrower_velocity_x** | `float8` |
| **thrower_velocity_y** | `float8` |
| **thrower_velocity_z** | `float8` |
| **thrower_yaw** | `float8` |
| **thrower_pitch** | `float8` |
| **grenade_id** | `varchar` |
| **projectile_id** | `varchar` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**grenade_projectiles_destroy**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **grenade_name** | `varchar` |
| **thrower_steam_id** | `varchar` |
| **thrower_name** | `varchar` |
| **thrower_team_name** | `varchar` |
| **thrower_side** | `int2` |
| **thrower_velocity_x** | `float8` |
| **thrower_velocity_y** | `float8` |
| **thrower_velocity_z** | `float8` |
| **thrower_yaw** | `float8` |
| **thrower_pitch** | `float8` |
| **grenade_id** | `varchar` |
| **projectile_id** | `varchar` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**he_grenades_explode**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **thrower_steam_id** | `varchar` |
| **thrower_name** | `varchar` |
| **thrower_team_name** | `varchar` |
| **thrower_side** | `int2` |
| **thrower_velocity_x** | `float8` |
| **thrower_velocity_y** | `float8` |
| **thrower_velocity_z** | `float8` |
| **thrower_yaw** | `float8` |
| **thrower_pitch** | `float8` |
| **grenade_id** | `varchar` |
| **projectile_id** | `varchar` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**inferno_positions**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **thrower_steam_id** | `varchar` |
| **thrower_name** | `varchar` |
| **unique_id** | `varchar` |
| **convex_hull_2d** | `varchar` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

</div>

<div style="margin:20px">

**player_blinds**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **duration** | `float8` |
| **flasher_steam_id** | `varchar` |
| **flasher_name** | `varchar` |
| **flasher_side** | `int2` |
| **is_flasher_controlling_bot** | `int2` |
| **flashed_steam_id** | `varchar` |
| **flashed_name** | `varchar` |
| **flashed_side** | `int2` |
| **is_flashed_controlling_bot** | `bool` |


</div>

<div style="margin:20px">

**player_positions**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **steam_id** | `varchar` |
| **name** | `varchar` |
| **team_name** | `varchar` |
| **side** | `int2` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |
| **yaw** | `float4` |
| **is_alive** | `bool` |
| **is_blinded** | `bool` |
| **is_airborne** | `bool` |
| **is_ducking** | `bool` |
| **is_walking** | `bool` |
| **is_scoped** | `bool` |
| **active_weapon_name** | `varchar` |
| **health** | `int4` |
| **armor** | `int4` |
| **has_helmet** | `bool` |
| **has_defuse_kit** | `bool` |
| **equipment_value** | `int4` |
| **money** | `int4` |

</div>

<div style="margin:20px">

**smokes_start**
| Colonne | Type | Commentaire |
|---------|------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **thrower_steam_id** | `varchar` |
| **grenade_id** | `varchar` |
| **projectile_id** | `varchar` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

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



## Plan d'analyse



### Qu'est-ce que nous voulons savoir ?

### Qu'est-ce que je pense trouver ?

### Comparaison ?

### Problèmes possibles ?

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
