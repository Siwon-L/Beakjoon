final class TreeNode<T> {
  let element: T
  var left: TreeNode?
  var right: TreeNode?
  
  init(_ element: T) {
    self.element = element
  }
}

struct BinaryTree<T: Hashable> {
  private var root: TreeNode<T>?
  private var dic: [T: TreeNode<T>] = [:]
  
  mutating func add(_ element: T, to parent: T? = nil, isLeft: Bool? = nil) {
    let newNode = TreeNode(element)
    dic[element] = newNode
    if root == nil {
      root = newNode
    }
    if let parent = parent, let isLeft = isLeft, let parentNode = dic[parent] {
      if isLeft {
        parentNode.left = newNode
      } else {
        parentNode.right = newNode
      }
    }
  }
  
  func printPreorder() {
    printPreorder(node: root)
  }
  
  private func printPreorder(node: TreeNode<T>?) {
    guard let node = node else { return }
    print(node.element, terminator: "")
    self.printPreorder(node: node.left)
    self.printPreorder(node: node.right)
  }
  
  func printOrder() {
    printOrder(node: root)
  }
  
  private func printOrder(node: TreeNode<T>?) {
    guard let node = node else { return }
    self.printOrder(node: node.left)
    print(node.element, terminator: "")
    self.printOrder(node: node.right)
  }
  
  func printPostorder() {
    printPostorder(node: root)
  }
  
  private func printPostorder(node: TreeNode<T>?) {
    guard let node = node else { return }
    self.printPostorder(node: node.left)
    self.printPostorder(node: node.right)
    print(node.element, terminator: "")
  }
}

let n = Int(readLine()!)!
var binanryTree: BinaryTree<String> = .init()

for i in 0..<n {
  let input = readLine()!.split(separator: " ").map { String($0) }
  if i == 0 {
    binanryTree.add(input[0])
  }
  if input[1] != "." {
    binanryTree.add(input[1], to: input[0], isLeft: true)
  }
  if input[2] != "." {
    binanryTree.add(input[2], to: input[0], isLeft: false)
  }
}

binanryTree.printPreorder()
print("")
binanryTree.printOrder()
print("")
binanryTree.printPostorder()
