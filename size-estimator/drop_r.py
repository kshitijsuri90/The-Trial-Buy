import pandas as pd

df = pd.read_csv("new.csv")

df = df[df.fit == 'fit']

df.to_csv("new.csv", index = None)