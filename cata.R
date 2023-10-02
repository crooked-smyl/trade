
options(shiny.maxRequestSize = 30*1024^2)

pill <- function(...) {
  shiny::tabPanel(..., class = "p-3 border rounded")
}


#Create sql lite database
pool <- dbPool(RSQLite::SQLite(), dbname = "db.sqlite")

#Create sql lite df
catalogue_df <- data.frame(row_id = character(),
                           trade = character(),
                           product = character(),
                           quantity = numeric(),
                           price = numeric(),
                           location = character(),
                           comment = character(),
                           available = character(),
                           date = as.Date(character()),
                           user = character(),
                           phone = numeric(),
                           stringsAsFactors = FALSE)

#Create responses table in sql database
dbWriteTable(pool, "catalogue_df", catalogue_df, overwrite = FALSE, append = TRUE)

#Label mandatory fields
labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}

appCSS <- ".mandatory_star { color: red; }"

# ui
cataui <- function(id){
  ns <- NS(id)
  
  
  
  page_fluid(
    shinyjs::useShinyjs(),
    shinyjs::inlineCSS(appCSS),
    
    
    div (class="container",
         div(class="row",
             actionButton(ns("add_button"), "Add", icon("plus"),width = '150px'),
             actionButton(ns("edit_button"), "Edit", icon("edit"),width = '150px'),
             actionButton(ns("copy_button"), "Copy", icon("copy"),width = '150px'),
             actionButton(ns("delete_button"), "Delete", icon("trash-alt"),width = '150px')
         )
    ),
    
    
    br(),
    div (class="container",
          div(class="row",
             DT::dataTableOutput(ns("responses_table"), width = "100%")
             
          )   
    )
  )
}

# Server
cataserver <- function(id,creds_reactive,credentials,product_res){
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
      
      
#      if (creds_reactive()$user == "Levis Ogoro"){
#        # If a manager, show everything.
#        return(cata)
#      } else{
#        # If a regular salesperson, only show their own sales.
#        return(cata[cata$user == creds_reactive()$user,])
#      }
      
      cata
      
    })
    
    
    
    
    
    
    
    
    #load catalogue_df and make reactive to inputs  
    catalogue_df <- reactive({
      
      
      
      #make reactive to
      input$submit
      input$submit_edit
      input$copy_button
      input$delete_button
      
      cata <- dbReadTable(pool, "catalogue_df")
      
        if (creds_reactive()$user == "Levis Ogoro"){
          # If a manager, show everything.
          return(cata)
        } else{
          # If a regular salesperson, only show their own sales.
          return(cata[cata$user == creds_reactive()$user,])
        }
      
      

      
      
    })  
    
    #List of mandatory fields for submission
    fieldsMandatory <- c("trade","product", "quantity","price","location","available")
    
    #define which input fields are mandatory 
    observe({
      
      
      
      mandatoryFilled <-
        vapply(fieldsMandatory,
               function(x) {
                 !is.null(input[[x]]) && input[[x]] != ""
               },
               logical(1))
      mandatoryFilled <- all(mandatoryFilled)
      
      shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
    })
    
    #Form for data entry
    entry_form <- function(button_id){
      
      
      
      showModal(
        modalDialog(
          div(id=("entry_form"),
              tags$head(tags$style(".modal-dialog{ width:400px}")),
              tags$head(tags$style(HTML(".shiny-split-layout > div {overflow: visible}"))),
              page_fluid(
                div(
                  splitLayout(
                    cellWidths = c("250px", "100px"),
                    cellArgs = list(style = "vertical-align: top"),
                    selectInput(ns("trade"), labelMandatory("Trade type"), multiple = FALSE, choices = c("Request", "Offer"))
                    
                     
                  ),
                  selectInput(ns("product"), labelMandatory("Product"), multiple = FALSE, choices = c((prod_df()$product),"Maize")),
                  numericInput(ns("quantity"), labelMandatory("Quantity"), value = 1, min = 1, max = 1000000),
                  numericInput(ns("price"), labelMandatory("Price Per Unit"), value = 1, min = 1, max = 1000000),
                  textInput(ns("location"), labelMandatory("Location"), placeholder = "", width = "354px"),
                  textAreaInput(ns("comment"), "Comment", placeholder = "", height = 100, width = "354px"),
                  radioButtons(ns('available'), labelMandatory('Availability'), choices = c("Available","Not Available")),
                  actionButton(ns(button_id), "Submit")
                  
                  
                ),
                easyClose = TRUE
              )
          )
        )
      )
    }
    
    #
    fieldsAll <- c("trade","product", "quantity","price" , "location","comment","available")
    
    #save form data into data_frame format
    formData <- reactive({
      
      
      
      formData <- data.frame(row_id = UUIDgenerate(),
                             trade = input$trade,
                             product = input$product,
                             quantity = input$quantity,
                             price = input$price,
                             location = input$location,
                             
                             comment = input$comment,
                             available = input$available,
                             date = as.character(format(Sys.Date(), format="%m/%d/%Y")),
                             user= as.character(creds_reactive()$user),
                             phone = as.numeric(creds_reactive()$phone),
                             stringsAsFactors = FALSE)
      return(formData)
      
    })
    
    #Add data
    appendData <- function(data){
      
      
      
      quary <- sqlAppendTable(pool, "catalogue_df", data, row.names = FALSE)
      dbExecute(pool, quary)
    }
    
    observeEvent(input$add_button, priority = 20,{
      
      
      
      entry_form("submit")
      
    })
    
    observeEvent(input$submit, priority = 20,{
      
      
      
      appendData(formData())
      shinyjs::reset("entry_form")
      removeModal()
      
    })
    
    #delete data
    deleteData <- reactive({
      
      
      
      SQL_df <- dbReadTable(pool, "catalogue_df")
      row_selection <- SQL_df[input$responses_table_rows_selected, "row_id"]
      
      quary <- lapply(row_selection, function(nr){
        
        dbExecute(pool, sprintf('DELETE FROM "catalogue_df" WHERE "row_id" == ("%s")', nr))
      })
    })
    
    observeEvent(input$delete_button, priority = 20,{
      
      
      
      if(length(input$responses_table_rows_selected)>=1 ){
        deleteData()
      }
      
      showModal(
        
        if(length(input$responses_table_rows_selected) < 1 ){
          modalDialog(
            title = "Warning",
            paste("Please select row(s)." ),easyClose = TRUE
          )
        })
    })
    
    #copy data
    unique_id <- function(data){
      
      
      
      replicate(nrow(data), UUIDgenerate())
    }
    
    copyData <- reactive({
      
      
      
      SQL_df <- dbReadTable(pool, "catalogue_df")
      row_selection <- SQL_df[input$responses_table_rows_selected, "row_id"] 
      SQL_df <- SQL_df %>% dplyr::filter(row_id %in% row_selection)
      SQL_df$row_id <- unique_id(SQL_df)
      
      quary <- sqlAppendTable(pool, "catalogue_df", SQL_df, row.names = FALSE)
      dbExecute(pool, quary)
      
    })
    
    observeEvent(input$copy_button, priority = 20,{
      
      
      
      if(length(input$responses_table_rows_selected)>=1 ){
        copyData()
      }
      
      showModal(
        
        if(length(input$responses_table_rows_selected) < 1 ){
          modalDialog(
            title = "Warning",
            paste("Please select row(s)." ),easyClose = TRUE
          )
        })
      
    })
    
    #edit data
    observeEvent(input$edit_button, priority = 20,{
      
      
      
      SQL_df <- dbReadTable(pool, "catalogue_df")
      
      showModal(
        if(length(input$responses_table_rows_selected) > 1 ){
          modalDialog(
            title = "Warning",
            paste("Please select only one row." ),easyClose = TRUE)
        } else if(length(input$responses_table_rows_selected) < 1){
          modalDialog(
            title = "Warning",
            paste("Please select a row." ),easyClose = TRUE)
        })  
      
      if(length(input$responses_table_rows_selected) == 1 ){
        
        
        
        entry_form("submit_edit")
        
        updateSelectInput(session, "trade", selected = SQL_df[input$responses_table_rows_selected, "trade"])
        updateSelectInput(session, "product", selected = SQL_df[input$responses_table_rows_selected, "product"])
        updateNumericInput(session, "quantity", value = SQL_df[input$responses_table_rows_selected, "quantity"])
        updateNumericInput(session, "price", value = SQL_df[input$responses_table_rows_selected, "price"])
        updateTextInput(session, "location", value = SQL_df[input$responses_table_rows_selected, "location"])
        updateTextAreaInput(session, "comment", value = SQL_df[input$responses_table_rows_selected, "comment"])
        updateRadioButtons(session, "available", selected = SQL_df[input$responses_table_rows_selected, "available"])
        
      }
      
    })
    
    observeEvent(input$submit_edit, priority = 20, {
      
      
      SQL_df <- dbReadTable(pool, "catalogue_df")
      row_selection <- SQL_df[input$responses_table_row_last_clicked, "row_id"] 
      dbExecute(pool, sprintf('UPDATE "catalogue_df" SET "product" = ?, "quantity" = ?, "price" = ? , "location" = ?,
                          "comment" = ?,"available" = ? WHERE "row_id" = ("%s")', row_selection), 
                param = list(
                  input$trade,
                  input$product,
                  input$quantity,
                  input$price,
                  input$location,
                             
                             input$comment,
                             input$available))
                
      removeModal()
      
    })
    
    
    output$responses_table <- DT::renderDataTable({
      
      table <- catalogue_df() %>% select(-row_id,-date,-user,-phone)
      names(table) <- c("Trade", "Product", "Quantity", "Price"  , "Location" ,"Comment","Available")
      table <- datatable(table, 
                         rownames = FALSE,
                         options = list(searching = FALSE, lengthChange = FALSE)
      )
      
    })
    
    return(list(
      submit = reactive({input$submit}),
      submitedit = reactive({input$submit_edit}),
      copy =  reactive({input$copy_button}),
      delete = reactive({input$delete_button})
      ))
    
    
    
  })
}


