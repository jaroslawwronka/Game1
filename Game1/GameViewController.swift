//
//  GameViewController.swift
//  Game1
//
//  Created by Boss on 11/01/2024.
//

import UIKit

class GameViewController: UIViewController {

    var winLine1 : twinLine1!
    var winLine2 : twinLine2!
    var winLine3 : twinLine3!
    var winLine4 : twinLine4!
    var winLine5 : twinLine5!
    var winLine6 : twinLine6!
    var winLine7 : twinLine7!
    var winLine8 : twinLine8!
    
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerScoreLbL: UILabel!
    @IBOutlet weak var computerScoreLbl: UILabel!
    @IBOutlet weak var Box1: UIImageView!
    @IBOutlet weak var Box2: UIImageView!
    @IBOutlet weak var Box3: UIImageView!
    @IBOutlet weak var Box4: UIImageView!
    @IBOutlet weak var Box5: UIImageView!
    @IBOutlet weak var Box6: UIImageView!
    @IBOutlet weak var Box7: UIImageView!
    @IBOutlet weak var Box8: UIImageView!
    @IBOutlet weak var Box9: UIImageView!
    @IBOutlet weak var Line: UIView!
    
    var playerName : String = ""
    var lastValue = "o"
    var tabCC : [[String]] = [["_","_","_"],["_","_","_"],["_","_","_"]]
    var posX : Int = 0
    var posY : Int = 0
    var randX : Int = 0
    var randY : Int = 0
    var activeBox : Int = 0
    var checkWin : Int = 0
    var checkInc : Int = 0
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerNameLbl.text = playerName + ":"
       
        createTap(on: Box1, type: .one)
        createTap(on: Box2, type: .two)
        createTap(on: Box3, type: .three)
        createTap(on: Box4, type: .four)
        createTap(on: Box5, type: .five)
        createTap(on: Box6, type: .six)
        createTap(on: Box7, type: .seven)
        createTap(on: Box8, type: .eight)
        createTap(on: Box9, type: .nine)
        Line.isOpaque = false
        
        winLine1 = twinLine1(frame: CGRect(x: Line.frame.minX,y : Line.frame.minY, width: Line.frame.width, height: Line.frame.height))
        winLine1.draw(_:Line.frame)
        Line.addSubview(winLine1)
        
        winLine2 = twinLine2(frame: CGRect(x: Line.frame.minX,y : Line.frame.minY, width: Line.frame.width, height: Line.frame.height))
        winLine2.draw(_:Line.frame)
        Line.addSubview(winLine2)
        
        winLine3 = twinLine3(frame: CGRect(x: Line.frame.minX,y : Line.frame.minY, width: Line.frame.width, height: Line.frame.height))
        winLine3.draw(_:Line.frame)
        Line.addSubview(winLine3)
        
        winLine4 = twinLine4(frame: CGRect(x: Line.frame.minX,y : Line.frame.minY, width: Line.frame.width, height: Line.frame.height))
        winLine4.draw(_:Line.frame)
        Line.addSubview(winLine4)
        
        winLine5 = twinLine5(frame: CGRect(x: Line.frame.minX,y : Line.frame.minY, width: Line.frame.width, height: Line.frame.height))
        winLine5.draw(_:Line.frame)
        Line.addSubview(winLine5)
        
        winLine6 = twinLine6(frame: CGRect(x: Line.frame.minX,y : Line.frame.minY, width: Line.frame.width, height: Line.frame.height))
        winLine6.draw(_:Line.frame)
        Line.addSubview(winLine6)
        
        winLine7 = twinLine7(frame: CGRect(x: Line.frame.minX,y : Line.frame.minY, width: Line.frame.width, height: Line.frame.height))
        winLine7.draw(_:Line.frame)
        Line.addSubview(winLine7)
        
        winLine8 = twinLine8(frame: CGRect(x: Line.frame.minX,y : Line.frame.minY, width: Line.frame.width, height: Line.frame.height))
        winLine8.draw(_:Line.frame)
        
        Line.subviews.forEach { $0.isHidden = true }
        
    }
    
    func createTap(on imageView:UIImageView, type box: Box){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
        {
            let tap = UITapGestureRecognizer(target: self, action: #selector (self.boxClicked(_:)))
            tap.name = box.rawValue
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
        }
    }
    
    @objc func boxClicked(_ sender: UITapGestureRecognizer) {
        
        if ((checkInc <= 8) && (checkWin == 0)) {

            let selectedBox = getBox(from: sender.name ?? "")
            if boxAvailable() == true {
                selectedBox.image = #imageLiteral(resourceName: "cross")
                lastValue = "x"
                tabCC[posX][posY] = lastValue
                checkInc = checkInc + 1
                //print(tabCC[0][0] + " " + tabCC[1][0] + " " + tabCC[2][0])
                //print(tabCC[0][1] + " " + tabCC[1][1] + " " + tabCC[2][1])
                //print(tabCC[0][2] + " " + tabCC[1][2] + " " + tabCC[2][2])
                //print("*")
                if checkIfWin(PC: lastValue) == true {
                    playerScoreLbL.text = String((Int(playerScoreLbL.text ?? "0") ?? 0) + 1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                    {
                        self.resetGame()
                    }
                    return
                }
                computerPlay()
            }
        }
    }
        
    func computerPlay(){
        
            if ((checkInc <= 8) && (checkWin == 0)) {
                
                //random position computer choice
                repeat {
                    posX = Int.random(in: 0 ..< 3)
                    posY = Int.random(in: 0 ..< 3)
                    
                } while !(boxAvailable()==true)
                
                //defense position computer choise
                if ((tabCC[0][0]=="x") && (tabCC[1][0]=="x") && (tabCC[2][0]=="_")) { if boxAvailable() == true {posX=2; posY=0 } }
                if ((tabCC[0][0]=="x") && (tabCC[2][0]=="x") && (tabCC[1][0]=="_")) { if boxAvailable() == true {posX=1; posY=0 } }
                if ((tabCC[1][0]=="x") && (tabCC[2][0]=="x") && (tabCC[0][0]=="_")) { if boxAvailable() == true {posX=0; posY=0 } }
                
                if ((tabCC[0][1]=="x") && (tabCC[1][1]=="x") && (tabCC[2][1]=="_")) { if boxAvailable() == true {posX=2; posY=1 } }
                if ((tabCC[0][1]=="x") && (tabCC[2][1]=="x") && (tabCC[1][1]=="_")) { if boxAvailable() == true {posX=1; posY=1 } }
                if ((tabCC[1][1]=="x") && (tabCC[2][1]=="x") && (tabCC[0][1]=="_")) { if boxAvailable() == true {posX=0; posY=1 } }
                
                if ((tabCC[0][2]=="x") && (tabCC[1][2]=="x") && (tabCC[2][2]=="_")) { if boxAvailable() == true {posX=2; posY=2 } }
                if ((tabCC[0][2]=="x") && (tabCC[2][2]=="x") && (tabCC[1][2]=="_")) { if boxAvailable() == true {posX=1; posY=2 } }
                if ((tabCC[1][2]=="x") && (tabCC[2][2]=="x") && (tabCC[0][2]=="_")) { if boxAvailable() == true {posX=0; posY=2 } }
                
                if ((tabCC[0][0]=="x") && (tabCC[0][1]=="x") && (tabCC[0][2]=="_")) { if boxAvailable() == true {posX=0; posY=2 } }
                if ((tabCC[0][1]=="x") && (tabCC[0][2]=="x") && (tabCC[0][0]=="_")) { if boxAvailable() == true {posX=0; posY=0 } }
                if ((tabCC[0][0]=="x") && (tabCC[0][2]=="x") && (tabCC[0][1]=="_")) { if boxAvailable() == true {posX=0; posY=1 } }
                
                if ((tabCC[1][0]=="x") && (tabCC[1][1]=="x") && (tabCC[1][2]=="_")) { if boxAvailable() == true {posX=1; posY=2 } }
                if ((tabCC[1][1]=="x") && (tabCC[1][2]=="x") && (tabCC[1][0]=="_")) { if boxAvailable() == true {posX=1; posY=0 } }
                if ((tabCC[1][0]=="x") && (tabCC[1][2]=="x") && (tabCC[1][1]=="_")) { if boxAvailable() == true {posX=1; posY=1 } }
                
                if ((tabCC[2][0]=="x") && (tabCC[2][1]=="x") && (tabCC[2][2]=="_")) { if boxAvailable() == true {posX=2; posY=2 } }
                if ((tabCC[2][1]=="x") && (tabCC[2][2]=="x") && (tabCC[2][0]=="_")) { if boxAvailable() == true {posX=2; posY=0 } }
                if ((tabCC[2][0]=="x") && (tabCC[2][2]=="x") && (tabCC[2][1]=="_")) { if boxAvailable() == true {posX=2; posY=1 } }
                
                if ((tabCC[0][0]=="x") && (tabCC[1][1]=="x") && (tabCC[2][2]=="_")) { if boxAvailable() == true {posX=2; posY=2 } }
                if ((tabCC[0][0]=="x") && (tabCC[2][2]=="x") && (tabCC[1][1]=="_")) { if boxAvailable() == true {posX=1; posY=1 } }
                if ((tabCC[1][1]=="x") && (tabCC[2][2]=="x") && (tabCC[0][0]=="_")) { if boxAvailable() == true {posX=0; posY=0 } }
                
                if ((tabCC[2][0]=="x") && (tabCC[1][1]=="x") && (tabCC[0][2]=="_")) { if boxAvailable() == true {posX=0; posY=2 } }
                if ((tabCC[2][0]=="x") && (tabCC[0][2]=="x") && (tabCC[1][1]=="_")) { if boxAvailable() == true {posX=1; posY=1 } }
                if ((tabCC[1][1]=="x") && (tabCC[0][2]=="x") && (tabCC[2][0]=="_")) { if boxAvailable() == true {posX=2; posY=0 } }
                
                //offensive position computer choice
                if ((tabCC[0][0]=="o") && (tabCC[1][0]=="o") && (tabCC[2][0]=="_")) { if boxAvailable() == true {posX=2; posY=0 } }
                if ((tabCC[0][0]=="o") && (tabCC[2][0]=="o") && (tabCC[1][0]=="_")) { if boxAvailable() == true {posX=1; posY=0 } }
                if ((tabCC[1][0]=="o") && (tabCC[2][0]=="o") && (tabCC[0][0]=="_")) { if boxAvailable() == true {posX=0; posY=0 } }
                
                if ((tabCC[0][1]=="o") && (tabCC[1][1]=="o") && (tabCC[2][1]=="_")) { if boxAvailable() == true {posX=2; posY=1 } }
                if ((tabCC[0][1]=="o") && (tabCC[2][1]=="o") && (tabCC[1][1]=="_")) { if boxAvailable() == true {posX=1; posY=1 } }
                if ((tabCC[1][1]=="o") && (tabCC[2][1]=="o") && (tabCC[0][1]=="_")) { if boxAvailable() == true {posX=0; posY=1 } }
                
                if ((tabCC[0][2]=="o") && (tabCC[1][2]=="o") && (tabCC[2][2]=="_")) { if boxAvailable() == true {posX=2; posY=2 } }
                if ((tabCC[0][2]=="o") && (tabCC[2][2]=="o") && (tabCC[1][2]=="_")) { if boxAvailable() == true {posX=1; posY=2 } }
                if ((tabCC[1][2]=="o") && (tabCC[2][2]=="o") && (tabCC[0][2]=="_")) { if boxAvailable() == true {posX=0; posY=2 } }
                
                if ((tabCC[0][0]=="o") && (tabCC[0][1]=="o") && (tabCC[0][2]=="_")) { if boxAvailable() == true {posX=0; posY=2 } }
                if ((tabCC[0][1]=="o") && (tabCC[0][2]=="o") && (tabCC[0][0]=="_")) { if boxAvailable() == true {posX=0; posY=0 } }
                if ((tabCC[0][0]=="o") && (tabCC[0][2]=="o") && (tabCC[0][1]=="_")) { if boxAvailable() == true {posX=0; posY=1 } }
                
                if ((tabCC[1][0]=="o") && (tabCC[1][1]=="o") && (tabCC[1][2]=="_")) { if boxAvailable() == true {posX=1; posY=2 } }
                if ((tabCC[1][1]=="o") && (tabCC[1][2]=="o") && (tabCC[1][0]=="_")) { if boxAvailable() == true {posX=1; posY=0 } }
                if ((tabCC[1][0]=="o") && (tabCC[1][2]=="o") && (tabCC[1][1]=="_")) { if boxAvailable() == true {posX=1; posY=1 } }
                
                if ((tabCC[2][0]=="o") && (tabCC[2][1]=="o") && (tabCC[2][2]=="_")) { if boxAvailable() == true {posX=2; posY=2 } }
                if ((tabCC[2][1]=="o") && (tabCC[2][2]=="o") && (tabCC[2][0]=="_")) { if boxAvailable() == true {posX=2; posY=0 } }
                if ((tabCC[2][0]=="o") && (tabCC[2][2]=="o") && (tabCC[2][1]=="_")) { if boxAvailable() == true {posX=2; posY=1 } }
                
                if ((tabCC[0][0]=="o") && (tabCC[1][1]=="o") && (tabCC[2][2]=="_")) { if boxAvailable() == true {posX=2; posY=2 } }
                if ((tabCC[0][0]=="o") && (tabCC[2][2]=="o") && (tabCC[1][1]=="_")) { if boxAvailable() == true {posX=1; posY=1 } }
                if ((tabCC[1][1]=="o") && (tabCC[2][2]=="o") && (tabCC[0][0]=="_")) { if boxAvailable() == true {posX=0; posY=0 } }
                
                if ((tabCC[2][0]=="o") && (tabCC[1][1]=="o") && (tabCC[0][2]=="_")) { if boxAvailable() == true {posX=0; posY=2 } }
                if ((tabCC[2][0]=="o") && (tabCC[0][2]=="o") && (tabCC[1][1]=="_")) { if boxAvailable() == true {posX=1; posY=1 } }
                if ((tabCC[1][1]=="o") && (tabCC[0][2]=="o") && (tabCC[2][0]=="_")) { if boxAvailable() == true {posX=2; posY=0 } }
                
                let selectedBox : UIImageView
                selectedBox = boxNumber()
                selectedBox.image = #imageLiteral(resourceName: "circle.png")
                lastValue = "o"
                tabCC[posX][posY] = lastValue
                checkInc = checkInc + 1
                
                print(tabCC[0][0] + " " + tabCC[1][0] + " " + tabCC[2][0])
                print(tabCC[0][1] + " " + tabCC[1][1] + " " + tabCC[2][1])
                print(tabCC[0][2] + " " + tabCC[1][2] + " " + tabCC[2][2])
                print("*")
                
                if checkIfWin(PC: lastValue) == true {
                    
                    computerScoreLbl.text = String((Int(computerScoreLbl.text ?? "0") ?? 0) + 1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {}
                        self.resetGame()
                    return
                }
                
            }
            if checkInc == 9 {
                self.resetGame()
            }
        
    }
 
    
    func computerThink() {
        repeat {
            posX = Int.random(in: 0 ..< 3)
            posY = Int.random(in: 0 ..< 3)
        } while !(boxAvailable()==true)
        
        if ((tabCC[0][0]=="x") && (tabCC[1][0]=="x")) { if boxAvailable() == true {posX=2; posY=0 } }
        if ((tabCC[0][0]=="x") && (tabCC[2][0]=="x")) { if boxAvailable() == true {posX=1; posY=0 } }
        if ((tabCC[1][0]=="x") && (tabCC[2][0]=="x")) { if boxAvailable() == true {posX=0; posY=0 } }
        
        if ((tabCC[0][1]=="x") && (tabCC[1][1]=="x")) { if boxAvailable() == true {posX=2; posY=1 } }
        if ((tabCC[0][1]=="x") && (tabCC[2][1]=="x")) { if boxAvailable() == true {posX=1; posY=1 } }
        if ((tabCC[1][1]=="x") && (tabCC[2][1]=="x")) { if boxAvailable() == true {posX=0; posY=1 } }
        
        if ((tabCC[0][2]=="x") && (tabCC[1][2]=="x")) { if boxAvailable() == true {posX=2; posY=2 } }
        if ((tabCC[0][2]=="x") && (tabCC[2][2]=="x")) { if boxAvailable() == true {posX=1; posY=2 } }
        if ((tabCC[1][2]=="x") && (tabCC[2][2]=="x")) { if boxAvailable() == true {posX=0; posY=2 } }
        
        if ((tabCC[0][0]=="x") && (tabCC[0][1]=="x")) { if boxAvailable() == true {posX=0; posY=2 } }
        if ((tabCC[0][1]=="x") && (tabCC[0][2]=="x")) { if boxAvailable() == true {posX=0; posY=0 } }
        if ((tabCC[0][0]=="x") && (tabCC[0][2]=="x")) { if boxAvailable() == true {posX=0; posY=1 } }
        
        if ((tabCC[1][0]=="x") && (tabCC[1][1]=="x")) { if boxAvailable() == true {posX=1; posY=2 } }
        if ((tabCC[1][1]=="x") && (tabCC[1][2]=="x")) { if boxAvailable() == true {posX=1; posY=0 } }
        if ((tabCC[1][0]=="x") && (tabCC[1][2]=="x")) { if boxAvailable() == true {posX=1; posY=1 } }
        
        if ((tabCC[2][0]=="x") && (tabCC[2][1]=="x")) { if boxAvailable() == true {posX=2; posY=2 } }
        if ((tabCC[2][1]=="x") && (tabCC[2][2]=="x")) { if boxAvailable() == true {posX=2; posY=0 } }
        if ((tabCC[2][0]=="x") && (tabCC[2][2]=="x")) { if boxAvailable() == true {posX=2; posY=1 } }
        
        if ((tabCC[0][0]=="x") && (tabCC[1][1]=="x")) { if boxAvailable() == true {posX=2; posY=2 } }
        if ((tabCC[0][0]=="x") && (tabCC[2][2]=="x")) { if boxAvailable() == true {posX=1; posY=1 } }
        if ((tabCC[1][1]=="x") && (tabCC[2][2]=="x")) { if boxAvailable() == true {posX=0; posY=0 } }
        
        if ((tabCC[2][0]=="x") && (tabCC[1][1]=="x")) { if boxAvailable() == true {posX=0; posY=2 } }
        if ((tabCC[2][0]=="x") && (tabCC[0][2]=="x")) { if boxAvailable() == true {posX=1; posY=1 } }
        if ((tabCC[1][1]=="x") && (tabCC[0][2]=="x")) { if boxAvailable() == true {posX=2; posY=0 } }
        
    }
    
    func boxNumber() -> UIImageView {
        var ret : UIImageView = Box1
        
        if ((posX == 0) && (posY == 0)) {ret = Box1}
        if ((posX == 1) && (posY == 0)) {ret = Box2}
        if ((posX == 2) && (posY == 0)) {ret = Box3}
        if ((posX == 0) && (posY == 1)) {ret = Box4}
        if ((posX == 1) && (posY == 1)) {ret = Box5}
        if ((posX == 2) && (posY == 1)) {ret = Box6}
        if ((posX == 0) && (posY == 2)) {ret = Box7}
        if ((posX == 1) && (posY == 2)) {ret = Box8}
        if ((posX == 2) && (posY == 2)) {ret = Box9}
        
        return ret
    }
    
    
    func boxAvailable() -> Bool {
        
        if tabCC[posX][posY] == "_" { return true} else { return false}
        
    }
    
    func checkIfWin(PC:String) -> Bool{
        var winGame : Bool = false
        
        
        if ((tabCC[0][0] == PC) && (tabCC[1][0] == PC) && (tabCC[2][0] == PC)) {
            
            winGame=true
            Line.subviews[0].isHidden = false
        }
        if ((tabCC[0][1] == PC) && (tabCC[1][1] == PC) && (tabCC[2][1] == PC)) {
            
            winGame=true
            Line.subviews[1].isHidden = false
        }
        if ((tabCC[0][2] == PC) && (tabCC[1][2] == PC) && (tabCC[2][2] == PC)) {
            
            winGame=true
            Line.subviews[2].isHidden = false
        }
        if ((tabCC[0][0] == PC) && (tabCC[0][1] == PC) && (tabCC[0][2] == PC)) {
            
            winGame=true
            Line.subviews[3].isHidden = false
        }
        if ((tabCC[1][0] == PC) && (tabCC[1][1] == PC) && (tabCC[1][2] == PC)) {
            
            winGame=true
            Line.subviews[4].isHidden = false
        }
        if ((tabCC[2][0] == PC) && (tabCC[2][1] == PC) && (tabCC[2][2] == PC)) {
            
            winGame=true
            Line.subviews[5].isHidden = false
        }
        if ((tabCC[0][0] == PC) && (tabCC[1][1] == PC) && (tabCC[2][2] == PC)) {
            
            winGame=true
            Line.subviews[6].isHidden = false
            
        }
        if ((tabCC[2][0] == PC) && (tabCC[1][1] == PC) && (tabCC[0][2] == PC)) {
            
            winGame=true
            Line.subviews[7].isHidden = false
        }
    
        
        
        if winGame == true {
            self.checkWin = 1
        }
      return winGame
    }
    
    class twinLine1: UIView {
        
        override func draw(_ rect: CGRect) {
            self.isOpaque = false
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(UIColor.darkGray.cgColor)
                context.setFillColor(UIColor.clear.cgColor)
                context.setLineWidth(4.0)
                context.move(to: CGPoint(x: 20, y: self.frame.size.height / 6 ))
                context.addLine(to: CGPoint(x: self.frame.maxX - 20, y: self.frame.maxY / 6 ))
                context.strokePath()
            }
        }
    }
    
    class twinLine2: UIView {
        
        override func draw(_ rect: CGRect) {
            self.isOpaque = false
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(UIColor.darkGray.cgColor)
                context.setLineWidth(4.0)
                context.move(to: CGPoint(x: 20, y: self.frame.maxY / 2))
                context.addLine(to: CGPoint(x: self.frame.maxX - 20, y: self.frame.maxY / 2 ))
                context.strokePath()
            }
        }
    }
    
    class twinLine3: UIView {
        
        override func draw(_ rect: CGRect) {
            self.isOpaque = false
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(UIColor.darkGray.cgColor)
                context.setLineWidth(4.0)
                context.move(to: CGPoint(x: 20, y: self.frame.maxY / 6 * 5))
                context.addLine(to: CGPoint(x: self.frame.maxX - 20, y: self.frame.maxY / 6 * 5))
                context.strokePath()
            }
        }
    }
    
    class twinLine4: UIView {
        
        override func draw(_ rect: CGRect) {
            self.isOpaque = false
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(UIColor.darkGray.cgColor)
                context.setLineWidth(4.0)
                context.move(to: CGPoint(x: self.frame.maxX / 6, y: 20))
                context.addLine(to: CGPoint(x: self.frame.maxX / 6, y: self.frame.maxY - 20))
                context.strokePath()
            }
        }
    }
    
    class twinLine5: UIView {
        
        override func draw(_ rect: CGRect) {
            self.isOpaque = false
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(UIColor.darkGray.cgColor)
                context.setLineWidth(4.0)
                context.move(to: CGPoint(x: self.frame.maxX / 2, y: 20))
                context.addLine(to: CGPoint(x: self.frame.maxX / 2, y: self.frame.maxY - 20))
                context.strokePath()
            }
        }
    }
    
    class twinLine6: UIView {
        
        override func draw(_ rect: CGRect) {
            self.isOpaque = false
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(UIColor.darkGray.cgColor)
                context.setLineWidth(4.0)
                context.move(to: CGPoint(x: self.frame.maxX / 6 * 5, y: 20))
                context.addLine(to: CGPoint(x: self.frame.maxX / 6 * 5, y: self.frame.maxY - 20))
                context.strokePath()
            }
        }
    }
    
    class twinLine7: UIView {
        
        override func draw(_ rect: CGRect) {
            self.isOpaque = false
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(UIColor.darkGray.cgColor)
                context.setLineWidth(4.0)
                context.move(to: CGPoint(x: 20, y: 20))
                context.addLine(to: CGPoint(x: self.frame.maxX - 20, y: self.frame.maxY - 20))
                context.strokePath()
            }
        }
    }
    
    class twinLine8: UIView {
        
        override func draw(_ rect: CGRect) {
            self.isOpaque = false
            if let context = UIGraphicsGetCurrentContext() {
                context.setStrokeColor(UIColor.darkGray.cgColor)
                context.setLineWidth(4.0)
                context.move(to: CGPoint(x: self.frame.maxX - 20, y: 20))
                context.addLine(to: CGPoint(x: 20, y: self.frame.maxY - 20))
                context.strokePath()
            }
        }
    }
    
  
    
    func resetGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
        {
            for name in Box.allCases {
                let box = self.getBox(from: name.rawValue)
                box.image = nil
            }
            self.Line.subviews.forEach { $0.isHidden = true }
            self.lastValue = "o"
            self.tabCC = []
            self.activeBox = 0
            self.checkWin = 0
            self.checkInc = 0
            self.posX = 0
            self.posY = 0
            self.randX = 0
            self.randY = 0
            self.tabCC = [["_","_","_"],["_","_","_"],["_","_","_"]]
        }
    }
    
    func getBox(from name:String) -> (UIImageView) {
        let box = Box(rawValue: name) ?? .one
        let imageBox : [UIImageView] = [Box1, Box2, Box3, Box4, Box5, Box6, Box7, Box8, Box9]
        
        if box == .one {
            activeBox = 1
            posX = 0
            posY = 0
        }
        if box == .two {
            self.activeBox = 2
            posX = 1
            posY = 0
        }
        if box == .three {
            self.activeBox = 3
            posX = 2
            posY = 0
        }
        if box == .four {
            self.activeBox = 4
            posX = 0
            posY = 1
        }
        if box == .five {
            self.activeBox = 5
            posX = 1
            posY = 1
        }
        if box == .six {
            self.activeBox = 6
            posX = 2
            posY = 1
        }
        if box == .seven {
            self.activeBox = 7
            posX = 0
            posY = 2
        }
        if box == .eight {
            self.activeBox = 8
            posX = 1
            posY = 2
        }
        if box == .nine {
            self.activeBox = 9
            posX = 2
            posY = 2
        }
    
    return imageBox[activeBox-1]
    }
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

enum Box: String, CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine
}
