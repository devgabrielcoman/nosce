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
      init(json: NSDictionary)

      // have default implementation
      init(json: String)
      init(json: NSData)
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

      init(json: NSDictionary) {
        name <- json["name"]
        age <- json["age"]
        hasClearance <- json["hasClearance"]
        isTrusted <- json["isTrusted"]
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

The first thing you'll notice is the ** <- ** operator. This is a shorthand Nosce operator that is equivalent to the following
swift line of code:

.. code-block:: swift

    if let name = json["name"] {
      self.name = name
    }

The ** <- ** operator takes care of matching types and handling optionals, so you'll get a much nicer and concise syntax.

The ** <- ** operator can also be substituted for the ** = ** operator in a lot of scenarios.
Thus, if you'd like to keep a uniform syntax you could:

.. code-block:: swift

	name <- json["name"]
	someValue <- false
	someObject <- Object()

Another thing to notice is that **dictionaryRepresentation** returns a NSDictionary object. This means it can't hold optional
values whatsoever.

Also, if your model contains swift optionals, then an elegant way of handling this is as seen above:

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

      init(json: NSDictionary) {
        name <- json["name"]
        salary <- json["salary"]
        isTemp <- json["isTemp"]
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

      init(json: NSDictionary) {
        name <- json["name"]
        if let dict = json["postion"] as? NSDictionary {
          position <- Position(json: dict)
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

and risk trying to assign an uninitialized optional as a value to the dictionary.

Arrays
^^^^^^

Nosce support serialization and deserialization for arrays, in a number of scenarios, using the same type of
functions as for complex objects.

An array can be serialized using the following functions:

.. code-block:: swift

	let array = [13, 12, 189, 33]

	let dict = array.dictionaryRepresentation ()
	let json1 = array.jsonPrettyStringRepresentation ()
	let json2 = array.jsonCompactStringRepresentation ()
	let data = array.jsonDataRepresentation ()

This works just as well for simple arrays, containing Ints or Strings, as well as for arrays comprising complex objects.
The only general rule is that those objects conform and implement the **NosceSerializationProtocol**.

.. code-block:: swift

	struct Position : NosceSerializationProtocol {
	  var name: String?
	  var salary: Int?

	  init(name: String, salary: Int) {
	  	self.name = name
		self.position = position
	  }

	  init(json: NSDictionary) {
	  	name <- json["name"]
		salary <- json["salary"]
	  }
	}

	let p1 = Position(name: "CEO", salary: 100000)
	let p2 = Position(name: "Engineer", salary: 35000)
	let array = [p1, p2]

	let jsonArray = array.dictionaryRepresentation ()
	let jsonString = array.jsonPreetyStringRepresentation ()

When it comes to deserialization, Nosce provides the same three types of initializer as for normal objects:

.. code-block:: swift

	Array<Element>(json: NSArray)
	Array<Element>(json: String)
	Array<Element>(json: NSData)

so you can have the following valid syntax:

.. code-block:: swift

	let p1 = "{ \"name\": \"CEO\", \"salary\": 100000 }"
	let p2 = "{ \"name\": \"Engineer\", \"salary\": 35000 }"
	let p = "[\(p1), \(p2)]"

	let array = Array<Position>(json: p) { (dict: NSDictionary) -> Position in
	  return Position(json: dict)
	}

which will generate an array of valid Position objects.

Putting it all together
^^^^^^^^^^^^^^^^^^^^^^^

Finally, a more complex example, gathering everything the library does so far:

.. code-block:: swift

	struct Position : NosceSerializationProtocol, NosceDeserializationProtocol {
	  var name: String?
	  var salary: Int?

	  init(json: NSDictionary) {
		name <- json["name"]
		salary <- json["salary"]
	  }

	  func dictionaryRepresentation () -> NSDictionary {
		return [
		  "name": name ?? NSNull(),
		  "salary": salary ?? NSNull()
		]
	  }
	}

	class Employee : NosceSerializationProtocol, NosceDeserializationProtocol {
	  var name: String?
	  var permanent: Bool = true
	  var current: Position?
	  var positions: [Position] = []

	  init(json: NSDictionary) {
		name <- json["name"]
		permanent <- json["permanent"]
		if let dict = json["current"] as? NSDictionary {
		  current <- Position(json: dict)
		}
		positions <- Array<Position>(json["positions"]) { (dict: NSDictionary) -> Position in
		  return Position(json: dict)
		}
	  }

	  func dictionaryRepresentation () -> NSDictionary {
	    return [
		  "name": name ?? NSNull(),
		  "permanent": permanent,
		  "current": safe(current).dictionaryRepresentation (),
		  "positions": positions.dictionaryRepresentation ()
		]
	  }
	}

	class Company : NosceSerializationProtocol, NosceDeserializationProtocol {
	  var name: String?
	  var employees: [Employee] = []

	  init(json: NSDictionary) {
	    name <- json["name"]
		employees <- Array<Employee>(json["employees"]) { (dict: NSDictionary) -> Employee in
		  return Employee(json: dict)
		}
	  }

	  func dictionaryRepresentation () -> NSDictionary {
	    return [
		  "name": name ?? NSNull(),
		  "employees": employees.dictionaryRepresentation ()
		]
	  }
	}
