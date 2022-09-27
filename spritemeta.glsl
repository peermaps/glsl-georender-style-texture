#pragma glslify: Settings = require('./settings.h')
#pragma glslify: defaultSettings = require('./settings.glsl')
#pragma glslify: SpriteMeta = require('./spritemeta.h')

vec2 spriteLocation(Settings settings, float spriteIndex) {
  float spriteMetaStart = settings.pointHeight + settings.lineHeight + settings.areaHeight + settings.areaBorderHeight;
  float x = mod(spriteIndex, settings.featureCount); 
  float y = spriteMetaStart + 2.0*(floor(spriteIndex/settings.featureCount));
  return vec2(x,y);
}

SpriteMeta readSpriteMeta(sampler2D styleTexture, vec2 imageSize, float index) {
  Settings settings = defaultSettings(7.0);

  //vec2 px0 = spriteLocation(settings, index);
  vec2 px0 = spriteLocation(settings, index);
  vec2 px1 = px0 + vec2(0,1);
  vec2 uv0 = px0/(imageSize - 1.0);
  vec2 uv1 = px1/(imageSize - 1.0);

  vec4 d0 = texture2D(styleTexture, uv0)*256.0;
  vec4 d1 = texture2D(styleTexture, uv1)*255.0;

  SpriteMeta spriteMeta;
  spriteMeta.width = d0.x*256.0 + d0.y;
  //spriteMeta.height = mod(d0.z, 128.0)*256.0 + d0.w;
  spriteMeta.height = mod(d0.z, 128.0)*256.0 + d0.w;
  spriteMeta.type = floor(d0.z/128.0);
  spriteMeta.x = d1.x*256.0 + d1.y;
  spriteMeta.y = d1.z*256.0 + d1.w;

  return spriteMeta;
}

#pragma glslify: export(readSpriteMeta)
