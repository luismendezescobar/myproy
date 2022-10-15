#!/usr/bin/env python3

#this program counts the number of chimpances

class capturaDatos:
    def __init__(self,rows,cols):
        self.rows=rows
        self.cols=cols
        self.A=[]
        self.A = [[0 for j in range(cols)] for i in range(rows)]

    def captura_datos(self):                
        for r in range(self.rows):            
            ren=input()
            self.A[r]=[*ren]


class CuentaChimpance(capturaDatos):
    def busca(self):
        count=0
        for i in range(len(self.A)):
            for j in range(len(self.A[0])):
                if(self.A[i][j]=='c'):
                    count+=1

        return count




                







rows,cols=input("introduzca el numero de renglones y columnas separados por un espacio:").split()

#capturar=capturaDatos(int(rows),int(cols))
#capturar.captura_datos()

busca_chango=CuentaChimpance(int(rows),int(cols))
busca_chango.captura_datos()
print(busca_chango.busca())