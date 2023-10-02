
pill <- function(...) {
  shiny::tabPanel(..., class = "p-3 border rounded")
}


catalogueui <- function(id){
  ns <- NS(id)
  
  page_fluid(
    
    div (class="position-relative",h1("Advertise Here")),
    
#  tags$style(HTML("
#                  cata {
#                    height:100px;
#                    overflow-y:scroll
#                  }
#                  ")),

  
  spsGoTop("mid", right = "50%",  bottom= "50%", icon = icon("arrow-up"), color = "green"),
  
  
  div (class="container",
      div (class="row",
  
  div(class="col-12",
      
    tabsetPanel(
      type = "pills",
           pill("Trade Offers",
                    
 #               layout_column_wrap(
#                  width = 1/2,
#                  heights_equal = "row",
#div( class="container vertical-scrollable",
           #     div(  class="position-fixed",
                     uiOutput(ns('cata')),
          #      ),
#     ),
                  
                  
  #              ),
#div( class="container vertical-scrollable",
        #        layout_column_wrap(
        #          width = 1/2,
        #          heights_equal = "row",
              #   div(  class="position-fixed",
                  uiOutput(ns('catas'))
               #   )
       #         )
#)
                
                     # uiOutput(ns("catas"))
                    
                        
           ),
           pill("Trade Requests",
                
                      uiOutput(ns('offersinput')),
                
                    uiOutput(ns("offerplot"))
                    
           )
           
    )
  )
#,
#  div(class="col-6",
#    div (class="position-fixed",h1("Advertise Here"))
#  )
  )
  )
  )
  
}




catalogueserver <- function(id,cata_res,product_res){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    
    #load product_df and make reactive to inputs  
    prod_df <- reactive({
      #make reactive to
      product_res$submit()
      product_res$submitedit()
      product_res$copy()
      product_res$delete()
      
      cata <- dbReadTable(pool, "product_df")
      
      
      cata
    })
    
    
    
    
#    output$cata = renderUI({
      
#      pickerInput(ns('catalogue'), 'Select Items To Filter', choices=unique(prod_df()$product), options = list(`actions-box` = TRUE), selected=NULL, multiple=TRUE)
      
#    })
    
#    output$offersinput = renderUI({
      
#      pickerInput(ns('offers'), 'Select Items To Filter', choices=unique(prod_df()$product), options = list(`actions-box` = TRUE), selected=NULL, multiple=TRUE)
      
#    })
    
    output$cata = renderUI({
      shiny::selectInput(ns('catalogue'), 'Select Items To Filter', 
                         choices=unique(prod_df()$product),
                         selectize = T,
                         selected=unique(prod_df()$product),
                         multiple = TRUE)
    })
      
    
    output$offersinput = renderUI({
      shiny::selectInput(ns('offers'), 'Select Items To Filter', 
                         choices=unique(prod_df()$product),
                         selectize = T,
                         selected=unique(prod_df()$product),
                         multiple = TRUE)
    })    
        
      
      
        
        
        trade <- reactive({
          cata_res$submit()
          cata_res$submitedit()
          cata_res$copy()
          cata_res$delete()
          
          
          
          
          db <- dbConnect(SQLite(), dbname="db.sqlite")
          
          data <- dbReadTable(db, "catalogue_df") 
          
          dat <- data%>%
            dplyr::filter(trade=="Request")%>%
            dplyr::filter(product %in% input$catalogue)
          
          
       #   if (is.null(input$catalogue)) {df <- dat
      #    } else df <- dat[dat$product %in% input$catalogue,]
          
      #    df1<- df %>% arrange(desc(mdy(df$date)))
          
      #    return(df1)
          dat
          
        })
    
        
    
        
    
    
    
    
    offers <- reactive({
      
      cata_res$submit()
      cata_res$submitedit()
      cata_res$copy()
      cata_res$delete()
      
      db <- dbConnect(SQLite(), dbname="db.sqlite")
      
      data <- dbReadTable(db, "catalogue_df")
      
      dat <- data%>%
        dplyr::filter(trade=="Offer")%>%
        dplyr::filter(product %in% input$offers)
      
      
      
      
    #  if (is.null(input$offers)) {df <- dat
    #  } else df <- dat[dat$product %in% input$offers,]
      
    #  df1<- df %>% arrange(desc(mdy(df$date)))
      
    #  return(df1)
      
    })
    
    
    
    output$catas <- renderUI({
      
      if (length(trade()$product) < 1){
        
        
        
      } 
      else{
      
      lapply(1:length(trade()$product), function(i) {
        
#        div (class="card mb-12",
#             div (class="row",
#                  div( class="col-sm-3",
#                       img (src=if(trade()$product[i] == 'Maize'){
#                         "https://images.all-free-download.com/images/graphicwebp/corn_maize_varieties_peru_227886.webp"
#                       } else {
#                         "https://images.all-free-download.com/images/graphicwebp/peas_190744.webp"
#                       }, alt="example design logo",height = 200, width = 200)),
#                  div (class="col-sm-9",
#                       div(trade()$product[i]),
#                       div("Price per Unit: KSH",trade()$price[i], HTML('&nbsp;'), HTML('&nbsp;') ,"Quantity:",trade()$quantity[i]),
#                       div(trade()$location[i],HTML('&nbsp;'),HTML('&nbsp;'), a(fa("whatsapp", fill = "green"),"WhatsApp", href=paste0("https://wa.me/",trade()$phone[i],"?text=I'm%20interested%20in%20your%20",trade()$product[i],"s%20on%20sale"))),
#                       div(trade()$comment[i])
#                  )
#             )
 #       )
        
        
        
        
        div (class="event-list",
             div( class="card flex-row",
                  #img (class="card-img-left img-fluid", src="https://via.placeholder.com/150C/O https://placeholder.com/" ),
                  div( class="card-body",
                       
                #       p( class="card-text",span(CrossBorder$Date[i]),span(CrossBorder$Time[i]) ),
                #       h4( class="card-title h5 h4-sm", trade()$product[i]),
                #       a (href=CrossBorder$Link[i],class="btn btn-primary","Read More...")
                div(trade()$product[i]),
                div("Price per Unit: KSH",trade()$price[i], HTML('&nbsp;'), HTML('&nbsp;') ,"Quantity:",trade()$quantity[i]),
                div(trade()$location[i],HTML('&nbsp;'),HTML('&nbsp;'), a(fa("whatsapp", fill = "green"),"WhatsApp", href=paste0("https://wa.me/",trade()$phone[i],"?text=I'm%20interested%20in%20your%20",trade()$product[i],"s%20on%20sale"))),
                div(trade()$comment[i])
                
                  )
             )
        )
        
        })
    }
    })
    
    output$offerplot <- renderUI({
      
      if (length(offers()$product) < 1){
        
      } 
      else{
        
        lapply(1:length(offers()$product), function(i) {
          
    #      attachmentBlock(
            
    #        title=offers()$product[i],
            
    #        image = if(offers()$product[i] == 'Maize'){
    #          "https://images.all-free-download.com/images/graphicwebp/corn_maize_varieties_peru_227886.webp"
    #        } else {
    #          "https://images.all-free-download.com/images/graphicwebp/peas_190744.webp"
    #        },
            
    #        div("Price per Unit: KSH",offers()$price[i], HTML('&nbsp;'), HTML('&nbsp;') ,"Quantity:",offers()$quantity[i]),
    #        div(offers()$location[i],HTML('&nbsp;'),HTML('&nbsp;'), a(fa("whatsapp", fill = "green"),"WhatsApp", href=paste0("https://wa.me/",offers()$phone[i],"?text=I'm%20interested%20in%20your%20",offers()$product[i],"s%20on%20sale"))),
    #        div(offers()$comment[i])
    #      )
          
          
          div (class="event-list",
               div( class="card flex-row",
                    #img (class="card-img-left img-fluid", src="https://via.placeholder.com/150C/O https://placeholder.com/" ),
                    div( class="card-body",
                         div(offers()$product[i]),
                         div("Price per Unit: KSH",offers()$price[i], HTML('&nbsp;'), HTML('&nbsp;') ,"Quantity:",offers()$quantity[i]),
                         div(offers()$location[i],HTML('&nbsp;'),HTML('&nbsp;'), a(fa("whatsapp", fill = "green"),"WhatsApp", href=paste0("https://wa.me/",offers()$phone[i],"?text=I'm%20interested%20in%20your%20",offers()$product[i],"s%20on%20sale"))),
                         div(offers()$comment[i])
                         
                    )
               )
          )
          
        })
      }
    })
    
    
    
 #   output$plotsum <- renderUI({
#      lapply(1:length(Kenya()$date), function(i) {
#        # creates a unique ID for each plotOutput
#        id <- paste0("plot_", i)
#        plotOutput(outputId = id)
        
        # render each plot
#        output[[id]] <- renderPlotly({plot_ly(Kenya(),x = ~date, y = ~price, type = "scatter",mode ="lines"  ,name = "Monthly Expense")%>%
#            layout(yaxis = list(title = 'Price In Ksh.'))%>%
#            layout(title = "Kenya Price Movement")})
#      })
#    })
  })
}


