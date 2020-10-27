import pandas as pd

df = pd.read_csv("new.csv")

df.dropna(subset = ["height"])
df = df[df['weight'].notna()]
df.dropna(subset = ["age"])

df.dropna(subset = ["size"])

print(df)
df.to_csv("new.csv",index = None)
