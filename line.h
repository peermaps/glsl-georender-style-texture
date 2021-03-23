struct Line {
  vec4 fillColor;
  vec4 strokeColor;
  float fillStyle;
  float strokeStyle;
  float fillDashGap;
  float strokeDashGap;
  float fillWidth;
  float strokeWidth;
  float zindex;
};

#pragma glslify: export(Line)
