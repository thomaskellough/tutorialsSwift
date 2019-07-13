import UIKit

// strings are NOT arrays of characters
let name = "Emma"
// This will work
for letter in name {
    print("Give me a \(letter)!")
}
// This will NOT work
// print(name[3])
// You must do this....
let letter = name[name.index(name.startIndex, offsetBy: 3)]

// Apple COULD do this
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

let letter2 = name[3]
// This creates a loop within a loop


/*
 SOME USEFUL STRING STUFF
*/

let password = "12345"
password.hasPrefix("123")
password.hasSuffix("455")

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}


let weather = "it's going to rain"
print(weather.capitalized)

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}

let input = "Swift is like Objective-C without the C"
input.contains("Swift") // return true
let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift") // return true
// Get ready for the confussssing part!
// How can we check that any language is in the input string? Maybe like this...
extension String {
    func containsAny(of array:[String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }
        
        return false
    }
}
input.containsAny(of: languages) // this works, but it isn't elegant

// Swift already has something that works
languages.contains(where: input.contains)
// contains(where: ) will call its closure once for every element of the array until it finds one to return true, then it stops
// for our closure, we are passing input.contains, which means it will call input.contains("python"), then input.contains("ruby"), so on... until true THEN stop


/*
 Formatting strings, bold, highlight, etc
 Use attributed strings
*/
let string = "This is a test string"
//let attributes: [NSAttributedString.Key: Any] = [
//    // It's common to use NSAttributedString.Key to make less typing later one (.foregroundColor, etc)
//    // value should be any since there are so many different types of keys to use
//    .foregroundColor: UIColor.white,
//    .backgroundColor: UIColor.red,
//    .font: UIFont.boldSystemFont(ofSize: 36)
//]
//let attributedString = NSAttributedString(string: string, attributes: attributes)

let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))

// Challenge 1
// Similar to what Paul taught us, except we need to use ! for NOT have prefix
extension String {
    func withPrefix(_ prefix: String) -> String {
        guard !self .hasPrefix(prefix) else { return self }
        return String(prefix + self)
    }
}
let challengeString1 = "pet"
challengeString1.withPrefix("car")

// Challenge 2
// Note: I had to convert the character into a string, then try to convert the string to an Int or Double
// The challenge talks about using doubles, but my thought is that if there is a double, then there could easily be an int
// which satisfies the condition to return true. Therefore, I only tested using Int.
extension String {
    var hasInt: Bool {
        for character in self {
            let character = String(character)
            if let character = Int(character) {
                return true
            } else { continue }
        }
        return false
    }
}
let challengeString2 = "string"
let challengeString22 = "str1ng"
let challengeString222 = "1string"
let challengeString2222 = "string1"
challengeString2.hasInt
challengeString22.hasInt
challengeString222.hasInt
challengeString2222.hasInt

// Challenge 3
extension String {
    var lines: [Any] {
        let array = self.split(separator: "\n")
        return array
        }
    }
let challengeString3 = "this\nis\na\ntest"
challengeString3.lines
