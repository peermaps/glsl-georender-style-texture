#pragma glslify: Area = require('./area.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
float pointHeight = 7.0*zoomCount;
float lineHeight = 8.0*zoomCount;
float areaHeight = 6.0*zoomCount;
float areaBorderHeight = 3.0*zoomCount;
float totalHeight = pointHeight + lineHeight + areaHeight + areaBorderHeight;
float areaStart = pointHeight + lineHeight;

Area readArea(sampler2D styleTexture, float featureType, float zoom, float featureCount) {
  float n = 6.0;
  float px = featureType; //pixel x
  float py = areaStart + n * (zoomStart + floor(zoom)); //pixel y

  vec4 d0 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+0.0)/totalHeight + 0.5/totalHeight)) * vec4(1,1,1,2.55);

  vec4 d1 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+1.0)/totalHeight + 0.5/totalHeight)) * 255.0;

  vec4 d2 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+2.0)/totalHeight + 0.5/totalHeight)) * vec4(1,1,1,2.55);

  vec4 d3 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+3.0)/totalHeight + 0.5/totalHeight)) * vec4(1,1,1,2.55);

  vec4 d4 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+4.0)/totalHeight + 0.5/totalHeight)) * 255.0;

  vec4 d5 = texture2D(styleTexture, vec2(
    px/featureCount+0.5/featureCount, (py+5.0)/totalHeight + 0.5/totalHeight)) * 255.0;

  Area area;
  area.color = d0;
  area.zindex = d1.x;
  area.labelStrokeWidth = d1.y;
  area.labelFillColor = d2;
  area.labelStrokeColor = d3;
  area.labelFont = d4.x;
  area.labelFontSize = d4.y;
  area.labelPriority = d4.z;
  area.labelConstraints = d4.w;
  area.labelSprite = d5.x;
  area.sprite = d5.y*256.0 + d5.z;
  return area;
}

#pragma glslify: export(readArea)
