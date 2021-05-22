credentials_gce <- function(scopes = "https://www.googleapis.com/auth/cloud-platform",
                            service_account = "default", ...) {
  
  print('Using OLD credentials_gce function.')
  
  gargle:::gargle_debug("trying {.fun credentials_gce}")
  if (!gargle:::detect_gce() || is.null(scopes)) {
    return(NULL)
  }
  instance_scopes <- gargle:::get_instance_scopes(service_account = service_account)
  # We add a special case for the cloud-platform -> bigquery scope implication.
  if ("https://www.googleapis.com/auth/cloud-platform" %in% instance_scopes) {
    instance_scopes <- c(
      "https://www.googleapis.com/auth/bigquery",
      instance_scopes
    )
  }
  if (!all(scopes %in% instance_scopes)) {
    return(NULL)
  }
  
  gce_token <- gargle:::fetch_access_token(scopes, service_account = service_account)
  
  params <- list(
    as_header = TRUE,
    scope = scopes,
    service_account = service_account
  )
  token <- gargle:::GceToken$new(
    credentials = gce_token$access_token,
    params = params,
    # The underlying Token2 class appears to *require* an endpoint and an app,
    # though it doesn't use them for anything in this case.
    endpoint = httr::oauth_endpoints("google"),
    app = httr::oauth_app("google", key = "KEY", secret = "SECRET")
  )
  token$refresh()
  if (is.null(token$credentials$access_token) ||
      !nzchar(token$credentials$access_token)) {
    NULL
  } else {
    token
  }
}

credentials_gce2 <- function(scopes = "https://www.googleapis.com/auth/cloud-platform",
                             service_account = "default", ...) {
  
  print('Using UPDATED credentials_gce function.')
  
  gargle:::gargle_debug("trying {.fun credentials_gce}")
  if (!gargle:::detect_gce() || is.null(scopes)) {
    return(NULL)
  }
  instance_scopes <- gargle:::get_instance_scopes(service_account = service_account)
  # We add a special case for the cloud-platform -> bigquery scope implication.
  if ("https://www.googleapis.com/auth/cloud-platform" %in% instance_scopes) {
    instance_scopes <- c(
      "https://www.googleapis.com/auth/bigquery",
      instance_scopes
    )
  }
  if (!all(scopes %in% instance_scopes)) {
    ###########    return(NULL)
  }
  
  gce_token <- gargle:::fetch_access_token(scopes, service_account = service_account)
  
  params <- list(
    as_header = TRUE,
    scope = scopes,
    service_account = service_account
  )
  token <- gargle:::GceToken$new(
    credentials = gce_token$access_token,
    params = params,
    # The underlying Token2 class appears to *require* an endpoint and an app,
    # though it doesn't use them for anything in this case.
    endpoint = httr::oauth_endpoints("google"),
    app = httr::oauth_app("google", key = "KEY", secret = "SECRET")
  )
  token$refresh()
  if (is.null(token$credentials$access_token) ||
      !nzchar(token$credentials$access_token)) {
    NULL
  } else {
    token
  }
}