type csfStory = unit => React.element
type decorator = csfStory => React.element

type csfMetadata<'params> = {
  title: string,
  component: Js.Nullable.t<unit => React.element>,
  decorators: Js.Nullable.t<array<decorator>>,
  parameters: Js.Nullable.t<'params>,
  includeStories: Js.Nullable.t<array<string>>,
  excludeStories: Js.Nullable.t<array<string>>,
}

type storyMetadata<'params> = {
  name: Js.Nullable.t<string>,
  decorators: Js.Nullable.t<array<decorator>>,
  parameters: Js.Nullable.t<'params>,
}

@ocaml.doc("
  * Bucklescript renames a variables called `default` to `$$default` and exports that as well.
  ")
let bsExports = ["$$default"]

@set
external story: (csfStory, storyMetadata<'params>) => unit = "story"

let make = (
  ~title,
  ~component=?,
  ~decorators=?,
  ~parameters=?,
  ~includeStories=?,
  ~excludeStories=?,
  (),
) => {
  title: title,
  component: component->Js.Nullable.fromOption,
  decorators: decorators->Js.Nullable.fromOption,
  parameters: parameters->Js.Nullable.fromOption,
  includeStories: includeStories->Js.Nullable.fromOption,
  excludeStories: excludeStories
  ->Belt.Option.mapWithDefault(bsExports, es => es->Js.Array2.concat(bsExports))
  ->Js.Nullable.return,
}

let addMeta = (csfStory, ~name=?, ~decorators=?, ~parameters=?, ()) =>
  csfStory->story({
    name: name->Js.Nullable.fromOption,
    decorators: decorators->Js.Nullable.fromOption,
    parameters: parameters->Js.Nullable.fromOption,
  })
