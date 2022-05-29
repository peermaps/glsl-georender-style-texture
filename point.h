struct Point {
  vec4 color;
  float size;
  float zindex;
  vec4 labelFillColor;
  vec4 labelStrokeColor;
  float labelFont;
  float labelFontSize;
  float labelPriority;
  float labelConstraints;
  float labelStrokeWidth;
};

#pragma glslify: export(Point)
