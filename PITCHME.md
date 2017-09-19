
### Demystifying the magic 
#### (Rails vs. Phoenix)

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
  
+++

### What we **won't** cover

- Intro to Ruby or Elixir
- Intro to Rails or Phoenix
- Deep dive into the above

If you're not familiar with any, don't worry, the concepts still largely apply.

+++

### What we **will** cover

- Code that often seems like [evil] "magic" to those unaccustomed to Ruby/Rails
- Ways that Elixir avoids magic (if you want)
- Pondering how magic can be minimized in our Ruby code
- Contemplating the advantages/disadvantages of each language and framework

+++

### Before we begin / Disclaimers

- Ruby/Elixir comparison, then Rails/Phoenix comparison
- Some code may be exaggerated in complexity for didactic purposes
- I do not consider myself a Ruby/Rails expert, much less so for Elixir/Phoenix
- After each big section is a **Reflections** slide with a few things to think about

---

### Nesting vs. Pipes
#### Ruby vs. Elixir

Let's contrast traditional Object Oriented Programming (objects using objects) with something more functional (a pipeline of functions)

+++

<div>
  <div class="left-column">
    <img src="https://www.playerattack.com/imagery/2010/08/AngryBirds-Nest.jpg" alt="nest" />
  </div>
  <div class="right-column">
    <img src="https://reichanjapan.files.wordpress.com/2016/02/super-mario-3d-world.png" alt="pipe" />
  </div>
</div>

+++?code=snippets/nesting_vs_pipes.rb&lang=ruby

@[1-10](A piece of code that calculates the expense of adopting a pet)
@[12-21](Helper private method)
@[24-36](Plain old data)
@[38-51](Code for calculating sales)
@[53-60](External API that determines sale)
@[62-73](Code for discounts)
@[75-82](Caller code)

+++

### Let's look at our call stack

- PetAdoptionService
  - Pet (Cat)
  - SaleService
    - Pet (Cat)
    - PetsApi
  - Discounter
  
+++

### What's not to like?
  
- Bigger stack and often split out into several private methods.
- Some things are in the model, some in the service, some elsewhere.
- Some things are static (self) methods, others are not.

+++

### What if we imagine it as a series of steps?

- Get base price for pet
- Change price depending on pet size
- Modify price if there is a sale
- Calculate discounts


+++?code=snippets/nesting_vs_pipes.exs&lang=elixir

@[1-10](A piece of code that calculates the expense of adopting a pet)
@[13-25](Plain old data)
@[27-35](Code that was previously lumped into service)
@[37-41](Code for calculating sales)
@[43-47](Code previously lumped into sales service)
@[49-58](Code for discounts)

+++

### Reflections

- If we had to change the order of discount processing (dollar discounts before percentages, etc.) which would be easier? 
- If we had to make our code flexible enough to deal with percentages, flat discounts, combination discounts, etc. which way would be easier to refactor? 
- Would this result in simpler testing, less stubbing? 

Note: 
 - Think about shifting pipe order vs. modifying methods, children, and their tests
 - Thinking about types
 - Think about dependencies in each class and testing in isolation vs. altogether
 
---

### The beauty of plugs and pipelines
#### Rails vs. Phoenix

With our newfound knowledge of how pipes stack up against objects, let's see how this applies to web development with Phoenix and Plugs.

+++?code=snippets/plugs.rb&lang=ruby

+++?code=snippets/plugs.exs&lang=elixir

+++

### Reflections:

- If we had to shift around before_actions / plugs, in which context would it be easier?
- Should plugs and/or before actions be reliant on other actions/plugs?
- Is it easier to look at a pipeline or a class hierarchy of actions?
- Can rails actions be tested in isolation?
- What do we gain from the "halted" idiom?

---

### Types and pattern matching
#### *(who needs 'em?)*
#### Ruby vs. Elixir

Let's contrast some free-spirited Ruby code with its Elixir counterpart.

+++

![pattern tips](https://i.ytimg.com/vi/_JWWclKKgZ8/maxresdefault.jpg)

+++?code=snippets/patterns_and_specs.rb&lang=ruby

+++?code=snippets/patterns_and_specs.exs&lang=elixir


+++

### Reflections:

- Is the Elixir code more affine to signature modifications?
- Is code clarity improved? Documentation? Does the Dialyzer incline us more?

---

### What is it called again?
#### *(Params and variables)*
#### Rails vs. Phoenix

Armed with our knowledge of pattern matching, let's see how this applies to our web controllers.

+++

![what](http://i0.kym-cdn.com/entries/icons/facebook/000/018/489/nick-young-confused-face-300x256_nqlyaa.jpg)

+++?code=snippets/params_and_vars.rb&lang=ruby

+++?code=snippets/params_and_vars.exs&lang=elixir

+++

### Reflections:

- Is it preferable to have an explicit signature or a blanket `params`?
- What are the advantages of explicit assignments?
- Does this simplify testing?

---

### Help me!
#### *(Helpers, Concerns, and so on...)*
#### Rails vs. Phoenix

Are helpers really that helpful?

+++

![lost](http://p.fod4.com/p/media/a87c8cb843/mRluNDklT1mSqS675Akp_c13.gif)

+++?code=snippets/helpers.rb&lang=ruby

+++?code=snippets/helpers.exs&lang=elixir

+++

### Reflections:

- How are we dodging the Rails pitfall with helpers and concerns?
- Would it be a problem if "everything" was a plug? Would that be any worse than the Rails alternative?

---

### To magic, or not to magic?

![wizard](https://images-cdn.9gag.com/photo/386037_700b.jpg)

+++

We've seen some comparisons of Ruby and Elixir, as well as how those differences impact the respective Rails and Phoenix frameworks.

I hope to leave you with a few final thoughts (regardless of your tech stack):

- Am I writing "magical" code?
- If I come back to this code after 6 months, how long will it take to ramp up?
- How easy it is to maintain my code?

---

### Resources

This presentation:
https://github.com/JAMSUPREME/phoenix-vs-rails-magic

This presentation on gitpitch:
https://gitpitch.com/jamsupreme/phoenix-vs-rails-magic