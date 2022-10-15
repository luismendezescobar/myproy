#!/usr/bin/env python3


def solution(raton_dict,agujeros_dict):
    raton_ordenado=sorted(raton_dict.keys())
    agujeros_dict_ordenado=sorted(agujeros_dict.keys())

    #raton_ordenado2,raton_ordenado3=set(raton_dict), set(raton_dict.values())
    #agujeros_dict_ordenado2,agujeros_dict_ordenado3=set(agujeros_dict),set(agujeros_dict.values())

    #print(raton_ordenado2)
    #print(agujeros_dict_ordenado2)
    #print(raton_ordenado3)
    #print(agujeros_dict_ordenado3)

    enumerado=enumerate(10)
    print(enumerado)



    for raton in raton_ordenado:
        print(raton_dict[raton],agujeros_dict[min(agujeros_dict_ordenado)])
        agujeros_dict_ordenado.pop(0)



total_entrada1=int(input())
raton_dict={}
for i in range(total_entrada1):
    raton_nombre,agujero=input().split()
    agujero_int=int(agujero)
    raton_dict[agujero_int]=raton_nombre

agujeros_dict={}
total_entrada2=int(input())
for i in range(total_entrada2):
    agujero_nombre,agujero_pos=input().split()
    agujero_pos_int=int(agujero_pos)
    agujeros_dict[agujero_pos_int]=agujero_nombre
    
    
solution(raton_dict,agujeros_dict)



