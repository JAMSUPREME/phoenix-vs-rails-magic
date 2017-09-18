
### Demystifying the magic (Rails vs. Phoenix)

Asking ourselves if Elixir and Phoenix add greater clarity to our code than Ruby and Rails.

Justin Spencer ([@jamsupreme](https://twitter.com/jamsupreme))

+++

### Questions policy

For the sake of time and productivity, I request a few courtesies regarding questions:

- Feel free to interject with clarifying questions:
  - "Where is this file?"
  - "What is that variable named?"
- Please hold onto broad questions until the end of a section or the presentation
  - "Why implement it this way?"
  - "How can I apply this to my legacy codebase?"

---

### Nesting vs. Pipes

Let's contrast traditional Object Oriented Programming (objects using objects) with something more functional (a pipeline of functions)

+++?code=snippets/nesting_vs_pipes.rb&lang=ruby

@[1-10](A piece of code that calculates the expense of adopting a pet)
@[12-21](Helper private method)
@[24-36](Plain old data)
@[38-47](Code for calculating sales)
@[49-55](External API that determines sale)
@[57-64](Code for discounts)
@[66-72](Caller code)

+++

### Let's look at our call stack

- PetAdoptionService
  - Pet (Cat)
  - SaleService
    - Pet (Cat)
    - PetsApi
  - Discounter
  
- Bigger stack and often split out into several private methods.
- Some things are in the model, some in the service, some elsewhere.
- Some things are static (self) methods, others are not.

### What if we imagine it as a series of steps?

- Get base price for pet
- Change price depending on pet size
- Modify price if there is a sale
- Calculate discounts


+++?code=snippets/nesting_vs_pipes.exs&lang=elixir

@[1-10](A piece of code that calculates the expense of adopting a pet)
@[13-25](Plain old data)
@[27-32](Code that was previously lumped into service)
@[34-38](Code for calculating sales)
@[40-43](Code previously lumped into sales service)
@[45-52](Code for discounts)

+++

### Reflections

- If we had to change the order of discount processing (dollar discounts before percentages, etc.) which would be easier? 
- If we had to make our code flexible enough to deal with percentages, flat discounts, combination discounts, etc. which way would be easier to refactor? 
- Would this result in simpler testing, less stubbing? 

Note: 
 - Think about shifting pipe order vs. modifying methods, children, and their tests
 - Thinking about types
 - Think about dependencies in each class and testing in isolation vs. altogether