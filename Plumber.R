
if(Sys.getenv('PORT') == '') Sys.setenv(PORT = 8000)

#' @apiTitle Testing Gargle on GCP
#' @apiDescription Testing Gargle on GCP

#* @get /scopes
#* @param scopes Comma-separated list of scopes to check with credentials_gce
#* @serializer text
function(scopes = 'https://www.googleapis.com/auth/cloud-platform'){
  
  base_url = 'https://pubsub.googleapis.com/'
  endpoint_url = 'v1/projects/r-scripts-273722/topics'
  
  scopes <- strsplit(scopes, ',')[[1]]
  
  token <- gargle::credentials_gce(scopes = scopes)
  
  nonNullToken <- !is.null(token)
  
  project_id <- rawToChar(httr::content(gargle:::gce_metadata_request('project/project-id')))
  
  request <- gargle::request_build(method = 'GET', 
                                   base_url = base_url, 
                                   path = endpoint_url, 
                                   token = httr::config(token = token))
  
  response <- gargle::request_make(request)
  
  print(response)
  
  tokenWorks <- response$status_code < 300
 
  return(paste(nonNullToken, tokenWorks, collapse = ', '))
}


#* @get /scopes2
#* @param scopes Comma-separated list of scopes to check with credentials_gce
#* @serializer text
function(scopes){
  
  source('credentials_gce2.R')
  
  assignInNamespace('credentials_gce', credentials_gce2, ns = 'gargle')
  
  scopes <- strsplit(scopes, ',')[[1]]
  
  token <- gargle::credentials_gce(scopes = scopes)
  
  nonNullToken <- !is.null(token)
  
  project_id <- rawToChar(httr::content(gargle:::gce_metadata_request('project/project-id')))
  
  request <- gargle::request_build(method = 'GET', base_url = 'https://pubsub.googleapis.com/', 
                                   path = paste0('v1/projects/', project_id, '/topics'), 
                                   token = httr::config(token = token))
  
  response <- gargle::request_make(request)
  print(response)
  
  tokenWorksForPubSub <- response$status_code < 300
  
  return(paste(nonNullToken, tokenWorksForPubSub, collapse = ', '))
}

#* @get /email
#* @serializer text
function(){
  
  token <- gargle::credentials_gce()
  
  return(gargle::token_email(token))
}


#* @get /instancescopes
#* @serializer text
function(){
  
  token <- gargle::credentials_gce()
  
  email <- gargle::token_email(token)
  
  instance_scopes <- gargle:::get_instance_scopes(email)
  
  return(paste(instance_scopes, collapse = ', '))
}
