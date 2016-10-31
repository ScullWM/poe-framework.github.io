---
layout: documentation
current_menu: principles
---

# Principles

Poe is highly inspired by the work done on popular HTTP frameworks, especially, [Express.js] and [Koa]. It also follows 
some **principles** which make it a modern an powerful framework:

* Everything is built on top of **standards** (PSR-*),
* Everything is a **[middleware]**,
* Everything is a **generator**.

## Standards

The PHP community has an active group which goal is to standardize components to ease interoperability. The [PHP-FIG]
already issued some specifications about interesting topics:

* PSR-1: [Basic Coding Standard]
* PSR-2: [Coding Style Guide]
* PSR-4: [Autoloading Standard]
* PSR-7: [HTTP Message Interface]
* PSR-11: [Container Interface] _(currently a draft)_

Poe is built on top of every PSR listed above. This is to make contribution and integration easier. There is one more 
PSR to come that we might have used: PSR-15 [HTTP Middlewares] _(currently a draft)_. We chose not to implement this
specification because it adds too much complexity for a simple middleware implementation. Let's see why and how we 
define **middlewares** in Poe.

## Middlewares

> HTTP middleware has been an important concept on other web development platforms for a good number of years, and 
> since the introduction of a formal HTTP Messages standard has been growing increasingly popular with web frameworks.
>
> — https://github.com/php-fig/fig-standards/blob/master/proposed/http-middleware/middleware.md

**Composing** middlewares to build applications is **a really powerful approach**. We can compose simple components to built 
a more complex application. Each of these components will have to **handle a simple task** which can be summed this up as:
  
> A middleware is something that takes a request (and a next) and produces a response.
>
> — Mathieu Napoli

Yes, this is as simple is that. The current state of the PSR-15 defines **a heavy object model** for such a simple task. 
Middleware implementors will have to make their middlewares compliant with two interfaces: the `MiddlewareInterface` and
the `DelegateInterface`. 

Within Poe, a middleware can be of one of the following form:

* A **class** that implements the `Poe\middleware` interface,
* A simple **callable**.

When called, the middleware will receive two arguments: the [context] and the _next_ callable. 

The first one, the [context] will allow the middleware to act on the request or the response, but not directly. The second 
one is just a simple function. When called it lets the current middleware trigger every other middlewares in the stack. 

This trigger **does not take any argument nor returns anything**. It just produces a **generator**.

## Generators

Why did we chose to build everything in Poe around generators?

Generators are one of the **newest PHP feature**. Basically, they are just a mean to **easily write iterators** but we 
can achieve much more than just that. Take a look at the [icicle] library for example, or at those [slides] _(fr)_.

As you may have seen generators allows us to write powerful things using **coroutines** and this is what we prepare for. 
In Poe every [middleware] is a generator, every _next_ is a generator and everything consumes other generators!

[Express.js]: http://expressjs.com/
[Koa]: http://koajs.com/
[middleware]: middlewares.html
[context]: context.html
[PHP-FIG]: http://www.php-fig.org/
[Basic Coding Standard]: http://www.php-fig.org/psr/psr-1/
[Coding Style Guide]: http://www.php-fig.org/psr/psr-2/
[Autoloading Standard]: http://www.php-fig.org/psr/psr-4/
[HTTP Message Interface]: http://www.php-fig.org/psr/psr-7/
[Container Interface]: http://www.php-fig.org/psr/psr-11/
[HTTP Middlewares]: http://www.php-fig.org/psr/psr-15/
[icicle]: https://icicle.io/
[slides]: https://speakerdeck.com/jubianchi/en-route-vers-le-multi-tache