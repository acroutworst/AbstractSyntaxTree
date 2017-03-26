//: Abstract Syntax Tree - Expression Evaluation

import UIKit

// Example:
// 10 + 8 / 4
10 + 8 / 4

//              '+'
//             /   \
//           '/'    10
//          /   \
//         8     4

// Node representing a value or operator in AST; Node connected by an edge
class Node {
    var operation: String? //"+", "-", "*", "/"
    var value: Float?
    var leftChild: Node?
    var rightChild: Node?
    
    init(operation: String?, value: Float?, leftChild: Node?, rightChild: Node?) {
        self.operation = operation
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}

// Error for mathematical operation
enum OperationError: Error {
    case DivideByZero
}


let fourNode = Node(operation: nil, value: 4, leftChild: nil, rightChild: nil)
let eightNode = Node(operation: nil, value: 8, leftChild: nil, rightChild: nil)
let tenNode = Node(operation: nil, value: 10, leftChild: nil, rightChild: nil)

let divideNode = Node(operation: "/", value: nil, leftChild: eightNode, rightChild: fourNode)
let rootNode = Node(operation: "+", value: nil, leftChild: divideNode, rightChild: tenNode)

// AST Implementation
func evaluate(node: Node) -> Float {
    if node.value != nil {
        return node.value!
    }
    
    if node.operation == "+" {
        return evaluate(node: node.leftChild!) + evaluate(node: node.rightChild!)
    } else if node.operation == "-" {
        return evaluate(node: node.leftChild!) - evaluate(node: node.rightChild!)
    } else if node.operation == "*" {
        return evaluate(node: node.leftChild!) * evaluate(node: node.rightChild!)
    } else if node.operation == "/" {
        if node.rightChild!.value! <= 0 {
            do {
                try handleError(error: OperationError.DivideByZero)
            } catch {
                print("Cannot divide by zero")
            }
        }
        return evaluate(node: node.leftChild!) / evaluate(node: node.rightChild!)
    }
    
    return 0
}

func handleError(error: OperationError) throws {
    throw error
}

evaluate(node: rootNode)

