import picamera
from time import sleep
import datetime
import numpy as np
import cv2

dest = "images/"
image_width = 320
image_height = 240
zzzz = 2
rows = 30
history = []
save_all_images = False # save image sequence

orientation_threshold = 33.33333
movement_threshold = 1.4

text_padding = 10
text_size = 0.5
text_font = cv2.FONT_HERSHEY_SIMPLEX
text_color = (255, 255, 255)
text_weight = 1
text_smooth = cv2.CV_AA

camera = picamera.PiCamera()
camera.resolution = (image_width,image_height)
camera.start_preview()

sleep(3)

# record the initial environment state
print "RASPBERRY EYE\nMotion Detective Extrodinaire!\n\n"

data = np.empty((image_width * image_height * 3), dtype=np.uint8)
camera.capture(data, 'bgr')
initial_image = data.reshape((image_height, image_width, 3)) 
previous_image = initial_image
history.append(np.sum(initial_image))

print "Appending initial capture"
print "Orientation starting:"
orientation = True


while True:
    ts = datetime.datetime.now()
    date = datetime.datetime.strftime(ts, "%Y%m%d")
    time = datetime.datetime.strftime(ts, "%H%M%S")
    now = "%s-%s" % (date, time)

    filename = "%s%s%s.jpg" % (dest, "test", now)

    # capture next image in memory
    data = np.empty((image_width * image_height * 3), dtype=np.uint8)
    camera.capture(data, 'bgr')
    img1 = data.reshape((image_height, image_width, 3)) 
    img2 = previous_image

    # diff the images and record the delta
    diff = cv2.subtract(img1, img2)
    diff_sum = np.sum(diff)

    img_max = np.amax(history)
    img_min = np.amin(history)
    img_ave = np.mean(history)
    img_sum = np.sum(img1)
    ratio = (diff_sum / img_ave) * 100.0

    # write the images to disk
    if save_all_images: cv2.imwrite("%s%s.jpg" % (dest, now), diff)

    cv2.putText(img1, now, (text_padding, image_height - text_padding),
            text_font, text_size, text_color, text_weight, text_smooth)
    cv2.imwrite("%scurrent.jpg" % dest, img1)
    cv2.imwrite("%sdifference.jpg" % dest, diff)
    cv2.imwrite("%saverage.jpg" % dest, np.mean(np.array([img1, img2]), axis=0))

    if orientation:
        history.append(img_sum)
        orientation = len(history) < rows
        print "(%02s) %017s" % (len(history), img_sum)
        if not orientation:
            print "Orientation complete.\n\n"
            print "Monitoring image deltas"
        continue

    if ratio > orientation_threshold:
        # camer re-orientation
        # drop the history and recapture
        print "Scene change detected. Re-orientation required (%s)" % ratio
        del history[:]
        history.append(img_sum)
        orientation = True
        continue

    if ratio < movement_threshold: 
        # only add inanimate images we want to build the mean value
        history.append(img_sum)
        zzzz = 2
    else:
        # report the movement, and delay the next capture
        print "(%02s) %05s %012s %020s" % (len(history), round(ratio,1), int(img_ave), now)
        zzzz = 10

    previous_image = img1
    history = history[-rows:]
    sleep(zzzz)
