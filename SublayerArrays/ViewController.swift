import Cocoa

class ViewController: NSViewController
{
    //--------------------------------------------------------------------------
    var timer: Timer!
    var waveAnimations: [CABasicAnimation]! = []
    let numLayers = 100
    var phasor: CGFloat = 0.0;
    let animationKey = "sine"
    //--------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.wantsLayer = true
        setupAnimation()
        addSquareLayerArray()
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(ViewController.update),
                                     userInfo: nil,
                                     repeats: true)
        
        for (layer,animation) in zip(view.layer!.sublayers!,waveAnimations)
        {
            layer.add(animation, forKey: animationKey)
        }
        
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
        
        
        for i in 0..<numLayers
        {
            let sublayer = CAShapeLayer()
            sublayer.fillColor = NSColor.green.cgColor
            sublayer.path = path
            sublayer.bounds = rect
            sublayer.position =
                CGPoint(x: (superlayer.bounds.size.width * CGFloat(i)) / CGFloat(numLayers) + rect.width,
                        y: superlayer.bounds.size.height/2)
            sublayers.append(sublayer)
        }
        superlayer.sublayers = sublayers
    }
    //--------------------------------------------------------------------------

    func setupAnimation()
    {
          for i in 0..<numLayers
          {
            let waveNodeAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            waveNodeAnimation.byValue =
                (sin(((2 * CGFloat.pi) * CGFloat(i)) / CGFloat(numLayers))) * view.bounds.midY            
            waveNodeAnimation.duration = 0.1
            waveNodeAnimation.fillMode = CAMediaTimingFillMode.forwards
            waveNodeAnimation.isRemovedOnCompletion = false
            waveAnimations.append(waveNodeAnimation)
        }
        

    }
    //--------------------------------------------------------------------------
    @objc func update()
    {
        phasor += 1.0;
                
        for i in 0..<numLayers
        {
            weak var layer = view.layer?.sublayers![i]
            weak var animation = waveAnimations[i]
            animation?.fromValue = animation?.toValue
            animation?.toValue = (sin(((2 * CGFloat.pi) * (CGFloat(i) + phasor)) / CGFloat(numLayers))) * view.bounds.midY
            layer?.add(animation!, forKey: animationKey)
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
