#!/usr/bin/env python3
import pandas as pd
import plotly.express as px

#df_gold_prices= pd.read_csv("C:\\repos\\personal\\myproy\\python\\pandas\\monthly_csv.csv")
df_gold_prices= pd.read_csv("monthly_csv.csv")

print(df_gold_prices.tail(20))

dates=df_gold_prices['Date']
prices= df_gold_prices['Price']

#simple operations
df_gold_prices['buy_price']= prices*.9
print(df_gold_prices['Price'].min())
#print(df_gold_prices.tail(20))
df_gold_prices['Date']=df_gold_prices['Date'].str.replace('-','--')

print(df_gold_prices.tail(20))

fig=px.line(df_gold_prices,x=dates,y=prices,title='Gold Prices Over Time')
fig.show()