import Cocoa

class ViewController: NSViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.wantsLayer = true
        drawSquare()
    }
    
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
    }

}

