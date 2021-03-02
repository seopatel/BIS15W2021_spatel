# HW 13 Question 2
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


ui <- dashboardPage(skin="black",
                    dashboardHeader(title = "University of California Admissions from 2010-2019", 
                                    titleWidth = 600),
                    dashboardSidebar(disable = T),
                    dashboardBody(selectInput("campus", " Select Campus:", 
                                              choices=unique(uc_admit$campus)),
                                  fluidRow(
                                    box(title = "Plot Options", width = 4,
                                        selectInput("x", "Student/Applicant Details", choices = c("ethnicity", "category"), 
                                                    selected = "campus"),
                                        hr(),
                                        helpText("Reference: University of California Information Center, Admissions (2010-2019) 
               https://www.universityofcalifornia.edu/infocenter." )
                                    ), 
                                    box(width = 8,
                                        plotOutput("plot", width = "800px", height = "500px")
                                    ) 
                                  ) 
                    ) 
)
server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
    uc_admit %>%
      filter(campus == input$campus) %>%
      filter(ethnicity!="All") %>% 
      ggplot(aes_string(x = "academic_yr", y="filtered_count_fr",fill = input$x)) +
      geom_col(position = "dodge")+
      scale_fill_brewer(palette = "Set3")+
      theme_light(base_size = 20)+
      scale_x_continuous(breaks=seq(2010, 2019, by = 1))+
      theme(axis.text.x = element_text(angle = 60, hjust = 1))+
      labs(title = "UC Admission Information from 2010-2019",x=NULL,y="Number of Admitted Freshmen")
  })
  
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)