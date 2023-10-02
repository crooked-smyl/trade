pill <- function(...) {
  shiny::tabPanel(..., class = "p-3 border rounded")
}

#Create sql lite database
pool <- dbPool(RSQLite::SQLite(), dbname = "db.sqlite")

#Create sql lite df
product_df <- data.frame(row_id = character(),
                       product = character(),
                       date = as.Date(character()),
                       user = character(),
                       stringsAsFactors = FALSE)

#Create responses table in sql database
dbWriteTable(pool, "product_df", product_df, overwrite = FALSE, append = TRUE)

#Label mandatory fields
labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}

appCSS <- ".mandatory_star { color: red; }"

# ui
productui <- function(id){
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
productserver <- function(id,creds_reactive,credentials){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    
    
    
    
    
    
    #load product_df and make reactive to inputs  
    product_df <- reactive({
      
      
      
      #make reactive to
      input$submit
      input$submit_edit
      input$copy_button
      input$delete_button
      
      cata <- dbReadTable(pool, "product_df")
      
      if (creds_reactive()$user == "Levis Ogoro"){
        # If a manager, show everything.
        return(cata)
      } else{
        # If a regular salesperson, only show their own sales.
        return(cata[cata$user == creds_reactive()$user,])
      }
      
    })
    
    
    
    #List of mandatory fields for submission
    fieldsMandatory <- c("product")
    
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
                di(
                  splitLayout(
                    cellWidths = c("250px", "100px"),
                    cellArgs = list(style = "vertical-align: top"),
                    textInput(ns("product"), labelMandatory("Product/Commodity"), placeholder = "")
                  ),
                  
                  actionButton(ns(button_id), "Submit")
                ),
                easyClose = TRUE
              )
          )
        )
      )
    }
    
    #
    fieldsAll <- c("product")
    
    #save form data into data_frame format
    formData <- reactive({
      
      
      
      formData <- data.frame(row_id = UUIDgenerate(),
                             product = input$product,
                             date = as.character(format(Sys.Date(), format="%d-%m-%Y")),
                             user= as.character(creds_reactive()$user),
                             stringsAsFactors = FALSE)
      return(formData)
      
    })
    
    #Add data
    appendData <- function(data){
      
      
      
      quary <- sqlAppendTable(pool, "product_df", data, row.names = FALSE)
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
      
      
      
      SQL_df <- dbReadTable(pool, "product_df")
      row_selection <- SQL_df[input$responses_table_rows_selected, "row_id"]
      
      quary <- lapply(row_selection, function(nr){
        
        dbExecute(pool, sprintf('DELETE FROM "product_df" WHERE "row_id" == ("%s")', nr))
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
      
      
      
      SQL_df <- dbReadTable(pool, "product_df")
      row_selection <- SQL_df[input$responses_table_rows_selected, "row_id"] 
      SQL_df <- SQL_df %>% dplyr::filter(row_id %in% row_selection)
      SQL_df$row_id <- unique_id(SQL_df)
      
      quary <- sqlAppendTable(pool, "product_df", SQL_df, row.names = FALSE)
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
      
      
      
      SQL_df <- dbReadTable(pool, "product_df")
      
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
        updateTextInput(session, "product", value = SQL_df[input$responses_table_rows_selected, "product"])
        
      }
      
    })
    
    observeEvent(input$submit_edit, priority = 20, {
      
      
      SQL_df <- dbReadTable(pool, "product_df")
      row_selection <- SQL_df[input$responses_table_row_last_clicked, "row_id"] 
      dbExecute(pool, sprintf('UPDATE "product_df" SET   "product" = ? 
                          WHERE "row_id" = ("%s")', row_selection), 
                param = list(
                  input$product))
      removeModal()
      
    })
    
    
    output$responses_table <- DT::renderDataTable({
      
      req(credentials()$user_auth)
      
      table <- product_df() %>% select(-row_id, -date, -user) 
      names(table) <- c("Product/Commodity")
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
