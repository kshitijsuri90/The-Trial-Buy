import pandas as pd

df = pd.read_csv("final_test.csv")
# df.reset_index(drop=True, inplace=True)
df = df.loc[:, ~df.columns.str.contains('^Unnamed')]

print(df)
df.to_csv("final_test.csv",index = None)