Nosce
=====

.. image:: https://img.shields.io/cocoapods/v/Nosce.svg?style=flat
.. image:: https://img.shields.io/badge/language-swift2.2-f48041.svg?style=flat
.. image:: https://img.shields.io/badge/platform-ios-lightgrey.svg
.. image:: https://img.shields.io/badge/license-GNU-blue.svg


Nosce is a library created to automate as much as possible the process of serialization and deserialization of
complex model objects (or arrays of model objects) into and from NSDictionary, JSON String objects and NSData objects.

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

Usage: Object to JSON serialization
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The simplest use case is when you want to transform a single object into the equivalent JSON model.

.. code-block:: swift

	class Model {
	  var name: String?
	  var age: Int = 0
	}

	let model = Model(name: "John", age: 23)

	// returns a pretty JSON string
	let json = serialize(model, format: .toPrettyJSON)

The result will be:

.. code-block:: json

	{
		"name": "John",
		"age": 23
	}

The serialize function has the following definition:

.. code-block:: swift

	public func serialize<T>(model: T, format: SerializationFormat) -> Any


**model** can be any type supported by swift. Usual candidates are complex objects or arrays of objects. These can have
member variables of type Int, Float, String, etc., but also tuples, enums, dictionaries, other complex objects or arrays of different kinds.
The function will also try to work with value based struct values or enums. It will also try to unwrap any optionals encountered. When there
is no value, it will replace it with a NSNull object.

**format** is an enum with the following values:

 * toDictionary - returns a NSDictionary representation of the complex model
 * toCompactJSON - returns a compact JSON string representation of the complex model
 * toPrettyJSON - returns a pretty printed JSON string representation
 * toNSData - returns a NSData object representation

If you have a more complex object hierarchy:

.. code-block:: swift

	struct Period {
	  var startYear: Int = 0
	  var endYear: Int?
	  var isActive: Bool = true
	}

	class Employee: NSObject {
	  var name: String?
	  var age: Int = 0
	  var salary: Int?
	  var benefits: [(name: String, val: Bool)]?
	  var period: Period?
	}

	class Company: NSObject {
	  var name: String?
	  var employees: [Employee] = []
	}

And you initialize your model space with some data:

.. code-block:: swift

	// populate first employee
	let employee1 = Employee()
	employee1.name = "John"
	employee1.age = 23
	employee1.salary = 23000
	employee1.benefits = [
	  (name: "medical", value: true),
	  (name: "daycare", value: false)
	]
	employee1.period = Period()
	employee1.period.startYear = 2013

	// populate second employee
	let employee2 = Employee()
	employee2.name = "Jane"
	employee2.age = 30
	employee2.salary = 45000
	employee2.benefits = [
	  (name: "medical", value: true),
	  (name: "daycare", value: true)
	]
	employee2.period = Period()
	employee2.period.startYear = 2010
	employee2.period.endYear = 2015
	employee2.period.isActive = false

	// now add employees to the company
	let company = Company(name: "Example Ltd.", employees: [emp1, emp2])

Applying the **serialize** function you can transform the **company** object into the
equivalent desired representation:

.. code-block:: swift

	// returns a NSDictionary
	let dictionary = serialize(company, format: .toDictionary)

	// returns a Strin
	let prettyJSON = serialize(company, format: .toPrettyJSON)

	// also returns a String
	let compactJSON = serialize(company, format: .toCompactJSON)

	// returns a NSData object
	let dataJSON = serialize(company, format: .toNSData)

And the result will be:

.. code-block:: json

	{
	  "name": "Example Ltd.",
	  "employees": [
	  	{
		  "name": "John",
		  "age": 23,
		  "salary": 23000,
		  "benefits": [
		  	["medical", true],
			["daycare", false]
		  ],
		  "period": {
		  	"startYear": 2013,
			"endYear": "<null>",
			"isActive": true
		  }
		},
		{
		  "name": "Jane",
		  "age": 30,
		  "salary": 40000,
		  "benefits": [
		  	["medical", true],
			["daycare", true]
		  ],
		  "period": {
		  	"startYear": 2010,
			"endYear": 2015,
			"isActive": false
		  }
		}
	  ]
	}

Limitations: Object to JSON
^^^^^^^^^^^^^^^^^^^^^^^^^^^

The serialization function will try to obtain the best valid JSON it can.
It will work with complex objects, containing classes, structs, tuples, enum values, arrays or dictionaries.
Base object you can try on can descend from AnyObject, NSObject or no class at all.
Enum values will be saved as strings in the JSON.


Usage: JSON to Object
^^^^^^^^^^^^^^^^^^^^^

The reverse can be done as well:

Assuming you have the following JSON String:

.. code-block:: swift

	let json = "{\"name\":\"Example Ltd.\", \"employees\":[{\"name\":\"John\", \"age\": 23, \"salary\": 23000},{\"name\":\"Jane\", \"age\":30, \"salary\": 30000}]}"

You can transform to a model object like so:

.. code-block:: swift

	let company = deserialize(Company(), jsonString: json) as? Company
	print(company.name)
	print(company.employees.length)

And the result will be:

.. code-block:: shell

	Example Ltd.
	2

Limitations
^^^^^^^^^^^

The deserialization function is a little more limited than the serialization one, and you should follow
a set of specific guidelines:

 * all your classes must descend from NSObject
 * avoid enums or structs
 * try to be explicit about arrays or dictionaries. Prefer:


.. code-block:: swift

	var names:[String] = []
	var dict: [Int : Employee] = [:]

instead of

.. code-block:: swift

	var names: NSMutableArray
	let dict: NSDictionary
	let dict2: [Int : AnyObject]
