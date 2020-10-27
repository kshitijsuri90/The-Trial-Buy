from sklearn import datasets 
from sklearn.metrics import confusion_matrix 
from sklearn.model_selection import train_test_split 
import pandas as pd
import numpy as np
import flask
print('Libraries Imported')

app = flask.Flask(__name__)

dataset = pd.read_csv('final_test.csv')
print(dataset)

dataset = dataset[dataset['age'].notna()]
dataset = dataset[dataset['height'].notna()]
print(dataset)

X = dataset.iloc[:,:3]
y = dataset.iloc[:,3]
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state = 0) 

from sklearn.neighbors import KNeighborsClassifier 
knn = KNeighborsClassifier(n_neighbors = 7).fit(X_train, y_train) 

accuracy = knn.score(X_test, y_test) 
print(accuracy)
  
print(X_test.iloc[1,:])
# knn_predictions = knn.predict(np.array([[56,22,180]]))
# print(knn_predictions)

@app.route("/predict",methods=['GET', 'POST'])
def predict_size():
    get_params = flask.request.get_json(force=True)
    age = get_params['age']
    weight = get_params['weight']
    height = get_params['height']

    knn_predictions = knn.predict(np.array([weight,age,height]))
    prediction = knn_predictions[0]

    if(prediction == 'XXXL'):
        prediction = 'XL'
    elif(prediction == 'XXL'):
        prediction = "L"
    elif(prediction == 'XL'):
        prediction = "M-L"
    elif(prediction == "XXS"):
        prediction = 'XS'
    elif(prediction == "XS"):
        prediction = 'S'
    return prediction

if __name__ == '__main__':
    app.run(host = '127.0.0.1', port = 800)
