FROM rocker/tidyverse

RUN install2.r gargle plumber

COPY [".", "./"]

ENTRYPOINT ["Rscript", "-e", "pr <- plumber::plumb(rev(commandArgs())[[1]]); pr$run(host='0.0.0.0', port=as.numeric(Sys.getenv('PORT')))"]

CMD ["Plumber.R"]