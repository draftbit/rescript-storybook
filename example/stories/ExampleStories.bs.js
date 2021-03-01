

import * as React from "react";
import * as Js_dict from "bs-platform/lib/es6/js_dict.js";
import * as MyButton from "../src/MyButton.bs.js";
import * as Storybook from "../bindings/Storybook.bs.js";
import * as React$1 from "@storybook/react";
import * as AddonKnobs from "@storybook/addon-knobs";
import * as AddonActions from "@storybook/addon-actions";

var _module = module;

React$1.storiesOf("My First Reason Story", _module).addDecorator(AddonKnobs.withKnobs).add("render MyButton test", (function (param) {
                  return React.createElement(MyButton.make, {});
                })).add("text knob test", (function (param) {
                var name = Storybook.Knobs.text("Name", "Patrick", undefined);
                var age = AddonKnobs.number("Age", 30, {
                      range: false,
                      min: 19,
                      max: 50,
                      step: 1
                    });
                var content = "I am " + (name + (" and I am " + (String(age | 0) + " old")));
                return React.createElement("span", {
                            onClick: AddonActions.action("Test")
                          }, content);
              })).add("object knob test with Js.t", (function (param) {
              var obj = AddonKnobs.object("User", {
                    color: "grey"
                  });
              var style = {
                backgroundColor: obj.color
              };
              return React.createElement("div", {
                          style: style
                        }, "tes");
            })).add("color knob test", (function (param) {
            var color = AddonKnobs.color("myColor", "red");
            var style = {
              backgroundColor: color
            };
            return React.createElement("div", {
                        style: style
                      }, "tes");
          })).add("select knob test with an array as options", (function (param) {
          var color = AddonKnobs.select("MySelection", [
                "red",
                "blue",
                "yellow"
              ], "red");
          var style = {
            color: color
          };
          return React.createElement("div", {
                      style: style
                    }, "Selected color: " + color);
        })).add("select knob test with a Dict as options", (function (param) {
        var options = Js_dict.fromArray([
              [
                "Red",
                "red"
              ],
              [
                "Blue",
                "blue"
              ],
              [
                "Yellow",
                "yellow"
              ],
              [
                "None",
                ""
              ]
            ]);
        var color = AddonKnobs.select("MySelection", options, "red");
        var style = {
          color: color
        };
        return React.createElement("div", {
                    style: style
                  }, "Selected color: " + color);
      }));

React$1.storiesOf("My Second Reason Story", _module).add("first chapter", (function (param) {
        return React.createElement("span", {
                    onClick: AddonActions.action("Test")
                  }, "HI");
      }));

var Action;

export {
  Action ,
  _module ,
  
}
/* _module Not a pure module */
