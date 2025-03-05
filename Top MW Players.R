library(cbbdata)
library(tidyverse)
library(ggrepel)
library(cbbplotR)
mw_players <- cbd_torvik_player_season(year = 2025, conf = "MWC")

airforce <- get_espn_players(team = "Air Force")
boisest <- get_espn_players(team = "Boise State")
csu <- get_espn_players(team = "Colorado State")
fresno <- get_espn_players(team = "Fresno State")
newmexico <- get_espn_players(team = "New Mexico")
unlv <- get_espn_players(team = "UNLV")
usu <- get_espn_players(team = "Utah State")
sjsu <- get_espn_players(team = "San Jose State")
sdsu <- get_espn_players(team = "San Diego State")
wyo <- get_espn_players(team = "Wyoming")
nevada <- get_espn_players(team = "Nevada")

mw <- rbind(airforce, boisest, csu, fresno, newmexico,
            unlv, usu, sjsu, sdsu, wyo, nevada)

mw_players <- left_join(mw_players, mw, join_by("player" == "displayName"))

top_10 <- mw_players |> 
  slice_max(mpg, n = 10) |> 
  select(player, porpag, dporpag, id.y)

ggplot(top_10, aes(x = porpag, y = dporpag)) +
  geom_cbb_headshots(aes(player_id = id.y, width = 0.15)) +
  ylim(2.5, 5) +
  labs(title = "PORPAG vs DPORPAG of Top 10 MW Players (MPG)",
       subtitle = "Current as of 3/5/2025",
       caption = "By Micah Davis
       See barttorvik.com for detailed explanation of stats")


