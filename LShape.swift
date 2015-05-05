//
//  LShape.swift
//  swiftris
//
//  Created by Andrew Levie on 4/2/15.
//  Copyright (c) 2015 Swampland Snacks LLC. All rights reserved.
//

class LShape:Shape {
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero: [ (0,0), (0,1), (0,2), (2,1)],
            Orientation.Ninety: [ (1,1), (0,1), (-1,1), (-1,2)],
            Orientation.OneEighty: [ (0,2), (0,1), (0,0), (-1,1)],
            Orientation.TwoSeventy: [ (-1,1), (0,1), (1,1), (1,0)]
        ]
    }
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty: [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]]
        ]
    }
}
