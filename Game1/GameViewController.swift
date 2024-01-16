//
//  GameViewController.swift
//  Game1
//
//  Created by Boss on 11/01/2024.
//

import UIKit

class GameViewController: UIViewController {

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
    
    var playerName : String = ""
    var lastValue = "o"
    var tabCC : [[String]] = [["_","_","_"],["_","_","_"],["_","_","_"]]
    var posX : Int = 0
    var posY : Int = 0
    var randX : Int = 0
    var randY : Int = 0
    var activeBox : Int = 0
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
        
        if ((checkInc <= 8)) {
            //isTaped = true
            let selectedBox = getBox(from: sender.name ?? "")
            if boxAvailable() == true {
                selectedBox.image = #imageLiteral(resourceName: "cross")
                lastValue = "x"
                tabCC[posX][posY] = lastValue
                checkInc = checkInc + 1
                print(tabCC[0][0] + " " + tabCC[1][0] + " " + tabCC[2][0])
                print(tabCC[0][1] + " " + tabCC[1][1] + " " + tabCC[2][1])
                print(tabCC[0][2] + " " + tabCC[1][2] + " " + tabCC[2][2])
                print("*")
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
        
            if checkInc <= 8 {
                
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
                    //DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                    //{
                        self.resetGame()
                    //}
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
        
        if ((tabCC[0][0] == PC) && (tabCC[1][0] == PC) && (tabCC[2][0] == PC)) { winGame=true}
        if ((tabCC[0][1] == PC) && (tabCC[1][1] == PC) && (tabCC[2][1] == PC)) { winGame=true}
        if ((tabCC[0][2] == PC) && (tabCC[1][2] == PC) && (tabCC[2][2] == PC)) { winGame=true}
        if ((tabCC[0][0] == PC) && (tabCC[0][1] == PC) && (tabCC[0][2] == PC)) { winGame=true}
        if ((tabCC[1][0] == PC) && (tabCC[1][1] == PC) && (tabCC[1][2] == PC)) { winGame=true}
        if ((tabCC[2][0] == PC) && (tabCC[2][1] == PC) && (tabCC[2][2] == PC)) { winGame=true}
        if ((tabCC[0][0] == PC) && (tabCC[1][1] == PC) && (tabCC[2][2] == PC)) { winGame=true}
        if ((tabCC[2][0] == PC) && (tabCC[1][1] == PC) && (tabCC[0][2] == PC)) { winGame=true}
     
      return winGame
    }
    
    func resetGame() {
        
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            box.image = nil
        }
        lastValue = "o"
        tabCC = []
        activeBox = 0
        checkInc = 0
        posX = 0
        posY = 0
        randX = 0
        randY = 0
        tabCC = [["_","_","_"],["_","_","_"],["_","_","_"]]
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
