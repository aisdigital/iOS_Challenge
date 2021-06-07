//
//  ABOUTViewController.swift
//  Salles Filmes
//
//  Created by Gabriel Vilarouca on 06/06/21.
//

import UIKit

class ABOUTViewController: UIViewController {
    
    let selection = UISelectionFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
        
    @IBOutlet weak var img_fundo: UIImageView!
    @IBOutlet weak var img_cartaz: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var ef_infos: UIVisualEffectView!
    @IBOutlet weak var ef_titulo: UIVisualEffectView!
    @IBOutlet weak var infos: UITextView!
    @IBOutlet weak var trailer_view: UIView!
    @IBOutlet weak var exit_view: UIView!
    
    var link_trailer = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        img_fundo.image = img_do_filme
        img_cartaz.image = img_do_filme
        
        titulo.text = nome_do_filme
        infos.text = descricao_do_filme
        
        //trailer_view.layer.cornerRadius = 25
        //trailer_view.layer.masksToBounds = true
        
        //exit_view.layer.cornerRadius = 25
        //exit_view.layer.masksToBounds = true
        
        img_cartaz.layer.cornerRadius = 40
        img_cartaz.layer.masksToBounds = true
        
        ef_infos.layer.cornerRadius = 20
        ef_infos.layer.masksToBounds = true
        
        ef_titulo.layer.cornerRadius = 20
        ef_titulo.layer.masksToBounds = true
        
        call_url_trailer()
                
    }
    
    func call_url_trailer(){
        let url : String = "https://api.themoviedb.org/3/movie/\(id_do_filme)/videos?api_key=ddbf92b2081a668a948235a40391d458&language=en-US"
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
            _ = String (data: data!, encoding: String.Encoding.utf8)
                              // print("response is \(response)")
                            do {
                                let getResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                                let countryArray = getResponse as! NSDictionary
                                
                                if (countryArray["results"] as! NSArray).count != 0{
                                    let country1 = countryArray["results"] as! NSArray
                                    let valores_data = country1[0] as! NSDictionary
                                    self.link_trailer = valores_data["key"] as! String
                                }else{
                                    self.link_trailer = "SEM"
                                }
                                
                                
                            } catch {
                                   print("error serializing JSON: \(error)")
                            }
                }.resume()
    }
    
    
    @IBAction func sair_click(_ sender: Any) {
        selection.selectionChanged()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func trailer_click(_ sender: Any) {
        if link_trailer == ""{
            msg = "Loading\nPlease wait"
            chamar_alerta()
        }else if link_trailer == "SEM"{
            msg = "This movie has no trailer."
            chamar_alerta()
        }else{
            selection.selectionChanged()
            if let url = URL(string: "https://www.youtube.com/watch?v=\(link_trailer)") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    var msg = ""
    func chamar_alerta(){
        self.notification.notificationOccurred(.error)
        let alert = UIAlertController(title: "iMovies", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true,completion: nil)
    }
    
}
