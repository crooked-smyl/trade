

#



# docker run --rm -p 8787:8787 -e PASSWORD=58582655 rocker/verse


# docker build -f C:\Users\user\Documents\Github\docker-trial\Dockerfile -t test .

# docker build -f D:\Github\ESCABOT\Dockerfile -t escabot .

# docker build -t test .


# set Directory on Ubuntu
# cd /mnt/e/username/folder1/folder2

# remember to set the path for the working directory the parent directory.
# Set-Location -Path C:\Users\user\Documents\Github\docker-trial

# Set-Location -Path D:\Github\Trade_Catalogue

# docker build -t trade .

# docker run -d --rm -p 3838:3838 trade .

# docker run -d -p 8080:8080 trade






#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyauthr)
library(bslib)
library(openssl)
library(googlesheets4)
library(conflicted)
library(readxl)
library(tidyr)
library(dplyr)
library(dbplyr)
library(magrittr)
library(ggplot2)
library(bslib)
library(shinyWidgets)
#library(networkD3)
library(DT)
library(purrr)
library(tidyverse)
library(htmltools)
library(htmlwidgets)
library(zoo)
library(RPMG)
library(shinyjs)
library(shinyjqui)
library(plotly)
#library(OSUICode)
library(data.table)
library(shinyBS)
library(svglite)
library(gdtools)
library(lubridate)
library(rsconnect)
library(readr)
library(RSQLite)
library(pool)
library(odbc)
library(DBI)
library(fontawesome)
library(bsicons)
library(googledrive)
library(renv)
library(uuid)
library(rmarkdown)
library(markdown)
library(knitr)
library(backports)
library(lifecycle)
library(tibble)
library(reprex)
library(crul)
library(curl)
library(httpcode)
library(AlphaPart)
library(openxlsx)
library(spsComps)
library(vetiver)

source("product.R")
source("cata.R")
source("catalogue.R")

options(shiny.host = '0.0.0.0')
options(shiny.port = 8080)

# dataframe that holds usernames, passwords and other user data
user_base <- tibble::tibble(
  user = c("user1", "user2"),
  password = sapply(c("pass1", "pass2"), sodium::password_store),
  permissions = c("admin", "standard"),
  name = c("User One", "User Two"),
  status = c("farmer", "hotel"),
  phone = c("254726164265","254712345678")
)

login_tab <- bslib::nav_panel(
  title = icon("lock"), 
  value = "login", 
  shinyauthr::loginUI("login")
)

# additional tabs to be added after login
product_tab <- bslib::nav_panel("Product Update",
                             productui("product")
)

cata_tab <- bslib::nav_panel("Catalogue Update",
                 cataui("traderc")
)



pill <- function(...) {
  shiny::tabPanel(..., class = "p-3 border rounded")
}


# Define UI for application that draws a histogram
ui <- ui <- page_fluid(
#  shinyjs::useShinyjs(),
#  shinyjs::inlineCSS(appCSS),
  
  theme = bslib::bs_theme(version = 5, bootswatch = "litera"),
  tags$style(
    ".glide-controls { position: absolute; top: 18px; right: 15px; width: 160px; }"
  ),
  tags$head(tags$style(HTML(".shiny-split-layout > div {overflow: visible}"))),
  #tags$head( tags$script(HTML(' $(document).ready(function() { const observer = new IntersectionObserver(function(entries) { if (entries[0].intersectionRatio > 0) {
  #          alert("Reached end of list!")
  #        }
  #      });

  #      observer.observe(document.querySelector("#end"));
  #    })
  #  '))
  #),
  
  
  page_navbar(title = htmltools::img(src="EAGC.png","B2B PLATFORM", height = "80px"),
              id = "tabs",
              theme = "style.css",
              bg = 'white',
              position = "static-top",
              window_title = "East-Sourthern Africa Cross-Border Trader",
              footer = includeHTML("www/footer.html"),
              fillable = TRUE,
              collapsible = TRUE,
              fluid = TRUE,
              
              
              nav_spacer(),
              
    bslib::nav_panel("Trade Catalogue",
                     catalogueui("my_first_module_1")
    ),
    bslib::nav_panel("About",
                     layout_column_wrap(
                       width = "300px",
                       height = 500,
                     card(
                       height = 500,
                       full_screen = TRUE,
                       card_image(
                         file = "www/EAGC.png",
                         #href = "https://github.com/rstudio/shiny"
                       ),
                       card_body(
                         fill = FALSE,
                         card_title("Gerald Masila"),
                         
                         HTML('
                              <ul class="d-flex gap-3 list-unstyled">
            <li><a href="https://www.linkedin.com/in/gerald-makau-masila-355a694b/"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-linkedin" viewBox="0 0 16 16">
  <path d="M0 1.146C0 .513.526 0 1.175 0h13.65C15.474 0 16 .513 16 1.146v13.708c0 .633-.526 1.146-1.175 1.146H1.175C.526 16 0 15.487 0 14.854V1.146zm4.943 12.248V6.169H2.542v7.225h2.401zm-1.2-8.212c.837 0 1.358-.554 1.358-1.248-.015-.709-.52-1.248-1.342-1.248-.822 0-1.359.54-1.359 1.248 0 .694.521 1.248 1.327 1.248h.016zm4.908 8.212V9.359c0-.216.016-.432.08-.586.173-.431.568-.878 1.232-.878.869 0 1.216.662 1.216 1.634v3.865h2.401V9.25c0-2.22-1.184-3.252-2.764-3.252-1.274 0-1.845.7-2.165 1.193v.025h-.016a5.54 5.54 0 0 1 .016-.025V6.169h-2.4c.03.678 0 7.225 0 7.225h2.4z"/>
</svg></a></li>
          </ul>'),
                         p(
                           class = "fw-light text-muted",
                           "Executive Director at Eastern Africa Grain Council."
                         )
                       )
                     ),
                     card(
                       height = 500,
                       full_screen = TRUE,
                       card_image(
                         file = "www/DSC2.jpg",
                         #href = "https://github.com/rstudio/shiny"
                       ),
                       card_body(
                         fill = FALSE,
                         card_title("Levis Ogoro"),
                         
                         HTML('
                              <ul class="d-flex gap-3 list-unstyled">
            <li><a href="https://twitter.com/OgoroLevis"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-twitter" viewBox="0 0 16 16">
  <path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z"/>
</svg></a></li>
            <li><a href="https://www.linkedin.com/in/ogorolevis/"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-linkedin" viewBox="0 0 16 16">
  <path d="M0 1.146C0 .513.526 0 1.175 0h13.65C15.474 0 16 .513 16 1.146v13.708c0 .633-.526 1.146-1.175 1.146H1.175C.526 16 0 15.487 0 14.854V1.146zm4.943 12.248V6.169H2.542v7.225h2.401zm-1.2-8.212c.837 0 1.358-.554 1.358-1.248-.015-.709-.52-1.248-1.342-1.248-.822 0-1.359.54-1.359 1.248 0 .694.521 1.248 1.327 1.248h.016zm4.908 8.212V9.359c0-.216.016-.432.08-.586.173-.431.568-.878 1.232-.878.869 0 1.216.662 1.216 1.634v3.865h2.401V9.25c0-2.22-1.184-3.252-2.764-3.252-1.274 0-1.845.7-2.165 1.193v.025h-.016a5.54 5.54 0 0 1 .016-.025V6.169h-2.4c.03.678 0 7.225 0 7.225h2.4z"/>
</svg></a></li>

<li><a href="https://wa.me/254726164265"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-whatsapp" viewBox="0 0 16 16">
  <path d="M13.601 2.326A7.854 7.854 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.933 7.933 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.898 7.898 0 0 0 13.6 2.326zM7.994 14.521a6.573 6.573 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.557 6.557 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592zm3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.729.729 0 0 0-.529.247c-.182.198-.691.677-.691 1.654 0 .977.71 1.916.81 2.049.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232z"/>
</svg></a></li>


<li><a href="mailto:ogorolevis@gmail.com"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
  <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/>
</svg></a></li>


          </ul>'),
                         p(
                           class = "fw-light text-muted",
                           "Good Citizen of The World 🌎| Passionate R Developer and Data Analyst | 
                           Crafting Interactive Shiny Applications for Data-driven Insights"
                         )
                       )
                     ),
                     card(
                       height = 500,
                       full_screen = TRUE,
                       card_image(
                         file = "www/EAGC.png",
                         #href = "https://github.com/rstudio/shiny"
                       ),
                       card_body(
                         fill = FALSE,
                         card_title("Claire Gitau"),
                         
                         HTML('
                              <ul class="d-flex gap-3 list-unstyled">
            
            <li><a href="https://www.linkedin.com/in/claire-gitau-28b08245/"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-linkedin" viewBox="0 0 16 16">
  <path d="M0 1.146C0 .513.526 0 1.175 0h13.65C15.474 0 16 .513 16 1.146v13.708c0 .633-.526 1.146-1.175 1.146H1.175C.526 16 0 15.487 0 14.854V1.146zm4.943 12.248V6.169H2.542v7.225h2.401zm-1.2-8.212c.837 0 1.358-.554 1.358-1.248-.015-.709-.52-1.248-1.342-1.248-.822 0-1.359.54-1.359 1.248 0 .694.521 1.248 1.327 1.248h.016zm4.908 8.212V9.359c0-.216.016-.432.08-.586.173-.431.568-.878 1.232-.878.869 0 1.216.662 1.216 1.634v3.865h2.401V9.25c0-2.22-1.184-3.252-2.764-3.252-1.274 0-1.845.7-2.165 1.193v.025h-.016a5.54 5.54 0 0 1 .016-.025V6.169h-2.4c.03.678 0 7.225 0 7.225h2.4z"/>
</svg></a></li>

<li><a href="https://wa.me/254712652104"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-whatsapp" viewBox="0 0 16 16">
  <path d="M13.601 2.326A7.854 7.854 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.933 7.933 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.898 7.898 0 0 0 13.6 2.326zM7.994 14.521a6.573 6.573 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.557 6.557 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592zm3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.729.729 0 0 0-.529.247c-.182.198-.691.677-.691 1.654 0 .977.71 1.916.81 2.049.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232z"/>
</svg></a></li>


          </ul>'),
                         p(
                           class = "fw-light text-muted",
                           "Good Citizen of The World 🌎| Passionate R Developer and Data Analyst | 
                           Crafting Interactive Shiny Applications for Data-driven Insights"
                         )
                       )
                     )
                     )
          #          includeHTML("about.html"),
          #           shinyjs::useShinyjs(),
          #           tags$head(
          #             tags$link(rel = "stylesheet", 
          #                       type = "text/css", 
          #                       href = "plugins/carousel.css"),
          #             tags$script(src = "plugins/holder.js")
          #           ),
          #           tags$style(type="text/css",
          #                      ".shiny-output-error { visibility: hidden; }",
          #                      ".shiny-output-error:before { visibility: hidden; }"
          #           )
    ),
    login_tab
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  # hack to add the logout button to the navbar on app launch 
  insertUI(
    selector = ".navbar .container-fluid .navbar-collapse",
    ui = tags$ul(
      class="nav navbar-nav navbar-right",
      tags$li(
        div(
          style = "padding: 10px; padding-top: 8px; padding-bottom: 0;",
          shinyauthr::logoutUI("logout")
        )
      )
    )
  )
  
  # call the shinyauthr login and logout server modules
  credentials <- shinyauthr::loginServer(
    id = "login",
    data = user_base,
    user_col = "user",
    pwd_col = "password",
    sodium_hashed = TRUE,
    reload_on_logout = TRUE,
    log_out = reactive(logout_init())
  )
  
  logout_init <- shinyauthr::logoutServer(
    id = "logout",
    active = reactive(credentials()$user_auth)
  )
  
  
  creds_reactive <- reactive({credentials()$info})
  
  GetUser<-reactive({
    return(creds_reactive()$user)
  })
  
  #################################################################################
  
  product_res <- productserver("product",creds_reactive,credentials)
  
  cata_res <- cataserver("traderc",creds_reactive,credentials,product_res)
  
  catalogueserver("my_first_module_1",cata_res,product_res)

    
# observeEvent(credentials()$user_auth, {
#  nav_insert(
#      "navBar", target = "Product Update", select = TRUE,
#      nav_panel("Dynamic", "Dynamically added content")
#    )
#  })
  
#  observe(
#    {
#     if(creds_reactive()$user == "Levis Ogoro") {
       
#     }
      
#    }
#  )
  
  
  observeEvent(credentials()$user_auth, {
    # if user logs in successfully
    if (credentials()$user_auth) { 
      # remove the login tab
      removeTab("tabs", "login")
      # add home tab 
      appendTab("tabs", product_tab, select = TRUE)
      # render user data output
#      output$user_data <- renderPrint({ dplyr::glimpse(credentials()$info) })
      # add data tab
      appendTab("tabs", cata_tab)
      # render data tab title and table depending on permissions
#      user_permission <- credentials()$info$permissions
#      if (user_permission == "admin") {
#        output$data_title <- renderUI(tags$h2("Storms data. Permissions: admin"))
#        output$table <- DT::renderDT({ dplyr::storms[1:100, 1:11] })
#      } else if (user_permission == "standard") {
#        output$data_title <- renderUI(tags$h2("Starwars data. Permissions: standard"))
#        output$table <- DT::renderDT({ dplyr::starwars[, 1:10] })
#      }
    }
  })
  
  
  
#  observeEvent(credentials()$user_auth, {
    # if user logs in successfully
#    if (length(credentials()$user_auth)<1) { 
      # remove the login tab
#      appendTab("navBar", "login")
      # add home tab 
#      removeTab("navBar", product_tab, select = TRUE)
      # render user data output
      #      output$user_data <- renderPrint({ dplyr::glimpse(credentials()$info) })
      # add data tab
#      removeTab("navBar", cata_tab)
      # render data tab title and table depending on permissions
      #      user_permission <- credentials()$info$permissions
      #      if (user_permission == "admin") {
      #        output$data_title <- renderUI(tags$h2("Storms data. Permissions: admin"))
      #        output$table <- DT::renderDT({ dplyr::storms[1:100, 1:11] })
      #      } else if (user_permission == "standard") {
      #        output$data_title <- renderUI(tags$h2("Starwars data. Permissions: standard"))
      #        output$table <- DT::renderDT({ dplyr::starwars[, 1:10] })
      #      }
#    }
#  })
  
  
  
  gc()
  
}

# Run the application 
shinyApp(ui = ui, server = server)
