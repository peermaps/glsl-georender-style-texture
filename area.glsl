#pragma glslify: Area = require('./area.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
float pointHeight = 7.0*zoomCount;
float lineHeight = 8.0*zoomCount;
float areaStart = pointHeight + lineHeight;

Area readArea(sampler2D styleTexture, float featureType, float zoom, vec2 imageSize) {
  float n = 6.0;
  float px = featureType; //pixel x
  float py = areaStart + n * (floor(zoom)-zoomStart); //pixel y

  vec4 d0 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+0.0)/imageSize.y + 0.5/imageSize.y)) * vec4(1,1,1,2.55);

  vec4 d1 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+1.0)/imageSize.y + 0.5/imageSize.y)) * 255.0;

  vec4 d2 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+2.0)/imageSize.y + 0.5/imageSize.y)) * vec4(1,1,1,2.55);

  vec4 d3 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+3.0)/imageSize.y + 0.5/imageSize.y)) * vec4(1,1,1,2.55);

  vec4 d4 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+4.0)/imageSize.y + 0.5/imageSize.y)) * 255.0;

  vec4 d5 = texture2D(styleTexture, vec2(
    px/imageSize.x+0.5/imageSize.x, (py+5.0)/imageSize.y + 0.5/imageSize.y)) * 255.0;

  Area area;
  area.color = d0;
  area.zindex = d1.x;
  area.labelStrokeWidth = d1.y;
  area.sprite = d1.z*256.0 + d1.w;
  area.labelFillColor = d2;
  area.labelStrokeColor = d3;
  area.labelFont = d4.x;
  area.labelFontSize = d4.y;
  area.labelPriority = d4.z;
  area.labelConstraints = d4.w;
  area.labelSprite = d5.x*256.0 + d5.y;
  area.labelSpritePlacement = d5.z;
  return area;
}

#pragma glslify: export(readArea)
