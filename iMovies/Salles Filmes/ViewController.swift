//
//  ViewController.swift
//  Salles Filmes
//
//  Created by Gabriel Vilarouca on 02/06/21.
//

import UIKit

var id_do_filme = 0
var img_do_filme = #imageLiteral(resourceName: "menorsemfundo.png")
var nome_do_filme = ""
var descricao_do_filme = ""

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    let selection = UISelectionFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
    
    @IBOutlet weak var img_fundo: UIImageView!
    @IBOutlet weak var img_destaque: UIImageView!
    @IBOutlet weak var texto_destaque: UILabel!
    @IBOutlet weak var view_destaque: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ef_carrega: UIView!
    @IBOutlet weak var sc_view: UIScrollView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewDois: UICollectionView!
    @IBOutlet weak var collectionViewTres: UICollectionView!
    @IBOutlet weak var collectionViewQuatro: UICollectionView!
    
    var id_banner = 0
    var nome_banner = NSString()
    var descricao_banner = NSString()
    var img_banner = NSString()
    var img_outra_banner = #imageLiteral(resourceName: "menorsemfundo.png")
    
    var nome_filme1 = [""]
    var descricao_filme1 = [""]
    var foto_filme1 = [#imageLiteral(resourceName: "menorsemfundo.png")]
    var id_filme1 = [0]
    
    var nome_filme2 = [""]
    var descricao_filme2 = [""]
    var foto_filme2 = [#imageLiteral(resourceName: "menorsemfundo.png")]
    var id_filme2 = [0]
    
    var nome_filme3 = [""]
    var descricao_filme3 = [""]
    var foto_filme3 = [#imageLiteral(resourceName: "menorsemfundo.png")]
    var poster_filme3 = [#imageLiteral(resourceName: "menorsemfundo.png")]
    var id_filme3 = [0]
    
    var nome_filme4 = [""]
    var descricao_filme4 = [""]
    var foto_filme4 = [#imageLiteral(resourceName: "menorsemfundo.png")]
    var id_filme4 = [0]
    
    var continuar1 = false
    var continuar2 = false
    var continuar3 = false
    var continuar4 = false
    var timer = Timer()
    
    //paginas collection 1
    var pg1 = 1
    var pg2 = 3
    //paginas collection 2
    var pg3 = 4
    var pg4 = 6
    //paginas collection 3
    var pg5 = 1
    var pg6 = 10
    //paginas collection 4
    var pg7 = 7
    var pg8 = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ef_carrega.isHidden = false
        ef_carrega.alpha = 1
        
        sc_view.layer.cornerRadius = 20
        sc_view.layer.masksToBounds = true
        
        img_destaque.layer.cornerRadius = 25
        img_destaque.layer.masksToBounds = true
        
        collectionView.layer.borderWidth = 0
        collectionView.layer.cornerRadius = 20
        collectionView.backgroundColor = .clear
        
        collectionViewDois.layer.borderWidth = 0
        collectionViewDois.layer.cornerRadius = 20
        collectionViewDois.backgroundColor = .clear
        
        collectionViewTres.layer.borderWidth = 0
        collectionViewTres.layer.cornerRadius = 20
        collectionViewTres.backgroundColor = .clear
        
        collectionViewQuatro.layer.borderWidth = 0
        collectionViewQuatro.layer.cornerRadius = 20
        collectionViewQuatro.backgroundColor = .clear
        
        self.id_filme1.removeAll()
        self.nome_filme1.removeAll()
        self.foto_filme1.removeAll()
        self.descricao_filme1.removeAll()
        
        self.id_filme2.removeAll()
        self.nome_filme2.removeAll()
        self.foto_filme2.removeAll()
        self.descricao_filme2.removeAll()
        
        self.id_filme3.removeAll()
        self.nome_filme3.removeAll()
        self.foto_filme3.removeAll()
        self.poster_filme3.removeAll()
        self.descricao_filme3.removeAll()
        
        self.id_filme4.removeAll()
        self.nome_filme4.removeAll()
        self.foto_filme4.removeAll()
        self.descricao_filme4.removeAll()
        
        banner()
        em_cartaz1()
        em_cartaz2()
        em_cartaz3()
        em_cartaz4()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.mudarImagem), userInfo: nil, repeats: true)
        }
    }
    
    func banner(){
        let url : String = "https://api.themoviedb.org/3/movie/now_playing?api_key=ddbf92b2081a668a948235a40391d458&language=en-US&page=1&region=us"
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
            _ = String (data: data!, encoding: String.Encoding.utf8)
                              // print("response is \(response)")
                            do {
                                let getResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                                let countryArray = getResponse as! NSDictionary
                                let country1 = countryArray["results"] as! NSArray
                                let qual_number = arc4random_uniform(11)
                                let valores_data = country1[Int(qual_number)] as! NSDictionary
                                
                                if (valores_data["poster_path"] as? NSString) != nil{
                                    self.nome_banner  = valores_data["title"] as! NSString
                                    self.img_banner = valores_data["backdrop_path"] as! NSString
                                    self.id_banner = valores_data["id"] as! NSInteger
                                    self.descricao_banner = valores_data["overview"] as! NSString
                                    let img_outra = valores_data["poster_path"] as! NSString
                                    
                                    let url_completa = URL(string: "https://image.tmdb.org/t/p/w500\(img_outra)")
                                    if let data = try? Data(contentsOf: url_completa!) {
                                        self.img_outra_banner = UIImage(data: data) ?? #imageLiteral(resourceName: "sem.png")
                                            //imageView.image = UIImage(data: data)
                                    }
                                    
                                    self.pegar_imagem_banner()
                                }else{
                                    self.banner()
                                }
                                
                                
                            } catch {
                                   print("error serializing JSON: \(error)")
                            }
                }.resume()
    }
    
    //COLOCAR IMAGEM DO BANNER
    func pegar_imagem_banner(){
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(img_banner)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.img_destaque.image = UIImage(data: data)
                    self.img_fundo.image = UIImage(data: data)
                    self.texto_destaque.text = "\(self.nome_banner)"
                }
            }
            task.resume()
        }
    }
    
    //BOTÃO BANNER
    @IBAction func banner_click(_ sender: Any) {
        selection.selectionChanged()
        
        id_do_filme = id_banner
        img_do_filme = img_outra_banner
        nome_do_filme = nome_banner as String
        descricao_do_filme = descricao_banner as String
        
        performSegue(withIdentifier: "about", sender: self)
    }
    
    
    //EM CARTAZ LISTA UM-------------------
    func em_cartaz1(){
        let url : String = "https://api.themoviedb.org/3/movie/now_playing?api_key=ddbf92b2081a668a948235a40391d458&language=en-US&page=\(pg1)&region=us"
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
            _ = String (data: data!, encoding: String.Encoding.utf8)
                              // print("response is \(response)")
                            do {
                                let getResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                                let countryArray = getResponse as! NSDictionary
                                //print(getResponse)
                                let country1 = countryArray["results"] as! NSArray
                                _ = country1[0] as! NSDictionary
                                
                                
                                var contador = -1
                                let contador2 = countryArray.count
                                
                                while contador != contador2{
                                    contador += 1
                                    let valores_data2 = country1[contador] as! NSDictionary
                                    
                                    if (valores_data2["poster_path"] as? NSString) != nil{
                                        
                                        self.id_filme1.append(valores_data2["id"] as! Int)
                                        self.nome_filme1.append(valores_data2["title"] as! String)
                                        self.descricao_filme1.append(valores_data2["overview"] as! String)
                                        let imagem = valores_data2["poster_path"] as! NSString
                                        let url_completa = URL(string: "https://image.tmdb.org/t/p/w500\(imagem)")
                                        if let data = try? Data(contentsOf: url_completa!) {
                                            self.foto_filme1.append(UIImage(data: data)!)
                                                //imageView.image = UIImage(data: data)
                                        }
                                    }
                                }
                                
                                if self.pg1 != self.pg2{
                                    self.pg1 += 1
                                    self.em_cartaz1()
                                }else{
                                    self.continuar1 = true
                                }
                                
                                
                            } catch {
                                   print("error serializing JSON: \(error)")
                            }
                }.resume()
    }
    
    //EM CARTAZ LISTA DOIS-------------------
    func em_cartaz2(){
        let url : String = "https://api.themoviedb.org/3/movie/now_playing?api_key=ddbf92b2081a668a948235a40391d458&language=en-US&page=\(pg3)&region=us"
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
            _ = String (data: data!, encoding: String.Encoding.utf8)
                              // print("response is \(response)")
                            do {
                                let getResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                                let countryArray = getResponse as! NSDictionary
                                //print(getResponse)
                                let country1 = countryArray["results"] as! NSArray
                                _ = country1[0] as! NSDictionary
                                
                                var contador = -1
                                let contador2 = countryArray.count
                                
                                while contador != contador2{
                                    contador += 1
                                    let valores_data2 = country1[contador] as! NSDictionary
                                    
                                    if (valores_data2["poster_path"] as? NSString) != nil{
                                        
                                        self.id_filme2.append(valores_data2["id"] as! Int)
                                        self.nome_filme2.append(valores_data2["title"] as! String)
                                        self.descricao_filme2.append(valores_data2["overview"] as! String)
                                        let imagem = valores_data2["poster_path"] as! NSString
                                        let url_completa = URL(string: "https://image.tmdb.org/t/p/w500\(imagem)")
                                        if let data = try? Data(contentsOf: url_completa!) {
                                            self.foto_filme2.append(UIImage(data: data)!)
                                                //imageView.image = UIImage(data: data)
                                        }
                                    }
                                }
                                
                                if self.pg3 != self.pg4{
                                    self.pg3 += 1
                                    self.em_cartaz2()
                                }else{
                                    self.continuar2 = true
                                }
                                
                                
                            } catch {
                                   print("error serializing JSON: \(error)")
                            }
                }.resume()
    }
    
    //EM CARTAZ LISTA TRES-------------------
    func em_cartaz3(){
        let url : String = "https://api.themoviedb.org/3/movie/now_playing?api_key=ddbf92b2081a668a948235a40391d458&language=en-US&page=\(pg5)&region=us"
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
            _ = String (data: data!, encoding: String.Encoding.utf8)
                              // print("response is \(response)")
                            do {
                                let getResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                                let countryArray = getResponse as! NSDictionary
                                //print(getResponse)
                                let country1 = countryArray["results"] as! NSArray
                                _ = country1[0] as! NSDictionary
                                
                                var contador = -1
                                let contador2 = countryArray.count
                                
                                while contador != contador2{
                                    contador += 1
                                    let valores_data2 = country1[contador] as! NSDictionary
                                    
                                    if (valores_data2["backdrop_path"] as? NSString) != nil && (valores_data2["poster_path"] as? NSString) != nil{
                                        
                                        self.id_filme3.append(valores_data2["id"] as! Int)
                                        self.nome_filme3.append(valores_data2["title"] as! String)
                                        self.descricao_filme3.append(valores_data2["overview"] as! String)
                                        let imagem = valores_data2["poster_path"] as! NSString
                                        let url_completa = URL(string: "https://image.tmdb.org/t/p/w500\(imagem)")
                                        if let data = try? Data(contentsOf: url_completa!) {
                                            self.foto_filme3.append(UIImage(data: data)!)
                                                //imageView.image = UIImage(data: data)
                                        }
                                        
                                        let imagem2 = valores_data2["backdrop_path"] as! NSString
                                        let url_completa2 = URL(string: "https://image.tmdb.org/t/p/w500\(imagem2)")
                                        if let data2 = try? Data(contentsOf: url_completa2!) {
                                            self.poster_filme3.append(UIImage(data: data2)!)
                                                //imageView.image = UIImage(data: data)
                                        }
                                    }
                                }
                                if self.pg5 != self.pg6{
                                    self.pg5 += 1
                                    self.em_cartaz3()
                                }else{
                                    self.continuar3 = true
                                }
                                
                                
                            } catch {
                                   print("error serializing JSON: \(error)")
                            }
                }.resume()
    }
    
    //FILMES POPULARES E BANNER
    func em_cartaz4(){
        let url : String = "https://api.themoviedb.org/3/movie/now_playing?api_key=ddbf92b2081a668a948235a40391d458&language=en-US&page=\(pg7)&region=us"
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
            _ = String (data: data!, encoding: String.Encoding.utf8)
                              // print("response is \(response)")
                            do {
                                let getResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                                let countryArray = getResponse as! NSDictionary
                                //print(getResponse)
                                let country1 = countryArray["results"] as! NSArray
                                _ = country1[0] as! NSDictionary
                                
                                var contador = -1
                                let contador2 = countryArray.count
                                
                                while contador != contador2{
                                    contador += 1
                                    let valores_data2 = country1[contador] as! NSDictionary
                                    
                                    if (valores_data2["poster_path"] as? NSString) != nil{
                                        
                                        self.id_filme4.append(valores_data2["id"] as! Int)
                                        self.nome_filme4.append(valores_data2["title"] as! String)
                                        self.descricao_filme4.append(valores_data2["overview"] as! String)
                                        let imagem = valores_data2["poster_path"] as! NSString
                                        let url_completa = URL(string: "https://image.tmdb.org/t/p/w500\(imagem)")
                                        if let data = try? Data(contentsOf: url_completa!) {
                                            self.foto_filme4.append(UIImage(data: data)!)
                                                //imageView.image = UIImage(data: data)
                                        }
                                    }
                                }
                                if self.pg7 != self.pg8{
                                    self.pg7 += 1
                                    self.em_cartaz4()
                                }else{
                                    self.continuar4 = true
                                }
                                
                                
                            } catch {
                                   print("error serializing JSON: \(error)")
                            }
                }.resume()
    }
    
    //VERIFICAR E COLOCAR NA COLLECTION
    @objc func mudarImagem() {
        if continuar1 == true && continuar2 == true && continuar3 == true && continuar4 == true{
            collectionView.reloadData()
            collectionViewDois.reloadData()
            collectionViewTres.reloadData()
            collectionViewQuatro.reloadData()
            continuar1 = false
            continuar2 = false
            continuar3 = false
            continuar4 = false
            notification.notificationOccurred(.success)
            UIView.animate(withDuration: 0.5, animations: {
                self.ef_carrega.alpha = 0
            })
            timer.invalidate()
        }
    }
    
    //COLLECTION VIEW COLOCAR
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return foto_filme1.count
        }else if collectionView == self.collectionViewDois {
            return foto_filme2.count
        }else if collectionView == self.collectionViewTres {
            return poster_filme3.count
        }else{
            return foto_filme4.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell1", for: indexPath) as! ImageCollectionViewCell
            
            cell1.backgroundColor = .clear
            cell1.imgImage.layer.cornerRadius = 20
            cell1.imgImage.image = image(foto_filme1[indexPath.row], withSize: CGSize(width: 120, height: 190))
            
            return cell1
        }else if collectionView == self.collectionViewDois{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell2", for: indexPath) as! ImageCollectionViewCell
            
            cell1.backgroundColor = .clear
            cell1.imgImageDois.layer.cornerRadius = 20
            cell1.imgImageDois.image = image(foto_filme2[indexPath.row], withSize: CGSize(width: 120, height: 190))
            
            return cell1
        }else if collectionView == self.collectionViewTres{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell3", for: indexPath) as! ImageCollectionViewCell
            
            cell1.backgroundColor = .clear
            cell1.imgImageTres.layer.cornerRadius = 20
            cell1.imgImageTres.image = image(poster_filme3[indexPath.row], withSize: CGSize(width: 370, height: 200))
            
            return cell1
        }else{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell4", for: indexPath) as! ImageCollectionViewCell
            
            cell1.backgroundColor = .clear
            cell1.imgImageQuatro.layer.cornerRadius = 20
            cell1.imgImageQuatro.image = image(foto_filme4[indexPath.row], withSize: CGSize(width: 120, height: 190))
            
            return cell1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selection.selectionChanged()
        if collectionView == self.collectionView{
            id_do_filme = id_filme1[indexPath.row]
            img_do_filme = foto_filme1[indexPath.row]
            nome_do_filme = nome_filme1[indexPath.row]
            descricao_do_filme = descricao_filme1[indexPath.row]
        }else if collectionView == self.collectionViewDois{
            id_do_filme = id_filme2[indexPath.row]
            img_do_filme = foto_filme2[indexPath.row]
            nome_do_filme = nome_filme2[indexPath.row]
            descricao_do_filme = descricao_filme2[indexPath.row]
        }else if collectionView == self.collectionViewTres{
            id_do_filme = id_filme3[indexPath.row]
            img_do_filme = foto_filme3[indexPath.row]
            nome_do_filme = nome_filme3[indexPath.row]
            descricao_do_filme = descricao_filme3[indexPath.row]
        }else{
            id_do_filme = id_filme4[indexPath.row]
            img_do_filme = foto_filme4[indexPath.row]
            nome_do_filme = nome_filme4[indexPath.row]
            descricao_do_filme = descricao_filme4[indexPath.row]
        }
        performSegue(withIdentifier: "about", sender: self)
    }
    
    //FORMATAR IMAGEM
    func image( _ image:UIImage, withSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.automatic)
    }
    
    //PESQUISAR
    @IBAction func buscar_click(_ sender: Any) {
        selection.selectionChanged()
        performSegue(withIdentifier: "buscar", sender: self)
    }
}

