import datetime
from random import Random, randint


# define a class to represent a person
class Person:
    def __init__(self, name: str, age: int, city: str):
        self.name = name
        self.age = age
        self.city = city

    def greet(self) -> str:
        return f'Hello, my name is {self.name}'

    def __repr__(self) -> str:
        return f'Person(name={self.name}, age={self.age}, city={self.city})'

    @classmethod
    def from_dict(cls, data: dict[str, str]) -> 'Person':
        return cls(data['name'], int(data['age']), data['city'])

    @staticmethod
    def is_adult(age: int) -> bool:
        return age >= 18


person_data = [
    {'name': 'Alice', 'age': '30', 'city': 'New York'},
    {'name': 'Bob', 'age': '25', 'city': 'San Francisco'},
    {'name': 'Charlie', 'age': '40', 'city': 'Chicago'},
]

for data in person_data:
    person = Person.from_dict(data)
    person.age = 3
    

print(datetime.datetime.now())
print(f'Is Alice an adult? {Person.is_adult(randint(1,100))}')
print(f'Is Alice an adult? {Person.is_adult(Random().randint(1,100))}')
