//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by муса магсумов on 05/03/2019.
//  Copyright © 2019 Michel Deiman. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController,UISplitViewControllerDelegate {
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc  = secondaryViewController as? ConcentrationViewController{
            if cvc.theme == nil{
                return true
            }
        }
       
        return false
    }
    
  
   
    
    
    @IBAction func changeTheme(_ sender: Any){
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender as! UIButton)
        }
        
    }
    
    private var splitViewDetailConcentrationViewController:ConcentrationViewController?{
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController :ConcentrationViewController?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "Choose Theme", let cvc = segue.destination as? ConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
                lastSeguedToConcentrationViewController = cvc
            }
        }
        
    }
    
    
}
