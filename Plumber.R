
if(Sys.getenv('PORT') == '') Sys.setenv(PORT = 8000)

#' @apiTitle Testing Gargle on GCP
#' @apiDescription Testing Gargle on GCP

#* @get /scopes
#* @param scopes Comma-separated list of scopes to check with credentials_gce
#* @serializer text
function(scopes){
  
  source('credentials_gce2.R')
  
  assignInNamespace('credentials_gce', credentials_gce, ns = 'gargle')
  
  scopes <- strsplit(scopes, ',')[[1]]
  
  token <- gargle::credentials_gce(scopes = scopes)
  
  tokenIsNull <- is.null(token)
  
  project_id <- rawToChar(httr::content(gargle:::gce_metadata_request('project/project-id')))
  
  requestUrl <- paste0('https://pubsub.googleapis.com/v1/projects/', 
                       project_id, 
                       '/topics')
  
  request <- gargle::request_build(method = 'GET', base_url = 'https://pubsub.googleapis.com/', 
                                   path = paste0('v1/projects/', project_id, '/topics'), 
                                   token = httr::config(token = token))
  
  response <- jsonlite::fromJSON(gargle::request_make(request))$code
  
  tokenWorksForPubSub <- response$status_code < 300
  
  return(paste(tokenIsNull, tokenWorksForPubSub, collapse = ', '))
}


#* @get /scopes2
#* @param scopes Comma-separated list of scopes to check with credentials_gce
#* @serializer text
function(scopes){
  
  source('credentials_gce2.R')
  
  assignInNamespace('credentials_gce', credentials_gce2, ns = 'gargle')
  
  scopes <- strsplit(scopes, ',')[[1]]
  
  token <- gargle::credentials_gce(scopes = scopes)
  
  tokenIsNull <- is.null(token)
  
  project_id <- rawToChar(httr::content(gargle:::gce_metadata_request('project/project-id')))
  
  request <- gargle::request_build(method = 'GET', base_url = 'https://pubsub.googleapis.com/', 
                                   path = paste0('v1/projects/', project_id, '/topics'), 
                                   token = httr::config(token = token))
  
  response <- gargle::request_make(request)
  
  tokenWorksForPubSub <- response$status_code < 300
  
  return(paste(tokenIsNull, tokenWorksForPubSub, collapse = ', '))
}

#* @get /email
#* @param scopes Comma-separated list of scopes to check with credentials_gce
#* @serializer text
function(){
  
  token <- gargle::credentials_gce()
  
  return(gargle::token_email(token))
}
