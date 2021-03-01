[@bs.val] [@bs.module "@storybook/addon-knobs"]
external withKnobs: Main.decorator = "withKnobs";

[@bs.val] [@bs.module "@storybook/addon-knobs"]
external extText: (string, Js.null_undefined(string)) => string = "text";

let text = (~label: string, ~defaultValue: option(string)=?, ()) =>
  extText(label, Js.Nullable.fromOption(defaultValue));

[@bs.val] [@bs.module "@storybook/addon-knobs"]
external extBoolean: (string, bool) => bool = "boolean";

let boolean = (~label: string, ~defaultValue=false, ()) =>
  extBoolean(label, defaultValue);

type jsRangeConfig = {
  .
  "range": bool,
  "min": float,
  "max": float,
  "step": float,
};

[@bs.val] [@bs.module "@storybook/addon-knobs"]
external extNumber: (string, float, Js.null_undefined(jsRangeConfig)) => float =
  "number";

type rangeConfig = {
  min: float,
  max: float,
  step: float,
};

let number =
    (
      ~label: string,
      ~defaultValue=0.,
      ~rangeConfiguration: option(rangeConfig)=?,
      (),
    )
    : float =>
  switch (rangeConfiguration) {
  | None => extNumber(label, defaultValue, Js.Nullable.undefined)
  | Some(c) =>
    let config = {"range": true, "min": c.min, "max": c.max, "step": c.step};
    extNumber(label, defaultValue, Js.Nullable.return(config));
  };

[@bs.val] [@bs.module "@storybook/addon-knobs"]
external extColor: (string, Js.null_undefined(string)) => string = "color";

let color = (~label: string, ~defaultValue: option(string)=?, ()) =>
  extColor(label, Js.Nullable.fromOption(defaultValue));

type selectConfig('a) = 'a;

[@bs.val] [@bs.module "@storybook/addon-knobs"]
external extSelect:
  (string, selectConfig('a), Js.null_undefined(string)) => string =
  "select";

let select =
    (
      ~label: string,
      ~options: selectConfig('a),
      ~defaultValue: option(string)=?,
      (),
    ) =>
  extSelect(label, options, Js.Nullable.fromOption(defaultValue));

[@bs.val] [@bs.module "@storybook/addon-knobs"]
external extDate: (string, Js.null_undefined(Js_date.t)) => string = "date";

let date = (~label: string, ~defaultValue: option(Js_date.t)=?, ()) =>
  extDate(label, Js.Nullable.fromOption(defaultValue));

type button;

[@bs.val] [@bs.module "@storybook/addon-knobs"]
external extButton: (string, ReactEvent.Mouse.t => unit) => button = "button";

let button = (~label: string, ~handler: ReactEvent.Mouse.t => unit, ()) =>
  extButton(label, handler);
