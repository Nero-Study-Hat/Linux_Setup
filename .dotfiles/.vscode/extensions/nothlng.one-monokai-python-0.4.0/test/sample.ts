// define a class to represent a person
class Person {
  private name: string;
  private age: number;
  private city: string;

  constructor(name: string, age: number, city: string) {
    this.name = name;
    this.age = age;
    this.city = city;
  }

  public greet(): string {
    return `Hello, my name is ${this.name}`;
  }

  public get Name(): string {
    return this.name;
  }

  public set Name(name: string) {
    this.name = name;
  }

  public get Age(): number {
    return this.age;
  }

  public set Age(age: number) {
    this.age = age;
  }

  public get City(): string {
    return this.city;
  }

  public set City(city: string) {
    this.city = city;
  }

  @logMethod
  public static fromObject(obj: {
    name: string;
    age: number;
    city: string;
  }): Person {
    return new Person(obj.name, obj.age, obj.city);
  }

  @logMethod
  public isAdult(): boolean {
    return this.age >= 18;
  }
}

// define a decorator function that logs a method call
function logMethod(target: any, key: string, descriptor: PropertyDescriptor) {
  const originalMethod = descriptor.value;
  descriptor.value = function (...args: any[]) {
    console.log(`Calling ${key} with arguments ${JSON.stringify(args)}`);
    return originalMethod.apply(this, args);
  };
  return originalMethod;
}

// create an array of person objects
const personData = [
  { name: "Alice", age: 30, city: "New York" },
  { name: "Bob", age: 25, city: "San Francisco" },
  { name: "Charlie", age: 40, city: "Chicago" },
];

// use a map function to create an array of Person objects from the data
const people = personData.map((data) => Person.fromObject(data));

// use an arrow function with type annotation to specify the argument and return types of the addNumbers function
const addNumbers = (x: number, y: number): number => {
  return x + y;
};

// use an arrow function with type annotation to specify the argument and return types of the getAges function
const getAges = (people: Person[]): number[] => {
  return people.map((person) => person.Age);
};

// use a decorator to log the method call and call the isAdult method on a person object
const alice = new Person("Alice", 30, "New York");
alice.isAdult();

console.log(people);
console.log(addNumbers(2, 3));
console.log(getAges(people));
