my.data <- read.delim('clipboard')

variogram <- function (x, lag ){
  Lag <- NULL
  vark <- NULL
  vario <- NULL
  for (k in 1: lag ){
    Lag[k] <- k
    vark [k] = sd( diff (x,k ))^2
    vario [k] = vark [k]/ vark [1]
  }
  return (as.data.frame( cbind (Lag , vario )))
}

variogram_production <- as.data.frame(variogram(my.data[,2], length (my.data[ ,2])/4))

ggplot(variogram_production, aes(x=Lag, y=vario))+
  geom_col()+
  labs(x = "Lag", y = "Variogram", title = "Variogram of US cheeses production")+
  theme_classic()+
  theme(plot.title = element_text(size = rel(1.5), face = "bold", hjust = 0.5),
        axis.title = element_text(size = rel(1.5)),
        legend.position = "bottom")