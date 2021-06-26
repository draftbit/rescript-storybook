type actionHandler<'a> = 'a => unit

@val @module("@storybook/addon-actions")
external action: string => actionHandler<'a> = "action"
