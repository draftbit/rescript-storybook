type section;

type webpackModule;

type chapter = unit => ReasonReact.reactElement;

type decorator = chapter => ReasonReact.reactElement;

[@bs.val] [@bs.module "@storybook/react"]
external storiesOf : (string, webpackModule) => section = "";

[@bs.send] external add : (section, string, chapter) => section = "";

[@bs.send] external addDecorator : (section, decorator) => section = "";
