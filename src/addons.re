type t;

type api;

type channel;

type callback = api => unit;

type channelListener = string => unit;

type panelConfig = {
  .
  "title": string,
  "render": unit => ReasonReact.reactElement
};

[@bs.module "@storybook/addons"] external addons : t = "default";

[@bs.send] external register : (t, string, callback) => unit = "register";

[@bs.send] external addPanel : (t, string, panelConfig) => unit = "addPanel";

[@bs.send] external getChannel : (t, unit) => channel = "getChannel";

[@bs.send] external emitChannel : (channel, string, string) => unit = "emit";

[@bs.send]
external onChannel : (channel, string, channelListener) => unit = "on";

[@bs.send]
external removeChannelListener : (channel, string, channelListener) => unit =
  "removeListener";

[@bs.send] external onStory : (api, unit => unit) => unit = "onStory";
