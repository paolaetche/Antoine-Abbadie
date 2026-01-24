#----------------------
# 1. Charger les library
# ---------------------
library(leaflet)
library(sp)
library(sf)
library(shiny)

#---------------------------
# 2. Encadrer le Pays Basque
#---------------------------
EuskalHerria <- st_read('Data/shp/Euskal herria.shp')

#-------------------
# 3. Lire les points 
#-------------------
Points <- read.csv2("Data/Abbadie map.csv")

#----------------
# 4. Mettre au propre
#----------------
Points$Longitude <- as.numeric(Points$Longitude)
Points$Latitude  <- as.numeric(Points$Latitude)

#----------------------------------------
# 5. Créer la fonction map et la légende
#----------------------------------------
map <- leaflet(EuskalHerria) %>%

addLegend("topright",
    labels = "Paola Etchemendy",
    col = "#CC897E",
    title = "Carte des fêtes Antoine d'Abbadie entre 1851 et 1897 (poètes et improvisateurs):"
  )%>%

addProviderTiles(providers$OpenStreetMap)%>%

#---------------------------
# 6. Choisir la vue initiale 
#---------------------------

setView(lng = -1.7902496843659934, 
        lat = 43.22510324515901, 
        zoom = 8.8) %>%


#-------------------------------
# 7. Placer les lieux des fêtes
#-------------------------------

addMarkers(data = Points,
           lng = Points$Longitude, 
           lat = Points$Latitude,
           group = "Lieux des fêtes",                                               #</b> pour le Bold
           clusterOptions = markerClusterOptions(),
           popup = ~paste(
              "<div style='max-width:300px; max-height:290px; overflow-y:auto;'>",
              "<b>", Nom, "</b>",                                                  #<br> pour sauter une ligne
              "<br>",
              "<br>", "<b>", "Période :", "</b>", Periode,
              "<br>", "<b>", "Poète(s) identifié(s) :", "</b>", Poetes_identifies,
              "<br>", "<b>", "Sujet(s) poésie(s) :", "</b>", Sujet_poesie,
              "<br>", "<b>", "Classement poètes :", "</b>", Resultat_poetes,
              "<br>", "<b>", "Improvisateur(s) identifié(s) :", "</b>", Improvisateurs.identifies,
              "<br>", "<b>", "Sujet(s) improvisation(s) :", "</b>", Sujets_improvisateurs,
              "<br>", "<b>", "Résultat improvisateurs :", "</b>", Resultat_improvisateurs,
              "<br>", "<b>", "Notes :", "</b>", Notes,
              "<br>", "<b>", "Sources :", "</b>", Sources,
                             sep = " ")) %>%

 
#--------------------------------------
# 8. Ajouter Pays Basque et les couches
#--------------------------------------

addPolygons(data = EuskalHerria, 
                  color = "#009780", 
                  weight = 1, 
                  smoothFactor = 0,
                  group = "Pays Basque") %>%
  
  
  
addLayersControl(overlayGroups = c("Lieux des fêtes", "Pays Basque"),
                 options = layersControlOptions(collapsed = TRUE))


#----------------------
# 9. Afficher la carte
#----------------------

map
  









