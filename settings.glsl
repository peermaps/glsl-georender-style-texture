#pragma glslify: Settings = require('./settings.h')

Settings defaultSettings(float spriteCount) {
  Settings settings;
  settings.featureCount = 1240.0;
  settings.zoomStart = 1.0;
  settings.zoomCount = 21.0;
  settings.pointHeight = 7.0*settings.zoomCount;
  settings.lineHeight = 8.0*settings.zoomCount;
  settings.areaHeight = 6.0*settings.zoomCount;
  settings.areaBorderHeight = 3.0*settings.zoomCount; 
  settings.spriteMetaHeight = 2.0*ceil(spriteCount/settings.featureCount);
  return settings;
}

#pragma glslify: export(defaultSettings)
