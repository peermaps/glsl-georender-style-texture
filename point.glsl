#pragma glslify: Point = require('./point.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
float pointHeight = 7.0*zoomCount;
float lineHeight = 8.0*zoomCount;
float areaHeight = 6.0*zoomCount;
float areaBorderHeight = 3.0*zoomCount;
float spriteHeight = 10.0*zoomCount;
float imageHeight = pointHeight + lineHeight + areaHeight + areaBorderHeight + spriteHeight;
float pointStart = 0.0;

Point readPoint(sampler2D styleTexture, float featureType, float zoom, float featureCount, vec2 imageSize) {
  float imageWidth = imageSize.x;
  float n = 7.0;
  float px = featureType; //pixel x
  float py = pointStart + n * (floor(zoom) - zoomStart); //pixel y

  vec4 d0 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+0.0)/imageHeight + 0.5/imageHeight)) * vec4(1,1,1,2.55);

  vec4 d1 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+1.0)/imageHeight + 0.5/imageHeight)) * vec4(1,1,1,2.55);

  vec4 d2 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+2.0)/imageHeight + 0.5/imageHeight)) * 255.0;

  vec4 d3 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+3.0)/imageHeight + 0.5/imageHeight)) * vec4(1,1,1,2.55);

  vec4 d4 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+4.0)/imageHeight + 0.5/imageHeight)) * vec4(1,1,1,2.55);

  vec4 d5 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+5.0)/imageHeight + 0.5/imageHeight)) * 255.0;

  vec4 d6 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+6.0)/imageHeight + 0.5/imageHeight)) * 255.0;

  Point point;
  point.fillColor = d0;
  point.strokeColor = d1;
  point.size = d2.x;
  point.strokeWidthInner = d2.y;
  point.strokeWidthOuter = d2.z;
  point.zindex = d2.w;
  point.labelFillColor = d3;
  point.labelStrokeColor = d4;
  point.labelFont = d5.x;
  point.labelFontSize = d5.y;
  point.labelPriority = d5.z;
  point.labelConstraints = d5.w;
  point.labelStrokeWidth = d6.x;
  point.labelSprite = d6.y;
  point.sprite = d6.z*256.0 + d6.w;
  return point;
}

#pragma glslify: export(readPoint)
