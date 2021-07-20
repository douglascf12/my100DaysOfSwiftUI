import UIKit

class Pokemon: CustomDebugStringConvertible {
    let name: String
    init(name: String) {
        self.name = name
    }
    var debugDescription: String { return "<Pokemon \(name)>" }
    deinit { print("\(self) escaped!") }
}

func delay(_ seconds: Int, closure: @escaping () -> ()) {
    let time = DispatchTime.now() + .seconds(seconds)
    DispatchQueue.main.asyncAfter(deadline: time) {
        print("⏱")
        closure()
    }
}

func demo1() {
    let pokemon = Pokemon(name: "Mewtwo")
    print("before closure: \(pokemon)")
    delay(1) {
        print("inside closure: \(pokemon)")
    }
    print("bye")
}

//print(demo1())

func demo2() {
    var pokemon = Pokemon(name: "Pikachu")
    print("before closure: \(pokemon)")
    delay(1) {
        print("inside closure: \(pokemon)")
    }
    pokemon = Pokemon(name: "Mewtwo")
    print("after closure: \(pokemon)")
}

//print(demo2())

func demo3() {
    var value = 42
    print("before closure: \(value)")
    delay(1) {
        print("inside closure: \(value)")
    }
    value = 1337
    print("after closure: \(value)")
}

//print(demo3())

func demo4() {
    var value = 42
    print("before closure:: \(value)")
    delay(1) {
        print("inside closure 1, before change: \(value)")
        value = 1337
        print("inside closure 1, after change: \(value)")
    }
    delay(2) {
        print("inside closure 2: \(value)")
    }
}

//print(demo4())

func demo5() {
  var value = 42
  print("before closure: \(value)")
  delay(1) { [constValue = value] in
    print("inside closure: \(constValue)")
  }
  value = 1337
  print("after closure: \(value)")
}

//(demo5())

func demo6() {
  var pokemon = Pokemon(name: "Pikachu")
  print("before closure: \(pokemon)")
  delay(1) { [pokemonCopy = pokemon] in
    print("inside closure: \(pokemonCopy)")
  }
  pokemon = Pokemon(name: "Mewtwo")
  print("after closure: \(pokemon)")
}

//print(demo6())

func demo6_equivalent() {
  var pokemon = Pokemon(name: "Pikachu")
  print("before closure: \(pokemon)")
  // here we create an intermediate variable to hold the instance
  // pointed by the variable at that point in the code:
  let pokemonCopy = pokemon
  delay(1) {
    print("inside closure: \(pokemonCopy)")
  }
  pokemon = Pokemon(name: "Mewtwo")
  print("after closure: \(pokemon)")
}

//print(demo6_equivalent())

func demo7() {
  var pokemon = Pokemon(name: "Mew")
  print("➡️ Initial pokemon is \(pokemon)")

  delay(1) { [capturedPokemon = pokemon] in
    print("closure 1 — pokemon captured at creation time: \(capturedPokemon)")
    print("closure 1 — variable evaluated at execution time: \(pokemon)")
    pokemon = Pokemon(name: "Pikachu")
    print("closure 1 - pokemon has been now set to \(pokemon)")
  }

  pokemon = Pokemon(name: "Mewtwo")
  print("🔄 pokemon changed to \(pokemon)")

  delay(2) { [capturedPokemon = pokemon] in
    print("closure 2 — pokemon captured at creation time: \(capturedPokemon)")
    print("closure 2 — variable evaluated at execution time: \(pokemon)")
    pokemon = Pokemon(name: "Charizard")
    print("closure 2 - value has been now set to \(pokemon)")
  }
}

print(demo7())
