number_format <- function(x, i=1){
  ndate <- ""
  for(i in seq(1, nchar(as.character(x)), 3)){
    
  }
}

date_range <- function(x, y=1) {
  range <- c(as.character(x[length(x) - y]), as.character(tail(x, 1)))
  return(range)
}

daily_count <- function(x){
  x <- gsub("([0-9\\-]+) ([0-9]+):([0-9]+):([0-9]+)", "\\1 \\2:00:00", x)
  j <- 1
  fecha <- c(x[j])
  total <- c(0)
  for( i in 1: length(x)){
    if(fecha[j] != x[i]){
      fecha[j + 1] = x[i]
      j = j + 1
    }
    total[j] = if(!is.na(total[j])) total[j] + 1 else 0
  }
  return(data.frame(fecha, total))
}

timeS <- function(x, y){
  return ( xts(x, order.by = strptime(y, format='%Y-%m-%d %H')) )
}

timeSD <- function(x, y){
  return ( xts(x, order.by = strptime(as.character(y), format='%Y-%m-%d')) )
}