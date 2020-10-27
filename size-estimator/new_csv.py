import pandas as pd

df = pd.read_csv("new.csv")

final_df = df[['weight','age','height','size']]

final_df.to_csv("final_df.csv",index = None)