# Blinky! A simply CLI for search

## Notes

The aim of this process is simplicity and separation of concerns.
As such, I used Interactors.
These are simple ways to divide up a chain of process into discrete sections with a fail fast approach.
Interactors hold a *context* which allows information about the process to be chained together.

The main process configures the required files, and uses an Organizer to chain 3 interactors.
These are `Validator`, `Loader` and `Actor`.

The `Validator` ensures that the environment is good, the data directory exists and has the required data files.
In the course of its operation, it also checks to see if the files are valid JSON.
It also checks that the size of the file is under 10,000 rows.

> There is a section where the incoming JSON should be validated to ensure the required fields are present.
> A `TODO` is included to indicate the need.

The `Loader` takes the JSON provided, and uses the *models* to load the data into rows.
After loading the data into each models rows, a visual table is displayed with statistics.

The `Actor` inputs and actions various user options. 
Currently this includes `users`, `tickets` and `organizations` for tabular output.
Additional commands allow control over the output.
These are:

1. `summary` => Show limited data about a model
2. `full` => Show complete data about a model
3. `deep` => From a model, show data extended information about associated models
4. `shallow` => Only show the model data

The code makes use of meta-programming to allow easy extensibility.
For example, the `Blinky::User` model `extend`s `GroupMethods`.
`GroupMethods` has a series of class methods that are common across models that are not model specific.

 


## Usage

To run the app:

`clear;export BLINKY_DATA_HOME='./data'; ruby blinky.rb`

This validates the environment, loads the data, displays 
some statistics and provides an input prompt.

The data includes tickets, organizations and users. 

Valid input prompts are:

`[group] [field_name] [criteria]`

Examples:

`users name rose newton`

| Input | Meaning |
| ----- | --------|
| deep  | Extend the search to include extra detail |
| shallow | Only show the main objects data |
| summary | Limit the output to include only meaningful data |
| full | Show all data for an object |


## Testing

`clear;bundle exec rspec`

Will run tests in the `spec` directory.
