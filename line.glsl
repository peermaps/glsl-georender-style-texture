#pragma glslify: Line = require('./line.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
float pointHeight = 7.0*zoomCount;
float lineHeight = 8.0*zoomCount;
float areaHeight = 6.0*zoomCount;
float areaBorderHeight = 3.0*zoomCount;
float totalHeight = pointHeight + lineHeight + areaHeight + areaBorderHeight;

vec2 texRange = vec2(pointHeight/totalHeight, (pointHeight + lineHeight)/totalHeight);

Line readLine(sampler2D styleTexture, float featureType, float zoom, float featureCount) {
  float n = 8.0;
  vec4 d0 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (0.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * vec4(1,1,1,2.55);

  vec4 d1 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (1.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * vec4(1,1,1,2.55);

  vec4 d2 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (2.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * 255.0;

  vec4 d3 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (3.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * 255.0;

  vec4 d4 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (4.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * vec4(1,1,1,2.55);

  vec4 d5 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (5.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * vec4(1,1,1,2.55);

  vec4 d6 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (6.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * 255.0;

  vec4 d7 = texture2D(styleTexture, vec2(
    featureType/featureCount+0.5/featureCount,
    ((floor(zoom)-zoomStart)/zoomCount + (7.0*2.0+1.0)/(n*zoomCount*2.0))
      * (texRange.y-texRange.x) + texRange.x
  )) * 255.0;


  Line line;
  line.fillColor = d0;
  line.strokeColor = vec4(d1.xyz, d0.w);
  line.fillDashLength = d2.x;
  line.fillDashGap = d2.y;
  line.strokeDashLength = d2.z;
  line.strokeDashGap = d2.w;
  line.fillWidth = d3.x;
  line.strokeWidthInner = d3.y;
  line.strokeWidthOuter = d3.z
  line.zindex = d3.w;
  line.labelFillColor = d4;
  line.labelStrokeColor = d5;
  line.labelFont = d6.x;
  line.labelFontSize = d6.y;
  line.labelPriority = d6.z;
  line.labelConstraints = d6.w;
  line.labelStrokeWidth = d7.x;
  line.labelSprite = d7.y;
  line.sprite = d7.z*256.0 + d7.w;
  return line;
}

#pragma glslify: export(readLine)
