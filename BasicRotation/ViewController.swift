import Cocoa

class ViewController: NSViewController
{
    //--------------------------------------------------------------------------
    var timer: Timer!
    var rotationAnimation: CABasicAnimation!
    //--------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.wantsLayer = true
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(ViewController.update),
                                     userInfo: nil,
                                     repeats: true)
        drawSquare()
    }
    //--------------------------------------------------------------------------
    func drawSquare()
    {
        let superlayer = view.layer!

        let rect = CGRect(x: 0,
                          y: 0,
                          width: 20,
                          height: 20)
        
        let path = CGPath(rect: rect, transform: nil)
        let sublayer = CAShapeLayer()
        sublayer.fillColor = NSColor.green.cgColor
        sublayer.path = path
        superlayer.addSublayer(sublayer)

        sublayer.bounds = rect
        sublayer.position = CGPoint(x: superlayer.bounds.size.width/2,
                                    y: superlayer.bounds.size.height/2)

        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.byValue = CGFloat.pi/2
        rotationAnimation.duration = 0.5
        
//        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotationAnimation.isRemovedOnCompletion = false
    }
    //--------------------------------------------------------------------------
    @objc func update()
    {
        view.layer?.sublayers?[0].add(rotationAnimation, forKey: nil)
    }
}

