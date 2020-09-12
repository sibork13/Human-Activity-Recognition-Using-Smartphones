
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
# Unimos los dos df
df<-rbind(xtrain,xtest)


# Lee archivo donde estan los nombres 
aclab<-fread("activity_labels.txt")
# Ponemos nombres para que sea facil de manipualr
names(aclab)<-c("id","activity")
# Cambia la clase de  la columna
df$Activity<-as.character(df$Activity)
# Cambia el valor
for(i in aclab$id){
  df$Activity<-sub(as.character(i),aclab$activity[i],df$Activity)
}


fea<-fread("features.txt")
names(fea)<-c("id","label")
names(df)[1:561]<-fea$label

library(dplyr)
me<-grep("mean()",names(df))
st<-grep("std()",names(df))
finales<-c(562,563,564)
me<-append(me,finales)
st<-append(me,st)
df<-select(df,sort(st))


# Agrupa por voluntario y actividad
tidy <- df %>% 
  group_by(Volunteer, Activity) %>%
  summarise_each(funs(mean))

# Crea el archivo "tidy_data.txt"
write.table(tidy, "tidy_df.txt", row.names = FALSE, 
            quote = FALSE)
