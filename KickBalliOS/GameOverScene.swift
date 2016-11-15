//
//  GameOverScene.swift
//  KickBalliOS
//
//  Created by apple on 2016/11/15.
//  Copyright © 2016年 cutetom. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene:SKScene{
    
    override init(size: CGSize) {
        super.init(size:size)
        
        var label = SKLabelNode(fontNamed: "Chalkduster");
        label.text = " Game Over "
        label.fontSize=45.0;
        label.position = CGPoint(x:size.width/2,y:size.height/2);
        addChild(label);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
