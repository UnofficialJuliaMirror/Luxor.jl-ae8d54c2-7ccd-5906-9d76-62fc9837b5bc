#!/usr/bin/env julia

using Luxor

function get_png_files(folder)
    cd(folder)
    imagelist = filter(f -> !startswith(f, ".") && endswith(f, "png"), readdir(folder))
    return map(realpath, imagelist)
end

imagelist = get_png_files(Pkg.dir("Luxor") * "/examples")

width, height = 2000, 2000
Drawing(width, height, "/tmp/paint-images.pdf")
origin()
background("grey50")

for imgfile in imagelist
    img = readpng(imgfile)
    rand(Bool) ? placeimage(img, rand(-width/2:width/2), rand(-height/2:height/2), rand(0.25:0.1:0.75)) : placeimage(img, Point(rand(-width/2:width/2), rand(-height/2:height/2)), rand(0.25:0.1:0.75))
end

finish()
preview()