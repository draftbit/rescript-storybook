@val @module("@storybook/addon-knobs/react")
external withKnobs: Main.decorator = "withKnobs"

@val @module("@storybook/addon-knobs/react")
external extText: (string, Js.null_undefined<string>) => string = "text"

let text = (~label: string, ~defaultValue: option<string>=?, ()) =>
  extText(label, Js.Nullable.fromOption(defaultValue))

@val @module("@storybook/addon-knobs/react")
external extBoolean: (string, bool) => bool = "boolean"

let boolean = (~label: string, ~defaultValue=false, ()) => extBoolean(label, defaultValue)

type jsRangeConfig = {"range": bool, "min": float, "max": float, "step": float}

@val @module("@storybook/addon-knobs/react")
external extNumber: (string, float, Js.null_undefined<jsRangeConfig>) => float = "number"

type rangeConfig = {
  min: float,
  max: float,
  step: float,
}

let number = (
  ~label: string,
  ~defaultValue=0.,
  ~rangeConfiguration: option<rangeConfig>=?,
  (),
): float =>
  switch rangeConfiguration {
  | None => extNumber(label, defaultValue, Js.Nullable.undefined)
  | Some(c) =>
    let config = {"range": true, "min": c.min, "max": c.max, "step": c.step}
    extNumber(label, defaultValue, Js.Nullable.return(config))
  }

@val @module("@storybook/addon-knobs/react")
external extColor: (string, Js.null_undefined<string>) => string = "color"

let color = (~label: string, ~defaultValue: option<string>=?, ()) =>
  extColor(label, Js.Nullable.fromOption(defaultValue))

type selectConfig<'a> = 'a

@val @module("@storybook/addon-knobs/react")
external extSelect: (string, selectConfig<'a>, Js.null_undefined<string>) => string = "select"

let select = (~label: string, ~options: selectConfig<'a>, ~defaultValue: option<string>=?, ()) =>
  extSelect(label, options, Js.Nullable.fromOption(defaultValue))

@val @module("@storybook/addon-knobs/react")
external extDate: (string, Js.null_undefined<Js_date.t>) => string = "date"

let date = (~label: string, ~defaultValue: option<Js_date.t>=?, ()) =>
  extDate(label, Js.Nullable.fromOption(defaultValue))

type button

@val @module("@storybook/addon-knobs/react")
external extButton: (string, ReactEvent.Mouse.t => unit) => button = "button"

let button = (~label: string, ~handler: ReactEvent.Mouse.t => unit, ()) => extButton(label, handler)
