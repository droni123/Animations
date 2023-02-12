//
//  LoaderView.swift
//  Animations
//
//  Created by De la Cruz Hernandez on 10/02/23.
//

//import Foundation
import Lottie
import UIKit


public class LoaderView: UIView {
    
    private let animationView:LottieAnimationView
    
    override public init(frame: CGRect) {
        animationView = LottieAnimationView()
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder){
        animationView = LottieAnimationView()
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit(){
        cargarAnimation(nombre: "fish")
        animationView.frame = CGRect(x:0,y:0,width: 280, height: 280)
        animationView.center = self.center
        animationView.animationSpeed = 0.2
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        self.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        self.addSubview(animationView)
        
        
    }
    @objc func cargarAnimation(nombre nombreAnimation:String) {
        if let path = Bundle.main.path(forResource: nombreAnimation, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let animation:LottieAnimation = try JSONDecoder().decode(LottieAnimation.self, from: data)
                    animationView.animation = animation
                    animationView.play()
            } catch {
                print("No se pudo cargar archivo")
            }
        }
    }
    @objc func cargarAnimacionRandom(){
        let randomInt = Int.random(in: 4...10)
        if let laUrl = URL(string: "https://idel.com.mx/dadm/ani_\(String(format: "%02d", randomInt)).json"){
            let configuracion = URLSessionConfiguration.ephemeral
            let session = URLSession(configuration: configuracion)
            let elReq = URLRequest(url: laUrl)
            let task = session.dataTask(with: elReq) { bytes, response, error in
                if error == nil {
                    guard let data = bytes else { return }
                    do {
                        let animation:LottieAnimation = try JSONDecoder().decode(LottieAnimation.self, from: data)
                        DispatchQueue.main.async() {
                            self.animationView.animation = animation
                            self.animationView.play()
                        }
                    } catch {
                        DispatchQueue.main.async() {
                            self.cargarAnimacionRandomLocal()
                        }
                    }
                }else{
                    DispatchQueue.main.async() {
                        self.cargarAnimacionRandomLocal()
                    }
                }
            }
            task.resume()
        }
    }
    @objc func cargarAnimacionRandomLocal(){
        let randomInt = Int.random(in: 1...3)
        let animacionLocal = "ani_0\(randomInt)"
        self.cargarAnimation(nombre: animacionLocal )
    }
}
