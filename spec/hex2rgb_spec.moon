colorspace = require 'colorspace'
colors     = require 'spec/vectors'

describe 'hex2rgb', ->
	it "should convert 6-digit colors", ->
		assert.same {1, 1, 1}, {colorspace.hex2rgb("#ffffff")}
	it "should convert 3-digit colors", ->
		assert.same {1, 1, 1}, {colorspace.hex2rgb("#fff")}
	it "Should convert 4-digit colors", ->
		assert.equal 1, select(4, colorspace.hex2rgb('#ffff'))
		assert.equal 0, select(4, colorspace.hex2rgb('#fff0'))
	it "Should convert 8-digit colors", ->
		assert.equal 1, select(4, colorspace.hex2rgb('#ffffffff'))
		assert.equal 0, select(4, colorspace.hex2rgb('#ffffff00'))
