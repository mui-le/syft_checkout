## Challenge

-------------------------------------------
our client is an online marketplace, here is a sample of some of the products available on our site:

```
Product code  | Name                   | Price
----------------------------------------------------------
001           | Lavender heart         | £9.25
002           | Personalised cufflinks | £45.00
003           | Kids T-shirt           | £19.95
```

Our marketing team want to offer promotions as an incentive for our customers to purchase these items.

If you spend over £60, then you get 10% of your purchase
If you buy 2 or more lavender hearts then the price drops to £8.50.

Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.

The interface to our checkout looks like this (shown in Ruby):

```
  co = Checkout.new(promotional_rules)
  co.scan(item)
  co.scan(item)
  price = co.total
```

Implement a checkout system that fulfills these requirements.

```
Test data
---------
Basket: 001,002,003
Total price expected: £66.78

Basket: 001,003,001
Total price expected: £36.95

Basket: 001,002,001,003
Total price expected: £73.76
```

## Code

The code was developed using docker container with the following stack
- ruby 2.6.3
- rspec 3.8

It should work in other versions but it was not tested.

### Implementation design

As it seems, the checkout is a stand-alone process and will work as a service, although no interface was provided, the assumption was the checkout process will work given a set of rules and products do not need to care where they are stored or test any other consistency in layers.

Due to that reason, I decided to keep all these records (PromotionalRule and Product) in-memory, for this test they are provided via YAML file. In a production scenario it should goes via a provided interface - HTTP, Message Broker, etc.

### Considerations
There is no rule to prevent stacked promotional rules, meaning, if there are two discounts to the cart, eg. 10% and 20%, it will apply both, it was not described as a requirement and the assumption was it will be filtered before the Checkout initialization.

### Testing
The development was based on docker containers - please check Dockerfile - and here are the step-by-step to reproduce the tests. Again, it should work on any other environment but it was not tested. Also, I'm assuming docker is already installed.

Clone the repo:
```
$ git clone https://github.com/ml-vilela/syft_checkout.git
```

Change to the project directory
```
$ cd syft_checkout
```

Build the image
```
$ docker build -t ruby-rspec:2.6.3 .
```

Execute the test
```
$ docker run -it -v `pwd`:'/app' ruby-rspec:2.6.3 rspec specs/
```

All should pass:
```
docker run -it -v `pwd`:'/app' ruby-rspec:2.6.3 rspec specs/
............


Finished in 0.40362 seconds (files took 0.61794 seconds to load)
12 examples, 0 failures
```
