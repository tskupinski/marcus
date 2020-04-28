# Marcus - Command Line Vending Machine

Time spent on coding: a little over 8 hours (not counting README preparation)

(I decided to tinker a bit around the application state for the 8 hour mark can be found on the 'Add README file' commit
which has a hash starting with d4c6ea1b66b0d24f6)

## Acceptence criteria

Implement vending machine according to this instructions:

- Once an item is selected and the appropriate amount of money is inserted, the vending machine should return the correct product
- It should also return change if too much money is provided, or ask for more money if insufficient funds have been inserted
- The machine should take an initial load of products and change. The change will be of denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2
- There should be a way of reloading either products or change at a later point
- The machine should keep track of the products and change that it contains

## Running the application

To run Marcus you will need to have Ruby 2.7.0 installed and bundler.
1. Clone the repository

2. Install dependencies

```
bundle install
```

3. Launch the application with:

```
ruby main.rb
```

4. Use `help` command while in the application to preview avaliable commands

## Approach

While developing this application, I started by modeling the vending machine and related objects while pushing the decision
to start working on the interface for as long as I could. At some point, I decided that it would be cool to implement
a bot-like interface for the machine, and that's when the idea to build it around commands was born. At this state, these
commands could use some more work to be less procedural. There are definitely some objects hiding in there, and some of
the responsibilities could be delegated to existing parts of the application. Therefore I am happy with the idea, but
the execution could use some work (I tried not to push time limit more - I have extended it over suggested 5 hours as it is).

## Areas for improvement


- There is definitely a place for a Printer/Display object in the Marcus. It's the missing link that would aggregate all the printing methods and allow for better test design and cleaner implementation. This would be my first change if given more time.
  (I already implemented this point after 8 hours time mark)
- There is definitely too much going on in the Insert command - I would look for ways to simplify it and push some more responsibilities into objects
- I would like to avoid raising errors and try to find a place for NullObjects in the application, which will cover corner cases
- Some of the specs definitely could use unification - I am aware that specs are not as consistent as they should be if I had some time to fix this, I would remove most of lets and subjects and keep the setup in the example to describe behavior better
- Currently, there are some spots were tests are coupled with implementation too much. I want to fix this.
- At this moment commands are taking in the machine, treasury, and inventory as parameters it's not the best solution
  but I wanted to avoid passing Marcus in and calling those objects from his accessors - that's something that might use
  some time to rethink
- It would be nice to separate maintenance mode from the normal one.
- When change is being passed to Treasury to subtract coins, it is currently just an Array of Ints, and I would like it to be Array of coins
- Change calculation method could use some refactoring to make it more readable and clean
- Not code related but the application is named after one of the Borderlands game characters, and when it comes to printing output it should definitely be more Marcus-like
- One of the biggest questions was how I should handle the product and coin quantity. In the end, I decided to keep it as an object attribute, but if I were to develop this app in the future I would probably explore different solutions, there might be a room for another level of abstraction like CoinHolder (for Coins), or Shelf (for Products)
- Price should be unified, currently there are places where it is displayed in pennies and sometimes in pounds
