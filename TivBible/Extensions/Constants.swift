//
//  Constants.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import Foundation
import SwiftData
import DeviceKit

enum Constants {
    static let dataModels: [any PersistentModel.Type] = [Book.self, Chapter.self, Verse.self, Note.self, NoteVerse.self, Hymn.self]
    
    static let modelContainer: ModelContainer = try! ModelContainer(for: dataModels)
    
    enum FontSize {
        static let max: Double = currentDevice.isPhone ? 20 : 26
        
        static let min: Double = currentDevice.isPhone ? 13 : 18
        
        static let `default`: Double = currentDevice.isPhone ? 15 : 17
    }
    
    static let chaptersPerRow: Int = currentDevice.isPhone ? 5 : 10
    
    enum ApostlesCreed {
        static let title = "Akaa a Puekarahar a Mbakristu sha won cii ve ne a jighjigh la"
        
        static let creedItems = [
            "M na Aondo TER Jighjigh, un u a hembe agee cii A gbe sha man tar la;",
            "Shi m na Yesu Kristu jighjigh, ka wan Na u i mar un tswen, ka Ter wase je la,",
            "U i jile un sha Icighan Jijingi, iniunkwase i i yer i er Maria la mar un;",
            "Ican er Un sha ikyev i Pontiu Pilatu , i mande Un sha tereakon, A kpe , i ii Un,  A sen A nyor shin Hade,",
            "Sha iyange i sha utar la A nder shin mbakpenev;",
            "A kondo A yem sha, A za tema ken uwegh ku iyanegh ku Aondo, Ter u A hembe agee cii;",
            "Shi Una mough sha la, Una va sha u va oron mba umav man mbakpenev ijir.",
            "Mna Icighan Jijingi jighjigh,",
            "Mna Icighan nongo u Kristu sha won cii jighjigh, ka mzough u ui cighan mbaiorov je ve.",
            "Mna mde u asorabo jighjigh",
            "Mna mder u iyol shin ku jighjigh",
            "Mna uma u tsoron jighjigh."
        ]
        
        static let shareableText = "\(title)\n\n\(creedItems.joined(separator: "\n\n"))"
    }
    
    enum Commandments {
        static let commandments = [
            "De lu a mbaaondo mbagenev ga saa Mo.",
            "De gbe eev ga, shin kwagh u a bee ma kwagh u a lu sha kwavaondo shin u a lu shin inya, shin u a lu shin mngerem ma shin mkur u inyaagh kpaa ga. De gur ve nya ga, shi de chivir ve kpaa ga; gadia Mo TER Aondo wou, m gu Aondo u gban iwuhe: mtshan mbayev sha ci u ifer kwagh i uter zan zan ikyoov itiar man inyiin kpa i mba ve kerem ihom; kpa mba m doo ve ishima man ve we atindi am iko yo, M eren a udubu vev imongo dedoo.",
            "De teren iti i TER Aondo wou dang ga, gadia or u nan teren iti i TER dang dang yo, Una na nan isho mayange ga.",
            "Umbur iyange I memen sha er u tsegha I yo, ayanga ateratar er tom man akaa a ou cii, kpa iyange I ataankaraharla, ka iyange I memen I TER Aondo wou je la, sha iyange ngi la de ker ma tom ave ga, we, man shi wan wou u nomso, man shi wan wou u kwase man or u shiren tom, man kwase u eren we tom, shi uzendenya ou, man shi shiror u nan nyer u a nyor, gadia TER gba sha man Tar man zegemnger kua akaa a a lu ken ve cii ayange ateratar , sha iyange  i ataankarahar la A men, ka nahan man TER a ver iyange i memen doo doo a tsegh I kpaa ye.",
            "Chivir teru man ngou er a seer we ayange ken tar u TER Aondo wou Alu nan we yo.",
            "De woo or ga.",
            "De eren idya ga.",
            "De iin ga.",
            "De we or u wan ndor a we aie iyol ga.",
            "De tem ya u or wan ndor a we ga, shi de tem kwase u or wan ndor a we ga, shin or u shiren nan tom, shin kwase u eren nan tom, shin bua u nan, shin ijaki I nan kpaa, kwagh mom mom u a lu or u or wan ndor a we yo, de tem ga."
        ]
        
        static let summary = "Man ken Mateu 22:35-40 se nenge, Yesu kohol atindi a pue la cii er: TER, Aondo wou A doo u ishima a ishima you cii, man a uma wou cii, man a mfe woyu cii. Ngun ka tindi u tamen man ka u hii hii kpaa, man u sha uhar u a lu er un yo, or u nan we ndor a we yo, nana doo u ishima er we iyol you nahan. Ka sha atindi ahar ne je man atindiakaa kua mbaprofeti cii ve har sha mi ye."
        
        static let subtitle = "Tso Aondo or akaa a ngan cii, A kaa er; Ka Mo TER M lu Aondo wou u M dugh awe ken tar u Igipiti ken ya u ikpan ye"
        
        static let title = "Akaa a Puekarahar a Mbakristu sha won cii ve ne a jighjigh la"
        
        static let shareableText = "\(title)\n\n\(subtitle)\n\n\(commandments.joined(separator: "\n\n"))\n\n\(summary)"
    }
    
    enum TheLordsPrayer {
        static let title = "Msen u Yesu tese mbahenev nav la (Mateu 6:9-13)"
        
        static let content = "Ter wase u A lu sha, i tsegha iti You, tartor wou va, i er ishima you shin tar kpaa vough er i eren i sha nahan. Na se kwaghyan wase nyian u a lu sha ciu ayange ayange la; man de se anzo ase di er se kpaa se deen mba ve gbe anzo hen vese nahan; man shi de ze a vese ape imeen ilu ga, kpa yima se sha ifer. Gadia tartor ka u wou kua agee man icivir kpaa, gbem sha won, Amen."
        
        static let shareableText = "\(title)\n\n\(content)"
    }
    
    static var shareableText = "The Tiv Bible Mobile App is a robust, user friendly, FREE and offline app that allows you to read the Holy Bible in Tiv language.\n\nIt has awesome, cool features such as:\n\n1. Copy/Paste of multiple verses\n\n2. Bookmarking multiple verses for later references.\n\n3. Highlighting verses using different highlight colors for emphasis.\n\n4. Changing font size and style dynamically while reading the bible.\n\n5. Dynamic switching between Light, Dark, System Default and Battery Saver Modes respectively.\n\n6. So much more to name a few!!!\n\nDownload Now: https://apps.apple.com/us/app/tiv-bible/id1584060052\n\nDon\'t forget to give the app a good rating on the AppStore!"
    
}
