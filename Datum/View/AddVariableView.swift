//
//  AddVariableView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-08.
//

import SwiftUI
import CoreData

struct AddVariableView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    var dataset: Dataset
    var continuousFetchRequest: FetchRequest<ContinuousVariable>
    var categoricalFetchRequest: FetchRequest<CategoricalVariable>
    
    init(dataset: Dataset) {
        
        self.dataset = dataset
        self.continuousFetchRequest = FetchRequest<ContinuousVariable>(entity: ContinuousVariable.entity(), sortDescriptors: [], predicate: NSPredicate(format: "dataset = %@", dataset), animation: .default)
        self.categoricalFetchRequest = FetchRequest<CategoricalVariable>(entity: CategoricalVariable.entity(), sortDescriptors: [], predicate: NSPredicate(format: "dataset = %@", dataset), animation: .default)
        
    }
    
    @State private var newVariableName: String = ""
    @State private var newVariableType: VariableTypes = .continuous
    
    @State private var newVariableMin: String = ""
    @State private var newVariableMax: String = ""
    
    @State private var newVariableCategories: [String] = []
    @State private var newCategoryName: String = ""
    
    @State private var alertMessage = ""
    @State private var alertShowing = false
    
    var body: some View {
        Form {
            Section {
                TextField("Variable Name", text: $newVariableName)
                Button("\(newVariableType.rawValue.capitalized)") {toggleVariableType()}
                
                if newVariableType == .categorical {
                    VStack {
                        List {
                            Text("Categories").font(.headline)
                            
                            ForEach(newVariableCategories, id: \.self) { category in
                                Text(category)
                            }
                        }
                        
                        TextField("Name", text: $newCategoryName)
                        
                        Button("Add Category") {
                            addCategoryName()
                        }

                    }
                    
                } else {
                    VStack {
                        TextField("Minumum Value", text: $newVariableMin)
                            .keyboardType(.decimalPad)
                        TextField("Maximum Value", text: $newVariableMax)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            
            Section {
                Button("Add Variable") {
                    addVariable()
                    viewContext.safeSave()
                }
            }
            
            List {
                Section(header: Text("Continuous Variables")) {
                    ForEach(dataset.continuousArray) { continuous in
                        Text(continuous.wrappedName)
                    }
                }
                
                Section(header: Text("Categorical Variables")) {
                    ForEach(dataset.categoricalArray) { categorical in
                        Text(categorical.wrappedName)
                    }
                }
            }
        }
        .alert(isPresented: $alertShowing) {
            Alert(title: Text(alertMessage))
        }
    }
    
    enum VariableTypes: String, CaseIterable, Identifiable {
        case continuous
        case categorical
        
        var id: String {self.rawValue}
    }
    
    func toggleVariableType() {
        if newVariableType == .continuous {
            newVariableType = .categorical
        } else {
            newVariableType = .continuous
        }
    }
    
    func addVariable() {
        
        guard let doubleMin = Double(newVariableMin) else {
            showAlert(message: "The minimum value you entered is not a number")
            return
            
        }
        guard let doubleMax = Double(newVariableMax) else {
            showAlert(message: "The maximum value you entered is not a number")
            return
        }
        
        if doubleMax - doubleMin < 0 {
            showAlert(message: "The minimum value is greater than the maximum value")
            return
        }
        
        if !newVariableName.isEmpty {
            switch newVariableType {
            case .continuous:
                let newVariable = ContinuousVariable(context: viewContext)
                newVariable.id = UUID()
                newVariable.dataset = dataset
                newVariable.name = newVariableName
                newVariable.min = doubleMin
                newVariable.max = doubleMax
                
            case .categorical:
                let newVariable = CategoricalVariable(context: viewContext)
                newVariable.id = UUID()
                newVariable.dataset = dataset
                newVariable.name = newVariableName
                addCategories(variable: newVariable)
            }
            viewContext.safeSave()
        } else {
            showAlert(message: "Please enter a variable name")
        }
    }
    
    func addCategories(variable: CategoricalVariable) {
        if !newVariableCategories.isEmpty {
            for category in newVariableCategories {
                let newCategory = Category(context: viewContext)
                newCategory.id = UUID()
                newCategory.name = category
                variable.addToCategories(newCategory)
            }
            viewContext.safeSave()
        } else {
            showAlert(message: "Please choose some variable categories")
        }
    }
    
    func addCategoryName() {
        if !newCategoryName.isEmpty {
            newVariableCategories.append(newCategoryName)
            newCategoryName = ""
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        alertShowing = true
    }
    
}

struct AddVariableView_Previews: PreviewProvider {
    
    static let moc = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        
        func getDataset() -> Dataset? {
            
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: Dataset.entity().name!)
                request.sortDescriptors = [NSSortDescriptor(keyPath: \Dataset.name, ascending: true)]
                
                let result = try moc.fetch(request) as? [Dataset]
                if !result!.isEmpty {
                    return result?.first!
                } else {
                    return nil
                }
            } catch {
                print("Could not fetch datasets")
                return nil
            }
        }
        
        return AddVariableView(dataset: getDataset()!)
    }
}
