
class solution:
    def __init__(self,S,sp,T):
        self.S=S
        self.sp=sp
        self.T=T

    def calculus(self):
        #myarray=[0 for i in range(T)]
        tiempo_accum=-1
        tiempo_accum+=self.S+self.sp
        if tiempo_accum >= self.T:
            print("saltito.gif")
            return

        while(1):
            tiempo_accum+=self.S
            if tiempo_accum >= self.T:
                print("SALTOTE.gif")
                return
            
            tiempo_accum+=self.sp

            if tiempo_accum >= self.T:
                print("saltito.gif")
                return



myranita=solution(5,1,7)
myranita=solution(5,1,11)
myranita=solution(3,8,30)
myranita=solution(3,8,12)

myranita.calculus()