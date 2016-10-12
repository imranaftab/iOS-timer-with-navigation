//
//  ViewController.swift
//  NavigationSwift
//
//  Created by Imran Aftab Rana on 12/10/2016.
//  Copyright © 2016 Imran Aftab Rana. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var timer = NSTimer()
    var time:Int = 0
    var sound = AVAudioPlayer()
    
    @IBOutlet weak var btn_Start: UIButton!
    @IBOutlet weak var lbl_TimeLeft: UILabel!
    @IBOutlet weak var txtTimer: UITextField!
    
    @IBOutlet weak var bar: UIToolbar!
    @IBOutlet weak var label: UILabel!

    
    @IBOutlet weak var lblError: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadScreen()
        loadAudioPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    ///////////////////////////////////////////
    func LoadScreen(){
        time = 0
        lbl_TimeLeft.hidden = true
        label.hidden = true
        lblError.hidden = true
        bar.hidden = true
        txtTimer.hidden = false
        btn_Start.hidden = false

    }
    func countDownScreen(){
        lbl_TimeLeft.hidden = false
        label.hidden = false
        bar.hidden = false
        txtTimer.hidden = true
        btn_Start.hidden = true
            }
    func startTimer(){
        if txtTimer.text == ""{
            return
        }
        time = Int(txtTimer.text!)!
        if time <= 0{
            lblError.hidden = false
            return
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("Increment"), userInfo: nil, repeats: true)
        countDownScreen()
    }

    @IBAction func btnStart(sender: AnyObject) {
        startTimer()
    }
    func stopTimer(){
        timer.invalidate()
    }
    func loadAudioPlayer(){
        let file = NSBundle.mainBundle().pathForResource("buzzer", ofType: "wav")
        let filePath = NSURL(fileURLWithPath:file!)
        do {
            try sound = AVAudioPlayer(contentsOfURL: filePath)
            sound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
   
    @IBAction func btnCancelledClick(sender: AnyObject) {
        time = 0
        txtTimer.text = ""
        timer.invalidate()
        LoadScreen()
    }
    func Increment(){
        
        
        if time == 0 {
            sound.play()
        }
        else{
            time = time-1
        }
        label.text = String(time)
    }
}

