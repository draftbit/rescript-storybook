type actionHandler('a) = 'a => unit;

[@bs.module "@storybook/addon-actions"]
external action: string => actionHandler('a);
