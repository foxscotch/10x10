Timer = require 'vendor.hump.timer'
deep = require 'vendor.deep'
V = require 'vector'
import copy from require 'moon'

Node = require 'node'


class Block extends Node
    @BASE_SIZE: 38
    @SPACING_FACTOR: 0.07
    @DEFAULT_SPACING: @BASE_SIZE * @SPACING_FACTOR
    @RADIUS_DIVISOR: 5
    @STATES: {
        SELECT:  factor: 0.62, padding: 0.00
        GRABBED: factor: 1.00, padding: 0.10
        PLACED:  factor: 1.00, padding: 0.00
    }

    new: (game, parent, pos, color, state) =>
        super game, parent, pos
        @state = copy state or @@STATES.PLACED
        size = @@BASE_SIZE * @state.factor
        @size = w: size, h: size
        @color = color or 'def'  -- string corresponding to theme color name
        @onTop = false  -- set by Polies

    getSpacing: =>
        @size.w * @@SPACING_FACTOR

    setState: (state) =>
        @game.timer\tween(.2, @state, state, 'out-back')

    update: =>
        size = @@BASE_SIZE * @state.factor
        @size = w: size, h: size

    draw: =>
        padding = @state.padding * @size.w
        size = @size.w - padding
        radius = size / @@RADIUS_DIVISOR
        deep.queue @onTop and 2 or 1, ->
            love.graphics.setColor @game.theme[@color]
            love.graphics.rectangle('fill',
                                    @pos.x + padding, @pos.y + padding,
                                    size, size,
                                    radius)


return Block
