# Basics


## View Controller Lifecycle 

<img width="1088" alt="Screenshot 2021-07-27 at 11 41 09" src="https://user-images.githubusercontent.com/44570720/127141305-51179e9d-4714-4485-89b0-9b757e518c7f.png">

**Q: What's the order**

**A:**

Option C: viewDidLoad, viewWillAppear, viewDidAppear viewWillDisappear, viewDidDisappear etc


## Application State/Lifecycle
<img width="1335" alt="Screenshot 2021-07-27 at 11 46 14" src="https://user-images.githubusercontent.com/44570720/127141610-d3fc0607-2825-4072-b0d3-ae0ebae2b075.png">


https://developer.apple.com/documentation/uikit/app_and_environment/managing_your_app_s_life_cycle

| App-Based Life-Cycle Events     | Scene-Based Life-Cycle Events     |
| :------------- | :----------: |
| <img width="433" alt="Screenshot 2021-07-27 at 12 09 12" src="https://user-images.githubusercontent.com/44570720/127144492-bcf0e063-1191-43df-8030-9e6ac0912845.png"> |  <img width="517" alt="Screenshot 2021-07-27 at 12 09 05" src="https://user-images.githubusercontent.com/44570720/127144511-3a189ed8-7e8e-403c-a505-20555cd088e4.png">

Non-running - The app is not running.  
*Foreground.*  
 Inactive - The app is running in the **foreground**. 
e.g. An iOS app can be placed into an inactive state, for example, when a call or SMS message is received.  
 Active - The app is running in the **foreground**, and receiving events.  
*Background.*  
 Background - The app is running in the **background**, and executing code.  
 Suspended - The app is in the **background**, but no code is being execute.  

---
**Q: State of an application of the app if app in background did not recieve any event**.  

**A: Suspended**.  
(options: Background State, Active State, Suspended State, Inactive State).   
*as its in the background and 'did not recieve any event' seems to mean the same as 'but no code is being execute'*. 

*questions raised*. 
Is terminated and suspended the same thing?

---
## Frameworks
**Q: What framework is NOT part of iOS layer Architecture: **

a. AppKit Framework,   
b.Foundation Framework,   
c. CoreMotion Framework,  
d. UIKit Framework

**A: unsure**
a. because for macOS apps (https://developer.apple.com/documentation/appkit)
and it isnt mentioned in the link nanda recommended: (https://www.tutorialspoint.com/apple-ios-architecture)






## Higher Order Functions / Closures
Higher order functions are simply functions that operate on other functions by either taking a function as an argument, or returning a function. Swift’s Array type has a few methods that are higher order functions: sorted, map, filter, and reduce. 
These methods use **closures** to allow us to pass in functionality that can then determine how we want the method to work on an array of objects.

**Converting functions into closures**
remove func keyword and name of the function. 
![image](https://user-images.githubusercontent.com/44570720/140043425-71f88474-ee8b-47ad-bf9b-84eaeefabdd8.png)
move the curly bracket to the front and replace it with the keyword in
![image](https://user-images.githubusercontent.com/44570720/140043591-614a3b2d-37ec-4423-a84c-28fa3c42170c.png)
Due to swift's type inference, you can remove the data types for the parameters and the output (i.e :Int, and -> Int). 
*this screenshot is slightly confusing as it nots showing a function with a function we are converting into a closure *. 
![image](https://user-images.githubusercontent.com/44570720/140044854-9a1f3b07-ee39-4f0a-a8ba-d965da4cdc4c.png)
can also remove the return keyword and have it on oneline
![image](https://user-images.githubusercontent.com/44570720/140045277-f74f38e4-1747-40bd-83e8-6bf8944e966b.png)
then remove parameters and replace with anonymous ones
![image](https://user-images.githubusercontent.com/44570720/140045533-bd8dcd91-ea7d-4324-8cf0-7c71752bd9a2.png)
$0 means first parameter 
$1 means second parameter 
![image](https://user-images.githubusercontent.com/44570720/140046252-36a8bf92-ba7b-4f86-81e1-c9f0b8a1c042.png)

trailing closure - theres a rule that if the last parameter of a function is a closure, you can close the parameters and put the closure on the outside:  
![image](https://user-images.githubusercontent.com/44570720/140049731-016ba592-72b2-4037-a376-309ece0292f6.png). 


**Escaping closures**
In Swift, closures are **non-escaping** by default. You use **@escaping** keyword to change this. 
A closure is said to “escape” a function when it’s called after that function returns. 

---

**Q: Identify the output for this code:**

**A: Compile time error - as Higher order functions (closures on arrays) only take one parameter/argument at a time**

![image](https://user-images.githubusercontent.com/44570720/140053492-3696ffb6-8e6d-429d-ab24-6c24356fcf8f.png)

---

**MORE ON Map**

map() will take a value out of its container, transform it using the code you specify, then put it back in its container. 
example:  
![image](https://user-images.githubusercontent.com/44570720/140163466-c3bc3eee-12f2-4b17-af4b-2ed4849e2fe6.png)


the orginal array may contain optionals to be tranformed (nil will result in nil),
the transformation may result in an optional, e.g convert String to Int: Int("2") -> 2, Int("Cat") -> nil
or both meaning the new array stores an optional optional (??) [flatMap()]

optionals make map complicated/dangerous if the transformed array now stores optionals (that may be nils), so we have flatMap() and compactMap() to combat this:

*compactMap()* performs a transformation, but if your transformation returns an optional it will be unwrapped and have any nil values discarded.

*flatMap()* performs a transformation , but then flattens what comes back so that “optional optional” just becomes “optional”.
                                        it also can flatten out arrays, if each transform results in an array, extracts from the array and adds to the main array                                           with the rest of the tranformations
*Update*
Some uses of flatMap() are being depreciated:
https://useyourloaf.com/blog/replacing-flatmap-with-compactmap/

## Testing Debugging
### Errors
Compile-Time Errors: Errors that occur when you violate the rules of writing syntax are known as Compile-Time errors

Run-Time Errors: Errors which occur during program execution(run-time) after successful compilation are called run-time errors.

### XCTAssertTrue
This function generates a failure when expression == false and is equivalent to XCTAssertTrue.

## Functions - multiple return values
![image](https://user-images.githubusercontent.com/44570720/140054513-d1bf1e9f-76ad-4714-94d5-af98b5d804a9.png)
---
**Q: We can create a function with multiple return values, T or F**.  

**A: True**.    
*are to answer this with T or F. But I see it as functions can have one return TYPE, in this case tuple. And multiple return VALUES (in the tuple)*. 

## Functions (keywords)
**Q: Which keyword is used on a function inside an Enumeration to indicate that the function will modify itself?**
(Options: mutable, mutating, var, inout)

**A: mutating**
_orgially thought it was only structs:_
The mutating keyword is only required if you are changing any state contained within the struct. Since Swift structs are immutable objects, calling a mutating function actually returns a new struct in-place (much like passing an inout parameter to a function). The mutating keyword lets callers know that the method is going to make the value change. 
but in these docs: can see an example of an enum has a fucntion with the keyword
https://docs.swift.org/swift-book/LanguageGuide/Methods.html

!!need to look into this topic in these docs more

inout parameters 
https://www.hackingwithswift.com/sixty/5/10/inout-parameters

**Function parameters are constants by default.** Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.
https://docs.swift.org/swift-book/LanguageGuide/Functions.html


---

## Optionals
Optionals- are denoted by:  
![image](https://user-images.githubusercontent.com/44570720/140083161-4f54295c-2b8e-4ce4-8bef-bf1c8eb1e711.png)

(Conversion of Data Types involves optionals)
![image](https://user-images.githubusercontent.com/44570720/141295902-991e7e0d-040e-49c4-8436-a676ee917b02.png)


Optional chaining - You specify optional chaining by placing a question mark (?) after the optional value on which you wish to call a property, method or subscript if the optional is non-nil.

## Classes vs Structs
classes are passed by reference (**reference NOT copy**)
structs passed by value (copy)

## Enumerations 


## Storyboards
---

**Q: Why are IBOutlets declared with a weak attribute by default?**
a. To increase loading speed. 
b. To save memory. 
c. IBOutlets are not declared with the wek atribute by default.  
d. They are already retained by the view


**A: Not sure but think it must be D**  
Reasons:
https://developer.apple.com/forums/thread/51044
'If the outlet is referencing a ui object in the view heirarchy then I would make it weak. The view heirarchy already has a strong reference. Might help avoid reference cycles when your dismissing the view controller.'
https://stackoverflow.com/questions/24011575/what-is-the-difference-between-a-weak-reference-and-an-unowned-reference
'A weak reference allows the possibility of it to become nil (this happens automatically when the referenced object is deallocated)'

**A: BUT found this**  
![image](https://user-images.githubusercontent.com/44570720/140184398-5cb1e706-c3c8-47b0-b836-8db48fef6e8b.png)


---
**Q:**
True or false to each of these statements:
- IBAction is a type qualifier used by IB to enable connection user expierence elements and app code - TRUE
- IBAction is a macro defined to denote a method that can be referred to in IB - Unsure
- IBAction resolves to void - unsure 

**A:**
https://stackoverflow.com/questions/1643007/iboutlet-and-ibaction
IBAction and IBOutlet are macros defined to denote variables and methods that can be referred to in Interface Builder.

IBAction resolves to void and IBOutlet resolves to nothing, but they signify to Xcode and Interface builder that these variables and methods can be used in Interface builder to link UI elements to your code.

If you're not going to be using Interface Builder at all, then you don't need them in your code, but if you are going to use it, then you need to specify IBAction for methods that will be used in IB and IBOutlet for objects that will be used in IB.

---
## Switch Statements

| Questions  |     |  Syntax   |
| :---------:| :----------: | :---------: |
| ![image](https://user-images.githubusercontent.com/44570720/140099342-c81f53cb-bf72-412b-b9da-1180f5016be4.png) it could also be the bottom one but the first one meets the criteria first | ![image](https://user-images.githubusercontent.com/44570720/140180348-191e56bb-4268-4028-95c1-4e722116e6f2.png) |  ![image](https://user-images.githubusercontent.com/44570720/140098379-91317e25-c319-49bd-aecf-730be9a158f5.png) 


## Swift integers
*think this is related to storing the numbers in binary, the larger the number the more bits you need*
UInt - On 32-bit platforms, UInt is the same size as UInt32, and on 64-bit platforms, UInt is the same size as UInt64.

https://gist.github.com/kharrison/0879fc225121edaec903799cf0afb091
![image](https://user-images.githubusercontent.com/44570720/140100773-9160b5c1-b0be-4dfe-b9f4-c5724485f5d2.png)

## Swift Keywords
The final keyword is a restriction on a class, method, or property that indicates that the declaration cannot be overridden (https://developer.apple.com/swift/blog/?id=27)

A lazy stored property is a property whose initial value isn't calculated until the first time it's used.
(https://docs.swift.org/swift-book/LanguageGuide/Properties.html#:~:text=A%20lazy%20stored%20property%20is,the%20first%20time%20it's%20used.&text=You%20must%20always%20declare%20a,until%20after%20instance%20initialization%20completes.)

---
**Q: Which of these is not a valid property declaration in Swift?**  
Answers:  
final let x = 0  
**A: final lazy let x = 0**  
final lazy var x = 0   
final var x = 0  

'cant use a let with a lazy' https://abhimuralidharan.medium.com/lazy-var-in-ios-swift-96c75cb8a13a
I think it must be because lazy isnt calculated until later, and let means constant so you CANT change it.

---
## Basic Operators
### Range Operators
The closed range operator (a...b) defines a range that runs from a to b, and includes the values a and b.
The half-open range operator (a..<b) defines a range that runs from a to b.  
The one-sided range the operator has a value on only one side.  
 
![image](https://user-images.githubusercontent.com/44570720/141297296-abcd80a4-dce8-413e-af93-011d03b3dbd9.png). 

---
## Strings and characters
### Multiline String Literals
If you need a string that spans several lines, use a multiline string literal—a sequence of characters surrounded by three double quotation marks:
![image](https://user-images.githubusercontent.com/44570720/127146031-b374c04b-ea5f-487a-baa2-37ad96a93e72.png)

### Characters
Characters are a swift data type
![image](https://user-images.githubusercontent.com/44570720/141447848-f4d1b555-39da-4879-9b66-83129fa6a10b.png)



---
**Q: Does this create the multiline string correctly?**
var burns = """
The best laid schemes
""  
**A: False (Due to only two " at the end)**. 
---


## Attributes
There are two kinds of attributes in Swift—those that apply to declarations and those that apply to types. An attribute provides additional information about the declaration or type.

https://docs.swift.org/swift-book/ReferenceManual/Attributes.html - need to learn more on this


## Lexical Structure

### Integer Literals
Underscores _(_)_ are allowed between digits for readability, but they’re ignored and therefore don’t affect the value of the literal. Integer literals can begin with leading zeros (0), but they’re likewise ignored and don’t affect the base or value of the literal.

## Intialization

![image](https://user-images.githubusercontent.com/44570720/141299005-f32f359e-d783-4607-8943-112bdbec98e3.png)


| Default Property Values    | Customizing Initialization |
| :------------- | :----------: |
| ![image](https://user-images.githubusercontent.com/44570720/141446031-da24fb68-749c-454d-9465-b8ffccd11fcc.png) | ![image](https://user-images.githubusercontent.com/44570720/141446703-3daa172f-bfa7-471d-a2cb-926abb2b1a4a.png)


## Miscellaneous 
Which is not part of Swift programming?

![image](https://user-images.githubusercontent.com/44570720/141346235-be67ddda-8464-40eb-a85e-f2d4ec1027ab.png)

??What does Double... mean?

Set -
An unordered collection of unique elements.

**Q: Whar is the type of String, Array and Dictionary**
a. class
b.structure
c. enumeration
d. objet

**A:Structure** but what exactly is an object? - i think they are incidences (intailised, copies) of class and structs








