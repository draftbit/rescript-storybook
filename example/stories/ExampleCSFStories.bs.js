

import * as React from "react";
import * as MyButton from "../src/MyButton.bs.js";
import * as Storybook from "../bindings/Storybook.bs.js";
import * as AddonKnobs from "@storybook/addon-knobs";
import * as AddonActions from "@storybook/addon-actions";

var $$default = Storybook.CSF.make("Reason CSF Story", undefined, [AddonKnobs.withKnobs], undefined, undefined, undefined, undefined);

function renderButton(param) {
  return React.createElement(MyButton.make, {});
}

Storybook.CSF.addMeta(renderButton, "render plain button", undefined, undefined, undefined);

function knobTest(param) {
  var name = Storybook.Knobs.text("Name", "Kyle", undefined);
  var age = AddonKnobs.number("Age", 37, {
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
