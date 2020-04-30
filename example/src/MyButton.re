[@react.component]
let make = () => {
  let style =
    ReactDOMRe.Style.make(
      ~display="inline-block",
      ~border="solid black thin",
      ~padding="4px",
      (),
    );
  <div style> "Hi"->React.string </div>;
};
