#pragma glslify: Line = require('./line.h')

float zoomStart = 1.0;
float zoomCount = 21.0;
float pointHeight = 7.0*zoomCount;
float lineHeight = 8.0*zoomCount;
float areaHeight = 6.0*zoomCount;
float areaBorderHeight = 3.0*zoomCount;
float spriteHeight = 10.0*zoomCount;
float imageHeight = pointHeight + lineHeight + areaHeight + areaBorderHeight + spriteHeight;
float lineStart = pointHeight;

Line readLine(sampler2D styleTexture, float featureType, float zoom, vec2 imageSize) {
  float imageWidth = imageSize.x;
  float n = 8.0;
  float px = featureType; //pixel x
  float py = lineStart + n * (floor(zoom) - zoomStart); //pixel y

  vec4 d0 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+0.0)/imageHeight + 0.5/imageHeight)) * vec4(1,1,1,2.55);

  vec4 d1 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+1.0)/imageHeight + 0.5/imageHeight)) * vec4(1,1,1,2.55);

  vec4 d2 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+2.0)/imageHeight + 0.5/imageHeight)) * 255.0;

  vec4 d3 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+3.0)/imageHeight + 0.5/imageHeight)) * 255.0;

  vec4 d4 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+4.0)/imageHeight + 0.5/imageHeight)) * vec4(1,1,1,2.55);

  vec4 d5 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+5.0)/imageHeight + 0.5/imageHeight)) * vec4(1,1,1,2.55);

  vec4 d6 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+6.0)/imageHeight + 0.5/imageHeight)) * 255.0;

  vec4 d7 = texture2D(styleTexture, vec2(
    px/imageWidth+0.5/imageWidth, (py+7.0)/imageHeight + 0.5/imageHeight)) * 255.0;


  Line line;
  line.fillColor = d0;
  line.strokeColor = vec4(d1.xyz, d0.w);
  line.fillDashLength = d2.x;
  line.fillDashGap = d2.y;
  line.strokeDashLength = d2.z;
  line.strokeDashGap = d2.w;
  line.fillWidth = d3.x;
  line.strokeWidthInner = d3.y;
  line.strokeWidthOuter = d3.z;
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
