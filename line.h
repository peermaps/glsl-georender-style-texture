struct Line {
  vec4 fillColor;
  vec4 strokeColor;
  float fillDashLength;
  float fillDashGap;
  float strokeDashLength;
  float strokeDashGap;
  float fillWidth;
  float strokeWidth;
  float zindex;
  vec4 labelFillColor;
  vec4 labelStrokeColor;
  float labelFont;
  float labelFontSize;
  float labelPriority;
  float labelConstraints;
  float labelStrokeWidth;
};

#pragma glslify: export(Line)
