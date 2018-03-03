type decoratedChapter = Main.chapter => Main.chapter;

[@bs.module "@storybook/addon-notes"]
external withNotes : string => decoratedChapter =
  "";
