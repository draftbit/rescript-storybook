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
