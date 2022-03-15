import numpy as np
from skimage import measure
import cv2

bw = cv2.imread('./finger.png',cv2.IMREAD_GRAYSCALE)
bw[bw>128]=255
bw[bw<=128]=0
labels =measure.label(bw)

labels = labels.astype(np.uint8)
labels = cv2.equalizeHist(labels)
colors = cv2.applyColorMap(labels,cv2.COLORMAP_JET)

cv2.imshow('labels',labels)
cv2.imshow('dst',colors)
cv2.waitKey()