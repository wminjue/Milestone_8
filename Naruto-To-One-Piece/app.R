library(shiny)
library(shinyjs)
library(readr)
library(dplyr)
library(tidyverse)

#Read in all of my graphs from the prep shiny so I can display them in the tabs more easily.
#I want to figure out how to do the ggplots on my app.R in the future to save on
#code and space

narr <- read_rds("narr.rds")
narp <- read_rds("narp.rds")
gintamr <- read_rds("gintamr.rds")
gintamp <- read_rds("gintamp.rds")
fmar <- read_rds("fmar.rds")
fmap <- read_rds("fmap.rds")
blear <- read_rds("blear.rds")
bleap <- read_rds("bleap.rds")
keroror <- read_rds("keroror.rds")
kerorop <- read_rds("kerorop.rds")
oner <- read_rds("oner.rds")
onep <- read_rds("onep.rds")
cr <- read_rds("cr.rds")
cp <- read_rds("cp.rds")
totality <- read_rds("totality.rds")


#Create list of anime for users to scroll through on the first tab

anime_names <- c("Naruto", "Bleach", "Gintama", "Fullmetal", "Keroro", "One Piece", "Detective Conan")

#Provide two scrolls on the front page so people can cross compare
#popularity and rank trends between different popular anime simultaneously,
#instead of clicking back and forth across a faceted graph

#Provided separate statistical modeling combining all the datasets
#on second tab to show overall trends and ues as a baseline to point
#out deviations on the first tab

ui <- fluidPage(
  useShinyjs(),
  navbarPage(
    "From Naruto to One Piece: Rise of Anime",
    tabPanel(
      "Ranking and Popularity Trends",
      titlePanel("Plotted Score Correlations"),
      br(),
      htmlOutput("interp"),
      sidebarPanel((
        selectInput("anime", "Anime Score out of Ten", anime_names))
      ),
      mainPanel(plotOutput("plot")),
      sidebarPanel((
        selectInput("anime1", "Anime Popularity", anime_names)
      )),
      mainPanel(plotOutput("plot1"))
    ),
    tabPanel(
      "Model Explanations",
      plotOutput("total"),
      htmlOutput("stats")
    ),
    tabPanel(
      "About",
      htmlOutput("intro"),
      htmlOutput("hitter"),
      uiOutput("rsource"),
      htmlOutput("more"),
      htmlOutput("source"),
      uiOutput("tab"),
      uiOutput("tab2"),
      uiOutput("tab3"),
      htmlOutput("bio")
    )
  )
)

#connected all the menu selection choices with their respective rds files
#I feel like my current formatting is clunky — going to try to figure out how to
#make it more aesthetically pleasing for my final presentation

server <- function(input, output, session) {
  
  data_input <- reactive({
    switch(input$anime,
           "Naruto" = narr, 
           "Bleach" = blear,
           "Gintama" = gintamr,
           "Fullmetal" = fmar,
           "Keroro" = keroror,
           "One Piece" = oner,
           "Detective Conan" = cr
    )
  })
  
  data_input2 <- reactive({
    switch(input$anime1,
           "Naruto" = narp, 
           "Bleach" = bleap,
           "Gintama" = gintamp,
           "Fullmetal" = fmap,
           "Keroro" = kerorop,
           "One Piece" = onep,
           "Detective Conan" = narp
    )
    
  })

  output$interp <- renderUI({
    HTML("<b><font size = 6> Turn in the Tides</font></b> <br>
         Looking at these graphs of rank and popularity trends for five 
         of the most enduring, still-running anime franchises can reveal important factors about the fan
         base, changes in audience consumption, and overall approval of new spinoffs. For example,
         looking at the ranking and popularity graphs of Naruto franchise productions organized by release 
         date, for example, shows that scores of Naruto productions initally dipped in the late 2000s 
         but is steadily increasing, while the overall score (out of ten) has decreased when compared to 
         all other anime productions. The more recent productions are attracted a smaller group of dedicated 
         fans (as measured by voting users), showing that the nature of the show has perhaps changed — no 
         longer a massive cult following, but something that caters more to a specific group of audiences 
         that have petered off from the original Shippuden series. 
         <br> <br>
         ")})
  
  output$intro <- renderUI({
    HTML("<b><font size=6> Anime: Rise of a Global Phenomenon</font></b>
                            <br><br>
                            <p> First created in 1917 with propaganda films such as Momotarō: Umi no Shinpei, 
                            Japanese animation (anime) swept the world in the 1980s as a global entertainment 
                            phenonemon with the rise of mecha, superhero series, and space operas. As the focus 
                            of anime shifted from film studio features such as Akira and Spirited Away, the format 
                            of popular anime transformed into increasingly long series consisting of shorter 
                            episodes — bite sized-chunks which can be pitched as more accessible, lower commitment, 
                            and reduced-stakes trial runs to mold to ever-shifting popular opinion. As of 2014, 
                            there are over 58 million hashtags for the topic of #anime, and in 2017 the the anime 
                            sector earned over $19 billion USD worldwide. The burning question follows: with such a 
                            high following and market shares, which anime series are responsible for bringing in 
                            most of the revenue, and how do they manage to successfully (do or they?) captivate 
                            audiences over decades of airing?<b><br><br>")})
  
  output$hitter <- renderUI({
    HTML("<b><font size=4>Rationale: Heavy Hitter's Frenzy </font></b> 
                            <br>
                             A glance at the Top Anime list on MyAnimeList, a manga/anime social networking and 
                             cataloging website with over 120 million visitors per month, reveals the most popular 
                             hits are consistently dominated by specific, classic anime shows that have aired 
                             hundreds of episodes over years. Fullmetal Alchemist:Brotherhood, for example, the 
                             second  64-episode reboot of the original Fullmetal adaptaion, boasts over a million 
                             members involved in forums, which doesn't even account for the amount of visiting 
                             members who simply leave ratings. This project seeks to analyze trends across years 
                             in ranking, popularity, audience size, and overall quality ratings of the 7 most 
                             popular long-running (and still running!) anime shows in history. These include Naruto, 
                             Bleach, Fullmetal Alchemist, Keroro Gunsō, Gin Tama, One Piece, and Detective Conan (Case 
                             Closed). Ranging from 120 to over 1600 
                             episodes each, these series and their offshoots have evolved over the past decade, and 
                             data gathered from various Anime review sites and new sources give a comprehensive 
                             overview of how popular ratings has changed from 2006-2016.
                             ")
  })
  
  output$more <- renderUI({
    HTML("<br><b> <font size=4>The More the Merrier...?</font> </b><br>
                             Although the global size of adoring otaku(anime fanatic) populations and never-ceasing 
                             news of the next Gin Tama season might seem like concrete assurance of these anime series' 
                             longstanding welcome, capturing tantalizing original content is a precarious struggle. 
                             Take these recent Naruto reviews from Kotaku Australia, and IGN, 
                             for example. With well over 500 episodes in the original franchise alone, this 
                             well-established ninja adventure series is now on its second generation — literally — 
                             as the last 126 episodes follow Naruto's son Boruto, who now carries his father's mantle. 
                             However, there is only so much one can do within the same worldbuilding parameters of a 
                             small ninja village before episodes start to cycle old themes, fight sequences, and dialogue. 
                             Die-hard fans who have suffered through the entire series specifically square off hundreds of 
                             episodes as to-be-avoided &#8220filler&#8221 fluff to newcomers, and a sizable portion of episode 
                             reviews feature negative commentary such as &#8220repetitive...poor AI&#8221, &#8220painfully 
                             long&#8221, and &#8220overrated&#8221. Here is where analysis of anime trends over release years 
                             come into light. A quick comparison of audience following and preferences of the same franchise 
                             over many years allows one to pinpoint when an audience tires from content, the effectiveness 
                             of new spinoffs, and hidden details about how much future productions of a show is worth investing in. 
                            <br><br>")
  })
  
  output$source <- renderUI({
    HTML("<b> <font size=4>Data Sources</font> </b>
                              <br>
                              My data includes three datasets. One is a raw csv file processed by “rfordatascience” which compiles 
                              the raw informational categories of anime series on MyAnimeList. This provides the basic background 
                              info about almost every anime series I could hope to analyze, giving key filters such as producers, 
                              genre, studio, number of episodes, airing date, duration, and date of premiere.
                              My second and third databases are CSV files of anime recommendation ratings on Kaggle. The first of 
                              these is scraped from user preference data from 73,516 anime networking site users on 12,294 anime titles, 
                              including movie titles instead of only multi-episode series. This contains a broader range of users and 
                              standardizes rantings on a 10 point scale across different anime review sites. My third database is 
                              compiled from 2006-2015 anime reviews from Anime News Network, a major anime industry news website 
                              which reaches audiences from Canada, Australia, U.S., and Southeast Asia.  <br> <br>")

  })
  
  output$stats <- renderUI({
    HTML("<font size = 4><b> Statistic Model Analysis</font></b> <br>
    How unusual is flunctuations in popularity within specific major anime franchises?
    What if the overall popularity trend is actually improving, and thus those spinoffs 
    that demonstrate a negative trend is unusual? To analyze this, I made a dataset 
    combining all of the popular anime franchise data to look at overall trends in 
    popularity over the years. Using the model lm(formula = rank ~ start_date, data = total),
    I found that the intercept is 5034.3099 -- not a bad starting point given the number of 
    ranked anime series in the analyzed datasets is over 70,000, showing that even considering
    lesser known spinoffs, the overall popularity rank of major franchises at its release
    considering any lifetime depreciation trends is still fairly high. Something I did not 
    expect, however, was a negative correlation of -0.2237 between start date and popularity,
    suggesting as the start date grows closer to modern time, audience enthusiasm for spinoff 
    franchises have increased, leading to higher (or a lower number) popularity rank. This is
    especially interesting given that I included a episode-based weight on the initial franchise 
    releases (like the original Naruto series), which significantly drags down the popularity
    trends by setting a very high (or numerically low) popularity rank at the very beginning.
    <br>
         ")})
  
  url0 <- a("Top Anime List", href = "https://myanimelist.net/topanime.php?type=bypopularity")

  output$rsource <- renderUI({
    tagList("Source: MyAnimeList:", url0)
  })
  

  url1 <- a("rfordatascience", href = "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-23/tidy_anime.csv")
  
  output$tab <- renderUI({
    tagList("URLs: Raw anime information database processed by", url1)
  })
  
  url2 <- a("https://www.kaggle.com/CooperUnion/anime-recommendations-database/data", href = " https://www.kaggle.com/CooperUnion/anime-recommendations-database/data")
  
  output$tab2 <- renderUI({
    tagList("Anime recommendations:", url2)
  })
  
  url3 <- a("https://www.kaggle.com/canggih/anime-data-score-staff-synopsis-and-genre#dataanime.csv", href = "https://www.kaggle.com/canggih/anime-data-score-staff-synopsis-and-genre#dataanime.csv")
  
  output$tab3 <- renderUI({
    tagList("A full recommendation set from Anime News Network:", url2)
  })
  
  
  output$bio <- renderUI({
    HTML("<br> <b> <font size=4>About Me</font></b><br>
                            My name is Minjue Wu and I am a sophomore at Harvard College studying History of
                            Science and Music with a secondary in Global Health and Health Policy. I was born in China and raised on a healthy diet of 
                             Asian animated shows, many of which are imported from Japan, and I am fascinated by the trends and evolution of these
                            productions.
         <br> <br>")
  })
  
  output$plot <- renderPlot(data_input())
  
  output$plot1 <- renderPlot(data_input2())
  
  output$total <- renderPlot(totality)

}

shinyApp(ui, server)

