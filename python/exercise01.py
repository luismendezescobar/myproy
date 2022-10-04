#!/usr/bin/env python3

def solution(S):    
    str_upper=""
    str_lower=""
    sort_upper=[]
    
    #conviertes to cadena inicial a set 
    # (set es un tipo de datos que elimina todos los duplicados)
    #en este caso quedaria como:
    # {'B', 'A', 'D', 'b', 'c', 'a'}
    str_sorted=set(S) 
    #ordenamos la cadena. queda asi: 
    #['A', 'B', 'D', 'a', 'b', 'c']
    str_sorted=sorted(str_sorted)     
    
    #en esta parte separamos mayusculas de minusculas
    #quedaria asi:
    #str_upper=ABD
    #str_lower=ABC  (notese que convertimos a mayusculas todo)

    for element in str_sorted:
        if element.isupper():
            str_upper+=element
        else:
            str_lower+=element.upper()

    
    # usamos join para obtener la interseccion de las cadenas
    #nos quedaria res=AB    
    res = ''.join(sorted(set(str_upper) &set(str_lower), key = str_upper.index))

    if len(res)==0:
        return "NO"
    else:
        #usamos max para mandar el mas grande , en este caso B
        return max(res)




print(solution("aaBabcDaA"))
print(solution("Codility"))
print(solution("WeTestCodErs"))


