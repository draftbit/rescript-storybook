type section

type webpackModule

type chapter = unit => React.element

type decorator = chapter => React.element

@val @module("@storybook/react")
external storiesOf: (string, webpackModule) => section = "storiesOf"

@send external add: (section, string, chapter) => section = "add"

@send external addDecorator: (section, decorator) => section = "addDecorator"
