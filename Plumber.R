
if(Sys.getenv('PORT') == '') Sys.setenv(PORT = 8000)

#' @apiTitle Testing Gargle on GCP
#' @apiDescription Testing Gargle on GCP
 

#* @get /pubsub
#* @serializer text
function(){
  
  scopes <- 'https://www.googleapis.com/auth/pubsub'
  
  token <- gargle::credentials_gce(scopes = scopes)
  
  return(is.null(token))
}


#* @get /cloud
#* @serializer text
function(){
  
  scopes <- 'https://www.googleapis.com/auth/cloud-platform'
  
  token <- gargle::credentials_gce(scopes = scopes)
  
  return(is.null(token))
}