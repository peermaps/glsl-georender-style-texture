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
};

#pragma glslify: export(Line)
