//
//  SEARCHViewController.swift
//  Salles Filmes
//
//  Created by Gabriel Vilarouca on 06/06/21.
//

import UIKit

class SEARCHViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var texto_pesquisa: UITextField!
    @IBOutlet weak var ef_carrefa: UIVisualEffectView!
    @IBOutlet weak var ef_texto: UIVisualEffectView!
    @IBOutlet weak var ef_table: UIVisualEffectView!
    
    let selection = UISelectionFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
    
    var nome_filme = [""]
    var descricao_filme = [""]
    var foto_filme = [#imageLiteral(resourceName: "menorsemfundo.png")]
    var id_filme = [0]
    var pesquisa = ""
    var continuar = false
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 40
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        
        ef_table.layer.cornerRadius = 40
        ef_table.clipsToBounds = true
        
        ef_texto.layer.borderWidth = 0
        ef_texto.layer.cornerRadius = 20
        ef_texto.clipsToBounds = true
        
        texto_pesquisa.layer.borderWidth = 0
        texto_pesquisa.layer.cornerRadius = 20
        texto_pesquisa.backgroundColor = .clear
        texto_pesquisa.clipsToBounds = true
        
    }
    
    @IBAction func digitar(_ sender: Any) {
        iniciar_pesquisa()
    }
    
    @IBAction func done(_ sender: UITextField) {
        iniciar_pesquisa()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        iniciar_pesquisa()
        return true
    }
    
    func iniciar_pesquisa(){
        let ab = texto_pesquisa.text ?? ""
        pesquisa = ab.trimmingCharacters(in: .whitespacesAndNewlines)
        if texto_pesquisa.text != "" && texto_pesquisa.text != " "{
            self.id_filme.removeAll()
            self.nome_filme.removeAll()
            self.foto_filme.removeAll()
            self.descricao_filme.removeAll()
            texto_pesquisa.resignFirstResponder()
            UIView.animate(withDuration: 1, animations: {
                self.ef_carrefa.isHidden = false
                self.ef_carrefa.alpha = 1
            })
            chamar_urlf()
        }
    }
    
    @IBAction func voltar_click(_ sender: Any) {
    }
    
    //BUSCAR RESULTADOS
    func chamar_urlf(){
        let url : String = "https://api.themoviedb.org/3/search/movie?api_key=ddbf92b2081a668a948235a40391d458&language=en-US&query=%20\(pesquisa)&page=1&include_adult=false"
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
            _ = String (data: data!, encoding: String.Encoding.utf8)
                              // print("response is \(response)")
                            do {
                                let getResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                                let countryArray = getResponse as! NSDictionary
                                
                                if (countryArray["results"] as! NSArray).count != 0{
                                    let country1 = countryArray["results"] as! NSArray
                                    _ = country1[0] as! NSDictionary
                                    
                                    var contador = -1
                                    let contador2 = countryArray.count
                                                                        
                                    while contador != contador2{
                                        contador += 1
                                        let valores_data2 = country1[contador] as! NSDictionary
                                        
                                        if (valores_data2["poster_path"] as? NSString) != nil{
                                            
                                            self.id_filme.append(valores_data2["id"] as! Int)
                                            self.nome_filme.append(valores_data2["title"] as! String)
                                            self.descricao_filme.append(valores_data2["overview"] as! String)
                                            let imagem = valores_data2["poster_path"] as! NSString
                                            let url_completa = URL(string: "https://image.tmdb.org/t/p/w500\(imagem)")
                                            if let data = try? Data(contentsOf: url_completa!) {
                                                self.foto_filme.append(UIImage(data: data)!)
                                                    //imageView.image = UIImage(data: data)
                                            }
                                        }
                                    }
                                    
                                    self.continuar = true
                                    DispatchQueue.main.async {
                                        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.pronto), userInfo: nil, repeats: true)
                                    }
                                    
                                }else{
                                    self.msg = "Cannot found"
                                    self.chamar_alerta()
                                }
                                
                                
                            } catch {
                                   print("error serializing JSON: \(error)")
                            }
                }.resume()
    }
    
    //VERIFICAR E COLOCAR NA TABLE
    @objc func pronto() {
        if continuar == true{
            continuar = false
            notification.notificationOccurred(.success)
            tableView.reloadData()
            UIView.animate(withDuration: 1, animations: {
                self.ef_carrefa.alpha = 0
                self.ef_carrefa.isHidden = true
            })
            UIView.animate(withDuration: 2, animations: {
                self.ef_table.isHidden = false
                self.ef_table.alpha = 1
            })
            timer.invalidate()
        }
    }
    
    //TABELA
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foto_filme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = nome_filme[indexPath.row]
        cell?.layer.borderWidth = 0.5
        cell?.textLabel?.numberOfLines = 0
        let myColor = UIColor.black
        cell?.layer.borderColor = myColor.cgColor
        cell?.textLabel?.textColor = myColor
        cell?.textLabel?.font = UIFont(name:"System-Medium",size:25)
        cell?.backgroundColor = .clear
        cell?.contentView.backgroundColor = UIColor(white: 1, alpha: 0)
        cell?.imageView!.image = image(foto_filme[indexPath.row], withSize: CGSize(width: 120, height: 190))
        cell?.imageView?.layer.cornerRadius = 20
        cell?.imageView?.clipsToBounds = true
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection.selectionChanged()
        id_do_filme = id_filme[indexPath.row]
        img_do_filme = foto_filme[indexPath.row]
        nome_do_filme = nome_filme[indexPath.row]
        descricao_do_filme = descricao_filme[indexPath.row]
        performSegue(withIdentifier: "bbc", sender: self)
    }
    
    
    //AJUSTADOR DE IMAGEM
    func image( _ image:UIImage, withSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.automatic)
    }
    
    //VOLTAR
    @IBAction func sair_click(_ sender: Any) {
        selection.selectionChanged()
        dismiss(animated: true, completion: nil)
    }
    
    //MENSAGEM
    var msg = ""
    func chamar_alerta(){
        self.notification.notificationOccurred(.error)
        let alert = UIAlertController(title: "iMovies", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true,completion: nil)
    }
    
}
