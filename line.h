struct Line {
  vec4 fillColor;
  vec4 strokeColor;
  float fillDashLength;
  float fillDashGap;
  float strokeDashLength;
  float strokeDashGap;
  float fillWidth;
  float strokeWidthInner;
  float strokeWidthOuter;
  float zindex;
  vec4 labelFillColor;
  vec4 labelStrokeColor;
  float labelFont;
  float labelFontSize;
  float labelPriority;
  float labelConstraints;
  float labelStrokeWidth;
  float labelSprite;
  float sprite;
};

#pragma glslify: export(Line)
