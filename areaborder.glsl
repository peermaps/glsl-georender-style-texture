#pragma glslify: Areaborder = require('./areaborder.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
vec2 texRange = vec2(0.8, 1.0);

Areaborder readAreaborder(sampler2D styleTexture, float featureType, float zoom, float featureCount) {
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

  Areaborder areaborder;
  areaborder.color = d0;
  areaborder.dashLength = d1.x;
  areaborder.dashGap = d1.y;
  areaborder.width = d1.z;
  areaborder.zindex = d1.w;
  return areaborder;
}

#pragma glslify: export(readAreaborder)
