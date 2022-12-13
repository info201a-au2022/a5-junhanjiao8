
library(shiny)
library(dplyr)
library(plotly)

co2_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")


#What is the average value of CO2_consumption in 2018 across all counties. 
avg_consump_1990 <- co2_df %>%
  filter(year == 1990) %>%
  summarise(ave_consump = mean(consumption_co2, na.rm = TRUE)) %>%
  pull(ave_consump)
avg_consump_1990

#What is the average value of CO2_consumption in 2020 across all counties. 
avg_consump_2020 <- co2_df %>%
  filter(year == 2020) %>%
  summarise(ave_consump = mean(consumption_co2, na.rm = TRUE)) %>%
  pull(ave_consump)
avg_consump_2020

#which country is the NO.1 consumption of CO2 in the world.
max_consump_country <- co2_df %>%
  group_by(country) %>%
  summarise(ave_consump = mean(consumption_co2, na.rm = TRUE)) %>%
  filter(ave_consump == max(ave_consump, na.rm = TRUE)) %>%
  pull(country)
max_consump_country



#Interactive graph
server <- function(input, output) {
#this is the text part 
  output$avg_consump_1990 <- renderText(avg_consump_1990)
  output$avg_consump_2020 <- renderText(avg_consump_2020)
  output$max_consump_country <- renderText(max_consump_country)
  
#this is the graph part 
  output$graph <- renderPlotly({
    #this function get interactive dataframe to produce graph
    get_data <- reactive({
      return(subset(co2_df, (country %in% input$country_name & 
                               year %in% (input$slider[1]:input$slider[2]))))
    })
    #use ggplot get the graph
    consump_df <- get_data()
    consump_plot <- ggplot(data = consump_df , aes(x = year, y = consumption_co2))+
      geom_bar(stat = "identity")
    consump_plot
  })
}
