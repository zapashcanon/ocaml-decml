# `DecML`: A Library and PPX Extension for Abductive Decoupling

`DecML` is an OCaml library and PPX preprocessor for building and optimising
numerical models. DecML allows models to be written as OCaml functions in which
parameters are explicitly indicated. The model can then be decoupled from its
parameters to obtain the collection of parameters used in the model and a
*parameterised* function for instantiating the model with a given collection of
parameters.

The `DecML` library contains functions for optimising a collection of parameters
for a given model with respect to a particular data set.

For example, the following code creates a linear regression model and then fits
it to a given data set using `DecML`'s built-in gradient descent:

```ocaml
open Decml
open   Model
open   Optimise

let%model linear x = ([%pc 1] *. x) +. [%pc 0]

let model =
  let%decouple (model, params) = linear in
  let params =
    grad_desc ~loss_f:mse ~rate:0.00001 ~threshold:1.0 ~epochs:50000 ~model
      params data in
  rebind model params
```

`DecML` makes building supervised learning models simple because it handles
model parameters automatically when combining models. Moreover, it uses OCaml's
type system to ensure that parameterised models can only be rebound with the
parameter collections from which they were decoupled.

## Depedencies

DecML depends on the following OCaml packages:

* `ocaml-migrate-parsetree`
* `jbuilder`
* `containers`
* `csv`

## Building and Installing

DecML is compiled using `jbuilder`. The PPX preprocessor is written using the
`ocaml-migrate-parsetree` package, and so it should be portable across compiler
versions.