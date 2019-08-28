from PIL import Image
import os, sys

path = "C:/Users/aruder/Downloads/Edge-AI-Platform-Tutorials-master/docs/DPU-Integration/reference-files/sdcard/common/image500_640_480/"
dirs = os.listdir( path )

def resize():
    for item in dirs:
        if os.path.isfile(path+item):
            im = Image.open(path+item)
            f, e = os.path.splitext(path+item)
            imResize = im.resize((32,32), Image.ANTIALIAS)
            imResize.save(f + ' resized.jpg', 'JPEG', quality=90)

resize()