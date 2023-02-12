//
//  ViewController.swift
//  Animations
//
//  Created by De la Cruz Hernandez on 10/02/23.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    var segmentedControl = UISegmentedControl()
    var animacion = LoaderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl = UISegmentedControl (items: ["Tostadora","Mounstro","Círculos","Random"])
        segmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        segmentedControl.addTarget(self, action: #selector(cambioAnimacion), for: .valueChanged)
        self.view.addSubview(segmentedControl)
        self.view.addSubview(animacion)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        segmentedControl.frame = CGRect(x: 10, y: 40, width:self.view.bounds.width - 20, height: 30)
        animacion.frame.size = CGSize(width: 250, height: 250)
        animacion.center = view.center
    }
    @objc func cambioAnimacion(){
        var animacion = "fish"
        switch segmentedControl.selectedSegmentIndex {
            case 0: animacion = "ani_01"
            case 1: animacion = "ani_02"
            case 2: animacion = "ani_03"
            case 3:
                self.animacion.cargarAnimacionRandom()
                return
            default: animacion = "fish"
        }
        self.animacion.cargarAnimation(nombre: animacion)
    }
}

