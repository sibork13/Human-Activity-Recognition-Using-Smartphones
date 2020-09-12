# Human Activity Recognition Using Smartphones

## Proyecto del curso para obtener y limpiar datos de coursera

Para este proyecto, necesitavamos hacer 5 pasos

  1. Combinar los datos de test y de train para crear un nuevo dataset
  2. Extrae solo las medidas de la media y la desviación estándar de cada medida.
  3. Utiliza nombres de actividades descriptivos para nombrar las actividades en el conjunto de datos.
  4. Etiquete adecuadamente el conjunto de datos con nombres de variables descriptivos.
  5. A partir del conjunto de datos del paso 4, crea un segundo conjunto de datos ordenado e independiente con el promedio de cada variable para cada actividad y cada tema.
  
   Para resolver el problema, debo hacer en desorden estos pasos

Primer paso, fusionar conjuntos de entrenamiento y prueba

En el script primero leo todos los archivos necesarios
Luego, configure los nombres para el marco de datos y_train, y_test, subject_train y prueba del sujeto
Finalmente, tomo todos los DF y los configuro en uno con la función cbind

Tercera parte, use etiquetas descriptivas para las actividades

En esta parte, leeré "activity_labels"
Luego, configure los nombres de las columnas para manipularlos más fácilmente
Arfther eso, convierta la clase entera en carácter
Finalmente, usé la función sub () para cambiar "carácter numérico" en una cadena almacenada en activity_labels "


Cuarta parte, establecer etiquetas de variables descriptivas

Hasta este punto, utilicé el archivo "feautres" para conocer todos los nombres de las etiquetas.
tomé las columnas para poner el nombre

Segunda parte, extraiga solo datos de desviación estándar y promedio

Para esta sección, ised dplyr library para usar la función select ()
con grep () obtuve todos los índices de columnas donde era mean o std en el nombre de la etiqueta
y seleccione estas columnas


Quinta sección, crear un nuevo DF con la media del voluntariado y la actividad
Para hacer esto, usé la funcion group_by() que me permite crear grupos de un df y asi
poder realizar el calculo del promedio
