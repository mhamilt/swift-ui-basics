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
        setupAnimation()
        addSquareLayerArray()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(ViewController.update),
                                     userInfo: nil,
                                     repeats: true)
    }
    //--------------------------------------------------------------------------
    func addSquareLayerArray()
    {
        let superlayer = view.layer!
        
        let rect = CGRect(x: 0,
                          y: 0,
                          width: 2,
                          height: 2)
    
        let path = CGPath(rect: rect, transform: nil)
        
        var sublayers: [CAShapeLayer]! = []
        let numLayers = 100
        
        for i in 1..<numLayers
        {
            let sublayer = CAShapeLayer()
            sublayer.fillColor = NSColor.green.cgColor
            sublayer.path = path
            sublayer.bounds = rect
            sublayer.position =
                CGPoint(x: (superlayer.bounds.size.width * CGFloat(i)) / CGFloat(numLayers),
                        y: superlayer.bounds.size.height/2)
            sublayers.append(sublayer)
        }
        superlayer.sublayers = sublayers
    }
    //--------------------------------------------------------------------------

    func setupAnimation()
    {
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.byValue = CGFloat.pi/2
        rotationAnimation.duration = 0.5
        rotationAnimation.isRemovedOnCompletion = false
    }
    //--------------------------------------------------------------------------
    @objc func update()
    {
        for layer in (view.layer!.sublayers!)
        {
            layer.add(rotationAnimation, forKey: nil)
        }
    }
}


//------------------------------------------------------------------------------
// Extensions

extension CGRect
{
    var centre: CGPoint
    {
        return CGPoint(x: self.midX, y: self.midY);
    }
}

extension CGPoint
{
    static func -(left: CGPoint, right: CGPoint) -> CGPoint
    {
        return CGPoint(x: left.x - right.x, y: left.y - right.y);
    }
    static prefix func -(right: CGPoint) -> CGPoint
    {
        return CGPoint(x: -right.x, y: -right.y);
    }
}

extension CGAffineTransform
{
    func translatedBy(_ vector: CGPoint) -> CGAffineTransform
    {
        return self.translatedBy(x: vector.x, y: vector.y);
    }
    
    func rotateAround(point:CGPoint, by: CGFloat) -> CGAffineTransform
    {
        return self.translatedBy(point).rotated(by: 0.25).translatedBy(-point)
    }
}
//------------------------------------------------------------------------------
