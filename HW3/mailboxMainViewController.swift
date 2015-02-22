//
//  mailboxMainViewController.swift
//  HW3
//
//  Created by Nissana Akranavaseri on 2/21/15.
//  Copyright (c) 2015 nissana. All rights reserved.
//

import UIKit

class mailboxMainViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var helpLabel: UIImageView!
    @IBOutlet weak var searchBox: UIImageView!
    @IBOutlet weak var navMenu: UIImageView!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var colorView: UIImageView!
    @IBOutlet weak var leftIcon: UIImageView!
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var message: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var listImage: UIImageView!
    
    var panGestureRecognizer: UIPanGestureRecognizer!
    var panEdgeGestureRecognizer: UIPanGestureRecognizer!
    var msgStartingPanBeganX: CGFloat! = 0
    var msgLastPanX: CGFloat! = 0
    
    var gray: UIColor!
    var red: UIColor!
    var green: UIColor!
    var yellow: UIColor!
    var tan: UIColor!
    
    @IBOutlet weak var menuControl: UISegmentedControl!
    @IBOutlet weak var laterImage: UIImageView!
    @IBOutlet weak var archiveImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ScrollView
        var scrollable = feedImage.frame.height + 5
        scrollable += searchBox.frame.height
        scrollable += helpLabel.frame.height
        scrollView.contentSize = CGSize(width: feedImage.frame.width, height: scrollable)
        
        //Swipe Colors
        gray = UIColorFromRGB ("CCCCCC")
        red = UIColorFromRGB ("E33C27")
        green = UIColorFromRGB ("62D54F")
        yellow = UIColorFromRGB ("F8CB28")
        tan = UIColorFromRGB ("CD9562")
        
        rightIcon.alpha = 0
        leftIcon.alpha = 0
        rescheduleImage.hidden = true
        listImage.hidden = true
        laterImage.hidden = true
        archiveImage.hidden = true
        
        //Gestures load...
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        panEdgeGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onEdgePan:")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //GESTURES
    @IBAction func onCustomPan(sender: UIPanGestureRecognizer) {
        
        //PAN allows tracking of these :
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)

        
        if (sender.state == UIGestureRecognizerState.Began){
            msgStartingPanBeganX = message.frame.origin.x
            
        } else if (sender.state == UIGestureRecognizerState.Changed){
            msgLastPanX = msgStartingPanBeganX + translation.x
            message.frame.origin.x = msgLastPanX
            
            //trailing icons
            rightIcon.frame.origin.x = msgLastPanX + 320 + 20 //msgOrigin + msgWidth + padding
            leftIcon.frame.origin.x = msgLastPanX - 25 - 20 //msgOrigin + iconWidth + padding

            //Swipe Left - velocity.x < 0
            if (msgLastPanX < 0 ){
                rightIcon.image = UIImage(named: "later_icon")
                
                    // 0...-60
                    if (msgLastPanX >= -60){
                        colorView.backgroundColor =  gray
                        rightIcon.frame.origin.x = 280
                        
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.rightIcon.alpha = 1
                        self.leftIcon.alpha = 0
                        })
                    }
                    // ...< -260
                    else if (msgLastPanX < -260){
                        colorView.backgroundColor = tan
                        rightIcon.image = UIImage(named: "list_icon")
                        rightIcon.frame.origin.x = msgLastPanX + 320 + 20
                    }
                    // in between
                    else {
                        colorView.backgroundColor = yellow
                        rightIcon.frame.origin.x = msgLastPanX + 320 + 20
                    }
            }
                
            //Swipe Right +
            else{
                leftIcon.image = UIImage(named: "archive_icon")
                
                    // 0...60
                    if (msgLastPanX < 60 ){
                        colorView.backgroundColor =  gray
                        leftIcon.frame.origin.x = 18
                        
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.leftIcon.alpha = 1
                            self.rightIcon.alpha = 0
                        })
                    }
                    // ...> 260
                    else if (msgLastPanX > 260){
                        colorView.backgroundColor = red
                        leftIcon.image = UIImage(named: "delete_icon")
                    }
                    // in between
                    else {
                        colorView.backgroundColor = green
                    }
            }
            
        } else if (sender.state == UIGestureRecognizerState.Ended){
          //SNAP on release
            msgLastPanX = message.frame.origin.x

            //Swipe Left -
            if (msgLastPanX < 0){
                if (msgLastPanX > -60){
                    message.frame.origin.x = 0
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self.rightIcon.alpha = 0
                    })
                }
                else if (msgLastPanX < -260){
                    message.frame.origin.x = -300
                    rightIcon.frame.origin.x = -300+320+20
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.listImage.hidden = false
                    })
                }
                else{
                    
                    UIView.animateWithDuration(0.2, delay: 0, options: nil, animations: { () -> Void in
                            self.message.frame.origin.x = -320
                            self.rightIcon.frame.origin.x = -300
                       
                        }, completion: { (Bool) -> Void in
                            self.rescheduleImage.hidden = false
                    })

                }
            }
            
            //Swipe Right +
            else{
                if (msgLastPanX < 60){
                    message.frame.origin.x = 0
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self.leftIcon.alpha = 0
                    })
                }
                else if (msgLastPanX > 260){
                    message.frame.origin.x = 300
                    leftIcon.frame.origin.x = 300-25-20
                }
                else{
                    message.frame.origin.x = 260
                    leftIcon.frame.origin.x = 260-25-20
                }
            }
            
        }//ended Pan
        
    }//end onCustomPan
    
    
    @IBAction func goToMenu(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.containerView.frame.origin.x = 280
        })
        rescheduleImage.hidden = true
        listImage.hidden = true
    }

    
    @IBAction func onEdgePan(sender: UIPanGestureRecognizer) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
             self.containerView.frame.origin.x = 0
        })
    }
    
    
    @IBAction func dismissReschedule(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        rescheduleImage.hidden = true
        listImage.hidden = true
        
        UIView.animateWithDuration(1, animations: { () -> Void in
        self.messageView.frame.origin.y = -85
        self.feedImage.frame.origin.y = -85/2
        })

        reset()
    }

    func reset (){
        //var resetPositionY = self.messageView.frame.height = 85
        self.message.frame.origin = CGPoint(x:0, y:0)
        self.colorView.backgroundColor = self.gray
        rightIcon.alpha = 0
        leftIcon.alpha = 0
        
        UIView.animateWithDuration(1, delay: 0.5, options: nil, animations: { () -> Void in
            self.feedImage.frame.origin.y = 85
            self.messageView.frame.origin = CGPoint(x:0, y:85)
            }, completion: { (Bool) -> Void in
        })
    }
    


    //HELPERS
    
    //Allow multiple gestures!
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    //Segment controller
    @IBAction func toMainPage(sender: AnyObject) {
        archiveImage.hidden = true
        laterImage.hidden = true
        menuControl.selectedSegmentIndex = 1
    }
    @IBAction func tabMenuControl(sender: AnyObject) {
        if(menuControl.selectedSegmentIndex == 0)
        {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.laterImage.hidden = false
            })
            
        }else if (menuControl.selectedSegmentIndex == 2){
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.archiveImage.hidden = false
            })
        }else{
            menuControl.selectedSegmentIndex == 1
        }
    }
    
    func dismissEditing (){
        view.endEditing(true)
        view.hidden = true
    }
    
    //Shakes to undo
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: (UIEvent!)) {
        if(event.subtype == UIEventSubtype.MotionShake) {
            
        let alertController = UIAlertController(title: "Undo?", message: "Mail will be in your inbox.", preferredStyle: .Alert)
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in}
        alertController.addAction(cancelAction)
            
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
            //refresh
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.messageView.frame.origin.y = -85
                self.feedImage.frame.origin.y = -85/2
            })
            self.reset()
        }
        alertController.addAction(OKAction)
            
        self.presentViewController(alertController, animated: true) {}

        }//end if
    }//end Shakes
   
    
    //UIColor(red: r/255, green: g/255, blue: b/255, alpha: CGFloat(alpha))
    //UIColorFromRGB("000000", alpha: 1.0) or www.touch-code-magazine.com/web-color-to-uicolor-convertor/
    func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
        var scanner = NSScanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
}
