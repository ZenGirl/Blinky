# Blinky! A simply CLI for search

This is a simple CLI program to handle the ZenDesk code challenge.
The original PDF is in the `docs` directory.

## Usage

Download gems:

`cd to folder; bundle install`

To run the app:

`clear;export BLINKY_DATA_HOME='./data'; ruby blinky.rb`

This validates the environment, loads the data, displays 
some statistics and provides an input prompt.

The data includes tickets, organizations and users. 

Valid input prompts are:

`[group] [field_name] [criteria]`

Examples:

You can quit by entering "quit" at the prompt.

There are 3 "groups": users, organizations and tickets.

Groups can be searched by entering a phrases like:

-  users _id 5
-  users name Rose Newton
-  tickets priority high
-  tickets _id 436bf9b0-1147-4c0a-8439-6f79833bff5b
-  organizations name nutralab

There are several "status" commands shown below. 

Status examples:

| command | meaning |
| ------- | ------- |
| help      | Display this message |
| stats     | Show current groups and row totals |
| summary   | Summarize the tabulated output horizontally |
| full      | Show full details vertically |
| deep      | Show extended details e.g. users organization |
| shallow   | Do not show extended details |



## Notes

The aim of this process is simplicity and separation of concerns.
As such, I used Interactors.
These are simple ways to divide up a chain of process into discrete sections with a fail fast approach.
Interactors hold a *context* which allows information about the process to be chained together.

> Having spent a couple of hours writing the base of the code, I realized that I was spending too much 
> time extending the functionality. As such, I stopped, as I believed that I had proved the basic
> code ability.

> Obviously if this was a real world project I would spend far more time cleaning and refactoring.
> Specifically the models as they need some TLC.

> Also the testing needs extending.
> Due to the use of meta-programming, the tests would get quite... er... complex.
> I chose not to do it, as the code shows my approach.

> I made a mistake in using uppercase for the sub-folder `Blinky` instead of `blinky`.
> Sigh. My bad.

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

## Trade-offs and missing functionality

I could extend the tests and functionality indefinitely.
I stopped as I had spent 6 hours on the code and I believe that it shows the approach I use.
The same is true of the number of rows in each model/file.
At present the code fails fast if the file is over 10,000 rows.
Obviously I would use a DB in a real world case.


## Testing

`clear;bundle exec rspec`

Will run tests in the `spec` directory.
