func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result = travel()
result("London")

let result2 = travel()("London")
let _ = travel()("London")

// -----------------------------------------------

print(Int.random(in: 1...10))

func getRandomNumber() -> Int {
    Int.random(in: 1...10)
}

print(getRandomNumber())

func makeRandomGenerator() -> () -> Int {
    let function = { Int.random(in: 1...10) }
    return function
}

let generator = makeRandomGenerator()
let random1 = generator()
print(random1)
