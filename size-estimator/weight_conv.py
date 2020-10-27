import pandas as pd

df = pd.read_csv('final_df.csv')

for i in range(len(df['weight'])):
    df['weight'].iloc[i]=int(df['weight'].iloc[i][:len(df['weight'].iloc[i])-3])//2.205
print(df)
df.to_csv("final_df.csv")