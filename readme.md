# glsl-georender-style-texture

[glslify](https://www.npmjs.com/package/glslify) module to read from a georender style texture

# example

```js
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
    #pragma glslify: Area = require('glsl-georender-style-texture/area.h');
    #pragma glslify: readArea = require('glsl-georender-style-texture/area.glsl');
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
```

to run example:

* clone the repo from `https://github.com/peermaps/glsl-georender-style-texture`
* navigate to the folder where the package was cloned and do `npm install`.
* do `npm run example`. you should see output like `Server running at http://192.168.129.29:9966/`.
* in the browser, navigate to that url. you should see a large blue triangle.

(the directions above assume that you have node.js and npm installed. instructions are for usage on the command line.)

in the example code, if you change the `featureType` value, the color of the triangle should change. try values like 1.0, 18.0, 40.0.

if you'd like to generate your own `texture.png`, you can use
[georender-style2png](https://www.npmjs.com/package/georender-style2png).


# api

```
#pragma glslify: Point = require('glsl-georender-style-texture/point.h');
#pragma glslify: readPoint = require('glsl-georender-style-texture/point.glsl');
#pragma glslify: Line = require('glsl-georender-style-texture/line.h');
#pragma glslify: readLine = require('glsl-georender-style-texture/line.glsl');
#pragma glslify: Area = require('glsl-georender-style-texture/area.h');
#pragma glslify: readArea = require('glsl-georender-style-texture/area.glsl');
```

## Point readPoint(sampler2D styleTexture, float featureType, float zoom, float featureCount)

return a Point from a style texture, for a given
[feature type](https://github.com/peermaps/georender-pack/blob/master/features.json),
zoom, and total number of features (featureCount).

## Point

* vec4 color - rgba
* float size - point size in pixels
* float zindex - stacking order from 0-100 where 0 is on bottom

## Line readLine(sampler2D styleTexture, float featureType, float zoom, float featureCount)

return a Line from a style texture, for a given
[feature type](https://github.com/peermaps/georender-pack/blob/master/features.json),
zoom, and total number of features (featureCount).

## Line

* vec4 fillColor - rgba
* vec4 strokeColor - rgba
* float fillStyle - float representing fill style.
    * if `solid`, 10.
    * if `dot`, 6.
    * if `dash`, default is 10.
    * if `line-fill-dash-length` is `short`, 10.
    * if `line-fill-dash-length` is `medium`, 15.
    * if `line-fill-dash-length` is `long`, 20.
* float strokeStyle - float representing stroke style.
    * if `solid`, 10.
    * if `dot`, 6.
    * if `dash`, default is 10.
    * if `line-stroke-dash-length` is `short`, 10.
    * if `line-stroke-dash-length` is `medium`, 15.
    * if `line-stroke-dash-length` is `long`, 20.
* float fillDashGap - float for the gap between dashes when the `line-fill-style` is `dash`. values from 0-100. default is 50 (dash and dash gap are equal length).
* float strokeDashGap - float for the gap between dashes when the `line-stroke-style` is `dash`. values from 0-100. default is 50 (dash and dash gap are equal length).
* float fillWidth - line fill width in pixels
* float strokeWidth - line stroke width in pixels
* float zindex - stacking order from 0-100 where 0 is on bottom

## Area readArea(sampler2D styleTexture, float featureType, float zoom, float featureCount)

return an Area from a style texture, for a given
[feature type](https://github.com/peermaps/georender-pack/blob/master/features.json),
zoom, and total number of features (featureCount).

## Area

* vec4 color - rgba
* float zindex - stacking order from 0-100 where 0 is on bottom

# install

`npm install glsl-georender-style-texture`

# license

MIT
