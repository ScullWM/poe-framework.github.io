---
layout: documentation
current_menu: middlewares
---

# Middlewares

In Poe, everything is a middleware. Even the [highest component] (the `Application`) you will use is a middleware. As said before, we chose to
not follow the [PSR-15] for practical reason: we don't want to introduce an heavy object-oriented model over a simple
concept.

To define a middleware, you will only have to follow **three rules**: 

* a middleware is a callable,
* it takes two arguments, a [context] and a _next_ callable,
* it returns a `Generator`.

You are free to define it as a function:

```php
<?php

namespace Me\Myself;

use Poe\Context;

function middleware(Context $context, callable $next) : \Generator
{
    // Do whatever you want here
    
    yield from $next();
    
    // Do whatever you want here
}
```

But you can also define is as a class:
 
```php
<?php

namespace Me\Myself;

use Poe;
use Poe\Context;

class Middleware implements Poe\Middleware
{
    public function __invoke(Context $context, callable $next) : \Generator
    {
        // Do whatever you want here
        
        yield from $next();
        
        // Do whatever you want here
    }    
}
```

As you can see, we are implementing the `Poe\middleware` interface: keep in mind that this is totally optionnal. A 
middleware is **just a callable** which produce a `Generator` and consumes a `Generator`. 
 
[highest component]: /middlewares/application.html
[PSR-15]: http://www.php-fig.org/psr/psr-15/
[context]: context.html