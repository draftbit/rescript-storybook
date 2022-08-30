# rescript-storybook

Rescript bindings for **[Storybook](https://storybook.js.org/)**.

The goal of this project is to provide bindings for the main Storybook API, as well as the official add-ons. Currently it supports:

- [actions](https://github.com/storybooks/storybook/tree/master/addons/actions)
- [knobs](https://github.com/storybooks/storybook/tree/master/addons/knobs)
- [addons API](https://storybook.js.org/addons/writing-addons/)

## Getting Started

First install this package:

```bash
npm install rescript-storybook
```

Next, you'll need to add `rescript-storybook` to your `bsconfig.json` as a dependency.

Then, get Storybook up and running according to [their docs](https://storybook.js.org/basics/quick-start-guide/)

> **Note:** This library does not attempt to provide a way to configure storybook in Reason - just use the standard JS configs.

In your `/.storybook/config.js`, import your stories from wherever your compiled Reason modules end up.
For example, if you're writing your stories inside a `__stories__` directory, and `bsb` is configured for a standard build, you might do something like:

```javascript
const req = require.context("../lib/js", true, /\__stories__\/.*.js$/);
configure(() => {
  req.keys().forEach((module) => {
    req(module).default();
  });
}, module);
```

or if you are using Storybook v6.

```javascript
/* .storybook/main.js */
module.exports = {
  stories: ["../stories/**/*.js"],
  addons: [
    "@storybook/addon-actions",
    "@storybook/addon-links",
    "@storybook/addon-knobs/register",
  ],
};
```

Note that in the above example, we're assuming the convention of each module containing a function as the `default` export. rescript-storybook is accountable for that while writting your stories:

## Writing a story

Here's a basic story in its entirety:

```reason
open BsStorybook.Story;

let _module = [%bs.raw "module"];

storiesOf("My First Reason Story", _module)
->add("Chapter I", () => <span> {React.string("Hello rescript-storybook!")} </span>);
```

Storybook uses a reference to the `module` global provided by webpack to facilitate hot-reloading. We'll access that via the `[%bs.raw]` decorator.

## Writing a CSF Story

If you'd prefer to use the newer [Component Story Format](https://storybook.js.org/docs/formats/component-story-format/), you can do that as well:

```reason
open Storybook;

let default = CSF.make(~title="My CSF Story", ());

let button = () => <MyButton />;

button->CSF.addMeta(~name="Plain Button", ());
```

## The Actions Addon

The action addon's API is essentially unchanged from its JS implementation:

> Make sure that you have `@storybook/addon-actions` in the config

```reason
let clickAction = Action.action("I Clicked The Button!");

<div onClick={clickAction} />
```

## The Knobs Addon

To use [knobs](https://github.com/storybooks/storybook/tree/master/addons/knobs) you have twoo ways:

> Make sure that you have @storybook/addon-knobs/register in the config

#### As a decorator

```reason
open Storybook;
open Story;

let _module = [%bs.raw "module"];

storiesOf("My First Reason Story", _module)
->addDecorator(Knobs.withKnobs)
->add("Chaper with Knobs", () => {
    let name = Knobs.text(~label="Name", ~defaultValue="Patrick", ());
    <span> {React.string(name)} </span>;
  })
```

#### Creating the story

```reason
open Storybook;
open Story;

let _module = [%bs.raw "module"];

let knobsStory =
  Main.createStory(
    ~title="Hey look, knobs!",
    ~decorators=[Knobs.withKnobs],
    ~_module,
    (),
  );

knobsStory.add("Chaper with Knobs", () => {
  let name = Knobs.text(~label="Name", ~defaultValue="Patrick", ());
  <span> {React.string(name)} </span>;
})
```

Each knob type is invoked using a function with labeled arguments, and each requires passing `unit` as the final argument. They all share a `~label` argument, and a `~defaultValue` argument (where appropriate):

### Text

```reason
let myText = Knobs.text(~label="What should it say?", ~defaultValue="Sup?", ());
```

### Boolean

```reason
let myBoolean = Knobs.boolean(~label="Should Show?", ~defaultValue=true, ());
```

Note: The boolean type will call the underlying JS knob with a defaultValue of `false` if one is not provided.

### Color

```reason
let myColor = Knobs.color(~label="Color", ~defaultValue="#333" ());
```

### Number

The number type works with floats. If no `defaultValue` is provided, it will pass `0`. It also takes an optional `rangeConfig` record, which allows for specifying a `min`, `max`, and `step` so that the knob is displayed as a range slider.

```reason
let num1 = Knobs.number(~label="Number 1", ());
let num2 =
  Knobs.number(
    ~label="Number 2",
    ~rangeConfiguration={range: true, min: 0., max: 10., step: 1.},
    ()
  );
```

### Select

To use the select knob, first define a record type that contains the shape of the options, then the actual options as a type of `selectConfig`, passing your shape as the constructor type:

```reason
type selectOptions = {
  one: string,
  two: string
};

let options : Knobs.selectConfig(selectOptions) = {
  one: "Hello",
  two: "Hi"
};
```

Then define the select knob like so:

```reason
let greeting = Knobs.select(~label="Greeting", ~options, ~defaultValue=options.one, ());
```

### Button

```reason
Knobs.button(
  ~label="Knob Button",
  ~handler=Action.action("Clicked the knob button"),
  ()
)
```

### Object

```reason
let obj = Knobs.object_(~label="User", ~defaultValue={"color": "grey"}, ());
```

### Js.Dict

> https://bucklescript.github.io/bucklescript/api/Js.Dict.html

```reason
let options =
  Js.Dict.fromArray([|
    ("Red", "red"),
    ("Blue", "blue"),
    ("Yellow", "yellow"),
    ("None", ""),
  |]);

let color =
  Knobs.selectFromDict(
    ~label="MySelection",
    ~options,
    ~defaultValue="red",
    (),
  );
```

### Array

```reason
let color =
  Knobs.selectFromArray(
    ~label="MySelection",
    ~options=[|"red", "blue", "yellow"|],
    ~defaultValue="red",
    (),
  );
```
