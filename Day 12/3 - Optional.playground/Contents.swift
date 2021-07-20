func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("Hello, \(unwrapped)")
}

greet(nil)
greet("Douglas")

// ===========================================

func getMeaningOfLife() -> Int? {
    42
}

func printMeaningOfLife() {
    if let name = getMeaningOfLife() {
        print(name)
    }
}

printMeaningOfLife()

func printMeaningOfLife2() {
    guard let name = getMeaningOfLife() else {
        return
    }
    
    print(name)
}

printMeaningOfLife2()
