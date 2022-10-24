def solution(puntos):
    matrix=[[0]]

    first=puntos[0]
    matrix[0][0]=first
    matrix_ren=0
    matrix_col=0


    for i in range(1,len(puntos)):
        if puntos[i]>=matrix[matrix_ren][matrix_col]:
            matrix_col+=1
            matrix[matrix_ren].append(puntos[i])              
        else:            
            matrix.append([0])  #we add a new row
            matrix_ren+=1
            matrix_col=0
            matrix[matrix_ren][matrix_col]=puntos[i]
                
    final_row=[]
    for row in matrix:
        if len(row)>0:
            sum_result=row[-1]-row[0]
            final_row.append(sum_result)

    print(max(final_row))

















#puntos=[2715,3572,3840,3712,4260,3817,3954,2715]
#puntos=[5365,7012,8848,7230,5365]
#puntos=[86,35,0]
puntos=[1000,1100,1100,1200]

solution(puntos)