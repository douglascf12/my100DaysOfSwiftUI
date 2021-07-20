protocol Purchaseable {
    var name: String { get set }
}

struct Book: Purchaseable {
    var name: String
    var author: String
}

struct Movie: Purchaseable {
    var name: String
    var actors: [String]
}

struct Car: Purchaseable {
    var name: String
    var manufacturer: String
}

struct Coffee: Purchaseable {
    var name: String
    var strength: Int
}

func buy(_ item: Purchaseable) {
    print("I'm buyinng \(item.name)")
}

buy(Book(name: "Harry Potter", author: "Linspector"))
buy(Movie(name: "Luca", actors: ["Unknow"]))
buy(Car(name: "Ferrari", manufacturer: "Ferrari"))
buy(Coffee(name: "Capuccino", strength: 1))
