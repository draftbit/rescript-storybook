type actionHandler('a) = 'a => unit;

[@bs.val] [@bs.module "@storybook/addon-actions"]
external action : string => actionHandler('a) = "";