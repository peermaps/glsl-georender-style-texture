#pragma glslify: AreaBorder = require('./areaborder.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
float pointHeight = 6.0*zoomCount;
float lineHeight = 8.0*zoomCount;
float areaHeight = 6.0*zoomCount;
float areaBorderHeight = 2.0*zoomCount;
float totalHeight = pointHeight + lineHeight + areaHeight + areaBorderHeight;

vec2 texRange = vec2((pointHeight + lineHeight + areaHeight)/totalHeight,(pointHeight + lineHeight + areaHeight + areaBorderHeight)/totalHeight);

AreaBorder readAreaBorder(sampler2D styleTexture, float featureType, float zoom, float featureCount) {
  float n = 2.0;
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

  AreaBorder areaBorder;
  areaBorder.color = d0;
  areaBorder.dashLength = d1.x;
  areaBorder.dashGap = d1.y;
  areaBorder.width = d1.z;
  areaBorder.zindex = d1.w;
  return areaBorder;
}

#pragma glslify: export(readAreaBorder)
