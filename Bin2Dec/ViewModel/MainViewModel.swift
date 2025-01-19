//
//  MainViewModel.swift
//  Bin2Dec
//
//  Created by Skander Thabet on 19/01/2025.
//

import Foundation
import Combine

// MARK: - MainViewModel
@MainActor
final class MainViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var input: String = ""
    @Published private(set) var state: ViewState = .initial

    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let debounceTime: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(300)
    
    // MARK: - Initialization
    init() {
        setupBindings()
    }
}

// MARK: - ViewState
extension MainViewModel {
    enum ViewState {
        case initial
        case success(Int)
        case error(String)
    }
}

// MARK: - Private Methods
private extension MainViewModel {
    func setupBindings() {
        $input
            .debounce(for: debounceTime, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] value in
                self?.handleInput(value)
            }
            .store(in: &cancellables)
    }
    
    func handleInput(_ value: String) {
        guard !value.isEmpty else {
            state = .initial
            return
        }
        
        let binary = BinaryNumber(value: value)
        
        do {
            try validateInput(binary)
            if let decimal = binary.decimalValue {
                state = .success(decimal)
            }
        } catch let error as ConversionError {
            state = .error(error.errorDescription ?? "Invalid input")
        } catch {
            state = .error("Unexpected error occurred")
        }
    }
    
    func validateInput(_ binary: BinaryNumber) throws {
        if binary.isExceedMaxLength {
            throw ConversionError.exceededMaxLength
        }
        if !binary.isValid {
            throw ConversionError.invalidCharacters
        }
    }
}
