import pandas as pd

df = pd.read_json("renttherunway_final_data.json",lines = True)

df.to_csv(r"new.csv", header = True)