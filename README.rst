Nosce
=====

.. image:: https://img.shields.io/cocoapods/v/Nosce.svg?style=flat
.. image:: https://img.shields.io/badge/language-swift2-f48041.svg?style=flat


Nosce is a JSON serialization / deserialization library that tries to automagically transform complex objects (or arrays of objects) into valid JSON and back.

Current version is **0.2.2 (Beta)**

Install
^^^^^^^

Installing the library is done via `CocoaPods <http://cocoapods.org/>`_:

You will need to modify your **Podfile** to add the library.

.. code-block:: shell

	use_frameworks!

	target 'MyProject' do
	  pod 'Nosce'
	end

Include
^^^^^^^

You can include the library into any file by adding the following line at the top of your .swift file:

.. code-block:: swift

	import Nosce

Usage: Object to JSON
^^^^^^^^^^^^^^^^^^^^^

Assume you have a hierarchy of objects as in the following example:

.. code-block:: swift

	class Employee: NSObject {
	  var name: String?
	  var age: Int = 0
	  var salary: Int?

	  override public init() {
	    super.init()
	  }
	}

	class Company: NSObject {
	  var name: String?
	  var employees: [Employee] = []

	  override public init() {
	    super.init()
	  }
	}

And you initialize your model space with some data:

.. code-block:: swift

	let employee1 = Employee()
	employee1.name = "John"
	employee1.age = 23
	employee1.salary = 23000

	let employee2 = Employee()
	employee2.name = "Jane"
	employee2.age = 30
	employee2.salary = 40000

	let company = Company()
	company.name = "Example Ltd."
	company.employees = [employee1, employee2]

Then, using Nosce you can turn this model space into a valid JSON (or NSDictionary):

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
		  "salary": 23000
		},
		{
		  "name": "Jane",
		  "age": 30,
		  "salary": 40000
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
