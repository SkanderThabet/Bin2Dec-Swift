//
//  ContentView.swift
//  Bin2Dec
//
//  Created by Skander Thabet on 19/01/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            headerSection
            inputSection
            resultSection
        }
        .padding()
    }
}

// MARK: - View Components
private extension ContentView {
    var headerSection: some View {
        VStack(spacing: 8) {
            Text("Binary to Decimal Converter")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Enter up to 8 binary digits (0s and 1s)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var inputSection: some View {
        BinaryInputField(
            text: $viewModel.input,
            state: viewModel.state
        )
    }
    
    var resultSection: some View {
        Group {
            if case .success(let value) = viewModel.state {
                Text("Decimal value: \(value)")
                    .font(.title2)
                    .fontWeight(.medium)
            }
        }
    }
}

struct BinaryInputField: View {
    @Binding var text: String
    let state: MainViewModel.ViewState
    
    private var isError: Bool {
        if case .error(_) = state { return true }
        return false
    }
    
    private var errorMessage: String? {
        if case .error(let message) = state { return message }
        return nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            textField
            feedbackRow
        }
    }
}

// MARK: - BinaryInputField Components
private extension BinaryInputField {
    var textField: some View {
        TextField("Binary Input", text: $text)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(isError ? Color.red : Color.clear, lineWidth: 1)
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
    
    var feedbackRow: some View {
        HStack {
            if let error = errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
            Spacer()
            Text("\(text.count)/\(BinaryNumber.maxLength)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(minHeight: 20) // Maintains consistent height
    }
}

#Preview {
    ContentView()
}
