colorspace = require 'colorspace'
colors     = require 'spec/vectors'

pending 'rgb2hsl', ->
	for color in *colors
		pending "Should correctly convert #{color.name} (#{color.hex}, hsl(#{color.hsl[1]}, #{color.hsl[2]}, ##{color.hsl[3]}))", ->
			assert.same color.hsl, {colorspace.rgb2hsl(color.rgb[1], color.rgb[2], color.rgb[3])}
	it "Should just pass additional arguments through", ->
		-- aka it should double as a hsla2rgba converter
		assert.equal 'foo', select 4, colorspace.hsl2rgb(0, 0, 0, 'foo')
