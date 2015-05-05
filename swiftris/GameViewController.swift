//
//  GameViewController.swift
//  swiftris
//
//  Created by Andrew Levie on 4/1/15.
//  Copyright (c) 2015 Swampland Snacks LLC. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, SwiftrisDelegate {
    var scene: GameScene!
    var swiftris:Swiftris!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the view.
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        // create and configure the scene
        scene = GameScene(size:skView.bounds.size)
        scene.scaleMode = .AspectFill
      
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.delegate = self
        swiftris.beginGame()

        // present the scene
        skView.presentScene(scene)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
    return true
    }
    func didTick() {
        swiftris.letShapeFall()
    }
}

func nextShape() {
    let newShapes = swiftris.newShape()
    if let fallingShape = newShapes.fallingShape {
        self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
        self.scene.movePreviewShape(fallingShape) {
            
            
            sself.view.userInteractionEnabled = true
            self.scene.startTicking()
        }
    }
}
func gameDidBegin(Swiftris: Swiftris) {

    if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
        scene.addPReviewShapeToScene(swiftris.nextShape!) {
    
                self.nextShape()
                
        } else {
            nextShape()
        }
}
    func gameDidEnd(swiftris: Swiftris) {
        view.userInteractionEnabled = false
        scene.stopTicking()
}
    func gameDidLevelUp(swiftris: Swiftris) {
        
}
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        nextSHape()
}

    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(swiftris.fallingShape!) {}
}




















