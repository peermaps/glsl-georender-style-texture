#pragma glslify: Point = require('./point.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
float pointStart = 0.0;

Point readPoint(sampler2D styleTexture, float featureType, float zoom, vec2 imageSize) {
  float n = 7.0;
  float px = featureType; //pixel x
  float py = pointStart + n * (floor(zoom) - zoomStart); //pixel y

  vec4 d0 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+0.0)/imageSize.y + 0.5/imageSize.y)) * vec4(1,1,1,2.55);

  vec4 d1 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+1.0)/imageSize.y + 0.5/imageSize.y)) * vec4(1,1,1,2.55);

  vec4 d2 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+2.0)/imageSize.y + 0.5/imageSize.y)) * 255.0;

  vec4 d3 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+3.0)/imageSize.y + 0.5/imageSize.y)) * vec4(1,1,1,2.55);

  vec4 d4 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+4.0)/imageSize.y + 0.5/imageSize.y)) * vec4(1,1,1,2.55);

  vec4 d5 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+5.0)/imageSize.y + 0.5/imageSize.y)) * 255.0;

  vec4 d6 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+6.0)/imageSize.y + 0.5/imageSize.y)) * 255.0;

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
  point.sprite = d6.y*255.0 + d6.z;
  return point;
}

#pragma glslify: export(readPoint)
