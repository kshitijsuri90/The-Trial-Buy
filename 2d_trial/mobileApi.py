from flask import Flask
from flask import json
from flask import request
from flask import Response
import json
import base64
import cv2
import numpy as np
import pickle
import hashlib
import mysql.connector
import subprocess
from source.user import userPreprocess
from source.fit import userFit
from source.lower import lowerFit
import os, shutil

app = Flask(__name__)

def removeDir(userId):
    folder = '../users/' + userId + '/'
    for the_file in os.listdir(folder):
        file_path = os.path.join(folder, the_file)
        try:
            if os.path.isfile(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path): shutil.rmtree(file_path)
        except Exception, e:
            print e

@app.route("/authenticate",methods=['POST'])
def auth():
    keyDict = request.get_json()
    keys = pickle.load(open('keys.p','rb'))
    key = str(keyDict['key'])
    if key in keys:
        keys.remove(key)
        pickle.dump(keys,open('keys.p','wb'))
        string = "OK"
    else:
        string = "error"
    result = {}
    result['status'] = string
    resp = Response(json.dumps(result),status=200, mimetype='application/json')
    return resp

@app.route("/login", methods=['POST'])
def login():
    #cnx = mysql.connector.connect(user='root', password='marood7t',host='127.0.0.1',database='marooner')
    keyDict = request.get_json()
    #userId = keyDict['userId']
    #cursor = cnx.cursor()
    #query = "SELECT * FROM Users WHERE FbId="+userId+";"
    #userId = userId.encode('ascii','ignore')
    cursor.execute(query)
    data = cursor.fetchone()
    if data is None:
        hashObject = hashlib.sha224(userId)
        hashedString = hashObject.hexdigest()
        cursor = cnx.cursor()
        addUser = "INSERT INTO Users VALUES(%s,%s,%s);"
        cursor.execute(addUser,(keyDict['userName'],userId,hashedString))
        subprocess.call(['mkdir','../users/' + hashedString])
        subprocess.call(['mkdir','../users/' + hashedString +'/debug'])
        cnx.commit()
        cursor.close()
        cnx.close()
        resp = Response(status=200, mimetype='application/json')
        return resp
    else:
        cursor.close()
        cnx.close()
        resp = Response(status=200, mimetype='application/json')
        return resp
    

@app.route("/imageUpload" , methods=['POST'])
def imageUpload():
    keyDict = request.get_json()
    #userId = hashlib.sha224(keyDict['userId']).hexdigest() 
    img = keyDict['image']
    #removeDir(userId)
    with open('../users/' + '/userImg.png','wb') as imgfile:
        imgfile.write(base64.b64decode(img))
    subprocess.call(['mkdir','../users/' + '/debug'])
    resp = Response(status=200, mimetype='application/json')
    return resp

@app.route("/setMask", methods=['POST'])
def setMask():
    keyDict = request.get_json()
    bgdmodel = np.zeros((1,65),np.float64)
    fgdmodel = np.zeros((1,65),np.float64) 
    #userId = hashlib.sha224(keyDict['userId']).hexdigest() 
    userImg = cv2.imread('../users/' + '/userImg.png')
    upperOrLower = keyDict['flag']
    if 'topX' in keyDict.keys():
        topX = int(keyDict['topX'])
        topY = int(keyDict['topY'])
        width = int(keyDict['width'])
        height = int(keyDict['height'])
        rect = (topX,topY,width,height)
        mask = np.zeros(userImg.shape[:2],dtype = np.uint8)
        cv2.grabCut(userImg,mask,rect,bgdmodel,fgdmodel,10,cv2.GC_INIT_WITH_RECT)
        np.save('../users/' + '/mask' + upperOrLower,mask)
        pickle.dump(rect,open('../users/' + '/userRect' + upperOrLower + '.p','wb'))
    else:
        rect = pickle.load(open('../users/' + '/userRect' + upperOrLower + '.p','rb'))
        topX, topY, width, height = rect
        mask = np.load('../users/' + '/mask' + upperOrLower + '.npy')
        
    
    fgPoints = []
    bgPoints = []
    for item in keyDict['foreground']:
        fgPoints.append((int(item['x']),int(item['y'])))

    for item in keyDict['background']:
        bgPoints.append((int(item['x']),int(item['y'])))
    
    for item in fgPoints:
        if topX < item[0] and item[0] < topX + width and topY < item[1] and item[1] < topY + height:
            cv2.circle(mask,(item[0],item[1]),3,1,-1)

    for item in bgPoints:
        if topX < item[0] and item[0] < topX + width and topY < item[1] and item[1] < topY + height:
            cv2.circle(mask,(item[0],item[1]),3,0,-1)

    cv2.grabCut(userImg,mask,rect,bgdmodel,fgdmodel,10,cv2.GC_INIT_WITH_MASK)
    mask2 = np.where((mask==2)|(mask==0),0,1).astype('uint8')
    output = userImg*mask2[:,:,np.newaxis]
    cv2.imwrite('../users/' +  '/grabcutOutput' + upperOrLower+ '.png',output)
    np.save('../users/' + '/mask' + upperOrLower,mask)
    encodeImg = base64.b64encode(open('../users/' +'/grabcutOutput' + upperOrLower + '.png').read())
    result = {}
    result['img'] = encodeImg
    result['status'] = 'OK'
    resp = Response(json.dumps(result),status=200, mimetype='application/json')
    return resp

@app.route('/upProcess',methods=['POST'])
def preprocess():
    keyDict = request.get_json()
    #userId = hashlib.sha224(keyDict['userId']).hexdigest()
    grabcutOutput = cv2.imread('../users/' +'/grabcutOutputupper.png') 
    processInst = userPreprocess(grabcutOutput)
    processInst.cropImg()
    processOut = processInst.removeTurds()
    cv2.imwrite('../users/' + '/processOutupper.png',processOut)
    processInst.segImage(processOut)
    LU, RU = processInst.getSegLines()
    leftArmUser = processInst.armSegment(processOut,'left')
    cv2.imwrite('../users/' + '/leftArmUser.png',leftArmUser)
    rightArmUser = processInst.armSegment(processOut,'right')
    cv2.imwrite('../users/' + '/rightArmUser.png',rightArmUser)
    segLines = (LU,RU)
    pickle.dump(segLines,open('../users/' + '/segLines.p','wb'))
    pickle.dump(processInst.returnUserBox(),open('../users/' + '/userBox.p','wb'))
    resp = Response(status=200, mimetype='application/json')
    return resp

@app.route('/fitUp',methods=['POST'])
def fit():
    keyDict = request.get_json()
    #userId = hashlib.sha224(keyDict['userId']).hexdigest()
    #catId = keyDict['catId']
    processOut = cv2.imread('../users/' + '/processOutupper.png')
    if processOut is None:
        result = {}
        result['status'] = 'Upload your image first'
        resp = Response(json.dumps(result),status=200, mimetype='application/json')
        return resp
    cropFlood = cv2.imread('/cropFloodOut.png')
    LU,RU = pickle.load(open('../users/' + '/segLines.p'))
    LC,RC = pickle.load(open('/segLines.p'))
    leftArmUser = cv2.imread('../users/'  + '/leftArmUser.png')
    rightArmUser = cv2.imread('../users/' + '/rightArmUser.png')
    leftArmCat = cv2.imread('/leftArmCat.png')
    rightArmCat = cv2.imread('/rightArmCat.png')
    userBox = pickle.load(open('../users/' + '/userBox.p'))
    fitInst = userFit(processOut,cropFlood)
    fitInst.setSegLines(LC,RC,LU,RU)
    colorUserOut = fitInst.colorUser()
    cv2.imwrite('../users/' + '/debug/colorUserOut.png',colorUserOut)
    fitInst.setUserArm(leftArmUser,rightArmUser)
    fitInst.setCatArm(leftArmCat,rightArmCat)
    fitLeft, fitRight = fitInst.sleeveFit()
    cv2.imwrite('../users/' + '/debug/fitLeft.png',fitLeft)
    cv2.imwrite('../users/' + '/debug/fitRight.png',fitRight)
    bodyFitOut = fitInst.bodyFit(colorUserOut)
    cv2.imwrite('../users/' + '/debug/bodyFitOut.png',bodyFitOut)
    finalFit = fitInst.finalFit(bodyFitOut,fitLeft,fitRight)
    cv2.imwrite('../users/'  + '/debug/finalFit.png',finalFit)
    fitInst.setUserBox(userBox)
    userImg = cv2.imread('../users/' + '/userImg.png')
    output = fitInst.fittingOntoUser(finalFit,userImg)
    cv2.imwrite('../users/' + '/fittingOntoUser.jpg',output)
    encodeImg = base64.b64encode(open('../users/' +'/fittingOntoUser.jpg').read())
    result = {}
    result['img'] = encodeImg
    resp = Response(json.dumps(result),status=200, mimetype='application/json')
    return resp

@app.route('/lowProcess',methods=['POST'])
def lowProcess():
    keyDict = request.get_json()
    #userId = hashlib.sha224(keyDict['userId']).hexdigest()
    grabcutOutput = cv2.imread('../users/' +'/grabcutOutputlower.png') 
    processInst = userPreprocess(grabcutOutput)
    processInst.cropImg()
    processOut = processInst.removeTurds()
    cv2.imwrite('../users/' + '/processOutLower.png',processOut)
    pickle.dump(processInst.returnUserBox(),open('../users/' + '/userLowBox.p','wb'))
    resp = Response(status=200, mimetype='application/json')
    return resp

@app.route('/fitLow',methods=['POST'])
def lowFit():
    keyDict = request.get_json()
    #userId = hashlib.sha224(keyDict['userId']).hexdigest()
    catId = keyDict['catId']
    processOut = cv2.imread('../users/' + '/processOutLower.png')
    if processOut is None:
        result = {}
        result['status'] = 'User lowers not extracted'
        resp = Response(json.dumps(result),status=200, mimetype='application/json')
        return resp
    cropFlood = cv2.imread('../catalogue/lower/image' + catId + '/cropFlood.png')
    lowInst = lowerFit(processOut,cropFlood)
    lowInst.calcLowerLine()
    lowInst.resizeCat()
    finalOut = lowInst.fit()
    fitInst = userFit(processOut,cropFlood)
    userBox = pickle.load(open('../users/' + '/userLowBox.p'))
    fitInst.setUserBox(userBox)
    userImg = cv2.imread('../users/' + '/userImg.png')
    output = fitInst.fittingOntoUser(finalOut,userImg)
    cv2.imwrite('../users/' + '/fittingOntoUser.jpg',output)
    encodeImg = base64.b64encode(open('../users/' +'/fittingOntoUser.jpg').read())
    result = {}
    result['img'] = encodeImg
    resp = Response(json.dumps(result),status=200, mimetype='application/json')
    return resp

if __name__ == "__main__":
    app.run(host='192.168.43.120',port=8000,debug=True,threaded=True)
