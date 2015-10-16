//
//  main.swift
//  domainModeling
//
//  Created by studentuser on 10/15/15.
//  Copyright © 2015 kartikey. All rights reserved.
//

import Foundation

struct Money {
    
    var amount: Double = 0
    var currency: String = "USD"
    
    let currencyDict = ["GBP" : 2.0, "USD" : 1.0, "EUR" : 0.66, "CAN" : 0.8]
    
    mutating func convert (from: String, to: String) {
        
        let conversionRate = currencyDict[to]! / currencyDict[from]!
        self.amount = self.amount * conversionRate
    }
    
    mutating func add (var amount: Double, cur: String) {
        
        if cur != currency {
            
            let cr = currencyDict[currency]! / currencyDict [cur]!
            amount = amount * cr
            self.amount += amount
            
        }
        else {
            self.amount += amount
        }
    }
    
    mutating func subtract (var amount: Double, cur: String) {
        
        if cur != currency {
            
            let cr = currencyDict[currency]! / currencyDict [cur]!
            amount = amount * cr
            self.amount += amount
            
        }
        else {
            self.amount -= amount
        }
    }
    
}

class Job {
    
    var title: String
    var salary = Money()
    var salaryType: String
    var hours: Double
    
    init () {
        title = ""
        salary = Money(amount: 1000, currency: "USD")
        salaryType = "hourly"
        hours = 52.0 * 40.0
    }
    
    func calculateIncome (hoursWorked: Double) -> Double{
        if salaryType == "yearly" {
            return salary.amount
        }
        else {
            return salary.amount * hoursWorked
        }
    }
    
    func raise (percentage: Double) {
        salary.amount = salary.amount + (salary.amount * (percentage/100.0))
    }
}

class Person {

    var firstName: String
    var lastName: String
    var age: Int
    var job: Job?
    var spouse : Person?
    
    
    init(fname: String, lname: String, age: Int) {
        firstName = fname
        lastName = lname
        self.age = age
        if age < 18 {
            print("Age is below 18 \(firstName) \(lastName) cannot be married")
            spouse = nil
        }
        if age < 16 {
            print("Age is less than 16 \(firstName) \(lastName) cannot have a job yet")
            job = nil
        }
    }
    
    func toString() {
        
        if job == nil && spouse == nil {
            print("First Name: \(firstName)")
            print("Last Name: \(lastName)")
            print("Age: \(age)")
            return
        }
        
        if job == nil && spouse != nil {
            print("First Name: \(firstName)")
            print("Last Name: \(lastName)")
            print("Age: \(age)")
            print("Spouse: ", spouse!.firstName)
            return
        }
        
        if job != nil && spouse == nil {
            print("First Name: \(firstName)")
            print("Last Name: \(lastName)")
            print("Age: \(age)")
            print("Job Title: \(job!.title)")
            print("Job Salary: \(job!.calculateIncome(0)) \(job!.salary.currency) \(job!.salaryType)")
            return
        }

        
        
        print("First Name: \(firstName)")
        print("Last Name: \(lastName)")
        print("Age: \(age)")
        print("Job Title: \(job!.title)")
        print("Job Salary: \(job!.calculateIncome(0)) \(job!.salary.currency) \(job!.salaryType)")
        print("Spouse: ", spouse!.firstName)
    }
    
}

class Family {
    
    var members: [Person] = []
    
    func houseHoldIncome() -> Double {
        
        var sum = 0.0
        
        for member in members {
            if member.job != nil {
                sum = sum + member.job!.salary.amount
            }
            
        }
        
        return sum
    }
    
    func haveChild (fname: String, lname: String) {
        let child = Person(fname: fname, lname: lname, age: 0)
        members.append(child)
    }
    
    func printFamilyMembers () {
        for member in members {
            member.toString()
            print("\n")
        }
    }
    
    func checkAges () {
        for member in members {
            if member.age >= 21 {
               print("At least one member is >= 21 hence family is legal.")
               return
            }
        }
        print("Family cannot be created emptying family list")
        members = []
    }
}


print("Creating a person -> var x = Person(fname: \"John\", lname: \"Doe\", age: 30)")

var x = Person(fname: "John", lname: "Doe", age: 30)
x.job = Job()
x.job!.title = "SDE"
x.job!.salaryType = "yearly"
x.job!.salary.amount = 120000
x.job!.salary.currency = "USD"

print("\nCreating the persons' spouse instance -> ar y = Person(fname: \"Hannah\", lname: \"Doe\", age: 28)")

var y = Person(fname: "Hannah", lname: "Doe", age: 28)

x.spouse = y


print("\nSalary of John Doe = ",x.job!.calculateIncome(0))

print("\nIncreasing salary by 20%")
x.job!.raise(20)

print("\nSalary now is = ", x.job!.calculateIncome(0))
print("\nAdding people to the family")

var fam = Family()
fam.members.append(x)
fam.members.append(y)


print("\nCreating child of age 0 and adding to family calling child Matt Doe")
fam.haveChild("Matt", lname: "Doe")


print("\nChecking if family is legal (i.e. at least one person >=21 years old)")
fam.checkAges()

print("\nFamily Members: ")
fam.printFamilyMembers()

print("\nFamily Household Income = ",fam.houseHoldIncome())






