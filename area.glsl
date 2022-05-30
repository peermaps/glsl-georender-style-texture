#pragma glslify: Area = require('./area.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
float pointHeight = 6.0*zoomCount;
float lineHeight = 8.0*zoomCount;
float areaHeight = 6.0*zoomCount;
float areaBorderHeight = 2.0*zoomCount;
float totalHeight = pointHeight + lineHeight + areaHeight + areaBorderHeight;

vec2 texRange = vec2((pointHeight + lineHeight)/totalHeight, (pointHeight+lineHeight+areaHeight)/totalHeight);

Area readArea(sampler2D styleTexture, float featureType, float zoom, float featureCount) {
  float n = 6.0;
  vec4 d0 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (0.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * vec4(1,1,1,2.55);

  vec4 d1 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (1.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * 255.0;

  vec4 d2 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (2.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * vec4(1,1,1,2.55);

  vec4 d3 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (3.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * vec4(1,1,1,2.55);

  vec4 d4 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (4.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * 255.0;

  vec4 d5 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (5.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * 255.0;

  Area area;
  area.color = d0;
  area.zindex = d1.x;
  area.labelFillColor = d2;
  area.labelStrokeColor = d3;
  area.labelFont = d4.x;
  area.labelFontSize = d4.y;
  area.labelPriority = d4.z;
  area.labelConstraints = d4.w;
  area.labelStrokeWidth = d5.x;
  return area;
}

#pragma glslify: export(readArea)
