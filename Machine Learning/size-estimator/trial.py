import pandas as pd
import numpy as np

df = pd.read_csv("new.csv")
for i in range(len(df['size'])):
    try:
        if(df['size'].iloc[i] < 2 and df['size'].iloc[i] >= 0):
            df['size'].iloc[i] = 'XXS'
        if(df['size'].iloc[i] < 6 and df['size'].iloc[i] >= 2):
            df['size'].iloc[i] = 'S'
        if(df['size'].iloc[i] < 10 and df['size'].iloc[i] >= 6):
            df['size'].iloc[i] = 'M'
        if(df['size'].iloc[i] < 14 and df['size'].iloc[i] >= 10):
            df['size'].iloc[i] = 'L'
        if(df['size'].iloc[i] < 18 and df['size'].iloc[i] >= 14):
            df['size'].iloc[i] = 'XL'
        if(df['size'].iloc[i] < 20 and df['size'].iloc[i] >= 18):
            df['size'].iloc[i] = 'XXL'
        if(df['size'].iloc[i] >= 20):
            df['size'].iloc[i] = 'XXXL'
        
    except:
        pass
print(df)
df.to_csv("new.csv",header = True)