# Projet IF36 : Counter-Strike 2

## Introduction

### Données

*Vos données décrites en détails avec le nombre d’observations et de variables, et le type des variables. D’où viennent-elles, pourquoi les avez-vous choisies, dans quel contexte s’intègre-elles ? Quel est leur format ? Y a-t-il des catégories ou des sous-groupes au sein des données ?*

**Type de données**

*Explication des fichiers .dem de Counter Strike, leur usage, et leur format*


**Provenance des données**

*Grabbing sur le site HLTV*

**Explication du pipeline**

*On récupère la données, on la décrypte avec le logiciel ( siter ), puis les données sont stockées dans une base de données postgresql*

**Mise a disposition des credentials**

*Possible d'accéder aux données depuis une interface dbeaver avec les mdp suivants*

**Schema de la base de données**

*Les données sont stocker sous la forme :*

\
**5eplay_accounts**
| Colonne | Type |
|---------|------|
| **id** | `varchar` |
| **domain_id** | `varchar` |
| **nickname** | `varchar` |
| **avatar_url** | `varchar` |
| **is_current** | `bool` |

\
**cameras**
| Colonne | Type |
|---------|------|
| **id** | `uuid` |
| **game** | `varchar` |
| **name** | `text` |
| **map_name** | `varchar` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |
| **pitch** | `float8` |
| **yaw** | `float8` |
| **comment** | `text` |
| **color** | `varchar` |

\
**checksum_tags**
| Colonne | Type |
|---------|------|
| **checksum** | `varchar` |
| **tag_id** | `int8` |

\
**comments**
| Colonne | Type |
|---------|------|
| **checksum** | `varchar` |
| **comment** | `text` |

\
**demo_paths**
| Colonne | Type |
|---------|------|
| **checksum** | `varchar` |
| **file_path** | `varchar` |

\
**demos**
| Colonne | Type |
|---------|------|
| **checksum** | `varchar` |
| **name** | `varchar` |
| **game** | `varchar` |
| **source** | `varchar` |
| **type** | `varchar` |
| **date** | `timestamptz` |
| **map_name** | `varchar` |
| **tick_count** | `int4` |
| **tickrate** | `float8` |
| **framerate** | `float8` |
| **duration** | `float8` |
| **server_name** | `varchar` |
| **client_name** | `varchar` |
| **network_protocol** | `int4` |
| **build_number** | `int4` |
| **share_code** | `varchar` |

\
**download_history**
| Colonne | Type |
|---------|------|
| **match_id** | `varchar` |
| **downloaded_at** | `timestamp` |

\
**faceit_accounts**
| Colonne | Type |
|---------|------|
| **id** | `varchar` |
| **nickname** | `varchar` |
| **avatar_url** | `varchar` |
| **is_current** | `bool` |

\
**faceit_matches**
| Colonne | Type |
|---------|------|
| **id** | `varchar` |
| **game** | `varchar` |
| **date** | `timestamptz` |
| **duration_in_seconds** | `int4` |
| **demo_url** | `varchar` |
| **map_name** | `varchar` |
| **url** | `varchar` |
| **game_mode** | `varchar` |
| **winner_id** | `varchar` |
| **winner_name** | `varchar` |

**steam_account_overrides**
| Colonne | Type |
|---------|------|
| **steam_id** | `varchar` |
| **name** | `text` |

**steam_account_tags**
| Colonne | Type |
|---------|------|
| **steam_id** | `varchar` |
| **tag_id** | `int8` |

\
**ignored_steam_accounts**
| Colonne | Type |
|---------|------|
| **steam_id** | `varchar` |

\
**maps**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **name** | `varchar` |
| **game** | `varchar` |
| **position_x** | `int4` |
| **position_y** | `int4` |
| **scale** | `float4` |
| **threshold_z** | `int4` |

\
**matches**
| Colonne | Type |
|---------|------|
| **checksum** | `varchar` |
| **demo_path** | `varchar` |
| **game_type** | `int4` |
| **game_mode** | `int4` |
| **game_mode_str** | `varchar` |
| **is_ranked** | `bool` |
| **kill_count** | `int4` |
| **death_count** | `int4` |
| **assist_count** | `int4` |
| **shot_count** | `int4` |
| **analyze_date** | `timestamptz` |
| **winner_name** | `varchar` |
| **winner_side** | `int2` |
| **overtime_count** | `int4` |
| **max_rounds** | `int4` |
| **has_vac_live_ban** | `bool` |

**players**
| Colonne | Type |
|---------|------|
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
| **mvp_count** | `int4` |
| **average_damage_per_round** | `float4` |
| **average_kill_per_round** | `float4` |
| **average_death_per_round** | `float4` |
| **utility_damage_per_round** | `float4` |
| **rank_type** | `int4` |
| **rank** | `int4` |
| **old_rank** | `int4` |
| **wins_count** | `int4` |
| **bomb_planted_count** | `int4` |
| **bomb_defused_count** | `int4` |
| **hostage_rescued_count** | `int4` |
| **score** | `int4` |
| **kast** | `float4` |
| **hltv_rating** | `float4` |
| **hltv_rating_2** | `float4` |
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

**rounds**
| Colonne | Type |
|---------|------|
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

\
**player_economies**
| Colonne | Type |
|---------|------|
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


\
**player_comments**
| Colonne | Type |
|---------|------|
| **steam_id** | `varchar` |
| **comment** | `text` |

\
**renown_accounts**
| Colonne | Type |
|---------|------|
| **steam_id** | `varchar` |
| **nickname** | `varchar` |
| **avatar_url** | `varchar` |
| **is_current** | `bool` |

\
**round_comments**
| Colonne | Type |
|---------|------|
| **match_checksum** | `varchar` |
| **number** | `int4` |
| **comment** | `text` |

\
**round_tags**
| Colonne | Type |
|---------|------|
| **checksum** | `varchar` |
| **round_number** | `int4` |
| **tag_id** | `int8` |

\
**steam_accounts**
| Colonne | Type |
|---------|------|
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

\
**tags**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **name** | `varchar` |
| **color** | `varchar` |

\
**bombs_defused**
| Colonne | Type |
|---------|------|
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

\
**kills**
| Colonne | Type |
|---------|------|
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

**smokes_start**
| Colonne | Type |
|---------|------|
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

**shots**
| Colonne | Type |
|---------|------|
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

\
**damages**
| Colonne | Type |
|---------|------|
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

\
**chat_messages**
| Colonne | Type |
|---------|------|
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

\
**player_buys**
| Colonne | Type |
|---------|------|
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

\
**clutches**
| Colonne | Type |
|---------|------|
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

**bombs_defuse_start**
| Colonne | Type |
|---------|------|
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

**bombs_exploded**
| Colonne | Type |
|---------|------|
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

**bombs_plant_start**
| Colonne | Type |
|---------|------|
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

**bombs_planted**
| Colonne | Type |
|---------|------|
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

**chicken_deaths**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **killer_steam_id** | `varchar` |
| **weapon_name** | `varchar` |

**chicken_positions**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

**decoys_start**
| Colonne | Type |
|---------|------|
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

**faceit_accounts**
| Colonne | Type |
|---------|------|
| **nickname** | `varchar` |
| **avatar_url** | `varchar` |
| **is_current** | `bool` |

**faceit_match_players**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **faceit_id** | `varchar` |
| **name** | `varchar` |
| **avatar_url** | `varchar` |
| **team_id** | `varchar` |
| **team_name** | `varchar` |
| **kill_count** | `int4` |
| **assist_count** | `int4` |
| **death_count** | `int4` |
| **headshot_count** | `int4` |
| **headshot_percentage** | `float4` |
| **kill_death_ratio** | `float4` |
| **kill_per_round** | `float4` |
| **mvp_count** | `int4` |
| **three_kill_count** | `int4` |
| **four_kill_count** | `int4` |
| **five_kill_count** | `int4` |
| **faceit_match_id** | `varchar` |

**teams**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **name** | `varchar` |
| **current_side** | `int2` |
| **score** | `int4` |
| **score_first_half** | `int4` |
| **score_second_half** | `int4` |
| **letter** | `varchar` |

**faceit_match_teams**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **faceit_id** | `varchar` |
| **name** | `varchar` |
| **score** | `int4` |
| **first_half_score** | `int4` |
| **second_half_score** | `int4` |
| **overtime_score** | `int4` |
| **faceit_match_id** | `varchar` |

**faceit_matches**
| Colonne | Type |
|---------|------|
| **id** | `varchat` |
| **game** | `varchar` |
| **date** | `timestamptz` |
| **duration_in_seconds** | `int4` |
| **demo_url** | `varchar` |
| **map_name** | `varchar` |
| **url** | `varchar` |
| **game_mode** | `varchar` |
| **winner_id** | `varchar` |
| **winner_name** | `varchar` |

**flashbangs_explode**
| Colonne | Type |
|---------|------|
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

**grenade_bounces**
| Colonne | Type |
|---------|------|
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

**grenade_positions**
| Colonne | Type |
|---------|------|
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


**grenade_projectiles_destroy**
| Colonne | Type |
|---------|------|
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

\
**he_grenades_explode**
| Colonne | Type |
|---------|------|
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

\
**hostage_pick_up_start**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **hostage_entity_id** | `int4` |
| **player_steam_id** | `varchar` |
| **is_player_controlling_bot** | `bool` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

\
**hostage_picked_up**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **hostage_entity_id** | `int4` |
| **player_steam_id** | `varchar` |
| **is_player_controlling_bot** | `bool` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

\
**hostage_positions**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **state** | `int4` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

\
**hostage_rescued**
| Colonne | Type |
|---------|------|
| **id** | `bigserial` |
| **match_checksum** | `varchar` |
| **round_number** | `int4` |
| **tick** | `int4` |
| **frame** | `int4` |
| **hostage_entity_id** | `int4` |
| **player_steam_id** | `varchar` |
| **is_player_controlling_bot** | `bool` |
| **x** | `float8` |
| **y** | `float8` |
| **z** | `float8` |

\
**inferno_positions**
| Colonne | Type |
|---------|------|
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

\
**migrations**
| Colonne | Type |
|---------|------|
| **schema_version** | `int4` |
| **run_at** | `timestamptz` |

\
**player_blinds**
| Colonne | Type |
|---------|------|
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


\
**player_positions**
| Colonne | Type |
|---------|------|
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

\
**smokes_start**
| Colonne | Type |
|---------|------|
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

\
**timestamps**
| Colonne | Type |
|---------|------|
| **name** | `varchar` |
| **date** | `timestamptz` |



---

### Plan d'analyse

*Sans écrire la moindre ligne de code, élaborez sur les questions que vous souhaitez vous poser sur les données. Quelles sont vos interrogations ? Quelles informations pensez-vous obtenir ? Quelles variables souhaitez-vous comparer ? Qu’est-ce qui pourrait poser problème ? Autrement dit : comment comptez-vous analyser ces données ?*
