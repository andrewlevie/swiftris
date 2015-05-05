//
//  JShape.swift
//  swiftris
//
//  Created by Andrew Levie on 4/2/15.
//  Copyright (c) 2015 Swampland Snacks LLC. All rights reserved.
//

class JShape:Shape {
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero: [(1,0), (1,1), (1,2), (0,2)],
            Orientation.Ninety: [(2,1), (1,1), (0,1), (0,0)],
            Orientation.OneEighty: [(0,2), (0,1), (0,0), (1,0)],
            Orientation.TwoSeventy: [(0,0), (1,0), (2,0), (2,1)]
    
    ]
  }
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.OneEighty: [blocks[FirstBlockIdx], blocks[SecondBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
}