import Foundation

/// Quick-Union algorithm may take ~MN steps
/// to process M union commands on N objects
public struct UnionFindQuickUnion<T: Hashable> {
  private var index = [T: Int]()
  private var parent = [Int]()
  private var size = [Int]()

  public init() {}

  public mutating func addSetWith(_ element: T) {
    index[element] = parent.count
    parent.append(parent.count)
    size.append(1)
  }

  private mutating func setByIndex(_ index: Int) -> Int {
    if parent[index] == index {
      return index
    } else {
      parent[index] = setByIndex(parent[index])
      return parent[index]
    }
  }

  public mutating func setOf(_ element: T) -> Int? {
    if let indexOfElement = index[element] {
      return setByIndex(indexOfElement)
    } else {
      return nil
    }
  }

  public mutating func unionSetsContaining(_ firstElement: T, and secondElement: T) {
    if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
      if firstSet != secondSet {
        parent[firstSet] = secondSet
        size[secondSet] += size[firstSet]
      }
    }
  }

  public mutating func inSameSet(_ firstElement: T, and secondElement: T) -> Bool {
    if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
      return firstSet == secondSet
    } else {
      return false
    }
  }
}
