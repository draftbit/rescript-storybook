

import * as List from "rescript/lib/es6/list.js";
import * as Belt_Option from "rescript/lib/es6/belt_Option.js";
import * as React from "@storybook/react";
import * as Js_null_undefined from "rescript/lib/es6/js_null_undefined.js";
import * as React$1 from "@storybook/addon-knobs/react";

var Story = {};

function createStory(title, decorators, _module, param) {
  var story = React.storiesOf(title, _module);
  List.iter((function (dec) {
          story.addDecorator(dec);
          
        }), decorators);
  return {
          add: (function (name, c) {
              story.add(name, c);
              
            })
        };
}

var Main = {
  createStory: createStory
};

var Notes = {};

function text(label, defaultValue, param) {
  return React$1.text(label, Js_null_undefined.fromOption(defaultValue));
}

function $$boolean(label, defaultValueOpt, param) {
  var defaultValue = defaultValueOpt !== undefined ? defaultValueOpt : false;
  return React$1.boolean(label, defaultValue);
}

function date(label, defaultValue, param) {
  return React$1.date(label, Js_null_undefined.fromOption(defaultValue));
}

function button(label, handler, param) {
  return React$1.button(label, handler);
}

var Knobs = {
  text: text,
  $$boolean: $$boolean,
  date: date,
  button: button
};

var Addons = {};

var Action = {};

var bsExports = ["$$default"];

function make(title, component, decorators, parameters, includeStories, excludeStories, param) {
  return {
          title: title,
          component: Js_null_undefined.fromOption(component),
          decorators: Js_null_undefined.fromOption(decorators),
          parameters: Js_null_undefined.fromOption(parameters),
          includeStories: Js_null_undefined.fromOption(includeStories),
          excludeStories: Belt_Option.mapWithDefault(excludeStories, bsExports, (function (es) {
                  return es.concat(bsExports);
                }))
        };
}

function addMeta(csfStory, name, decorators, parameters, param) {
  csfStory.story = {
    name: Js_null_undefined.fromOption(name),
    decorators: Js_null_undefined.fromOption(decorators),
    parameters: Js_null_undefined.fromOption(parameters)
  };
  
}

var CSF = {
  bsExports: bsExports,
  make: make,
  addMeta: addMeta
};

export {
  Story ,
  Main ,
  Notes ,
  Knobs ,
  Addons ,
  Action ,
  CSF ,
  
}
/* @storybook/react Not a pure module */
