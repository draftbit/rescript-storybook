open Storybook

let default = CSF.make(~title="Reason CSF Story", ~decorators=[Knobs.withKnobs], ())

let renderButton = () => <MyButton />
renderButton->CSF.addMeta(~name="render plain button", ())

let knobTest = () => {
  let name = Knobs.text(~label="Name", ~defaultValue="Kyle", ())
  let age = Knobs.number(
    ~label="Age",
    ~defaultValue=37.,
    ~range={range: false, min: 19., max: 50., step: 1.},
    (),
  )

  let content =
    "I am " ++ (name ++ (" and I am " ++ (age->Belt.Float.toInt->Belt.Int.toString ++ " old")))
  <span onClick={Action.action("Test")}> {content->React.string} </span>
}
