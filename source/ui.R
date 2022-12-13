library(shiny)
source("server.R")

intro <- tabPanel(
  "Introduction",
  h1("CO2 Emission"),
  h2("Introduction:"),
  p("• This website is dedicated analyse the the emission of the CO2 all around the world. 
    As the human activities caused severe impact on the climate, it is worthy to do plenty of research on it."),
           
  h2("Variables"),
  p("The topic I analysed is about the consumption of CO2. This is one of the variables that related to 
    public health. For example, the average CO2 consumption of the world back in 1990 was ",
    textOutput(outputId = "avg_consump_1990", inline = T), "."),
  p("And in 30 years later, the average CO2 consumption increases to ", 
    textOutput(outputId = "avg_consump_2020", inline = T),
    "This great increase of CO2 consumption leads to further discussion on the growing trend of CO2 consumption."),
  p("After the calculation, I found out that the number one CO2 consumption contry in the world is : ",
    textOutput(outputId = "max_consump_country", inline = T), ".",
    "Therefore, I decided to keep investigating the trend of Co2 consumption both in U.S. and other countries."
   )
)


plot <- tabPanel("Visualization", titlePanel("CO2 Consumption Across Different Years Around the World"),

    sidebarPanel(
      sliderInput(
        inputId = "slider",
        label = "Select Year",
        min = min(co2_df$year),
        max = max(co2_df$year),
        value = c(2010, 2020)
      ),

      selectizeInput(
        inputId = "country_name",
        label = "Select country",
        choices = co2_df$country,
        selected = "America",
        )
    ),
    
    mainPanel(
      p(plotlyOutput(outputId = "graph"),
        "We can see from this visualization, the general trend of CO2 consumption 
        is still increasing, we can also see the effort of the improvement of how people 
        think of CO2 consumption, because more and more counties are 
        taking this serious, and using more method to increase the consumption of CO2.
        But in different place of the world, the CO2 consumption level are different.
        Maybe in some areas, the CO2 consumption are increasing but in small amount. 
        That means they still need some help on reducing the CO2, and do better in stopping the global warming.
        ")
    )
  
)

Ui <- navbarPage(
  "CO2 Emission",
  intro,
  plot
)
