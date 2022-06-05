#pragma glslify: Point = require('./point.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
float pointHeight = 7.0*zoomCount;
float lineHeight = 8.0*zoomCount;
float areaHeight = 6.0*zoomCount;
float areaBorderHeight = 3.0*zoomCount;
float totalHeight = pointHeight + lineHeight + areaHeight + areaBorderHeight;
float pointStart = 0.0;

Point readPoint(sampler2D styleTexture, float featureType, float zoom, float featureCount) {
  float n = 7.0;
  float px = featureType; //pixel x
  float py = pointStart + n * (zoomStart + floor(zoom)); //pixel y

  vec4 d0 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+0.0)/totalHeight + 0.5/totalHeight)) * vec4(1,1,1,2.55);

  vec4 d1 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+1.0)/totalHeight + 0.5/totalHeight)) * vec4(1,1,1,2.55);

  vec4 d2 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+2.0)/totalHeight + 0.5/totalHeight)) * 255.0;

  vec4 d3 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+3.0)/totalHeight + 0.5/totalHeight)) * vec4(1,1,1,2.55);

  vec4 d4 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+4.0)/totalHeight + 0.5/totalHeight)) * vec4(1,1,1,2.55);

  vec4 d5 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+5.0)/totalHeight + 0.5/totalHeight)) * 255.0;

  vec4 d6 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+6.0)/totalHeight + 0.5/totalHeight)) * 255.0;

  Point point;
  point.fillColor = d1;
  point.strokeColor = d0;
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
