import pandas as pd

df = pd.read_csv("final_df.csv")

for i in range(len(df['height'])):
    try:
        new_arr = df['height'].iloc[i].split(' ')
        foot = int(new_arr[0][0])
        inches = int(new_arr[1][:len(new_arr[1])-1])
        new_h = foot*12+inches
        new_h = (new_h * 0.0254)*100
        df['height'].iloc[i] = new_h
    except:
        pass
print(df)
df.to_csv("final_test.csv",index = None)