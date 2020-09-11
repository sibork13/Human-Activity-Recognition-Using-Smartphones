
''' Primero haremos un cambio en x_train y x_test, agregando una columna "Tipe" que
 especifique si es train o test
'''
'''
Uniremos x_test con y_test  y con subject_test , x_train con y_train y con subject_train
 '''

 '''
Cambiaremos el nombre de las columnas y_train y y_test a Activity
Cambiaremos subject_test y subject_train por Subject
'''

'''
Unimremos los dos df con merge o melt
'''
library(data.table)
xtrain<-fread("train/X_train.txt")
xtest<-fread("test/X_test.txt")
ytrain<-fread("train/y_train.txt")
ytest<-fread("test/y_test.txt")
subtrain<-fread("train/subject_train.txt")
subtest<-fread("test/subject_test.txt")

names(ytrain)<-c("Activity")
names(ytest)<-c("Activity")
names(subtrain)<-c("Volunteer")
names(subtest)<-c("Volunteer")

Tipe<-rep("train",dim(xtrain)[1])
xtrain<-cbind(xtrain,Tipe,ytrain,subtrain)
Tipe<-rep("test",dim(xtest)[1])
xtest<-cbind(xtest,Tipe,ytest,subtest)

df<-rbind(xtrain,xtest)
'''
Para hacer la segunda parte,m haremos la tercer y cuarta parte primero
'''
# Leemos ela rchivo donde especifica a que actividad representa cada numero
# aclab<-fread("activity_labels.txt")
# names(aclab)<-c("id","activity")
# library(dplyr)

# actividad<-vector()
# cont<-0
# for(i in df$Activity){
#   i<-filter(aclab,aclab$id==i)[2]
#   cont<-cont+1
#   actividad[cont]<-i
# }
# df$Activity<-actividad
