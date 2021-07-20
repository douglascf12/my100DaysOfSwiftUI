var series: Set<String> = (["Banshee", "Person of Interest", "Vikings"])
let banshee = "Banshee"
let arrow = "Arrow"

let (inserted, memberAfterInsert) = series.insert(banshee)
if !inserted {
    print("\(memberAfterInsert) já existe na coleção!")
} else {
    print("\(memberAfterInsert) não existe na coleção!")
}

let (inserido, membroAposInserir) = series.insert(arrow)
if !inserido {
    print("\(membroAposInserir) já existe na coleção!")
} else {
    print("\(membroAposInserir) não existe na coleção!")
}

print(series)
