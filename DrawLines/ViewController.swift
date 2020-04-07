import Cocoa

class ViewController: NSViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.wantsLayer = true
        drawLine()
    }
    
    func drawLine()
    {
        let superlayer = view.layer!
        
        var sineWave: [CGPoint] = []
        let numSteps = 40
        let radPerStep = 2 * CGFloat.pi / CGFloat(numSteps)
        for i in 0..<numSteps
        {
            let phase = sin(radPerStep*CGFloat(i))
            let xpos = superlayer.bounds.maxX * CGFloat(i) / CGFloat(numSteps)
            let ypos = superlayer.bounds.midY + (phase * superlayer.bounds.midY)
            sineWave.append(CGPoint(x: xpos, y: ypos))
        }
                
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 20, y: 20))
        path.addLines(between: sineWave)
        let sublayer = CAShapeLayer()
        sublayer.strokeColor = NSColor.green.cgColor
        sublayer.fillColor = NSColor.clear.cgColor
        sublayer.lineWidth = 2.0
        sublayer.path = path
        superlayer.addSublayer(sublayer)
    }

}

