#pragma glslify: Point = require('./point.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
vec2 texRange = vec2(0, 0.25);

Point readPoint(sampler2D styleTexture, float featureType, float zoom, float featureCount) {
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

  Point point;
  point.color = vec4(d0.xyz, d0.w/100.0);
  point.size = d1.x;
  point.zindex = d1.y;
  return point;
}

#pragma glslify: export(readPoint)
