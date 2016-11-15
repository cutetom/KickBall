//
//  GameScene.swift
//  KickBalliOS
//
//  Created by apple on 2016/11/15.
//  Copyright (c) 2016年 cutetom. All rights reserved.
//

import SpriteKit

let MASK_EDGE:UInt32=0b1 //0b二进制数据
let MASK_BALL:UInt32=0b10
let MASK_FLAG:UInt32=0b100

class GameScene: SKScene,SKPhysicsContactDelegate{
    
    var gameStarted:Bool!
    var ball:SKSpriteNode!
    var startGameLabel:SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame);
        
        physicsWorld.contactDelegate = self;//碰撞检测代理
        physicsBody?.contactTestBitMask = MASK_EDGE
        
        ball = childNode(withName: "ball") as! SKSpriteNode;
        startGameLabel=childNode(withName: "startGameLabel") as! SKLabelNode
        gameStarted=false;
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == true {
            //add flag
            var index = arc4random()%11 + 1;
            print("\(index)")
            var imgName = String.init(format: "flag%d", index);
            var flag = SKSpriteNode(imageNamed: imgName);
            addChild(flag);
            flag.physicsBody = SKPhysicsBody(rectangleOf: flag.frame.size);
            flag.position = (touches.first?.location(in: self))!;
            flag.physicsBody?.contactTestBitMask=MASK_FLAG
            flag.physicsBody?.velocity = CGVector(dx: 0, dy: 500);
        }else{
            gameStarted = true
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
            ball.physicsBody?.contactTestBitMask=MASK_BALL
            
            startGameLabel.isHidden = true
            
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let maskCode = contact.bodyA.contactTestBitMask|contact.bodyB.contactTestBitMask;
        
        if maskCode == MASK_EDGE|MASK_FLAG {
            
            if contact.bodyA.contactTestBitMask==MASK_FLAG {
                contact.bodyA.node?.removeFromParent();
            }
            if contact.bodyB.contactTestBitMask==MASK_FLAG {
                contact.bodyB.node?.removeFromParent();
            }
        }else if maskCode == MASK_EDGE|MASK_BALL {
            print("GameOver");
            //切换到游戏结束场景
            self.view?.presentScene(GameOverScene(size:self.frame.size));
        }
        
        print(">>>")
    }
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}
