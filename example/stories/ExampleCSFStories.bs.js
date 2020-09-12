

import * as React from "react";
import * as MyButton from "../src/MyButton.bs.js";
import * as Storybook from "../bindings/Storybook.bs.js";
import * as AddonActions from "@storybook/addon-actions";
import * as React$1 from "@storybook/addon-knobs/react";

var $$default = Storybook.CSF.make("Reason CSF Story", undefined, [React$1.withKnobs], undefined, undefined, undefined, /* () */0);

function renderButton(param) {
  return React.createElement(MyButton.make, { });
}

Storybook.CSF.addMeta(renderButton, "render plain button", undefined, undefined, /* () */0);

function knobTest(param) {
  var name = Storybook.Knobs.text("Name", "Kyle", /* () */0);
  var age = React$1.number("Age", 37, {
        range: false,
        min: 19,
        max: 50,
        step: 1
      });
  var content = "I am " + (name + (" and I am " + (String(age | 0) + " old")));
  return React.createElement("span", {
              onClick: AddonActions.action("Test")
            }, content);
}

export {
  $$default ,
  $$default as default,
  renderButton ,
  knobTest ,
  
}
/* default Not a pure module */
