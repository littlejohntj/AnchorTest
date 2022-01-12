// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen


import Foundation
import SolanaSwift
import AnchorKit
import BufferLayoutSwift

struct PurpleContract {

  static func initialize(
      data: Int64,
      myAccount: SolanaSDK.PublicKey,
      user: SolanaSDK.PublicKey,
      systemProgram: SolanaSDK.PublicKey,
      clock: SolanaSDK.PublicKey,
      programId: SolanaSDK.PublicKey
  ) -> SolanaSDK.TransactionInstruction {
    let keys = [
        SolanaSDK.Account.Meta(publicKey: myAccount, isSigner: true, isWritable: true), // myAccount
        SolanaSDK.Account.Meta(publicKey: user, isSigner: true, isWritable: true), // user
        SolanaSDK.Account.Meta(publicKey: systemProgram, isSigner: false, isWritable: false), // systemProgram
        SolanaSDK.Account.Meta(publicKey: clock, isSigner: false, isWritable: false), // clock
    ]

    let sigHash: [UInt8] = AnchorKit.sighash(nameSpace: "global", name: "initialize")

    let dataData = try! data.serialize()
    let dataBytes = (dataData as BytesEncodable).bytes
    let instructionData: [UInt8] = sigHash + dataBytes

    return SolanaSDK.TransactionInstruction(keys: keys, programId: programId, data: instructionData)
  }

  static func update(
      data: Int64,
      myAccount: SolanaSDK.PublicKey,
      clock: SolanaSDK.PublicKey,
      programId: SolanaSDK.PublicKey
  ) -> SolanaSDK.TransactionInstruction {
    let keys = [
        SolanaSDK.Account.Meta(publicKey: myAccount, isSigner: false, isWritable: true), // myAccount
        SolanaSDK.Account.Meta(publicKey: clock, isSigner: false, isWritable: false), // clock
    ]

    let sigHash: [UInt8] = AnchorKit.sighash(nameSpace: "global", name: "update")

    let dataData = try! data.serialize()
    let dataBytes = (dataData as BytesEncodable).bytes
    let instructionData: [UInt8] = sigHash + dataBytes

    return SolanaSDK.TransactionInstruction(keys: keys, programId: programId, data: instructionData)
  }

    public struct MyAccount: DecodableBufferLayout {
    let data: Int64
  }
}
  
