#!/bin/sh
# Purpose: Velocity ellipses in (N,E) and rotated conventions. Rotational wedges: PSB margins
# Area: Philippine Sea Basin
# Behrman cylindrical projection. GMT modules: gmtset, gmtdefaults, makecpt, grdcut, grdinfo, pscoast, psbasemap, grdcontour, project, psxy, pslegend, pstext, logo, psconvert
# Generate a file
# Extract a subset of GEBCO for the study area
gmt grdcut GEBCO_2019.nc -R120/152/4/35 -Gpsb_relief.nc
ps=Geol_PSB_velo.ps
# GMT set up
gmt set FORMAT_GEO_MAP=dddF \
    MAP_FRAME_PEN dimgray \
    MAP_FRAME_WIDTH 0.1c \
    MAP_TITLE_OFFSET 1.5c \
    MAP_ANNOT_OFFSET 0.1c \
    MAP_TICK_PEN_PRIMARY thinner,dimgray \
    MAP_GRID_PEN_PRIMARY thinner,blue \
    MAP_GRID_PEN_SECONDARY thinnest,blue \
    FONT_TITLE 12p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY 8p,Helvetica,dimgray \
    FONT_LABEL 8p,Helvetica,dimgray
# Overwrite defaults of GMT
gmtdefaults -D > .gmtdefaults
# Make raster image
gmt grdimage psb_relief.nc -Cetopo1.cpt -R120/152/4/35 -JY16c -P -I+a15+ne0.75 -Xc -K > $ps
# Add elemens of basemap: title, grids, rose, scale, time stamp
gmt psbasemap -R120/152/4/35 -JM16c \
    -B+t"Velocity ellipses in (N,E) and rotated conventions. Rotational wedges: PSB margins" \
    -Bpxg8f2a4 -Bpyg6f3a3 -Bsxg4 -Bsyg3 \
    -Lx13.0c/-1.0c+c50+w500k+l"Behrman cylindrical projection. Scale (km)"+f \
    -UBL/-0.2c/-1.0c -K > $ps
# Add bathymetric contours
gmt grdcontour psb_relief.nc -R -J -C2000 -W0.1p -O -K >> $ps
# tectonic plates
gmt psxy -R -J TP_Philippine_Sea.txt -L -W3p,red -O -K >> $ps
gmt psxy -R -J TP_Pacific.txt -L -W3p,red -O -K >> $ps
gmt psxy -R -J TP_Eurasian.txt -L -W3p,red -O -K >> $ps
gmt psxy -R -J trench.gmt -Sf1.5c/0.2c+l+t -Wthick,blue -Gblue -O -K >> $ps
# Velocity ellipses in (N,E) convention
gmt psvelo CMT.txt -R -J -W0.3p,green -L -Ggreen -Se0.1/0.95/5 \
    -A0.2p -O -K >> $ps
# Velocity ellipses in rotated convention
gmt psvelo CMT.txt -R -J -W0.3p,red -Sr0.1/0.95/5 \
    -Ggreen -A0.2p -O -K >> $ps
# Rotational wedges
gmt psvelo CMT.txt -R -J -W0.05p -L -Sw0.5/1.e7 -D2 \
    -Gslateblue2 -Elightgray -A0.2p -O -K >> $ps
# Step-7. Add color legend
gmt psscale -Dg114.0/4+w17.0c/0.4c+v+o0.3/0i+ml -Rpsb_relief.nc -J -Cetopo1.cpt \
    --FONT_LABEL=8p,Helvetica,dimgray \
    --FONT_ANNOT_PRIMARY=6p,Helvetica,black \
    -Baf+l"Topographic color palette: ETOPO1 global relief map [R=-11000/8500, H=0, C=RGB]" \
    -I0.2 -By+lm -O -K >> $ps
# texts
gmt pstext -R -J -N -O -K \
-F+f13p,Helvetica−Bold,deeppink4+jLB -Gwhite@30 >> $ps << EOF
145.0 30.8 PACIFIC PLATE
128.0 20.0 PHILIPPINE SEA PLATE
122.0 31.1 EURASIAN PLATE
135.0 4.1 CAROLINE PLATE
EOF
gmt pstext -R -J -N -O -K \
-F+f11p,Times-Roman,darkblue+jLB -Gwhite@30 >> $ps << EOF
123.5 30.0 EAST
123.5 29.3 CHINA
123.5 28.5 SEA
EOF
gmt pstext -R -J -N -O -K \
-F+f8p,Palatino-Roman,black+jLB -Gwhite@20 >> $ps << EOF
130 32.5 KYUSHU
EOF
gmt pstext -R -J -N -O -K \
-F+f12p,Helvetica−Bold,white+jLB+a-262 >> $ps << EOF
144.2 27.5 I z u - B o n i n
EOF
gmt pstext -R -J -N -O -K \
-F+f12p,Helvetica−Bold,white+jLB+a-265 >> $ps << EOF
145.0 27.5 T r e n c h
EOF
gmt pstext -R -J -N -O -K \
-F+f10p,Times−Bold,blue+jLB -Gwhite@40 >> $ps << EOF
142.3 34.0 Boso Triple Junction
EOF
gmt pstext -R -J -N -O -K \
-F+f10p,Times−Bold,blue+jLB+a-300 -Gwhite@40 >> $ps << EOF
131.8 28.5 Nankai
EOF
gmt pstext -R -J -N -O -K \
    -F+f10p,Times−Bold,blue+jLB+a-317 -Gwhite@40 >> $ps << EOF
133.2 30.7 Trough
EOF
gmt pstext -R -J -N -O -K \
    -F+f10p,Times−Bold,blue+jLB+a-340 -Gwhite@40 >> $ps << EOF
135 32.0 Suruga
EOF
gmt pstext -R -J -N -O -K \
-F+f10p,Times−Bold,blue+jLB+a-325 -Gwhite@40 >> $ps << EOF
137.2 32.8 Trough
EOF
gmt pstext -R -J -N -O -K \
-F+f10p,Times−Bold,blue+jLB+a-20 -Gwhite@40 >> $ps << EOF
139.7 34.3 Sagami
139.7 33.8 Trough
EOF
gmt pstext -R -J -N -O -K \
-F+f10p,Times−Bold,blue+jLB+a-80 -Gwhite@40 >> $ps << EOF
141.8 28.7 Bonin Ridge
EOF
gmt pstext -R -J -N -O -K \
-F+f12p,Helvetica−Bold,white+jLB+a-66 >> $ps << EOF
125.6 15 Philippine
EOF
gmt pstext -R -J -N -O -K \
-F+f12p,Helvetica−Bold,white+jLB+a-77 >> $ps << EOF
127.5 11 Trench
EOF
gmt pstext -R -J -N -O -K \
-F+f12p,Helvetica−Bold,white+jLB+a-326 >> $ps << EOF
126.1 22.8 R y u k y u
EOF
gmt pstext -R -J -N -O -K \
-F+f12p,Helvetica−Bold,white+jLB+a-303 >> $ps << EOF
129.8 25.3 T r e n c h
EOF
gmt pstext -R -J -N -O -K \
-F+f12p,Helvetica−Bold,white+jLB+a-44 >> $ps << EOF
144.6 23.7 Mariana
EOF
gmt pstext -R -J -N -O -K \
-F+f12p,Helvetica−Bold,white+jLB+a-62 >> $ps << EOF
146.9 21.6 Trench
EOF
gmt pstext -R -J -N -O -K \
-F+f12p,Helvetica−Bold,white+jBL+a-345 >> $ps << EOF
141 10.0 Mariana
EOF
gmt pstext -R -J -N -O -K \
-F+f12p,Helvetica−Bold,white+jBL+a-335 >> $ps << EOF
144.5 10.9 Trench
EOF
gmt pstext -R -J -N -O -K \
-F+f8p,Palatino-Roman,black+jLB+a-80 -Gwhite@30 >> $ps << EOF
140.3 33.0 I Z U - B O N I N  V O L C A N I C  A R C
EOF
gmt pstext -R -J -N -O -K \
-F+f11p,Helvetica−Bold,white+jBL+a-305 >> $ps << EOF
137.7 6.8 Yap Trench
EOF
gmt pstext -R -J -N -O -K \
-F+f11p,Helvetica−Bold,white+jBL+a-310 >> $ps << EOF
134.0 4.2 Palau Trench
EOF
gmt pstext -R -J -N -O -K \
-F+f9p,Palatino-Roman,black+jLB+a-350 -Gwhite@40 >> $ps << EOF
136.0 5.7 West Caroline Trough
EOF
gmt pstext -R -J -N -O -K \
-F+f10p,Times−Bold,blue+jLB+a-290 -Gwhite@40 >> $ps << EOF
139.2 11.9 Parece Vela Rift
142.1 4.8 Eauripik Rise
EOF
gmt pstext -R -J -N -O -K \
--F+f10p,Times−Bold,blue+jLB+a-280 -Gwhite@40 >> $ps << EOF
133.4 6.3 Kyushu Palau Ridge
EOF
gmt pstext -R -J -N -O -K \
-F+f10p,Times−Bold,blue+jLB+a-75 -Gwhite@40 >> $ps << EOF
138.3 28.9 Ogasawara Trough
EOF
gmt pstext -R -J -N -O -K \
-F+f10p,Times−Bold,blue+jLB -Gwhite@40 >> $ps << EOF
145.0 25.4 Ogasawara Plateau
EOF
gmt pstext -R -J -N -O -K \
-F+f8p,Palatino-Roman,black+jLB -Gwhite@40 >> $ps << EOF
134.0 23.0 SHIKOKU BASIN
EOF
# Step-12. Add subtitle
gmt pstext -R0/10/0/15 -JX10/10 -X0.5c -Y7.2c -N -O -K \
    -F+f10p,Palatino-Roman,black+jLB >> $ps << EOF
-0.5 15.5 Dataset: Global CMT Catalog (Harvard CMT). Contourmap: GEBCO 15 arc sec grid, isobaths: 2,000 m
EOF
# Add GMT logo
gmt logo -Dx6.3/-0.8+o0.3c/-8.2c+w2c -O >> $ps
# Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Geol_PSB_velo.ps -A0.5c -E720 -Tj -P -Z
