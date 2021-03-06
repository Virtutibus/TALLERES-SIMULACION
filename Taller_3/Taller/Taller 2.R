# Ejercicio 0.1
###################################################################
##    P-valor es una variable aleatoria Uniforme[0,1]             #              
###################################################################
# Para verificar mediante simulaci�n que el p-valor tiene una     #
# distribuci�n Uniforme [0,1] bajo hip�tesis nula H0:theta=theta0#
# El escenario de simulaci�n es el siguiente:                     #
# -  Sistema de hip�tesis: Ho: mu=0   VS.    Ha: mu <> 0.          #
# -  Poblaciones con distribuci�n normal (mu,1). (mu=0, mu=2)      #
# -  Muestra aleatoria de tama�o n=20 tomada de una poblaci�n      #
#   normal.                                                       #
# -	Aplicaci�n de una prueba t, es decir el estad�stico de prueba # 
#   sigue una distribuci�n t-student con (n-1) grados de libertad.# 
# -	Se realizan nsim=10000 simulaciones                           #
#-----------------------------------------------------------------#
# Bajo la hip�tesis nula Ho: mu=0, se considera los siguientes    #
# casos:                                                          #
#-----------------------------------------------------------------#
set.seed(7654321)                                                 #
nsim<-10000                                                       #
n<-20                                                             #
#
estadistico<-function(x,mu){                                      #
  n<-length(x)                                                    #
  xbar<-mean(x)                                                   #
  s<-sqrt(var(x))                                                 #
  T<-abs((xbar-mu)/(s/sqrt(n)))                                   # 
  p<-2*(1-pt(T,n-1))                                              #
}                                                                 #
#
par(mfrow=c(1,2))                                                 #
###################### H0 mu=0  vs. H0 mu<>0 ######################                     
# Generamos nsim muestras distribuidas normalmente de tama�o n    #
# con media mu diferente a cero                                   #
#-----------------------------------------------------------------#
# CASO 1: N(mu=0,1)                                               #
# Descripci�n resultados:                                         # 
# El histograma de los p-valores toma la forma de una             #
# distribuci�n plana y uniforme sobre el intervalo [0, 1].        #
# Por tanto podemos verificar que un p-valor no es la probabilidad#
# de que Ho sea cierto, ya que al considerar una muestra de una   #
# poblaci�n normal (0,1), claramente Ho es cierta, sin embargo el #
# p-valor est� uniformemente distribuido entre cero y uno.        #
#-----------------------------------------------------------------#         
mu<-0                                                             #
X<-matrix(rnorm(n*nsim,mu,1),ncol=nsim,nrow=n)                    #
p<-apply(X,2,estadistico,mu=0)                                    #
hist(p,main=c("Caso1:mu = 0"))                                    #
#-----------------------------------------------------------------#   
# CASO 2: N(mu=0.5,1)                                             #   
#-----------------------------------------------------------------#
# Descripci�n resultados:                                         #
# El histograma de los p-valores ya no es uniforme.               #
# Puede observarse que existe m�s chance de obtener p-valores     #
# menores al nivel de significaci�n, ser� m�s alto estos valores  #
# bajo la hip�tesis alternativa que bajo la hip�tesis nula y ese  #
# efecto es m�s claro a medida que mu incrementa su valor.        #
#-----------------------------------------------------------------#
mu<-0.5                                                           #
X<-matrix(rnorm(n*nsim,mu,1),ncol=nsim,nrow=n)                    #
p<-apply(X,2,estadistico,mu=0)                                    #
hist(p,main=c("Caso2:mu = 0.5"))                                  #
#-----------------------------------------------------------------#

# Ejercicio 0.2                                                   
###################################################################
##         Gr�ficos de Potencia (Ho=1 vs Ho>1)                    #
###################################################################
potencia.n<-function(theta,n,alpha){                              #
  1-((1-alpha))/theta^n   # 1-((1- alpha))/theta^n                        #
}                                                                 #
#-----------------------------------------------------------------#
# alpha=0.05                                                      #
#-----------------------------------------------------------------#
alpha<-0.05                                                       #
# Seteamos el �rea del gr�fico                                    #  
x<-seq(1,2,0.1)                                                   #
a<-expression(pi(theta)==1-over((1-alpha),theta^n))               #
plot(potencia.n(x,alpha=0.05,n=10),type="n",ylim=c(0.05,1),       #
     xlim=c(0.8,2),ylab="Potencia",xlab="Theta",main=a,cex.main=1,#
     xaxs="i",bty="n")                                            #
# gr�ficos las diferentes curvas de potencia                      #
curve(potencia.n(x,alpha,n=10),from=1,to=2,add=T,col=1,lty=1,     #
      lwd=2)                                                      #
curve(potencia.n(x,alpha,n=20),from=1,to=2,add=T,col=2,lty=2,     #
      lwd=2)                                                      #
curve(potencia.n(x,alpha,n=50),from=1,to=2,add=T,col=3,lty=3,     #
      lwd=2)                                                      #
# 
legend("right",,paste("n",c(10,20,50),sep="="),lty=1:3,col=1:3,   #
       title="Alpha=0.05",,bty="n")                               # 
#-----------------------------------------------------------------#
# alpha=0.1                                                       #
#-----------------------------------------------------------------#
alpha<-0.1                                                        #
# Seteamos el �rea del gr�fico                                    #  
x<-seq(1,2,0.1)                                                   #
a<-expression(pi(theta)==1-over((1-alpha),theta^n))               #
plot(potencia.n(x,alpha=0.1,n=10),type="n",ylim=c(0.05,1),        #
     xlim=c(0.8,2),ylab="Potencia",xlab="Theta",main=a,cex.main=1,#
     xaxs="i",bty="n")                                            #
# gr�ficos las diferentes curvas de potencia                      #
curve(potencia.n(x,alpha,n=10),from=1,to=2,add=T,col=1,lty=1,     #
      lwd=2)                                                      #
curve(potencia.n(x,alpha,n=20),from=1,to=2,add=T,col=2,lty=2,     #
      lwd=2)                                                      #
curve(potencia.n(x,alpha,n=50),from=1,to=2,add=T,col=3,lty=3,     #
      lwd=2)                                                      #
# 
legend("right",,paste("n",c(10,20,50),sep="="),lty=1:3,col=1:3,   #
       title="Alpha=0.05",,bty="n")                               # 
#-----------------------------------------------------------------#
# n=10,20 y 50                                                            #
#-----------------------------------------------------------------#
# Seteamos el �rea del gr�fico                                    #  
x<-seq(1,2,0.1)                                                   #
a<-expression(pi(theta)==1-over((1-alpha),theta^n))               #
plot(potencia.n(x,alpha=0.1,n),type="n",ylim=c(0.05,1),           #
     xlim=c(0.8,2),ylab="Potencia",xlab="Theta",main=a,cex.main=1,#
     xaxs="i",bty="n")                                            #
# gr�ficos las diferentes curvas de potencia                      #
n=10
curve(potencia.n(x,alpha=0.05,n),from=1,to=2,add=T,col=1,lty=1,   #
      lwd=2)                                                      #
curve(potencia.n(x,alpha=0.1,n),from=1,to=2,add=T,col=2,lty=2,    #
      lwd=2)                                                      #
n<-20                                                             # 
curve(potencia.n(x,alpha=0.05,n),from=1,to=2,add=T,col=1,lty=1,   #
      lwd=2)                                                      #
curve(potencia.n(x,alpha=0.1,n),from=1,to=2,add=T,col=2,lty=2,    #
      lwd=2)                                                      #
#
n<-50                                                             # 
curve(potencia.n(x,alpha=0.05,n),from=1,to=2,add=T,col=1,lty=1,   #
      lwd=2)                                                      #
curve(potencia.n(x,alpha=0.1,n),from=1,to=2,add=T,col=2,lty=2,    #
      lwd=2)                                                      #
#
legend("right",,paste("alpha",c(0.05,0.1),sep="="),lty=1:2,col=1:2#
       ,title="Alpha=0.05",,bty="n")                              # 
#-----------------------------------------------------------------#
# Ejercicio Pr�ctico                                                   
###################################################################
##                  Comportamiento p-valor                        #
###################################################################

#d)  Prepare algunas simulaciones para estudiar el comportamiento del p-valor:
#  - Simular 1000 muestras de tama�o n (por ejemplo, n = 10, 20, 50) de 
#una Uniforme [0, theta] distribuci�n (por ejemplo, theta = 1, 1,05, 1,10).
#- Para cada muestra, realizar la prueba y calcular el correspondiente valor de p.
#- Utilizar las estad�sticas de resumen, histogramas y / o box-plot para describir 
#el comportamiento de los p-valores obtenidos. Comentar los resultados.


n<-c(10,20,50)
theta<-c(1,1.05,1.10)

n<-10
theta<-4
nsim<-10000
set.seed(7654321)
muestra<-matrix(runif(n*nsim,0,theta),ncol=nsim,nrow=n)
estadistico<-apply(muestra,2,max)
hist(estadistico)
valores<-quantile(estadistico,c(0.90,0.95,0.99));valores
evaluar<-(valores/theta)^n;evaluar
p.valor<-(estadistico/theta)^n
hist(p.valor)
boxplot(p.valor)
valores2<-quantile(p.valor,c(0.90,0.95,0.99));valores2

alpha<-c(0.90,0.95,0.99)
(1-alpha)^(1/n)

