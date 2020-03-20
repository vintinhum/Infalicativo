//
//  ViewController.swift
//  Licativo de Finanças
//
//  Created by Vítor Bárrios Luís de Albuquerque on 02/03/20.
//  Copyright © 2020 Vítor Bárrios Luís de Albuquerque. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //retornarView.isHidden = false
        pageOneView.isHidden = false
        pageTwoView.isHidden = true
        proximoView.isHidden = true
        etapaLabel.text = "Coleta de Dados (Etapa 1 de 3)"
        retornarView.isHidden = true
        labelPrincipal.text = "Por gentileza, nos informe seu saldo bancário atual e sua renda mensal."
        labelAuxiliar1.text = "Seu saldo bancário:"
        labelAuxiliar2.text = "Sua renda mensal:"
        labelAuxiliar2.isHidden = false
        
        
        
    }
    
    
    @IBOutlet weak var pageOneView: UIView!
    @IBOutlet var calcularView: UIView!
    @IBOutlet var proximoView: UIView!
    @IBOutlet var retornarView: UIView!
    @IBOutlet var pageTwoView: UIView!
    @IBOutlet var pageThreeView: UIView!
    
    
    @IBOutlet var labelGastoTotal: UILabel!
    @IBOutlet var labelRendaTotal: UILabel!
    @IBOutlet weak var labelPrincipal: UILabel!
    @IBOutlet var etapaLabel: UILabel!
    @IBOutlet var resultado: UILabel!
    @IBOutlet var labelAuxiliar1: UILabel!
    @IBOutlet var labelAuxiliar2: UILabel!
    
    
    @IBOutlet var saldoTextField: UITextField!
    @IBOutlet var rendaTextField: UITextField!
    @IBOutlet var domesticaTextField: UITextField!
    @IBOutlet var alimentacaoTextField: UITextField!
    @IBOutlet var roupasTextField: UITextField!
    @IBOutlet var lazerTextField: UITextField!
    
    
    let vitor: Usuário = Usuário(gastoDomestica: 0, gastoAlimentacao: 0, gastoRoupa: 0, gastoLazer: 0, saldoBancario: 0, rendaMensal: 0)
    
    //    var valoresDespesasBackUp: [Float] = []
    func lerSaldoERenda () {
        
        var saldoBancario: String = saldoTextField.text!
        var rendaMensal: String = rendaTextField.text!
        saldoBancario = saldoBancario.replacingOccurrences(of: ",", with: ".")
        rendaMensal = rendaMensal.replacingOccurrences(of: ",", with: ".")
        
        vitor.saldoBancario = Float(saldoBancario) ?? 0
        vitor.rendaMensal = Float(rendaMensal) ?? 0
    }
    
    func lerGastoTotal() {
        
        //Lê o que está em cada text field de despesas.
        var despesaDomestica: String = domesticaTextField.text!
        var despesaAlimentacao: String = alimentacaoTextField.text!
        var despesaRoupas: String = roupasTextField.text!
        var despesaLazer: String = lazerTextField.text!
        
        despesaDomestica = despesaDomestica.replacingOccurrences(of: ",", with: ".")
        despesaAlimentacao = despesaAlimentacao.replacingOccurrences(of: ",", with: ".")
        despesaRoupas = despesaRoupas.replacingOccurrences(of: ",", with: ".")
        despesaLazer = despesaLazer.replacingOccurrences(of: ",", with: ".")
        
        
        
        //Transforma texto em Float
        vitor.gastoDomestica = Float(despesaDomestica) ?? 0.0
        vitor.gastoAlimentacao = Float(despesaAlimentacao) ?? 0.0
        vitor.gastoRoupa = Float(despesaRoupas) ?? 0.0
        vitor.gastoLazer = Float(despesaLazer) ?? 0.0
        
        
    }
    
    
    @IBAction func inserirSaldoERenda() {
        lerSaldoERenda()
        if (saldoTextField.text?.count != 0 && rendaTextField.text?.count != 0){
            proximoView.isHidden = false
        }
        else {
            proximoView.isHidden = true
        }
    }
    
    @IBAction func inserirValoresDespesas() {
        lerGastoTotal()
        if (domesticaTextField.text?.count != 0 && alimentacaoTextField.text?.count != 0 && roupasTextField.text?.count != 0 && lazerTextField.text?.count != 0) {
            calcularView.isHidden = false
            
        }
            
        else {
            calcularView.isHidden = true
            proximoView.isHidden = true
            resultado.text = ""
        }
    }
    
    
    func despesaTotal() -> Float {
        
        let despesaDomAli: Float
        let despesaRouLaz: Float
        let despesaTotal: Float
        despesaDomAli = vitor.gastoDomestica + vitor.gastoAlimentacao
        despesaRouLaz = vitor.gastoRoupa + vitor.gastoLazer
        despesaTotal = despesaDomAli + despesaRouLaz
        return despesaTotal
    }
    
    @IBAction func botaoCalcular(_ sender: UIButton) {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.alwaysShowsDecimalSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "pt_BR")
        let resultadoSomaCurrency = currencyFormatter.string(from: NSNumber(value: despesaTotal()))
        print(resultadoSomaCurrency)
        resultado.text = "Total: " + (resultadoSomaCurrency ?? "")
        proximoView.isHidden = false
    }
    
    @IBAction func botaoPróximo() {
        if (pageTwoView.isHidden == false && proximoView.isHidden == false && etapaLabel.text == "Coleta de Dados (Etapa 2 de 3)"){
            pageTwoView.isHidden = true
            proximoView.isHidden = true
            etapaLabel.text = "Resultado (Etapa 3 de 3)"
            retornarView.isHidden = false
            labelAuxiliar1.isHidden = true
            labelPrincipal.text = "Nos últimos 3 meses, esse foi o seu rendimento:"
            pageThreeView.isHidden = false
            
            let currencyFormatter = NumberFormatter()
            currencyFormatter.alwaysShowsDecimalSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.locale = Locale(identifier: "pt_BR")
            
            
            let resultadoSomaCurrency = currencyFormatter.string(from: NSNumber(value: despesaTotal()))
            labelGastoTotal.text = "Gastou " + (resultadoSomaCurrency ?? "")
            
            
            let resultadoRenda3Meses = currencyFormatter.string(from: NSNumber(value: renda3Meses()))
            labelRendaTotal.text = "Rendeu " + (resultadoRenda3Meses ?? "")
            
            
            let resultadoDifGastoRenda = currencyFormatter.string(from: NSNumber(value: difGastoRenda()))
            
            
            let resultadoSaldoTotal = currencyFormatter.string(from: NSNumber(value: saldoTotal()))
                
            if (difGastoRenda() < 0){
                resultado.text = "Nesse ritmo, seu saldo chegará a zero em " + (numeroDeMesesAteFalencia()) + " meses."
            }
            else if (difGastoRenda() > 0){
                
                resultado.text = "Nesse ritmo, em 6 meses, seu saldo total será de " + (resultadoSaldoTotal ?? "") + "."
            }
            
            else {
                resultado.text = "Você não teve lucro nem prejuízo."
            }

        }
        else {
            pageOneView.isHidden = true
            pageTwoView.isHidden = false
            etapaLabel.text = "Coleta de Dados (Etapa 2 de 3)"
            retornarView.isHidden = false
            labelPrincipal.text = "Quanto você gastou com as seguintes despesas nos últimos 3 meses?"
            labelAuxiliar1.text = "Domésticas"
            labelAuxiliar2.isHidden = true
            resultado.isHidden = false
            proximoView.isHidden = true
        }
    }
    
    @IBAction func botaoRetornar() {
        if (pageTwoView.isHidden == false){
            retornarView.isHidden = false
            
        }
        if /* A tela atual é a de Etapa 3*/(pageTwoView.isHidden == true && proximoView.isHidden == true && etapaLabel.text == "Resultado (Etapa 3 de 3)") {
            pageTwoView.isHidden = false
            proximoView.isHidden = false
            etapaLabel.text = "Coleta de Dados (Etapa 2 de 3)"
            retornarView.isHidden = false
            labelAuxiliar1.isHidden = false
            labelPrincipal.text = "Quanto você gastou com as seguintes despesas nos últimos 3 meses?"
            pageThreeView.isHidden = true
            
            let currencyFormatter = NumberFormatter()
            currencyFormatter.alwaysShowsDecimalSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.locale = Locale(identifier: "pt_BR")
            let resultadoSomaCurrency = currencyFormatter.string(from: NSNumber(value: despesaTotal()))
            resultado.text = "Total: " + (resultadoSomaCurrency ?? "")
        }
            
        else /*A tela atual é a de etapa 2*/{
            pageOneView.isHidden = false
            pageTwoView.isHidden = true
            proximoView.isHidden = false
            etapaLabel.text = "Coleta de Dados (Etapa 1 de 3)"
            retornarView.isHidden = true
            labelPrincipal.text = "Por gentileza, nos informe seu saldo bancário atual e sua renda mensal, respectivamente."
            labelAuxiliar1.text = "Seu saldo bancário:"
            labelAuxiliar2.isHidden = false
            labelAuxiliar2.text = "Sua renda mensal:"
            resultado.isHidden = true
            
        }
    }
    
    
    
    
    func renda3Meses() -> Float{
        //        //Multiplica valor inserido no text field de Renda Mensal por 3.
        let renda3meses: Float = vitor.rendaMensal * 3
        return renda3meses
    }
    
    func difGastoRenda() -> Float{
        //Subtrai o resultado de despesaTotal() do resultado de renda3Meses().
        let difGastoRenda: Float = renda3Meses() - despesaTotal()
        return difGastoRenda
        
    }
    func difGastoRenda6Meses() -> Float {
        //Multiplica resultado de difGastoRenda() por 6.
        let difGastoRenda6Meses: Float = difGastoRenda() * 6
        return difGastoRenda6Meses
    }
    func saldoTotal() -> Float {
        //Soma valor inserido no text field de Saldo com o resultado de difGastoRenda6meses().
        let saldoTotal: Float = vitor.saldoBancario + difGastoRenda6Meses()
        return saldoTotal
    }
    
    func numeroDeMesesAteFalencia() -> String {
        
        var numeroDeMesesAteFalencia: String = String (round((vitor.saldoBancario * 3) / abs(difGastoRenda())))
        numeroDeMesesAteFalencia = numeroDeMesesAteFalencia.replacingOccurrences(of: ".0", with: "")
        
        return numeroDeMesesAteFalencia
    }
}





