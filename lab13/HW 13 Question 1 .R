# HW 13 Question 1 
# Seona Patel

library(tidyverse)
library(shiny)
library(shinydashboard)
library(naniar)
library(janitor)
library(stringr)
library(RColorBrewer)

uc_admit <- readr::read_csv("data/UC_admit.csv")
uc_admit <- clean_names(uc_admit)
uc_admit <- uc_admit %>% 
  mutate(perc_fc_dbl = str_replace(perc_fr, "%", "")) %>% 
  select(-perc_fr)
uc_admit$academic_yr <- as.factor(uc_admit$academic_yr)


ui <- dashboardPage(skin = "red",
                    dashboardHeader(title = "University of California Admissions 2010-2019"),
                    dashboardSidebar(),
                    dashboardBody(
                      selectInput("y", "Select Filter", choices = c("academic_yr", "campus", "category"), selected = "campus"),
                      plotOutput("plot", width = "800px", height = "500px"))
)

server <- function(input, output, session) { 
  output$plot <- renderPlot({
    uc_admit %>% 
      filter(ethnicity!="All") %>% 
      ggplot(aes_string(x = "ethnicity", y = "filtered_count_fr", fill=input$y)) +
      geom_col(position="dodge", alpha = 0.8, size=4)+
      theme_light(base_size = 20) + 
      scale_fill_brewer(palette = "Paired")+
      labs(title= "University of California Admissions Data 2010-2019", x="Ethnicity", y="Number of Admitted Freshmen", fill = "Legend")+
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
  })
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)
