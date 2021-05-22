
if(Sys.getenv('PORT') == '') Sys.setenv(PORT = 8000)

#' @apiTitle Testing Gargle on GCP
#' @apiDescription Testing Gargle on GCP
 
#* @get /scopes
#* @param scopes Comma-separated list of scopes to check with credentials_gce
#* @serializer text
function(scopes){
  
  scopes <- strsplit(scopes, ',')[[1]]

  token <- gargle::credentials_gce(scopes = scopes)
  
  return(is.null(token))
}

#* @get /email
#* @param scopes Comma-separated list of scopes to check with credentials_gce
#* @serializer text
function(){
  
  token <- gargle::credentials_gce()
  
  return(gargle::token_email(token))
}

#* @get /instancescopes
#* @serializer text
function(){
  
  token <- gargle::credentials_gce()
  
  scopes <- gargle:::get_instance_scopes(gargle::token_email(token))
  
  return(paste(result, collapse = ', '))
}
