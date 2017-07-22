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

hours <- function(x) {
  x$start <- gsub("([0-9\\-]+) ([0-9]+):([0-9]+):([0-9]+)", "\\1 \\2:00:00", x$start)
  group <- x %>% group_by(start) %>% summarise(n())
  ceros <- rep.int(0, length(group$start))
  j <- 1
  fecha <- c(x$start[j])
  busy <- ceros
  congestion <- ceros
  failed <- ceros
  no_answer <- ceros
  
  for(i in 1:length(x$start)){
    if(fecha[j] != x$start[i]){
      fecha[j + 1] = x$start[i]
      j = j + 1
    }
    
    if( x$disposition[i] == "BUSY"){
      busy[j] = busy[j] +1
    }else if(x$disposition[i] == "CONGESTION"){
      congestion[j] = congestion[j] +1
    }else if(x$disposition[i] =="FAILED") {
      failed[j] = failed[j] +1
    }else{
      no_answer[j] = no_answer[j] +1
    }
  }
  
  return(data.frame(fecha, busy, congestion, failed, no_answer))
}

sin_exito <- function(x){
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