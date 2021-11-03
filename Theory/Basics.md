# Basics


## View Controller Lifecycle 
viewDidLoad, viewDidDisappear etc
<img width="1088" alt="Screenshot 2021-07-27 at 11 41 09" src="https://user-images.githubusercontent.com/44570720/127141305-51179e9d-4714-4485-89b0-9b757e518c7f.png">


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


## Multiline String Literals
If you need a string that spans several lines, use a multiline string literal—a sequence of characters surrounded by three double quotation marks:
![image](https://user-images.githubusercontent.com/44570720/127146031-b374c04b-ea5f-487a-baa2-37ad96a93e72.png)

---
**Q: Does this create the multiline string correctly?**
var burns = """
The best laid schemes
""  
**A: False (Due to only two " at the end)**. 

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

---

**Q: Identify the output for this code:**

**A: Compile time error - as Higher order functions (closures on arrays) only take one parameter/argument at a time**

![image](https://user-images.githubusercontent.com/44570720/140053492-3696ffb6-8e6d-429d-ab24-6c24356fcf8f.png)

---

**MORE ON Map**

map() will take a value out of its container, transform it using the code you specify, then put it back in its container. 

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
# Errors
Compile-Time Errors: Errors that occur when you violate the rules of writing syntax are known as Compile-Time errors

Run-Time Errors: Errors which occur during program execution(run-time) after successful compilation are called run-time errors.

# XCTAssertTrue
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

---

## Optionals
Optionals- are denoted by:  
![image](https://user-images.githubusercontent.com/44570720/140083161-4f54295c-2b8e-4ce4-8bef-bf1c8eb1e711.png)

Optional chaining - You specify optional chaining by placing a question mark (?) after the optional value on which you wish to call a property, method or subscript if the optional is non-nil.


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


