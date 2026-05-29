library(shiny)
library(ggplot2)
library(dplyr)
library(dbscan)
library(tidyr)
library(plotly)
library(ggimage)
library(patchwork)
library(png)
library(grid)
server <- function(input, output, session) {
  demos <- read.csv("./../data/demos.csv") 
  matches <- read.csv("./../data/matches.csv")
  rounds <- read.csv("./../data/rounds_de_mirage.csv")
  kills <- read.csv("./../data/kills_de_mirage.csv")
  bombs <- read.csv("./../data/bombs_de_mirage.csv")
  messages <- read.csv("./../data/messages.csv")
  players = read.csv("./../data/players.csv")
  
  plot_heatmap <- function(data, title = "") {
    ggplot(data, aes(x = x, y = y)) +
      geom_image(
        data = tibble(x = -680, y = -850),
        aes(image = "./../images/de_mirage.png"),
        size = 1.32
      ) +
      stat_density_2d(
        aes(fill = after_stat(ndensity)),
        geom = "raster",
        contour = FALSE,
        alpha = 0.5,
        bins = 100
      ) +
      scale_fill_gradientn(colors = c("blue", "green", "yellow", "red")) +
      geom_image(
        data = tibble(x = -680, y = -850),
        aes(image = "./../images/de_mirage_mask.png"),
        size = 1.32
      ) +
      coord_equal() +
      ggtitle(title)
  }
  
  
  output$position_bombe_xy <- renderPlot({
    killer_xy = select(kills, c(killer_x ,killer_y))
    p <- ggplot(bombs, aes(x = x, y = y)) +
      geom_image(
        data = tibble(x = -680, y = -850),
        aes(image = "./../images/de_mirage.png"),
        size = 1.32
      )+
      geom_bin2d(bins = 50) +
      scale_fill_continuous(type = "viridis")+
      coord_equal(ratio=1, xlim=c(max(select(killer_xy, killer_x)), min(select(killer_xy, killer_x))), ylim=c(max(select(killer_xy, killer_y)), min(select(killer_xy, killer_y))))+geom_image(
        data = tibble(x = -680, y = -850),
        aes(image = "./../images/de_mirage_mask.png"),
        size = 1.32
      )
    p
  })
  
  output$map <- renderPlot({
    killer_xy = select(kills, x = killer_x, y = killer_y, side = killer_side)
    killer_xy = mutate(killer_xy, side = case_when(
      side == 2 ~ "terro",
      side == 3 ~ "anti"
    ))
    
    victim_xy = select(kills, x = victim_x, y = victim_y, side = victim_side)
    victim_xy = mutate(victim_xy, side = case_when(
      side == 2 ~ "terro",
      side == 3 ~ "anti"
    ))
    
    if(input$choix_type == "Tueur"){
      if(input$choix_equipe == "Anti-Terroriste"){
        p <- plot_heatmap(filter(killer_xy, side == "anti"), "Tueur - Anti")
      }
      else if(input$choix_equipe == "Terroriste"){
        p <- plot_heatmap(filter(killer_xy, side == "terro"), "Tueur - Terro")
      }
      else{
        p <- plot_heatmap(killer_xy, "Tueur - Général")
      }
    }
    else {
      if(input$choix_equipe == "Anti-Terroriste"){
        p <- plot_heatmap(filter(victim_xy, side == "anti"), "Mort - Anti")
      }
      else if(input$choix_equipe == "Terroriste"){
        p <- plot_heatmap(filter(victim_xy, side == "terro"), "Mort - Terro")
      }
      else{
        p <- plot_heatmap(victim_xy, "Mort - Général")
      }
    }
    
    
    p
  })
  
  output$repartition_cluster <- renderPlotly({
    
    vectors <- mutate(kills,
                      dx = victim_x - killer_x,
                      dy = victim_y - killer_y,
                      start_x = killer_x,
                      start_y = killer_y
    )
    
    vectors_norm <- scale(select(vectors, killer_x, killer_y, dx, dy))
    
    cl <- dbscan::dbscan(vectors_norm, eps = input$epsilon_cluster, minPts = input$min_ptn_cluster)
    
    vectors$cluster <- cl$cluster
    
    killer_xy = select(kills, c(killer_x, killer_y))
    victim_xy = select(kills, c(victim_x, victim_y))
    
    cluster_representatives <- filter(vectors, cluster != 0)
    cluster_representatives <- group_by(cluster_representatives, cluster)
    cluster_representatives <- summarise(cluster_representatives,
                                         killer_x = median(killer_x),
                                         killer_y = median(killer_y),
                                         victim_x = median(victim_x),
                                         victim_y = median(victim_y),
                                         n = n()
    )
    cluster_representatives <- ungroup(cluster_representatives)
    
    killer_counts <- filter(vectors, cluster != 0)
    killer_counts <- count(killer_counts, cluster, killer_side, name = "n")
    
    killer_counts <- rename(killer_counts, side = killer_side)
    
    p <- ggplot(killer_counts, aes(x = factor(cluster), y = n, fill = factor(side))) +
      geom_bar(stat = "identity", position = "stack") +
      labs(
        title = "Nombre de tirs par cluster et côté",
        x = "Cluster",
        y = "Nombre de tirs",
        fill = "Camp"
      ) +
      scale_fill_manual(
        values = c("2" = "#F99E1C", "3" = "#00428C"),
        labels = c("2" = "Terroriste", "3" = "Anti-Terroriste")
      ) +
      theme_minimal()
    
    ggplotly(p)
  })
  
  
  output$position_cluster <- renderPlot({
    
    vectors <- mutate(kills,
                      dx = victim_x - killer_x,
                      dy = victim_y - killer_y,
                      start_x = killer_x,
                      start_y = killer_y
    )
    
    vectors_norm <- scale(select(vectors, killer_x, killer_y, dx, dy))
    
    cl <- dbscan::dbscan(vectors_norm, eps = input$epsilon_cluster, minPts = input$min_ptn_cluster)
    
    vectors$cluster <- cl$cluster
    
    killer_xy = select(kills, c(killer_x, killer_y))
    victim_xy = select(kills, c(victim_x, victim_y))
    
    cluster_representatives <- filter(vectors, cluster != 0)
    cluster_representatives <- group_by(cluster_representatives, cluster)
    cluster_representatives <- summarise(cluster_representatives,
                                         killer_x = median(killer_x),
                                         killer_y = median(killer_y),
                                         victim_x = median(victim_x),
                                         victim_y = median(victim_y),
                                         n = n()
    )
    cluster_representatives <- ungroup(cluster_representatives)
    
    p <- ggplot(killer_xy, aes(x = killer_x, y = killer_y)) +
      geom_image(
        data = tibble(killer_x = -680, killer_y = -830),
        aes(image = "./../images/de_mirage.png"),
        size = 1.32
      ) +
      geom_segment(
        data = cluster_representatives,
        aes(
          x = killer_x, 
          y = killer_y, 
          xend = victim_x, 
          yend = victim_y,
          color = as.factor(cluster)
        ),
        arrow = arrow(length = unit(0.2, "cm"), type = "closed"),
        alpha = 0.9,
        linewidth = 1.2
      ) +
      geom_image(
        data = tibble(killer_x = -680, killer_y = -830),
        aes(image = "./../images/de_mirage_mask.png"),
        size = 1.32
      ) +
      labs(
        title="Lignes de tir récurrentes",
        x ="x",
        y ="y"
      )+
      scale_color_discrete(name = "Cluster")+
      geom_point(size = 0.1, alpha = 0.01) +
      coord_equal()
    
    p
  })
  
  output$cluster_part <- renderPlot({
    vectors <- mutate(kills,
                      dx = victim_x - killer_x,
                      dy = victim_y - killer_y,
                      start_x = killer_x,
                      start_y = killer_y
    )
    
    vectors_norm <- scale(select(vectors, killer_x, killer_y, dx, dy))
    
    cl <- dbscan::dbscan(vectors_norm, eps = input$epsilon_cluster, minPts = input$min_ptn_cluster)
    
    vectors$cluster <- cl$cluster
    
    killer_xy = select(kills, c(killer_x, killer_y))
    victim_xy = select(kills, c(victim_x, victim_y))
    
    cluster_representatives <- filter(vectors, cluster != 0)
    cluster_representatives <- group_by(cluster_representatives, cluster)
    cluster_representatives <- summarise(cluster_representatives,
                                         killer_x = median(killer_x),
                                         killer_y = median(killer_y),
                                         victim_x = median(victim_x),
                                         victim_y = median(victim_y),
                                         n = n()
    )
    cluster_representatives <- ungroup(cluster_representatives)
    
    tmp1 <- filter(vectors, cluster != 0)
    
    tmp2 <- count(tmp1, cluster, killer_side)
    
    tmp3 <- group_by(tmp2, cluster)
    
    tmp4 <- mutate(tmp3,
                   total = sum(n),
                   prop = n / total)
    
    cluster_side <- ungroup(tmp4)
    
    tmp5 <- group_by(cluster_side, cluster)
    
    tmp6 <- slice_max(tmp5, n, n = 1, with_ties = FALSE)
    
    dominant_cluster <- ungroup(tmp6)
    
    sel <- select(dominant_cluster, cluster, killer_side, total)
    
    cluster_representatives2 <- left_join(
      cluster_representatives,
      sel,
      by = "cluster"
    )
    
    #On convertit les sides en textes
    cluster_representatives2$killer_side <- factor(
      cluster_representatives2$killer_side,
      levels = c(2, 3),
      labels = c("Terroriste", "Anti-Terroriste")
    )
    
    ggplot(killer_xy, aes(x = killer_x, y = killer_y)) +
      geom_image(
        data = tibble(killer_x = -680, killer_y = -830),
        aes(image = "./../images/de_mirage.png"),
        size = 1.32
      ) +
      geom_segment(
        data = cluster_representatives2,
        aes(
          x = killer_x,
          y = killer_y,
          xend = victim_x,
          yend = victim_y,
          color = killer_side
        ),
        arrow = arrow(length = unit(0.2, "cm"), type = "closed"),
        linewidth = 1,
        alpha = 0.9
      ) +
      geom_image(
        data = tibble(killer_x = -680, killer_y = -830),
        aes(image = "./../images/de_mirage_mask.png"),
        size = 1.32
      ) +
      scale_color_manual(values = c(
        "Terroriste" = "#F99E1C",
        "Anti-Terroriste" = "#4DA3FF"
      )) +
      labs(
        title = "Lignes de tir par camp",
        x = "x",
        y = "y",
        color = "Camp dominant"
      ) +
      coord_equal(ratio=1, xlim=c(max(select(killer_xy, killer_x)), min(select(killer_xy, killer_x))), ylim=c(max(select(killer_xy, killer_y)), min(select(killer_xy, killer_y))))+
      theme_minimal()
  })
  
  ##Permet d'afficher les messages les plus envoyées
  output$topmessage <- renderPlotly({
    
    filtered_messages <- messages
    
    if (!is.null(input$filtre_additif) && nzchar(input$filtre_additif)) {
      filtered_messages <- filter(
        filtered_messages,
        grepl(input$filtre_additif, message, ignore.case = TRUE)
      )
    }
    
    if (!is.null(input$filtre_soustractif) && nzchar(input$filtre_soustractif)) {
      filtered_messages <- filter(
        filtered_messages,
        !grepl(input$filtre_soustractif, message, ignore.case = TRUE)
      )
    }
    
    
    top <- slice_head(count(filtered_messages,message, sort = TRUE), n = 20)
    
    p <- ggplot(top, aes(x = reorder(message, n), y = n)) +
      geom_col() +
      geom_text(aes(label = n), hjust = -0.1) +
      coord_flip() +
      ggtitle("Messages les plus envoyés") +
      ylab(NULL)
    
    plotly::ggplotly(p)
  })
  
  output$messagewin <- renderPlotly({
    
    filtered_messages <- messages
    
    if (!is.null(input$filtre_additif) && nzchar(input$filtre_additif)) {
      filtered_messages <- dplyr::filter(
        filtered_messages,
        grepl(input$filtre_additif, message, ignore.case = TRUE)
      )
    }
    
    if (!is.null(input$filtre_soustractif) && nzchar(input$filtre_soustractif)) {
      filtered_messages <- dplyr::filter(
        filtered_messages,
        !grepl(input$filtre_soustractif, message, ignore.case = TRUE)
      )
    }
    
    message_is_winner_filtered <- mutate(
      left_join(
        left_join(
          filtered_messages,
          matches,
          by = c("match_checksum" = "checksum")
        ),
        select(players, c("steam_id", "team_name", "match_checksum")),
        by = c("sender_steam_id" = "steam_id", "match_checksum" = "match_checksum")
      ),
      is_winner = ifelse(team_name == winner_name, TRUE, FALSE)
    )
    
    message_is_winner_when_filtered <- mutate(
      left_join(
        message_is_winner_filtered,
        select(demos, c("checksum", "tickrate", "duration")),
        by = c("match_checksum" = "checksum")
      ),
      when = round(tick / tickrate)
    )
    
    message_counts_filtered <- drop_na(
      count(distinct(message_is_winner_when_filtered, match_checksum, sender_name, is_winner), is_winner)
    )
    
    ggplot(message_counts_filtered, aes(x = is_winner, y = n)) +
      geom_col() +
      geom_text(aes(label = n), hjust = -0., vjust=-0.5) +
      labs(
        title = "Nombre de message envoyé (par expéditeur distinct) en fonction de l'issu du match",
        x = "Victoire ?",
        y = "Nombre de messages"
      )
    
  })
  
  
  output$messagewinrate <- renderPlotly({

    filtered_messages <- messages
    
    if (!is.null(input$filtre_additif) && nzchar(input$filtre_additif)) {
      filtered_messages <- filter(
        filtered_messages,
        grepl(input$filtre_additif, message, ignore.case = TRUE)
      )
    }
    
    if (!is.null(input$filtre_soustractif) && nzchar(input$filtre_soustractif)) {
      filtered_messages <- filter(
        filtered_messages,
        !grepl(input$filtre_soustractif, message, ignore.case = TRUE)
      )
    }
    
    message_is_winner_filtered <- mutate(
      left_join(
        left_join(
          filtered_messages,
          matches,
          by = c("match_checksum" = "checksum")
        ),
        select(players, c("steam_id", "team_name", "match_checksum")),
        by = c("sender_steam_id" = "steam_id", "match_checksum" = "match_checksum")
      ),
      is_winner = ifelse(team_name == winner_name, TRUE, FALSE)
    )
    
    message_is_winner_when_filtered <- mutate(
      left_join(
        message_is_winner_filtered,
        select(demos, c("checksum", "tickrate", "duration")),
        by = c("match_checksum" = "checksum")
      ),
      when = round(tick / tickrate)
    )
    
    player_n_partie <- arrange(count(players, name), desc(n))
    
    player_n_win <- summarise(group_by(mutate(right_join(players, matches, by=c("match_checksum"="checksum")), winner = team_name == winner_name), name), nb_victoires = sum(winner, na.rm=TRUE))
    
    player_ratio_win <- mutate(
      right_join(rename(player_n_partie, "nb_parties"=n), 
      player_n_win, by=("name"="name")), 
    ratio=nb_victoires/nb_parties)
    
    
    player_n_message_filtered <- rename(
      arrange(
        count(filtered_messages, sender_name),
        desc(n)
      ),
      nb_messages = n
    )
    
    tmp_win_rate <- left_join(
      player_n_message_filtered,
      player_ratio_win,
      by = c("sender_name" = "name")
    )
    
    tmp_win_rate2 <- group_by(tmp_win_rate, nb_messages)
    
    win_rate_nb_message_filtered <- rename(
      summarise(
        tmp_win_rate2,
        ratio_moyen = mean(ratio, na.rm = TRUE),
        .groups = "drop"
      ),
      nb_msg = nb_messages
    )
    
    agg_tmp <- mutate(
      win_rate_nb_message_filtered,
      nb_msg = as.numeric(as.character(nb_msg))
    )
    
    agg_tmp2 <- group_by(agg_tmp, nb_msg)
    
    agg_data <- arrange(
      summarise(
        agg_tmp2,
        mean_ratio = mean(ratio_moyen, na.rm = TRUE),
        .groups = "drop"
      ),
      nb_msg
    )
    
    mean_ratio_all <- mean(player_ratio_win$ratio, na.rm = TRUE)
    mean_ratio_filtered <- mean(win_rate_nb_message_filtered$ratio_moyen, na.rm = TRUE)
    
    sd_ratio_filtered <- sd(win_rate_nb_message_filtered$ratio_moyen, na.rm = TRUE)
    lower_filtered <- mean_ratio_filtered - sd_ratio_filtered
    upper_filtered <- mean_ratio_filtered + sd_ratio_filtered
    
    ggplot(agg_data, aes(x = nb_msg, y = mean_ratio)) +
      geom_col(width = 0.8) +
      scale_x_continuous(breaks = agg_data$nb_msg) +
      
      geom_hline(
        aes(yintercept = mean_ratio_all, color = "global"),
        linetype = "dashed"
      ) +
      
      geom_hline(
        aes(yintercept = mean_ratio_filtered, color = "filtered"),
        linetype = "dashed"
      ) +
      
      geom_hline(
        aes(yintercept = lower_filtered, color = "lower"),
        linetype = "dotted"
      ) +
      
      geom_hline(
        aes(yintercept = upper_filtered, color = "upper"),
        linetype = "dotted"
      ) +
      
      scale_color_manual(
        name = "Lignes de référence",
        values = c(
          global = "red",
          filtered = "blue",
          lower = "blue",
          upper = "blue"
        ),
        labels = c(
          global = paste0("Moyenne globale : ", round(mean_ratio_all, 3)),
          filtered = paste0("Moyenne filtrée : ", round(mean_ratio_filtered, 3)),
          lower = paste0("± 1 SD (bas) : ", round(lower_filtered, 3)),
          upper = paste0("± 1 SD (haut) : ", round(upper_filtered, 3))
        )
      ) +
      
      labs(
        title = "Taux de victoire moyen par nombre de messages",
        x = "Nombre de messages",
        y = "Taux de victoire moyen"
      )
  })
  
  output$messageperiod <- renderPlotly({
    down_limit <- 60 * input$limits_temps[1]
    up_limit <- 60 * (50-input$limits_temps[2])
    
    filtered_messages <- messages
    
    if (!is.null(input$filtre_additif) && nzchar(input$filtre_additif)) {
      filtered_messages <- filter(
        filtered_messages,
        grepl(input$filtre_additif, message, ignore.case = TRUE)
      )
    }
    
    if (!is.null(input$filtre_soustractif) && nzchar(input$filtre_soustractif)) {
      filtered_messages <- filter(
        filtered_messages,
        !grepl(input$filtre_soustractif, message, ignore.case = TRUE)
      )
    }
    
    message_is_winner_filtered <- mutate(
      left_join(
        left_join(
          filtered_messages,
          matches,
          by = c("match_checksum" = "checksum")
        ),
        select(players, c("steam_id", "team_name", "match_checksum")),
        by = c("sender_steam_id" = "steam_id", "match_checksum" = "match_checksum")
      ),
      is_winner = ifelse(team_name == winner_name, TRUE, FALSE)
    )
    
    message_is_winner_when_filtered <- mutate(
      left_join(
        message_is_winner_filtered,
        select(demos, c("checksum", "tickrate", "duration")),
        by = c("match_checksum" = "checksum")
      ),
      when = round(tick / tickrate)
    )
    
    message_is_winner_when_filtered_limits <- mutate(
      message_is_winner_when_filtered,
      period = case_when(
        when <= down_limit ~ "Start",
        when >= duration - up_limit ~ "End",
        TRUE ~ "Sometime"
      )
    )
    
    period_summarise_filtered <- summarise(
      group_by(message_is_winner_when_filtered_limits, period),
      n = n()
    )
    
    p <- ggplot(period_summarise_filtered, aes(x = period, y = n)) +
      geom_col() +
      geom_text(aes(label = n), hjust = -0., vjust=-0.5) +
      ggtitle("Période d'envoi des messages")+
      ylab("nb_messages")
    
    ggplotly(p)
  })
  
  output$messagetype <- renderPlotly({
    
    filtered_messages <- messages
    
    if (!is.null(input$filtre_additif) && nzchar(input$filtre_additif)) {
      filtered_messages <- filter(
        filtered_messages,
        grepl(input$filtre_additif, message, ignore.case = TRUE)
      )
    }
    
    if (!is.null(input$filtre_soustractif) && nzchar(input$filtre_soustractif)) {
      filtered_messages <- filter(
        filtered_messages,
        !grepl(input$filtre_soustractif, message, ignore.case = TRUE)
      )
    }
    
    message_is_winner_filtered <- mutate(
      left_join(
        left_join(
          filtered_messages,
          matches,
          by = c("match_checksum" = "checksum")
        ),
        select(players, c("steam_id", "team_name", "match_checksum")),
        by = c("sender_steam_id" = "steam_id", "match_checksum" = "match_checksum")
      ),
      is_winner = ifelse(team_name == winner_name, TRUE, FALSE)
    )
    
    message_count <- count(message_is_winner_filtered, match_checksum)
    
    communication_type <- summarise(
      group_by(message_is_winner_filtered, match_checksum),
      is_winner = n_distinct(is_winner, na.rm = TRUE)
    )
    
    
    communication_type <- merge(
      message_count,
      communication_type,
      by = "match_checksum",
      all.x = TRUE
    )
    
    communication_type$is_winner[is.na(communication_type$is_winner)] <- 0
    
    communication_type$communication <- ifelse(
      communication_type$n == 1,
      "Appel déséspérer",
      ifelse(
        communication_type$is_winner == 1,
        "Communication interne",
        "Communication entre les deux camps"
      )
    )
    
    communication_summary <- count(communication_type, communication)
    
    p <- ggplot(communication_summary,
           aes(x = communication, y = n)) +
      geom_col() +
      geom_text(aes(label = n), vjust = -0.3) +
      ggtitle("Type de communication par match") +
      xlab("") +
      ylab("Nombre de matchs")
    
    ggplotly(p)
  })
  
  output$messagetypepart <- renderPlotly({
    filtered_messages <- messages
    
    if (!is.null(input$filtre_additif) && nzchar(input$filtre_additif)) {
      filtered_messages <- filter(
        filtered_messages,
        grepl(input$filtre_additif, message, ignore.case = TRUE)
      )
    }
    
    if (!is.null(input$filtre_soustractif) && nzchar(input$filtre_soustractif)) {
      filtered_messages <- filter(
        filtered_messages,
        !grepl(input$filtre_soustractif, message, ignore.case = TRUE)
      )
    }
    
    message_is_winner_filtered <- mutate(
      left_join(
        left_join(
          filtered_messages,
          matches,
          by = c("match_checksum" = "checksum")
        ),
        select(players, c("steam_id", "team_name", "match_checksum")),
        by = c("sender_steam_id" = "steam_id", "match_checksum" = "match_checksum")
      ),
      is_winner = ifelse(team_name == winner_name, TRUE, FALSE)
    )
    
    message_is_winner_filtered$is_winner_cat <- ifelse(
      message_is_winner_filtered$is_winner == TRUE,
      "Winner",
      "Loser"
    )
    message_count <- count(message_is_winner_filtered, match_checksum)
    
    communication_type <- summarise(
      group_by(message_is_winner_filtered, match_checksum),
      is_winner = n_distinct(is_winner, na.rm = TRUE)
    )
    
    
    communication_type <- merge(
      message_count,
      communication_type,
      by = "match_checksum",
      all.x = TRUE
    )
    
    communication_type$is_winner[is.na(communication_type$is_winner)] <- 0
    
    communication_type$communication <- ifelse(
      communication_type$n == 1,
      "Appel déséspérer",
      ifelse(
        communication_type$is_winner == 1,
        "Communication interne",
        "Communication entre les deux camps"
      )
    )
    
    communication_summary <- count(communication_type, communication)
    
    plot_data <- merge(
      message_is_winner_filtered,
      communication_type[, c("match_checksum", "communication")],
      by = "match_checksum"
    )
    
    plot_data <- filter(plot_data, communication != "Communication entre les deux camps", !is.na(is_winner_cat),!is.na(communication))
    
    ggplot(plot_data,
           aes(x = communication, fill = is_winner_cat)) +
      geom_bar(position = "fill") +
      ggtitle("Proportion winner / loser dans les communications a sens unique") +
      xlab("") +
      ylab("Proportion") +
      scale_y_continuous(labels = scales::percent) +
      theme(legend.title = element_blank())
  })
  
 
}