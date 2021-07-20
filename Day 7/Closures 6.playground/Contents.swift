//func travel() -> (String) -> Void {
//    var counter = 1
//
//    return {
//        print("\(counter). I'm going to \($0)")
//        counter += 1
//    }
//}
//
//let result = travel()
//result("London")
//result("London")
//result("London")

// ======================================

func makeRandomNumberGenerator() -> () -> Int {
    var previousNumber = 0
    
    return {
        var newNumber: Int
        
        repeat {
            newNumber = Int.random(in: 1...3)
        } while newNumber == previousNumber
        
        previousNumber = newNumber
        return newNumber
    }
}

let generator = makeRandomNumberGenerator()

for _ in 1...10 {
    print(generator())
}
