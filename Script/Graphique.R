#----------------------
# 1. Charger les library
# ---------------------

library(ggplot2)
library(plotly)

#-------------------
# 2. Lire les données 
#-------------------


Statistiques <- read.csv2("Data/Statistiques.csv")


#-----------------------------------
# 3. Mettre les données dans l'ordre 
#-----------------------------------


Statistiques$Annee <- factor(Statistiques$Annee, levels = Statistiques$Annee)


#----------------------------------
# 4. Construire un graph à colonne 
#----------------------------------


p <- ggplot(
  Statistiques,
  aes(
    x = Annee,
    y = Nombre.de.poetes,
    text = paste(
      "Fête :", Annee,
      "<br>Nombre de poètes :", Nombre.de.poetes)))+

  
  geom_col(fill = "#824670", show.legend = FALSE) +
  
  geom_point(
    data = subset(Statistiques, Presence.femmes == "Vrai"),
    aes(
      y = Nombre.de.poetes - 0.5,
      shape = "Présence d’une poétesse"),
      color = "gold",
      size = 2) +
  
  geom_point(
    data = subset(Statistiques, Hegoalde == "Vrai"),
    aes(
      y = Nombre.de.poetes - 1,
      shape = "Pays Basque Sud"),
    color = "#74D3AE",
    size = 1.6) +
  
  scale_shape_manual(
    name = "Légende",
    values = c("Présence d’une poétesse" = 8, "Pays Basque Sud" = 18))+

  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  
  labs(
    title = "<b>Nombre de poètes par édition (1851–1897)</b>",
    x = "Année",
    y = "Nombre de poètes")
  
                                                                     
#-------------------------
# 5. Le rendre intéractif
#-------------------------

ggplotly(p, tooltip = "text")

