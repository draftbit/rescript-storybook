module Story = {
  type section;

  type webpackModule;

  type chapter = unit => ReasonReact.reactElement;

  type decorator = chapter => ReasonReact.reactElement;

  [@bs.module "@storybook/react"]
  external storiesOf: (string, webpackModule) => section;

  [@bs.send] external add: (section, string, chapter) => section;

  [@bs.send] external addDecorator: (section, decorator) => section;
};

module Main = {
  type chapter = unit => ReasonReact.reactElement;

  type section;

  [@bs.module "@storybook/react"]
  external storiesOf: (string, 'a) => section;

  [@bs.send] external extAdd: (section, string, chapter) => unit = "add";

  type decorator = chapter => ReasonReact.reactElement;

  [@bs.send] external addDecorator: (section, decorator) => unit;

  type webpackModule;

  type chapterAdd = (string, chapter) => unit;

  type story = {add: chapterAdd};

  let createStory =
      (
        ~title: string,
        ~decorators: list(decorator),
        ~_module: webpackModule,
        (),
      )
      : story => {
    let story = storiesOf(title, _module);
    List.iter(dec => addDecorator(story, dec), decorators);
    {add: (name: string, c: chapter) => extAdd(story, name, c)};
  };
};

module Notes = {
  type decoratedChapter = Main.chapter => Main.chapter;

  [@bs.module "@storybook/addon-notes"]
  external withNotes: string => decoratedChapter;
};

module Knobs = {
  [@bs.module "@storybook/addon-knobs/react"]
  external withKnobs: Main.decorator;

  [@bs.module "@storybook/addon-knobs/react"]
  external extText: (string, Js.null_undefined(string)) => string = "text";

  let text = (~label: string, ~defaultValue: option(string)=?, ()) =>
    extText(label, Js.Nullable.fromOption(defaultValue));

  [@bs.module "@storybook/addon-knobs/react"]
  external extBoolean: (string, bool) => bool = "boolean";

  let boolean = (~label: string, ~defaultValue=false, ()) =>
    extBoolean(label, defaultValue);

  type rangeConfig = {
    range: bool,
    min: float,
    max: float,
    step: float,
  };

  [@bs.module "@storybook/addon-knobs/react"]
  external number:
    (~label: string, ~defaultValue: float, ~range: rangeConfig=?, unit) =>
    float =
    "number";

  [@bs.module "@storybook/addon-knobs/react"]
  external object_:
    (~label: string, ~defaultValue: Js.t('a), unit) => Js.t('a) =
    "object";

  [@bs.module "@storybook/addon-knobs/react"]
  external color: (~label: string, ~defaultValue: string=?, unit) => string =
    "color";

  type selectConfig('a) = 'a;

  [@bs.module "@storybook/addon-knobs/react"]
  external select:
    (
      ~label: string,
      ~options: selectConfig('a),
      ~defaultValue: string,
      unit
    ) =>
    string =
    "select";

  [@bs.module "@storybook/addon-knobs/react"]
  external selectFromArray:
    (~label: string, ~options: array('a), ~defaultValue: string, unit) => 'a =
    "select";

  [@bs.module "@storybook/addon-knobs/react"]
  external selectFromDict:
    (~label: string, ~options: Js.Dict.t('a), ~defaultValue: string, unit) =>
    'a =
    "select";

  [@bs.module "@storybook/addon-knobs/react"]
  external selectFromAny:
    (~label: string, ~options: 'a, ~defaultValue: string, unit) => 'a =
    "select";

  [@bs.module "@storybook/addon-knobs/react"]
  external extDate: (string, Js.null_undefined(Js_date.t)) => string = "date";

  let date = (~label: string, ~defaultValue: option(Js_date.t)=?, ()) =>
    extDate(label, Js.Nullable.fromOption(defaultValue));

  type button;

  [@bs.module "@storybook/addon-knobs/react"]
  external extButton: (string, ReactEvent.Mouse.t => unit) => button =
    "button";

  let button = (~label: string, ~handler: ReactEvent.Mouse.t => unit, ()) =>
    extButton(label, handler);
};

module Addons = {
  type t;

  type api;

  type channel;

  type callback = api => unit;

  type channelListener = string => unit;

  type panelConfig = {
    .
    "title": string,
    "render": unit => ReasonReact.reactElement,
  };

  [@bs.module "@storybook/addons"] external addons: t = "default";

  [@bs.send] external register: (t, string, callback) => unit = "register";

  [@bs.send] external addPanel: (t, string, panelConfig) => unit = "addPanel";

  [@bs.send] external getChannel: (t, unit) => channel = "getChannel";

  [@bs.send] external emitChannel: (channel, string, string) => unit = "emit";

  [@bs.send]
  external onChannel: (channel, string, channelListener) => unit = "on";

  [@bs.send]
  external removeChannelListener: (channel, string, channelListener) => unit =
    "removeListener";

  [@bs.send] external onStory: (api, unit => unit) => unit = "onStory";
};

module Action = {
  type actionHandler('a) = 'a => unit;

  [@bs.module "@storybook/addon-actions"]
  external action: string => actionHandler('a);
};

module CSF = {
  type csfStory = unit => React.element;
  type decorator = csfStory => React.element;

  type csfMetaData('params) = {
    title: string,
    component: Js.Nullable.t(unit => React.element),
    decorators: Js.Nullable.t(array(decorator)),
    parameters: Js.Nullable.t('params),
    includeStories: Js.Nullable.t(array(string)),
    excludeStories: Js.Nullable.t(array(string)),
  };

  type storyMetadata('params) = {
    name: Js.Nullable.t(string),
    decorators: Js.Nullable.t(array(decorator)),
    parameters: Js.Nullable.t('params),
  };

  /**
   * Bucklescript renames a variables called `default` to `$$default` and exports that as well.
   */
  let bsExports = [|"$$default"|];

  [@bs.set]
  external story: (csfStory, storyMetadata('params)) => unit = "story";

  let make =
      (
        ~title,
        ~component=?,
        ~decorators=?,
        ~parameters=?,
        ~includeStories=?,
        ~excludeStories=?,
        (),
      ) => {
    title,
    component: component->Js.Nullable.fromOption,
    decorators: decorators->Js.Nullable.fromOption,
    parameters: parameters->Js.Nullable.fromOption,
    includeStories: includeStories->Js.Nullable.fromOption,
    excludeStories:
      excludeStories
      ->Belt.Option.mapWithDefault(bsExports, es =>
          es->Js.Array2.concat(bsExports)
        )
      ->Js.Nullable.return,
  };

  let addMeta = (csfStory, ~name=?, ~decorators=?, ~parameters=?, ()) =>
    csfStory->story({
      name: name->Js.Nullable.fromOption,
      decorators: decorators->Js.Nullable.fromOption,
      parameters: parameters->Js.Nullable.fromOption,
    });
};
