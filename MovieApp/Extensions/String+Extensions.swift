
import Foundation
import CryptoSwift

private let key = "baigge.com123456" //16weikey

/*
 爱情 - Romance
 喜剧 - Comedy
 科幻 - Science Fiction
 动作 - Action
 都市 - Urban
 冒险 - Adventure
 武侠 - Martial Arts
 警匪悬疑 - Crime and Suspense
 纪录片 - Documentary
 其他 - Other
 */
//let videoTypes = ["爱情","喜剧","科幻","动作","都市","冒险","武侠","警匪悬疑", "纪录片", "其他"]
let videoTypes = ["Romance","Comedy","Science Fiction","Action","Urban","Adventure","Martial Arts","Crime and Suspense", "Documentary", "Other"]

private func encryptedAESString(plainText: String) -> String {

    do {

        //            print("key密钥：\(key)")

        //使用AES-128-ECB加密模式
        let aes = try AES(key: key.bytes, blockMode: ECB())

        //开始加密
        let encrypted = try aes.encrypt(plainText.bytes)
        let encryptedBase64 = encrypted.toBase64() //将加密结果转成base64形式

        return encryptedBase64
      

    } catch  {

        return plainText

    }
}

private func decrypedFromAESString(encryptedBase64: String) -> String {

    do {
        //使用AES-128-ECB加密模式
        let aes = try AES(key: key.bytes, blockMode: ECB())
        //开始解密2（从加密后的base64字符串解密）
        let decrypted2 = try encryptedBase64.decryptBase64ToString(cipher: aes) // 可以
        return decrypted2

    } catch  {

        return  encryptedBase64

    }
}



extension String {

    func asDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: self)
    }

    /** 计算属性，用于获取字符串AES加密  */
    var convertAESString: String {
        // 加密
        return encryptedAESString(plainText: self)
    }

    /** 计算属性，用于获取字符串AES解密  */
    var decrypedAESString: String {
        // 解密
        return decrypedFromAESString(encryptedBase64: self)
    }

    /** 本地化字符串包含注释 */
    func localWithCom(_ comment: String) -> String {
       return NSLocalizedString(self, comment: comment)
    }

}
