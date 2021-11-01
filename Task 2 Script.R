#Task 2 Taller R
#Rafael Otero 201821640
#Maria Paula Alvarez 201820569
#Version de R: R version 4.1.0 (2021-05-18) ,Platform: x86_64-apple-darwin17.0 (64-bit), Running under: macOS Big Sur 11.5.2


rm(list = ls()) # limpia el entorno de R
if(!require(pacman)) install.packages(pacman)
require(pacman)
p_load(dplyr,data.table)
print

#Pregunta 1
library("tidyverse")
install.packages("fs")
library("fs")
p_load(rio,skimr,tidyverse,readxl,haven,WriteXLS)

patterns=list() # Genero una lista llamada patterns
for (x in c("2017/","2018/","2019/","2020/")) {
  patterns[x] = as.data.frame(list.files(paste0("task_2 /data/input/",x),full.names = T))
} #Pego todos los patterns de los archivos en una lista
patterns = patterns %>% unlist() # vuelvo la lista patterns en vector de valores para poder meterlos en el siguiente vector

chip=list() # Genero una lista llamada chip

for (i in 1:length(patterns)){
  chip[[i]]<-read_excel(patterns[i])
} # Utilizo el loop for para importar las bases de datos de las carpetas 2017,2018,2019,2020

#Pregunta 2
Extractor=function(i){{ #Genero funcion Extractor
  P=chip[[i]][9,8] #Referencia de dato de pagos para categoria de Educacion
    pagos=paste("pagos =",P)
}
  {N=colnames(chip[[i]])[1]#Referencia de dato del codigo y nombre del municipio
    nombrecodigo=paste("codigo y nombre de municipio =",N)
  }
  
  {PI=chip[[i]][2,1]#Referencia de dato del periodo de la informacion
    periodo=paste("periodo de informacion =",PI)
  }
lapply(c(pagos,periodo,nombrecodigo), print)
}    
   
Extractor(i=4)#Ejemplo para base de datos 4 de chip
Extractor(i=36)#Ejemplo para base de datos 36 de chip
Extractor(i=78)#Ejemplo para base de datos 78 de chip

#En este caso si quisieramos extraer la informacion sobre el pago de otra variable tocaria cambiar el la fila en el primer argumento de la funcion

#Pregunta 3
chip_valores=c(1:length(chip))# Genero un vector con la longitud de la lista
data = lapply(chip_valores,function(i) Extractor(i))#aplico lapply para generar lista con la informacion de la funcion Extraer para todos los elementos de la lista

