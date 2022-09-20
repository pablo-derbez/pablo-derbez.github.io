//Autor:Pablo Derbez
//Fecha: 20 de septiembre de 2022
//Fecha de última modificación: 20 de septiembre de 2022


clear all
set more off


set obs 13514 //Número de días desde 19 de septiembre de 2022

gen date = _n-1 + 9393 //Fecha en formato stata; 0 es 1 de enero de 1960. 9,393 son los días de diferencia entre 1 de enero de 1960 y 19 de septiembre de 2022

format date %td //Formato de fecha


local iterations=5000 //Número de iteraciones de la simualción

expand `iterations' //Copiamos nuestras observaciones la cantidad de veces deseada

sort date //Ordenamos por fecha (importante para el siguiente paso)

gen trial = mod(_n-1,`iterations')+1 //Asignamos una iteración a cada copia de la fecha

local p=86/44821 //Establecemos la probabilidad de sismo


set seed 616472870 // Seed de random.org

gen sismo=rbinomial(1,`p') //Generamos una variable que es igual a 1 con probabilidad p


gen dofy=doy(date) //Obtenemos el día del año




bysort trial dofy: egen repeats = total(sismo) //Para cada día del año e iteración, contamos cuántos "sismos hubieron"

collapse (max) repeat, by(trial) //Nos quedamos con el máximo número de repeticiones para cada iteración

tab repeat //Resúmen de los resultados


