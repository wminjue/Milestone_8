library(shiny)
library(shinyjs)
library(readr)
library(dplyr)
library(tidyverse)

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

anime_names <- c("Naruto", "Bleach", "Gintama", "Fullmetal", "Keroro")

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
      "Model Explanations"
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
      htmlOutput("bio")
    )
  )
)

server <- function(input, output, session) {
  
  data_input <- reactive({
    switch(input$anime,
           "Naruto" = narr, 
           "Bleach" = blear,
           "Gintama" = gintamr,
           "Fullmetal" = fmar,
           "Keroro" = keroror
    )
  })
  
  data_input2 <- reactive({
    switch(input$anime1,
           "Naruto" = narp, 
           "Bleach" = bleap,
           "Gintama" = gintamp,
           "Fullmetal" = fmap,
           "Keroro" = kerorop
    )
    
  })

  output$interp <- renderUI({
    HTML("<b><font size = 6> Turn in the Tides</font></b> <br>
         Looking at these graphs of rank and popularity trends for ten (five more datasets forthcoming!) 
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
                             in ranking, popularity, audience size, and overall quality ratings of the 10 most 
                             popular long-running (and still running!) anime shows in history. These include Naruto, 
                             Bleach, Fullmetal Alchemist, Keroro Gunsō, Gin Tama, One Piece, Detective Conan (Case 
                             Closed), Crayon Shin-Chan, Dragon Ball Z, and Sazae-san. Ranging from 120 to over 1600 
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
  
  url0 <- a("Top Anime List", href = "https://myanimelist.net/topanime.php?type=bypopularity")

  output$rsource <- renderUI({
    tagList("Source: MyAnimeList:", url0)
  })
  

  url1 <- a("Kotaku Australia", href = "https://www.kotaku.com.au/2014/11/naruto-is-fun-and-action-filled-but-its-also-repetitive-and-painfully-long/")
  
  output$tab <- renderUI({
    tagList("URLs: Raw anime information database processed by", url1)
  })
  
  url2 <- a("https://about.twitter.com/en_us/values/elections-integrity.html#data", href = " https://about.twitter.com/en_us/values/elections-integrity.html#data")
  
  output$tab2 <- renderUI({
    tagList("Data source:", url2)
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
}

shinyApp(ui, server)

