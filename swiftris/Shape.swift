//
//  Shape.swift
//  swiftris
//
//  Created by Andrew Levie on 4/1/15.
//  Copyright (c) 2015 Swampland Snacks LLC. All rights reserved.
//

import Foundation
import SpriteKit

let NumOrientations: UInt32 = 4

enum Orientation: Int, Printable {
    case Zero = 0, Ninety, OneEighty, TwoSeventy
    
    var description: String {
        switch self {
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .TwoSeventy:
            return "270"
        case .OneEighty:
            return "180"
        }
    }

    static func random() -> Orientation {
        return Orientation(rawValue: Int(arc4random_uniform(NumOrientations)))!
    }
   
    static func rotate(orientation: Orientation, clockwise: Bool) -> Orientation {
        var rotated = orientation.rawValue + (clockwise ? 1 : -1)
        if rotated > Orientation.TwoSeventy.rawValue {
            rotated = Orientation.Zero.rawValue
        
        } else if rotated < 0 {
            rotated = Orientation.TwoSeventy.rawValue
        }
        return Orientation(rawValue: rotated)!
    }
}
// the number of total shape varitities 
let NumShapeTypes: UInt32 = 7

//shape indexes
let FirstBlockIdx: Int = 0
let SecondBlockIdx: Int = 1
let ThirdBlockIdx: Int = 2
let FourthBlockIdx: Int = 3

class Shape: Hashable, Printable {
    // the color of the shape 
    let color:BlockColor
    //the blocks comprisint the shape 
    var blocks = Array<Block>()
    //the current orientation of the shape 
    var orientation: Orientation
    //the coulmn and row representing the shapes sanchor point 
    var column, row:Int
    
    //required overrides 

//#1
    //subclasses ust override this property 
    var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
//#2 
    var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [:]
    }
//#3 
    var bottomBlocks:Array<Block> {
        if let  bottomBlocks = bottomBlocksForOrientations[orientation] {
            return bottomBlocks
        }
        return []
    }
    //hashable
    var hashValue:Int {
//#4
        return reduce(blocks, 0) { $0.hashValue ^ $1.hashValue }
    }
    //printabe
    var description:String {
        return "\(color) block facing \(orientation): \(blocks[FirstBlockIdx]), \(blocks[ThirdBlockIdx]), \(blocks[FourthBlockIdx])"
    }
    init(column:Int, row:Int, color: BlockColor, orientation:Orientation) {
        self.color = color
        self.column = column
        self.row = row
        self.orientation = orientation
        initializeBlocks()
      
        
    }
//#5 
    convenience init(column:Int, row:Int) {
        self.init(column:column, row:row, color:BlockColor.random(), orientation:Orientation.random())
    }
//#1
    final func initializeBlocks() {
//#2
        if let blockRowColumnTranslations = blockRowColumnPositions[orientation] {
            for i in 0..<blockRowColumnTranslations.count {
                let blockRow = row + blockRowColumnTranslations[i].rowDiff
                let blockColumn = column + blockRowColumnTranslations[i].columnDiff
                let newBlock = Block(column: blockColumn, row: blockRow, color: color)
                blocks.append(newBlock)
            }
        }
    }
    
    final func rotateBlocks(orientation: Orientation) {
        if let blockRowColumnTranslation:Array<(columnDiff: Int, rowDiff: Int)> = blockRowColumnPositions[orientation] {
            
            for (idx, (columnDiff:Int, rowDiff:Int)) in enumerate(blockRowColumnTranslation) {
                blocks[idx].column = column + columnDiff
                blocks[idx].row = row + rowDiff
            }
        }
    }
    final func rotateClockwise() {
        let newOrientation = Orientation.rotate(orientation, clockwise: true)
        rotateBlocks(newOrientation)
        orientation = newOrientation
    }
    
    final func rotateCounterClockwise() {
        
        let newOrientation = Orientation.rotate(orientation, clockwise: false)
        rotateBlocks)(newOrientation)
        orientation = newOrientation
    }
    final func lowerShapeByOneRow() {
        shiftBy(0, rows:1)
    }
    final func raiseShapeByOneRow() {
        shiftBy(0, rows:-1)
    }
    final func shiftRightByOneColumn() {
        shiftBy(1, rows:0)
    }
    final func shiftLeftByOneColumn() {
        shiftBy(-1, rows:0)
    }
    
}
final func shiftBy(columns: Int, rows: Int) {
    self.column += columns
    self.row += rows
    for block in blocks {
        block.column += columns
        block.row += rows
     }
}
func ==(lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}

final func moveTo(column: Int, row:Int) {
    self.column = column
    self.row = row
    rotateBlocks(orientation)
    
}

final  func random(startingColumn: Int, startingRow:Int) -> Shape {
    switch Int(arc4random_uniform(NumShapeTypes)) {
    case 0:
        return SquareShape(column: startingColumn, row: startingRow)
    case 1:
        return LineShape(column: startingColumn, row: startingRow)
    case 2:
        return TShape(column: startingColumn, row: startingRow)
    case 3:
        return LShape(column: startingColumn, row: startingRow)
    case 4:
        return JShape(column: startingColumn, row: startingRow)
    case 5:
        return Sshape(column: startingColumn, row: startingRow)
    default:
        return ZShape(column: startingColumn, row: startingRow)
    }
}




























