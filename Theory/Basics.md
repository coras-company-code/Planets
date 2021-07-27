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
 |

An iOS app can be placed into an 
inactive state, for example, when a call or SMS message is received. 
Active - The app is running in the foreground, and receiving events. 
Background - The app is running in the background, and executing code. 
Suspended - The app is in the background, but no code is being execute


Q: State of an application of the app if app in background did not recieve any event
A: Suspended ?

*I know it is not Active or inactive, i think suspended as the documentation talks about responding to events, and managing and preparing the app for those states but does not discuss this when in suspended state*

Is terminated and suspended the same thing?


## Multiline String Literals
If you need a string that spans several lines, use a multiline string literal—a sequence of characters surrounded by three double quotation marks:
![image](https://user-images.githubusercontent.com/44570720/127146031-b374c04b-ea5f-487a-baa2-37ad96a93e72.png)

## Higher Order Functions / Closures
Higher order functions are simply functions that operate on other functions by either taking a function as an argument, or returning a function. Swift’s Array type has a few methods that are higher order functions: sorted, map, filter, and reduce. 
These methods use **closures** to allow us to pass in functionality that can then determine how we want the method to work on an array of objects.

**Map**
map() will take a value out of its container, transform it using the code you specify, then put it back in its container. 

the orginal array may contain optionals to be tranformed (nil will result in nil),
the transformation may result in an optional, e.g convert String to Int: Int("2") -> 2, Int("Cat") -> nil
or both meaning the new array stores an optional optional (??) [flatMap()]

optionals make map complicated/dangerous if the transformed array now stores optionals (that may be nils), so we have flatMap() and compactMap() to combat this:

*compactMap()* performs a transformation, but if your transformation returns an optional it will be unwrapped and have any nil values discarded.

*flatMap()* performs a transformation , but then flattens what comes back so that “optional optional” just becomes “optional”.
