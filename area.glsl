#pragma glslify: Area = require('./area.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
vec2 texRange = vec2(0.75, 1.0);

Area readArea(sampler2D styleTexture, float featureType, float zoom, float featureCount) {
  float n = 2.0;
  vec4 d0 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (0.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * vec4(1,1,1,255);
  vec4 d1 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (1.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * 255.0;

  Area area;
  area.color = vec4(d0.xyz, d0.w/100.0);
  area.zindex = d1.x;
  return area;
}

#pragma glslify: export(readArea)
