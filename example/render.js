var glsl = require('glslify')
var regl = require('regl')()
var draw = regl({
  frag: glsl`
    precision highp float;
    varying vec4 v_color;
    void main() {
      gl_FragColor = vec4(v_color);
    }
  `,
  vert: glsl`
    precision highp float;
    #pragma glslify: Area = require('../area.h');
    #pragma glslify: readArea = require('../area.glsl');
    uniform sampler2D texture;
    attribute vec2 position;
    varying vec4 v_color;
    void main() {
      float zoom = 10.0;
      float featureCount = 50.0;
      float featureType = 6.0;
      Area area = readArea(texture, featureType, zoom, featureCount);
      v_color = area.color;
      gl_Position = vec4(position,0,1);
    }
  `,
  uniforms: {
    texture: regl.prop('texture')
  },
  attributes: {
    position: [-0.8,-0.8,+0.0,+0.8,+0.8,-0.8]
  },
  elements: [0,1,2]
})

require('resl')({
  manifest: {
    texture: {
      type: 'image',
      src: './example/texture.png',
      parser: function (data) { return regl.texture({ data }) }
    }
  },
  onDone: function ({texture}) {
    regl.frame(function () {
      regl.poll()
      regl.clear({ color: [0,0,0,1], depth: true })
      draw({texture})
    })
  }
})
