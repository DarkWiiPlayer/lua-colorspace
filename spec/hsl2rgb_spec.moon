colorspace = require 'colorspace'
colors     = require 'spec/vectors'

describe 'hsl2rgb', ->
	for color in *colors
		it "Should correctly convert #{color.name} (#{color.hex}, hsl(#{color.hsl[1]}, #{color.hsl[2]}, ##{color.hsl[3]}))", ->
			assert.same color.rgb, {colorspace.hsl2rgb(color.hsl[1], color.hsl[2], color.hsl[3])}
	it "Should just pass additional arguments through", ->
		-- aka it should double as a hsla2rgba converter
		assert.equal 'foo', select 4, colorspace.hsl2rgb(0, 0, 0, 'foo')
