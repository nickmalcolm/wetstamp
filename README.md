# Watermarkify

Better watermarks for Shopify Product Images.

## Image

### Options

 *  Rotate watermark (degrees -360 to 360)
 *  Transparency (0 transparent to 1 opaque)
 *  Position
    * 9 points on a cube (NorthEast, Center, etc.)
 * Tiled
    * Position fixed to center


### Examples

    image = Magick::Image.read(path)
    wmark = Magick::Image.read(path)

A 25% visible watermark, rotated -45º, centered.

    image.dissolve(wmark.rotate(-45), 0.25, 1.0, Magick::CenterGravity).write("watermarked.jpg")

A tiled and rotated watermark.

    # Make a transparent canvas the right size
    mark = Magick::Image.read("xc:none") { self.size = "500x500" }.first
    # Rotate and tile the watermark onto the canvas
    rtiled = mark.composite_tiled(wmark.rotate(-45))
    # Dissolve the tiled watermark on to the image
    image.dissolve(rtiled, 0.25, 1.0, Magick::CenterGravity).write("watermarked.jpg")


## Test Shops

quitzon-and-sons6225.myshopify.com