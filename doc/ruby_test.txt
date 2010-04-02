*unit test ruby*        Ruby Unit testing guidelines

from http://en.wikibooks.org/wiki/Ruby_Programming/Unit_Testing, 06/2008
Ruby Programming/Unit testing
From Wikibooks, the open-content textbooks collection
< Ruby Programming(Redirected from Ruby Programming/Unit Testing)
Jump to: navigation, search

← Exceptions | RubyDoc →Unit testing is a great way to catch minor errors early in the development process, if you dedicate time to writing appropriate and useful tests. As in other languages, Ruby provides a framework for setting up, organizing, and running tests called Test::Unit.

Specifically, Test::Unit provides three basic functionalities:

   1. A way to define basic pass/fail tests.
   2. A way to gather like tests together and run them as a group.
   3. Tools for running single tests or whole groups of tests.

Contents
[hide]

    * 1 A Simple Introduction
    * 2 Available Assertions
    * 3 Structuring and Organizing Tests
          o 3.1 Naming Conventions
          o 3.2 Running Specific Tests
          o 3.3 Setup and Teardown
    * 4 Exercises
    * 5 External Links
    * 6 Sample Code
          o 6.1 SimpleNumber

[edit] A Simple Introduction

Let's start with an example to test my new class SimpleNumber (source for this class included at the bottom of this page).

require "simpleNumber"
require "test/unit"

class TestSimpleNumber < Test::Unit::TestCase

 def test_simple
    assert_equal(4, SimpleNumber.new(2).add(2) )
    assert_equal(6, SimpleNumber.new(2).multiply(3) )
  end

end

Which produces

>> ruby tc_simpleNumber.rb
Loaded suite tc_simpleNumber
Started
.
Finished in 0.002695 seconds.

1 tests, 2 assertions, 0 failures, 0 errors

So what happened here? We defined a class TestSimpleNumber which inherited from Test::Unit::TestCase. In TestSimpleNumber we defined a member function called test_simple. That member function contains a number of simple assertions which exercise my class. When we run that class (note I haven't put any sort of wrapper code around it -- it's just a class definition), the tests are automatically run, and we're informed that we've run 1 test and 2 assertions.

Let's try a more complicated example.

require "simpleNumber"
require "test/unit"

class TestSimpleNumber < Test::Unit::TestCase

  def test_simple
    assert_equal(4, SimpleNumber.new(2).add(2) )
    assert_equal(4, SimpleNumber.new(2).multiply(2) )
  end

  def test_typecheck
    assert_raise( RuntimeError ) { SimpleNumber.new('a') }
  end

  def test_failure
    assert_equal(3, SimpleNumber.new(2).add(2), "Adding doesn't work" )
  end

end

>> ruby tc_simpleNumber2.rb
Loaded suite tc_simpleNumber2
Started
F..
Finished in 0.038617 seconds.

  1) Failure:
test_failure(TestSimpleNumber) [tc_simpleNumber2.rb:16]:
Adding doesn't work.
<3> expected but was
<4>.

3 tests, 4 assertions, 1 failures, 0 errors

Now there are three tests (three member functions) in the class. The function test_typecheck uses assert_raise to check for an exception. The function test_failure is set up to fail, which the Ruby output happily points out, not only telling us which test failed, but how it failed (expected <3> but was <4>). On this assertion, we've also added an final parameters which is a custom error message. It's strictly optional but can be helpful for debugging. All of the assertions include their own error messages which are usually sufficient for simple debugging.

[edit] Available Assertions

Test::Unit provides a rich set of assertions, which are documented thoroughly at Ruby-Doc. Here's a brief synopsis (assertions and their negative are grouped together. The text description is usually for the first one listed -- the names should make some logical sense):
assert( boolean, [message] )  True if boolean
assert_equal( expected, actual, [message] )
assert_not_equal( expected, actual, [message] )   True if expected == actual
assert_match( pattern, string, [message] )
assert_no_match( pattern, string, [message] )   True if string =~ pattern
assert_nil( object, [message] )
assert_not_nil( object, [message] )   True if object == nil
assert_in_delta( expected_float, actual_float, delta, [message] )   True if (actual_float - expected_float).abs <= delta
assert_instance_of( class, object, [message] )  True if object.class == class
assert_kind_of( class, object, [message] )  True if object.kind_of?(class)
assert_same( expected, actual, [message])
assert_not_same( expected, actual, [message] )  True if actual.equal?( expected ).
assert_raise( Exception,... ) {block}
assert_nothing_raised( Exception,...) {block}   True if the block raises (or doesn't) one of the listed exceptions.
assert_throws( expected_symbol, [message] ) {block}
assert_nothing_thrown( [message] ) {block}  True if the block throws (or doesn't) the expected_symbol.
assert_respond_to( object, method, [message] )  True if the object can respond to the given method.
assert_send( send_array, [message] )  True if the method sent to the object with the given arguments return true.
assert_operator( object1, operator, object2, [message] )  Compares the two objects with the given operator, passes if true

[edit] Structuring and Organizing Tests

Tests for a particular unit of code are grouped together into a test case, which is a subclass of Test::Unit::TestCase. Assertions are gathered in tests, member functions for the test case whose names start with test_. When the test case is executed or required, Test::Unit will iterate through all of the tests (finding all of the member functions which start with test_ using reflection) in the test case, and provide the appropriate feedback.

Test case classes can be gathered together into test suites which are Ruby files which require other test cases:

# File: ts_allTheTests.rb
require 'test/unit'
require 'testOne'
require 'testTwo'
require 'testThree'

In this way, related test cases can be naturally grouped. Further, test suites can contain other test suites, allowing the construction of a hierarchy of tests.

This structure provides relatively fine-grained control over testing. Individual tests can be run from a test case (see below), a full test case can be run stand-alone, a test suite containing multiple cases can be run, or a suite of suites can run, spanning many test cases.

[edit] Naming Conventions

The author of Test::Unit, Nathaniel Talbott, suggests starting the names of test cases with tc_ and the names of test suites with ts_

[edit] Running Specific Tests

It's possible to run just one (or more) tests out of a full test case:

>> ruby -w tc_simpleNumber2.rb --name test_typecheck 
Loaded suite tc_simpleNumber2
Started
.
Finished in 0.003401 seconds.

1 tests, 1 assertions, 0 failures, 0 errors

[edit] Setup and Teardown

There are many cases where a small bit of code needs to be run before and/or after each test. Test::Unit provides the setup and teardown member functions, which are run before and after every test (member function).

require "simpleNumber"
require "test/unit"

class TestSimpleNumber < Test::Unit::TestCase

  def setup
    @num = SimpleNumber.new(2)
  end

  def teardown
    ## Nothing really
  end

  def test_simple
    assert_equal(4, @num.add(2) )
  end

  def test_simple2
    assert_equal(4, @num.multiply(2) )
  end

end

>> ruby tc_simpleNumber3.rb
Loaded suite tc_simpleNumber3
Started
..
Finished in 0.00517 seconds.

2 tests, 2 assertions, 0 failures, 0 errors

[edit] Exercises

[edit] External Links

    * Test::Unit documentation at Ruby-Doc

[edit] Sample Code

[edit] SimpleNumber

class SimpleNumber

  def initialize( num )
    raise if !num.is_a?(Numeric)
    @x = num
  end

  def add( y )
    @x + y
  end

  def multiply( y )
    @x * y
  end

end

