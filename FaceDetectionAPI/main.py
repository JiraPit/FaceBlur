from fastapi import FastAPI
from base64 import b64encode
from cv2 import cvtColor,imdecode,imencode,COLOR_BGR2GRAY,IMREAD_COLOR,CascadeClassifier
from PIL import Image,ImageFilter
from numpy import array,frombuffer
from requests import Session
# import uvicorn

app = FastAPI()

@app.get("/")
async def root():
    return "Hello, this is an API for face detection using FastAPI, OpenCV, and Deta"

@app.get("/detect/{url}")
async def detect(url: str):
    def blurFace(img,feature):
        pilImage = Image.fromarray(img)
        for(x,y,w,h) in feature:
            roi = pilImage.crop((x,y,x+w,y+h))
            blurred_roi = roi.filter(ImageFilter.GaussianBlur(radius=15))
            pilImage.paste(blurred_roi,(x,y,x+w,y+h))
        img = array(pilImage)
        return img
            
    def detectFace(img,faceCascade):
        grayed = cvtColor(img,COLOR_BGR2GRAY)
        feature = faceCascade.detectMultiScale(grayed,1.1,10)
        img = blurFace(img,feature);
        return img

    url = url.replace('____','/').replace('jirachayanid','http')
    session = Session()
    response = session.get(url, headers={'user-agent': 'Mozilla/5.0'})
    pic1 = array(bytearray(response.content), dtype="uint8")
    cvpic =  imdecode(pic1, IMREAD_COLOR)
    faceCascade = CascadeClassifier('haarcascade_frontalface_alt2.xml')
    detectedImage = detectFace(cvpic,faceCascade)
    buffer = imencode('.jpg',detectedImage)[1]
    new_utf8 = b64encode(buffer)
    return new_utf8

# if __name__ == "__main__":
#     uvicorn.run(app)