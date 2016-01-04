setwd('~/Documents/R/avaliacao_governo/')

library(tidyr)
library(dplyr)
library(rCharts)




#ibope <- read.csv('ibope.csv', stringsAsFactors=F)


# str(ibope)

#ibope <- gather(ibope, data, valor, -TIPO)
#ibope$data <- as.character(ibope$data)
#ibope$data <- gsub("X", "", ibope$data)


#ibope$data <- as.Date(ibope$data, format="%m.%d.%y")

#ibope <- select(ibope, data, tipo_avaliacao=TIPO, valor, instituto)

#ibope$instituto <- "ibope"

#datafolha <- read.csv('avaliacao_datafolha.csv', stringsAsFactors=F)

#datafolha$data <- as.Date(datafolha$data, format="%d/%m/%y")

#datafolha$instituto <- "datafolha"



# avaliacao <- rbind(ibope, datafolha)


# avaliacao$date <- as.numeric(avaliacao$data)
# write.csv(avaliacao, 'avaliacao.csv', row.names=FALSE)

avaliacao <- read.csv('avaliacao.csv', stringsAsFactors=FALSE)

# dados_new <- NULL
# for (i in unique(avaliacao$tipo_avaliacao)) {
#  temp <- filter(avaliacao, tipo_avaliacao==i)
#  temp_reg <- loess(valor ~ date, data=temp)
#  dados_novos <- select(temp, data, tipo_avaliacao, date)
#  dados_novos <- filter(dados_novos, !is.na(date))
#  print(which(duplicated(dados_novos)))
#  dados_novos$valor <- predict(temp_reg, dados_novos)
#  dados_new <- rbind(dados_new, dados_novos)
# }

library(forecast)






str(avaliacao)

avaliacao <- arrange(avaliacao, tipo_avaliacao, data)

avaliacao <- group_by(avaliacao, tipo_avaliacao) %>%
  mutate(serie= (valor+lag(valor)+lag(lag(valor)))/3 )


avaliacao$controle_tempo <- 0

avaliacao$controle_tempo[is.na(avaliacao$serie)]  <- 1



write.csv(avaliacao, "avaliacao.csv", row.names=FALSE)
