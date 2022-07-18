#pragma glslify: AreaBorder = require('./areaborder.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
float pointHeight = 7.0*zoomCount;
float lineHeight = 8.0*zoomCount;
float areaHeight = 6.0*zoomCount;
float areaBorderStart = pointHeight + lineHeight + areaHeight;

AreaBorder readAreaBorder(sampler2D styleTexture, float featureType, float zoom, vec2 imageSize) {
  float n = 3.0;
  float px = featureType; //pixel x
  float py = areaBorderStart + n * (floor(zoom) - zoomStart); //pixel y

  vec4 d0 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+0.0)/imageSize.y + 0.5/imageSize.y)) * vec4(1,1,1,2.55);

  vec4 d1 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+1.0)/imageSize.y + 0.5/imageSize.y)) * 255.0;

  vec4 d2 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+2.0)/imageSize.y + 0.5/imageSize.y)) * 255.0;

  AreaBorder areaBorder;
  areaBorder.color = d0;
  areaBorder.dashLength = d1.x;
  areaBorder.dashGap = d1.y;
  areaBorder.widthInner = d1.z;
  areaBorder.widthOuter = d1.w;
  areaBorder.zindex = d2.x;
  areaBorder.sprite = d2.y*256.0 + d2.z;
  return areaBorder;
}

#pragma glslify: export(readAreaBorder)
