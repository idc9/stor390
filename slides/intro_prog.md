Programming in R
========================================================
author: STOR 390
date: 1/26/17
autosize: true

This lecture is about
========================================================
- conditionals (if/else)
- loops (for, while)
- how to define your own functions
- basic programming flow




References
========================================================
- section 19 ([functions](http://r4ds.had.co.nz/functions.html))
- 21.1-21.3



if statements
========================================================

```r
if (2 > 1) {
  print('fact')
}
```

```
[1] "fact"
```




if statements
========================================================


```r
if (2 < 1) {
  print('alternative fact')
}
```



if/else statements
========================================================

```r
# Flip a coin 
if (runif(1) < 0.5) {
    print('heads')
} else {
    print('tails')
}
```

```
[1] "tails"
```


else-if statements
========================================================

```r
r <- runif(1)
# rock paper sissors
if (r < 1/3) {
    print('rock')
} else if (1/3 < r && r < 2/3) {
    print('paper')
} else{
    print('scissors')
}
```

```
[1] "scissors"
```


Equality
========================================================

```r
2*5 == 10
```

```
[1] TRUE
```


Beware of finite precision arithmetic
========================================================

```r
# oops
sqrt(2)^2 == 2
```

```
[1] FALSE
```

Safety first
========================================================

```r
dplyr::near(sqrt(2)^2, 2)
```

```
[1] TRUE
```

Vectorized operations
========================================================

```r
c(1, 1, 1) == c(1, 2, 1)
```

```
[1]  TRUE FALSE  TRUE
```

Use the double symbol in for loops
========================================================

default to `&&` or `||` in a for loop

```r
c(T, T, T) || c(T, F, T)
```

```
[1] TRUE
```


Otherwise you get a vector
========================================================

```r
c(T, T, T) | c(T, F, T)
```

```
[1] TRUE TRUE TRUE
```

Loops
========================================================
- for
- while


for loops
========================================================

```r
for (i in 1:10) {
  print(i)
}
```

```
[1] 1
[1] 2
[1] 3
[1] 4
[1] 5
[1] 6
[1] 7
[1] 8
[1] 9
[1] 10
```


Pre-allocate memory 
========================================================

```r
nums <- vector("double", 10) # or rep(0, 10) or something else
for (i in 1:10) {
  nums[i] <- runif(1)
}
```

Dynamic allocation bad
========================================================

```r
# nums <- c()
# for (i in 1:10) {
#   nums <- c(nums, runif(1))
# }
```


while loops
========================================================

```r
current_position <- 10
n_iter <- 0
while (current_position > 0){
    current_position <- current_position + rnorm(1)
    n_iter <- n_iter + 1
}
print(paste0('you lost all your money after ', n_iter, ' trips to the casino'))
```

```
[1] "you lost all your money after 194 trips to the casino"
```


Infinite loops
========================================================

```r
while (TRUE){
    print('Duke sucks')
}
```

Vectorization
========================================================
Try to vectorize anything you can (once you learn what that means...)

```r
sapply(1:10, function(x) x * 2)
```

Functions are for humans and computers
========================================================
- break long program up into small chunks
- more readable
- code reuse
    - catch errors
    - don't have to copy/paste
- only need to fix code in one place

When to write a function?
========================================================
> You should consider writing a function whenever you’ve copied and pasted a block of code more than twice

Define a function
========================================================

```r
power <- function(num, exponent){
    # returns num raised to the exponent
    num ^ exponent
}

power(2, 3)
```

```
[1] 8
```

Default arguments
========================================================

```r
power <- function(num, exponent=3){
    # returns num raised to the exponent
    num ^ exponent
}

power(2)
```

```
[1] 8
```

Return values
========================================================

```r
random_rps <- function(){
    # randomly returns one of rock, paper or scissors
    
    r <- runif(1)
    # rock paper sissors
    if (r < 1/3) {
        return('rock')
    } else if (1/3 < r && r < 2/3) {
        return('paper')
    } else{
        return('scissors')
    }
}

random_rps()
```

```
[1] "scissors"
```

Write functions in separate scripts and import them
========================================================

```r
source('fun.R')

helper_fun()
```

```
[1] "Im not a very helpful helper function"
```

Michael Jordan
========================================================
**I basically know of two principles for treating complicated systems in
simple ways; the first is the principle of modularity and the second is the
principle of abstraction.** I am an apologist for computational probability
in machine learning, and particularly for graphical models and variational
methods, because I believe that probability theory implements these two
principles in deep and intriguing ways – namely through factorization and
through averaging. Exploiting these two mechanisms as fully as possible
seems to me to be the way forward in machine learning.

Michael I. Jordan Massachusetts Institute of Technology, 1997.

(quote borrowed from Ben Vigoda's thesis)

Modularity and abstraction
========================================================
- modularity
    - break a complicated task into many smaller sub-tasks
- abstraction
    - you don't need to  know the inner workings of every part of the system, just how things interact



More topics
========================================================
- testing
- vectorization
- recursion
- debugging / profiling
- environments / scoping
- object oriented programming
- functional programming
- non-standard evaluation
- dynamic programming
- memory usage
- using Rcpp


Vectors and lists
========================================================
- vectors are homogeneous and sequential (1 dimensional)
- lists are heterogeneous and hierarchical 

section 20 from r4ds

Vectors have a type
========================================================
boolean, character, complex, raw, integer and double

Integer vector
========================================================

```r
c(1,2,3) # 1:3
```

```
[1] 1 2 3
```

Boolean vector
========================================================

```r
# boolean
c(TRUE, FALSE, TRUE) 
```

```
[1]  TRUE FALSE  TRUE
```

Character vector
========================================================

```r
# string
c('I', 'wish', 'vectors', 'were', 'named', 'lists', 'instead')
```

```
[1] "I"       "wish"    "vectors" "were"    "named"   "lists"   "instead"
```


typeof
========================================================

```r
typeof(rep(TRUE, 4))
```

```
[1] "logical"
```



Question 1
========================================================
What are the types of the following vectors
https://goo.gl/forms/Rcpz7rQxUQPmc3Cu1


```r
# a
c(1, 2, 'three')

# b
c(TRUE, TRUE, "FALSE")

# c
c(1, 2, 3.1)
```

Explicit coercion
========================================================

```r
as.integer(c('1', '2', '3'))
```

```
[1] 1 2 3
```

Implicit coercion
========================================================

```r
c(1, 2, TRUE)
```

```
[1] 1 2 1
```

Vectorized operations and implicit coercion
========================================================

```r
sum(c(-2, -1, 1, 2) > 0)
```

```
[1] 2
```

Subsetting a vector
========================================================

```r
v <- 1:10
v[c(1,10)]
```

```
[1]  1 10
```

```r
v[v %%2 == 0]
```

```
[1]  2  4  6  8 10
```


Numbers to words
========================================================
Create the `numbers2words` function from https://github.com/ateucher/useful_code/blob/master/R/numbers2words.r




```r
numbers2words(312)
```

```
[1] "three hundred twelve"
```

Sub strings
========================================================


```r
substr('Iain', 2, 3)
```

```
[1] "ai"
```


Question 2
========================================================
How many numbers below 4869 are divisible by three and start with the letter n?

https://goo.gl/forms/VBt4BOHQZPdNrPJn2

```r
sum(1:4869 %% 3 == 0 & substr(numbers2words(1:4869), 1, 1) == 'n' )
```

```
[1] 39
```

Lists 
========================================================

Lists can contain objects of multiple types and are indexed by names (as opposed to index sequentially)

Make a list
========================================================

```r
L <- list(number=1, letter='a', bool=TRUE)
L
```

```
$number
[1] 1

$letter
[1] "a"

$bool
[1] TRUE
```

Access elements of a list with [[]]
========================================================
To access elements of a list use `[[]]` 

```r
L[['number']]
```

```
[1] 1
```

A single bracket returns a list
========================================================
you can use a single `[]` and this will return a list 

```r
L['number']
```

```
$number
[1] 1
```
see section 20.5.3 for the difference between [] and [[]]

Lists are hierarchical
========================================================

```r
LoL <- list(names = list('Iain', 'Brendan', 'Varun'),
            numbers=list(1:3, 1:5, 1:7))

LoL[['numbers']][[2]]
```

```
[1] 1 2 3 4 5
```




