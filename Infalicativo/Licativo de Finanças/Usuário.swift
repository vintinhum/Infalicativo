//
//  Usuário.swift
//  Licativo de Finanças
//
//  Created by Vítor Bárrios Luís de Albuquerque on 10/03/20.
//  Copyright © 2020 Vítor Bárrios Luís de Albuquerque. All rights reserved.
//

import Foundation

class Usuário {
    
    var gastoDomestica: Float
    var gastoAlimentacao: Float
    var gastoRoupa: Float
    var gastoLazer: Float
    var saldoBancario: Float
    var rendaMensal: Float
    
    init(gastoDomestica: Float, gastoAlimentacao: Float, gastoRoupa: Float, gastoLazer: Float, saldoBancario: Float, rendaMensal: Float) {
        
        self.gastoDomestica = gastoDomestica
        self.gastoAlimentacao = gastoAlimentacao
        self.gastoRoupa = gastoRoupa
        self.gastoLazer = gastoLazer
        self.saldoBancario = saldoBancario
        self.rendaMensal = rendaMensal
    }
    
    func valorVitor() {
        print("gastoDomestica: \(self.gastoDomestica)")
        print("gastoAlimentacao: \(self.gastoAlimentacao)")
        
        print("gastoRoupa: \(self.gastoRoupa)")
        
        
        print("gastoLazer: \(self.gastoLazer)")
    }
    
}
