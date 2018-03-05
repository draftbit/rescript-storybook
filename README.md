# bs-storybook

BuckleScript bindings for Storybook.js! The goal of this project is to provide bindings for the main Storybook API, as well as the official add-ons. Currently it supports:
 * [actions](https://github.com/storybooks/storybook/tree/master/addons/actions)
 * [knobs](https://github.com/storybooks/storybook/tree/master/addons/knobs)
 * [addons API](https://storybook.js.org/addons/writing-addons/)

## Getting Started

After installing this package, add it to your `bsconfig.json` as a dependency.

Get Storybook up and running according to their docs. This library does not attempt to provide a way to configure storybook in Reason - just use the standard JS configs.

In your `/.storybook/config.js`, import your stories from wherever your compiled Reason modules end up. For example, if you're writing your stories inside a `__stories__` directory, and `bsb` is configured for a standard build, you might do something like:

```javascript
const req = require.context('../lib/js', true, /\__stories__\/.*.js$/)
configure(() => {
  req.keys().forEach(module => {
    req(module).default();
  })
}, module)
```

Note that in the above example, we're assuming the convention of each module containing a function as the `default` export. We'll account for that when writing our stories in the next section.

## Writing a story

Here's a basic story in its entirety:

```reason
open BsStorybook.Main;

let _module = [%bs.raw "module"];

let default = () => {
  let myStory =
    createStory(~title="My First Reason Story", ~decorators=[], ~_module, ());
  myStory.add(
    "first chapter",
    () => <span> (ReasonReact.stringToElement("Hello bs-storybook!")) </span>
  )
};
```

Storybook uses a reference to the `module` global provided by webpack to facilitate hot-reloading. We'll access that via the `[%bs.raw]` decorator. We're also wrapping the story definition in a `default` function to make it work with the way we've configured storybook. There's nothing enforcing this convention - you can choose to use another export name if you'd like.

We create a story using `createStory`, and pass it the story's title, any decorators we'd like to use (in the above example, we're not using any), and the module reference we created.

From there, we can add to the story using essentially the same API as the JS version of storybook: call `add()` and pass a string + a function that returns a React element.

## The Actions Addon

The action addon's API is essentially unchanged from its JS implementation:

```reason
let clickAction = Action.action("I Clicked The Button!");
```

## The Knobs Addon

To use knobs, be sure to add the decorator to your story definition:

```reason
let knobsStory =
	createStory(~title="Hey look, knobs!", ~decorators=[Knobs.withKnobs], ~_module, ());
```

Each knob type is invoked using a function with labeled arguments, and each requires passing `unit` as the final argument. They all share a `~label` argument, and a `~defaultValue` argument (where appropriate);

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
		~rangeConfiguration={min: 0., max: 10., step: 1.},
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

Not yet implemented.

### Array

Not yet implemented.
