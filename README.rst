Nosce
=====

Nosce is a JSON serialization / deserialization library that tries to automagically transform complex objects (or arrays of objects) into valid JSON and back.

Current version is 0.2.2 (Beta)

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

	let dictionary = serialize(company, format: .toDictionary)
	let preetyJSON = serialize(company, format: .toPreetyJSON)
	let compactJSON = serialize(company, format: .toCompactJSON)
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
