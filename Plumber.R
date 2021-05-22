
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
  print(project_id)
  requestUrl <- paste0('https://pubsub.googleapis.com/v1/projects/', 
                       project_id, 
                       '/topics')
  
  tokenWorksForPubSub <- httr::GET(requestUrl)
  
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
  print(project_id)
  requestUrl <- paste0('https://pubsub.googleapis.com/v1/projects/', 
                       project_id, 
                       '/topics')
  
  tokenWorksForPubSub <-httr::GET(requestUrl)
  
  return(paste(tokenIsNull, tokenWorksForPubSub, collapse = ', '))
}

#* @get /email
#* @param scopes Comma-separated list of scopes to check with credentials_gce
#* @serializer text
function(){
  
  token <- gargle::credentials_gce()
  
  return(gargle::token_email(token))
}
