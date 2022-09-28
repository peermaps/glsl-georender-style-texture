#pragma glslify: SpriteMeta = require('./spritemeta.h')
#pragma glslify: Settings = require('./settings.h')
#pragma glslify: defaultSettings = require('./settings.glsl')

vec4 readSprite(sampler2D styleTexture, vec2 imageSize, SpriteMeta spriteMeta, vec2 uv) {
  Settings settings = defaultSettings(7.0);
  float spriteStart = settings.pointHeight + settings.lineHeight + settings.areaHeight + settings.areaBorderHeight + settings.spriteMetaHeight;

  float x = spriteMeta.x;
  float y = spriteMeta.y + spriteStart;
  float width = spriteMeta.width;
  float height = spriteMeta.height-1.0;
  float iwidth = imageSize.x;
  float iheight = imageSize.y;
  vec2 tuv = vec2(
    (uv.x*width+x)/(iwidth-1.0),
    (uv.y*height+y)/(iheight-1.0)
  );
  return texture2D(styleTexture, tuv);
}

#pragma glslify: export(readSprite)
