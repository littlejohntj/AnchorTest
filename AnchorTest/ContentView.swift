//
//  ContentView.swift
//  AnchorTest
//
//  Created by Todd Littlejohn on 1/6/22.
//

import SwiftUI
import SolanaSwift
import BufferLayoutSwift

struct AccountManager {
    
    let solanaSDK:SolanaSDK
    
    init() {
        let mnemonic = Mnemonic()
        let account = try! SolanaSDK.Account(phrase: mnemonic.phrase, network: .devnet, derivablePath: .default)
        try! InMemoryAccountStorage.shared.save(account)
        solanaSDK = SolanaSDK(endpoint: SolanaSDK.APIEndPoint.defaultEndpoints.last!, accountStorage: InMemoryAccountStorage.shared)
    }
}

struct InMemoryAccountStorage: SolanaSDKAccountStorage {
    
    static var shared: InMemoryAccountStorage = InMemoryAccountStorage()
    
    private var _account: SolanaSDK.Account?
    mutating func save(_ account: SolanaSDK.Account) throws {
        _account = account
    }
    var account: SolanaSDK.Account? {
        _account
    }
}

struct ContentView: View {
    
    let manager = AccountManager()
    
    var body: some View {
        Button("Hit Me!") {
            let data: Int64 = 69420
            
            let mintMnemonic = Mnemonic()
            let mintAccount = try! SolanaSDK.Account(phrase: mintMnemonic.phrase, network: .devnet, derivablePath: .default)
            let mintAddress = mintAccount.publicKey
            
            
            let sysvarClock: SolanaSDK.PublicKey = "SysvarC1ock11111111111111111111111111111111"
            let programId: SolanaSDK.PublicKey = "FvQHtPyf8HwURig1pmPMddBsJ6pKcwyu8CaMmZ36mHUR"
//            SolanaSDK.PublicKey.metadataProgramId, isSigner: false, isWritable: false), // Token metadata
//            SolanaSDK.Account.Meta(publicKey: SolanaSDK.PublicKey.tokenProgramId, isSigner: false, isWritable: false), // Token program
//            SolanaSDK.Account.Meta(publicKey: SolanaSDK.PublicKey.programId, isSigner: false, isWritable: false), // System Program
//            SolanaSDK.Account.Meta(publicKey: SolanaSDK.PublicKey.sysvarRent, isSigner: false, isWritable: false), // Rent
//            SolanaSDK.Account.Meta(publicKey: SolanaSDK.PublicKey.sysvarClock
            
            let transaction = PurpleContract.initialize(data: data,
                                                        myAccount: mintAddress,
                                                        user: manager.solanaSDK.accountStorage.account!.publicKey,
                                                        systemProgram: SolanaSDK.PublicKey.programId,
                                                        clock: sysvarClock,
                                                        programId: programId)
            
            manager.solanaSDK.serializeAndSend(instructions: [transaction], recentBlockhash: nil, signers: [mintAccount, manager.solanaSDK.accountStorage.account!], isSimulation: false)
                .subscribe({balance in
                    print(balance)
                })
        }
        .onAppear {
            print(manager.solanaSDK.accountStorage.account!.publicKey.base58EncodedString)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Array: BufferLayoutProperty where Element: BufferLayoutProperty {
    public init(buffer: Data, pointer: inout Int) throws {
//        guard let element = try? Element(buffer: buffer, pointer: &pointer) else {
//            self = nil
//            return
//        }
//        self = element
        self = Array<Element>()
    }
    
    public func serialize() throws -> Data {
//        guard let self = self else {return Data()}
//        return try self.serialize()
        return Data()
    }
}

//extension String: DecodableBufferLayout {}
//
//extension String: BufferLayoutProperty {
//    public init(buffer: Data, pointer: inout Int) throws {
//
//        func fuck( arr: [UInt8] ) -> Int {
//
//            var v: Int = 0
//
//            for i in 0..<arr.count {
//                let f = arr[i]
//                let s = pow(Double(256), Double(i))
//                v += Int(s * Double(f))
//            }
//
//            return v
//        }
//
////        let size = MemoryLayout<Self>.size
//        guard buffer.count >= 4 else {
//            throw Error.bytesLengthIsNotValid
//        }
//
//        let sizeArray = Array(buffer[pointer..<pointer+4])
//        let newStart = pointer + 4
//        // todo: actually calculate correct size
//
//        let size = fuck(arr: sizeArray)
//
//        let data = Array(buffer[newStart..<newStart+size])
//
//        guard let str = String(bytes: data, encoding: .utf8) else {
//            throw Error.bytesLengthIsNotValid
//        }
//
//        pointer += size + 4
//
//        self = str.replacingOccurrences(of: "\0", with: "")
//    }
//}
