import Cocoa

var greeting = "Hello, playground"

var names: [String]?
names = ["hung", "john", "bird"]
if let names = names {
    print("\(names.joined(separator: ", "))")
}
