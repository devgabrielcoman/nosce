Nosce
=====

.. image:: https://img.shields.io/cocoapods/v/Nosce.svg?style=flat
.. image:: https://img.shields.io/badge/language-swift2.2-f48041.svg?style=flat
.. image:: https://img.shields.io/badge/platform-ios-lightgrey.svg
.. image:: https://img.shields.io/badge/license-GNU-blue.svg


Nosce is a library created to help you streamline as much as possible the process of serialization and deserialization
of complex models or arrays of models into and from NSDictionary, JSON String objects and NSData objects.

Install
^^^^^^^

You can install the library via `CocoaPods <http://cocoapods.org/>`_:

You'll need to modify your **Podfile** to add it:

.. code-block:: shell

	use_frameworks!

	target 'MyProject' do
	  pod 'Nosce'
	end

Import
^^^^^^

You can include the library into any file by adding the following line at the top of your .swift file:

.. code-block:: swift

	import Nosce

Serialization
^^^^^^^^^^^^^

Nosce defines the following protocol to handle serialization:


.. code-block:: swift

    public protocol NosceSerializationProtocol {
      // must be implemented by user
      func dictionaryRepresentation () -> NSDictionary

      // have default implementation
      func jsonPrettyStringRepresentation () -> String?
      func jsonCompactStringRepresentation () -> String?
      func jsonDataRepresentation () -> NSData?
    }

The **NosceSerializationProtocol** can be applied to any class or struct, whether it descends from NSObject or not.
It defines four important functions, but users will generally need to implement only **dictionaryRepresentation**.
The other three functions are also available , butNosce provides a default implementation,
one that usually uses **dictionaryRepresentation** to create
a valid JSON dictionary, and then convert it into a String or a NSData object using Cocoa Serialization APIs.

Deserialization
^^^^^^^^^^^^^^^

Nosce defines the following protocol to handle deserialization:

.. code-block:: swift

    public protocol NosceDeserializationProtocol {
      // must be implemented by user
      init(jsonDictionary: NSDictionary)

      // have default implementation
      init(jsonString: String)
      init(jsonData: NSData)
      func isValid() -> Bool
    }

The **NosceDeserializationProtocol** can also be applied to any class or struct, whether it descends from NSObject or not.
It defines three custom constructors, that each take either a NSDictionary, a String or a NSData object as only parameter.
Users will only need to implement the NSDictionary constructor. The other two constructors are also available, but will
use the NSDictionary constructor as base.

Lastly, there is an *isValid* functions used to validate what has already been deserialized. This should be used in scenarios where
the model being parsed from JSON must have a certain number of fields correctly populated for it to be considered valid.

Simple example
^^^^^^^^^^^^^^

The simplest use case is when you want to transform a single object into the equivalent JSON model and back:

.. code-block:: swift

    class Model {
      var name: String?
      var age: Int = 0
      var hasClearance: Bool?
      var isTrusted: Bool = false
    }

This model must implement the two protocols mentioned above, and implement the JSON Dictionary functions:

.. code-block:: swift

    class Model : NosceSerializationProtocol, NosceDeserializationProtocol {
      var name: String?
      var age: Int = 0
      var hasClearance: Bool?
      var isTrusted: Bool = false

      init(jsonDictionary: NSDictionary) {
        name <- jsonDictionary["name"]
        age <- jsonDictionary["age"]
        hasClearance <- jsonDictionary["hasClearance"]
        isTrusted <- jsonDictionary["isTrusted"]
      }

      func dictionaryRepresentation () -> NSDictionary {
        return [
          "name": name ?? NSNull(),
          "age": age,
          "hasClearance": hasClearance ?? NSNull(),
          "isTrusted": isTrusted
        ]
      }
    }

The first thing you'll notice is the **<-** operator. This is a shorthand Nosce operator that is equivalent to the following
swift line of code:

.. code-block:: swift

    if let name = jsonDictionary["name"] {
      self.name = name
    }

The **<-** operator takes care of matching types and handling optionals, so you'll get a much nices and concise syntax.

You can however do the actual parsing from the dictionary any way you see fit, as long as it's valid.

Another thing to notice is that **dictionaryRepresentation** returns a NSDictionary object. This means it can't hold optional
values whatsoever.

If your model contains swift optionals, then an elegant way of handling this is as seen above:

.. code-block:: swift

    "name": name ?? NSNull()

Also, please make sure you don't explicitly unwrap optionals by using the **!** operator, since you'll end up causing an error
somewhere down the line, if a NULL value ever happens to be set in a NSDictionary.

Advanced example
^^^^^^^^^^^^^^^^

When you have a more complex example, involving two nested models:

.. code-block:: swift

	struct Positon : NosceSerializationProtocol, NosceDeserializationProtocol {
      var name: String?
      var salary: Int?
      var isTemp: Bool = false

      init(jsonDictionary: NSDictionary) {
        name <- jsonDictionary["name"]
        salary <- jsonDictionary["salary"]
        isTemp <- jsonDictionary["isTemp"]
      }

      dictionaryRepresentation() -> NSDictionary {
        return [
          "name": name ?? NSNull()
          "salary": salary ?? NSNull(),
          "isTemp": isTemp
        ]
      }
    }

    class Employee : NosceSerializationProtocol, NosceDeserializationProtocol {
      var name: String?
      var position: Position?

      init(jsonDictionary: NSDictionary) {
        name <- jsonDictionary["name"]
        if let dict = jsonDictionary["postion"] as? NSDictionary {
          position = Position(jsonDictionary: dict)
        }
      }

      dictionaryRepresentation() -> NSDictionary {
        return [
          "name": name ?? NSNull(),
          "position": safe(position).dictionaryRepresentation ()
        ]
      }
    }

Please note the **safe** function, applied to the **position** optional struct instance.
This is so that you avoid having to do:

.. code-block:: swift

    "position": position!.dictionaryRepresentation ()

and risk trying to assign an unitialized optional as a value to the dictionary.

Arrays
^^^^^^

For the moment, Nosce support array serialization (not deserialization):

.. code-block:: swift

    // data set
    let position1 = Position(name: "CEO", salary: 100000)
    let position2 = Position(name: "Engineer", salary: 35000)
    let position3 = Position(name: "Accountant", salary: 28000)
    let positions = [position1, position2,  position3]

    // serialization
    let arrayDictionary = positions.dictionaryRepresentation ()
    let arrayString = positions.jsonPreetyStringRepresentation ()

If you have a complex model containing arrays, you can implement it's **dictionaryRepresentation** function by also
taking advantage of the array's own **dictionaryRepresentation** function to array at a convenient, readable syntax:

.. code-block:: swift

    class Person : NosceSerializationProtocol {
      var name: String?
      var positions: [Position] = []

      func dictionaryRepresentation () -> NSDictionary {
        return [
          "name": name ?? NSNull(),
          "positions": positions.dictionaryRepresentation ()
        ]
      }
    }

The above will work for arrays of complex objects like **Position**, in this case, or for simple arrays containing integers, strings, etc.

On the other hand, if you would like to deserialize, an array, Nosce comes with a built-in operator to help you do that:

.. code-block:: swift

    class Person: NosceDeserializationProtocol {
      var name: String?
      var positions: [Position] = []

      init(jsonDictionary: NSDictionary) {
        name <- jsonDictionary["name"]
        positions <- jsonDictionary["positions"] => { (dict: NSDictionary) -> Position in
          return Position(jsonDictionary: dict)
        }
      }
    }
