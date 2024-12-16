//
//  ContentView.swift
//  ForeTellSwiftUIAppKitAppDelegate
//
//  Created by charlie on 14/12/2024.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var viewModel: ExternalModel
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            HStack()
            {
                Text(self.viewModel.column1).font(.system(size: Constants.textSize))
                
                Text(self.viewModel.column2).font(.system(size: Constants.textSize))
                
                Text(self.viewModel.column3).font(.system(size: Constants.textSize))
            }
            .padding(.bottom)
            
            Text(self.viewModel.doctorInfo).font(.system(size: Constants.textSize))
            
            if self.viewModel.errors != ""
            {
                Text(self.viewModel.errors).padding(.top).font(.system(size: Constants.textSize))
            }
        }
        .padding(Constants.padding)
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView(viewModel: ExternalModel(runUpdate: true)).frame(width: 700, height: 500)
    }
}
