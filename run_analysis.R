#
# ''' Primero haremos un cambio en x_train y x_test, agregando una columna "Tipe" que
#  especifique si es train o test
# '''
# '''
# Uniremos x_test con y_test  y con subject_test , x_train con y_train y con subject_train
#  '''
#
#  '''
# Cambiaremos el nombre de las columnas y_train y y_test a Activity
# Cambiaremos subject_test y subject_train por Subject
# '''
#
# '''
# Unimremos los dos df con merge o melt
# '''
# Importamos librerias
library(data.table)

# Leemos todos los archivos
xtrain<-fread("train/X_train.txt")
xtest<-fread("test/X_test.txt")
ytrain<-fread("train/y_train.txt")
ytest<-fread("test/y_test.txt")
subtrain<-fread("train/subject_train.txt")
subtest<-fread("test/subject_test.txt")

# Cambiamos nombres a las columnas
names(ytrain)<-c("Activity")
names(ytest)<-c("Activity")
names(subtrain)<-c("Volunteer")
names(subtest)<-c("Volunteer")

# Creamos una columna que tenga el tipo (train or test)
Tipe<-rep("train",dim(xtrain)[1])
xtrain<-cbind(xtrain,Tipe,ytrain,subtrain)
Tipe<-rep("test",dim(xtest)[1])
xtest<-cbind(xtest,Tipe,ytest,subtest)
# Merge two dataframes
df<-rbind(xtrain,xtest)


# '''
# Para hacer la segunda parte,m haremos la tercer y cuarta parte primero
# Tercer seccion
# '''

# Read file where is the activity names
aclab<-fread("activity_labels.txt")
# Set names to easy manipulate
names(aclab)<-c("id","activity")
# Change class of Activiy column
df$Activity<-as.character(df$Activity)
# Change number to descriptive name
for(i in aclab$id){
  df$Activity<-sub(as.character(i),aclab$activity[i],df$Activity)
}
# '''
# Cuarta seccion
# Cambiamos los nombres de las 561 columnas del df con los 561 nombres en el archivo features
# '''

fea<-fread("features.txt")
names(fea)<-c("id","label")
names(df)[1:561]<-fea$label
# '''
# Seccion dos
# Nos piden tener solo las columnas que sean promedio o derivacionestnadar
# Buscaremos el numero de columna que tenga mean() o std() y haremos un select con esos indice
# '''
library(dplyr)
me<-grep("mean()",names(df))
st<-grep("std()",names(df))
finales<-c(562,563,564)
me<-append(me,finales)
st<-append(me,st)
df<-select(df,sort(st))



# '''
# Ultima seccion, seccion 5
# En esta parte nos piden obtener un dataset donde se tenga el promedio de los valores
# por cada variable,actividad y sujeto
# '''
# La funcion aggregate aplica una funcion entre un objeto r y hace un df
# con las columnas pasdas
nuevo<-aggregate(cbind(df$Volunteer,df$Activity), df,mean)
# Ordenamo el df
nuevo<-nuevo[order(nuevo$Volunteer,nuevo$Activity),]
write.table(nuevo, "nuevo.txt", row.name=FALSE)
