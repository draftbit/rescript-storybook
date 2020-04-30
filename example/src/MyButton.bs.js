

import * as React from "react";

function MyButton(Props) {
  var style = {
    border: "solid black thin",
    display: "inline-block",
    padding: "4px"
  };
  return React.createElement("div", {
              style: style
            }, "Hi");
}

var make = MyButton;

export {
  make ,
  
}
/* react Not a pure module */
