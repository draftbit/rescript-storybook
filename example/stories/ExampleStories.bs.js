

import * as React from "react";
import * as Js_dict from "bs-platform/lib/es6/js_dict.js";
import * as MyButton from "../src/MyButton.bs.js";
import * as Storybook from "../bindings/Storybook.bs.js";
import * as React$1 from "@storybook/react";
import * as AddonActions from "@storybook/addon-actions";
import * as React$2 from "@storybook/addon-knobs/react";

var _module = module;

React$1.storiesOf("My First Reason Story", _module).addDecorator(React$2.withKnobs).add("render MyButton test", (function (param) {
                  return React.createElement(MyButton.make, { });
                })).add("text knob test", (function (param) {
                var name = Storybook.Knobs.text("Name", "Patrick", /* () */0);
                var age = React$2.number("Age", 30, {
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
              var obj = React$2.object("User", {
                    color: "grey"
                  });
              var style = {
                backgroundColor: obj.color
              };
              return React.createElement("div", {
                          style: style
                        }, "tes");
            })).add("color knob test", (function (param) {
            var color = React$2.color("myColor", "red");
            var style = {
              backgroundColor: color
            };
            return React.createElement("div", {
                        style: style
                      }, "tes");
          })).add("select knob test with an array as options", (function (param) {
          var color = React$2.select("MySelection", [
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
              /* tuple */[
                "Red",
                "red"
              ],
              /* tuple */[
                "Blue",
                "blue"
              ],
              /* tuple */[
                "Yellow",
                "yellow"
              ],
              /* tuple */[
                "None",
                ""
              ]
            ]);
        var color = React$2.select("MySelection", options, "red");
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

var Action = /* alias */0;

export {
  Action ,
  _module ,
  
}
/* _module Not a pure module */
