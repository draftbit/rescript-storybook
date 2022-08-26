open Storybook

open Story

module Action = Storybook.Action

let _module = %raw("module")

storiesOf("My First Reason Story", _module)
->addDecorator(Knobs.withKnobs)
->add("render MyButton test", () => <MyButton />)
->add("text knob test", () => {
  let name = Knobs.text(~label="Name", ~defaultValue="Patrick", ())
  let age = Knobs.number(
    ~label="Age",
    ~defaultValue=30.,
    ~range={range: false, min: 19., max: 50., step: 1.},
    (),
  )

  let content =
    "I am " ++ (name ++ (" and I am " ++ (age->Belt.Float.toInt->Belt.Int.toString ++ " old")))
  <span onClick={Action.action("Test")}> {content->React.string} </span>
})
->add("object knob test with Js.t", () => {
  let obj = Knobs.object_(~label="User", ~defaultValue={"color": "grey"}, ())

  let style = ReactDOM.Style.make(~backgroundColor=obj["color"], ())

  <div style> {"tes"->React.string} </div>
})
->add("color knob test", () => {
  let color = Knobs.color(~label="myColor", ~defaultValue="red", ())

  let style = ReactDOM.Style.make(~backgroundColor=color, ())

  <div style> {"tes"->React.string} </div>
})
->add("select knob test with an array as options", () => {
  let color = Knobs.selectFromArray(
    ~label="MySelection",
    ~options=["red", "blue", "yellow"],
    ~defaultValue="red",
    (),
  )

  let style = ReactDOM.Style.make(~color, ())

  <div style> {("Selected color: " ++ color)->React.string} </div>
})
->add("select knob test with a Dict as options", () => {
  let options = Js.Dict.fromArray([
    ("Red", "red"),
    ("Blue", "blue"),
    ("Yellow", "yellow"),
    ("None", ""),
  ])

  let color = Knobs.selectFromDict(~label="MySelection", ~options, ~defaultValue="red", ())

  let style = ReactDOM.Style.make(~color, ())

  <div style> {("Selected color: " ++ color)->React.string} </div>
})
->ignore

storiesOf("My Second Reason Story", _module)
->add("first chapter", () => <span onClick={Action.action("Test")}> {"HI"->React.string} </span>)
->ignore
