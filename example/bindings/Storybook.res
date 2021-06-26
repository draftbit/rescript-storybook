module Story = {
  type section

  type webpackModule

  type chapter = unit => React.element

  type decorator = chapter => React.element

  @val @module("@storybook/react")
  external storiesOf: (string, webpackModule) => section = "storiesOf"

  @send external add: (section, string, chapter) => section = "add"

  @send external addDecorator: (section, decorator) => section = "addDecorator"
}

module Main = {
  type chapter = unit => React.element

  type section

  @val @module("@storybook/react")
  external storiesOf: (string, 'a) => section = "storiesOf"

  @send external extAdd: (section, string, chapter) => unit = "add"

  type decorator = chapter => React.element

  @send external addDecorator: (section, decorator) => unit = "addDecorator"

  type webpackModule

  type chapterAdd = (string, chapter) => unit

  type story = {add: chapterAdd}

  let createStory = (
    ~title: string,
    ~decorators: list<decorator>,
    ~_module: webpackModule,
    (),
  ): story => {
    let story = storiesOf(title, _module)
    List.iter(dec => addDecorator(story, dec), decorators)
    {add: (name: string, c: chapter) => extAdd(story, name, c)}
  }
}

module Notes = {
  type decoratedChapter = Main.chapter => Main.chapter

  @module("@storybook/addon-notes")
  external withNotes: string => decoratedChapter = "withNotes"
}

module Knobs = {
  @val @module("@storybook/addon-knobs/react")
  external withKnobs: Main.decorator = "withKnobs"

  @val @module("@storybook/addon-knobs/react")
  external extText: (string, Js.null_undefined<string>) => string = "text"

  let text = (~label: string, ~defaultValue: option<string>=?, ()) =>
    extText(label, Js.Nullable.fromOption(defaultValue))

  @val @module("@storybook/addon-knobs/react")
  external extBoolean: (string, bool) => bool = "boolean"

  let boolean = (~label: string, ~defaultValue=false, ()) => extBoolean(label, defaultValue)

  type rangeConfig = {
    range: bool,
    min: float,
    max: float,
    step: float,
  }

  @module("@storybook/addon-knobs/react")
  external number: (~label: string, ~defaultValue: float, ~range: rangeConfig=?, unit) => float =
    "number"

  @module("@storybook/addon-knobs/react")
  external object_: (~label: string, ~defaultValue: 'a, unit) => 'a = "object"

  @module("@storybook/addon-knobs/react")
  external color: (~label: string, ~defaultValue: string=?, unit) => string = "color"

  type selectConfig<'a> = 'a

  @module("@storybook/addon-knobs/react")
  external select: (
    ~label: string,
    ~options: selectConfig<'a>,
    ~defaultValue: string,
    unit,
  ) => string = "select"

  @module("@storybook/addon-knobs/react")
  external selectFromArray: (
    ~label: string,
    ~options: array<'a>,
    ~defaultValue: string,
    unit,
  ) => 'a = "select"

  @module("@storybook/addon-knobs/react")
  external selectFromDict: (
    ~label: string,
    ~options: Js.Dict.t<'a>,
    ~defaultValue: string,
    unit,
  ) => 'a = "select"

  @module("@storybook/addon-knobs/react")
  external selectFromAny: (~label: string, ~options: 'a, ~defaultValue: string, unit) => 'a =
    "select"

  @module("@storybook/addon-knobs/react")
  external extDate: (string, Js.null_undefined<Js_date.t>) => string = "date"

  let date = (~label: string, ~defaultValue: option<Js_date.t>=?, ()) =>
    extDate(label, Js.Nullable.fromOption(defaultValue))

  type button

  @val @module("@storybook/addon-knobs/react")
  external extButton: (string, ReactEvent.Mouse.t => unit) => button = "button"

  let button = (~label: string, ~handler: ReactEvent.Mouse.t => unit, ()) =>
    extButton(label, handler)
}

module Addons = {
  type t

  type api

  type channel

  type callback = api => unit

  type channelListener = string => unit

  type panelConfig = {"title": string, "render": unit => React.element}

  @module("@storybook/addons") external addons: t = "default"

  @send external register: (t, string, callback) => unit = "register"

  @send external addPanel: (t, string, panelConfig) => unit = "addPanel"

  @send external getChannel: (t, unit) => channel = "getChannel"

  @send external emitChannel: (channel, string, string) => unit = "emit"

  @send
  external onChannel: (channel, string, channelListener) => unit = "on"

  @send
  external removeChannelListener: (channel, string, channelListener) => unit = "removeListener"

  @send external onStory: (api, unit => unit) => unit = "onStory"
}

module Action = {
  type actionHandler<'a> = 'a => unit

  @val @module("@storybook/addon-actions")
  external action: string => actionHandler<'a> = "action"
}

module CSF = {
  type csfStory = unit => React.element
  type decorator = csfStory => React.element

  type csfMetaData<'params> = {
    title: string,
    component: Js.Nullable.t<unit => React.element>,
    decorators: Js.Nullable.t<array<decorator>>,
    parameters: Js.Nullable.t<'params>,
    includeStories: Js.Nullable.t<array<string>>,
    excludeStories: Js.Nullable.t<array<string>>,
  }

  type storyMetadata<'params> = {
    name: Js.Nullable.t<string>,
    decorators: Js.Nullable.t<array<decorator>>,
    parameters: Js.Nullable.t<'params>,
  }

  @ocaml.doc("
   * Bucklescript renames a variables called `default` to `$$default` and exports that as well.
   ")
  let bsExports = ["$$default"]

  @set
  external story: (csfStory, storyMetadata<'params>) => unit = "story"

  let make = (
    ~title,
    ~component=?,
    ~decorators=?,
    ~parameters=?,
    ~includeStories=?,
    ~excludeStories=?,
    (),
  ) => {
    title: title,
    component: component->Js.Nullable.fromOption,
    decorators: decorators->Js.Nullable.fromOption,
    parameters: parameters->Js.Nullable.fromOption,
    includeStories: includeStories->Js.Nullable.fromOption,
    excludeStories: excludeStories
    ->Belt.Option.mapWithDefault(bsExports, es => es->Js.Array2.concat(bsExports))
    ->Js.Nullable.return,
  }

  let addMeta = (csfStory, ~name=?, ~decorators=?, ~parameters=?, ()) =>
    csfStory->story({
      name: name->Js.Nullable.fromOption,
      decorators: decorators->Js.Nullable.fromOption,
      parameters: parameters->Js.Nullable.fromOption,
    })
}
