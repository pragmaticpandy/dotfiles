# Java-Class -- Instances of the class Class represent classes and interfaces in a running Java application.
{:data-section="shell"}
{:data-date="April 18, 2019"}
{:data-extra="Um Pages"}

## Getting the name of a class
Generally, these are the rules:

* Use getSimpleName() for the unqualified name.
* Use getCanonicalName() for the qualified name.
* For anonymous classes, see this stack overflow post:
    * https://stackoverflow.com/a/15203417
* For arrays, see the JavaDoc:
    * https://docs.oracle.com/javase/8/docs/api/java/lang/Class.html

### Examples
`int.class.getSimpleName()`
: int

`String.class.getSimpleName()`
: String

`int.class.getCanonicalName()`
: int

`String.class.getCanonicalName()`
: java.lang.String

