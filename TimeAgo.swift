//
//  TimeAgo.swift
//
//  Created by Rat Mengheang on 7/12/16.
//  Copyright © 2016 QFirst. All rights reserved.
//
// time ago in khmer
func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
    let calendar = NSCalendar.currentCalendar()
    let now = NSDate()
    let earliest = now.earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
    
    if (components.year >= 1){
        return convertToKhmerDate(date)
    }
    else if (components.month >= 1){
        return convertToKhmerDate(date)
    } else if (components.weekOfYear >= 2) {
        return "\(convertFullNumber("\(components.weekOfYear)")) សប្តាហ៍មុន"
    } else if (components.weekOfYear >= 1){
        if (numericDates){
            return "១ សប្តាហ៍មុន"
        } else {
            return "សប្តាហ៍មុន"
        }
    } else if (components.day >= 2) {
        return "\(convertFullNumber("\(components.day)")) ថ្ងៃមុន"
    } else if (components.day >= 1){
        if (numericDates){
            return "១ ថ្ងៃមុន"
        } else {
            return "ម្សិលមិញ"
        }
    } else if (components.hour >= 2) {
        return "\(convertFullNumber("\(components.hour)")) ម៉ោងមុន"
    } else if (components.hour >= 1){
        if (numericDates){
            return "១ ម៉ោងមុន"
        } else {
            return "មួយម៉ោងមុន"
        }
    } else if (components.minute >= 2) {
        return "\(convertFullNumber("\(components.minute)")) នាទីមុន"
    } else if (components.minute >= 1){
        if (numericDates){
            return "១ នាទីមុន"
        } else {
            return "A minute ago"
        }
    } else if (components.second >= 3) {
        return "\(convertFullNumber("\(components.second)")) នាទីមុន"
    } else {
        return "មុននេះបន្តិច"
    }
    
}

// convert 1 charactor to khmer number
func convertNumber2Kh(Num:String) -> String{
    switch Num {
    case "0":
        return "០"
    case "1":
        return "១"
    case "2":
        return "២"
    case "3":
        return "៣"
    case "4":
        return "៤"
    case "5":
        return "៥"
    case "6":
        return "៦"
    case "7":
        return "៧"
    case "8":
        return "៨"
    case "9":
        return "៩"
    default:
        return ""
    }
}
// convert multi number into khmer number
func convertFullNumber(Num:String)->String{
    var data = ""
    for index in 0..<Num.long {
        data += convertNumber2Kh("\(Num)"[index])
    }
    return data
}
/* access string by index
 "abcde"[0] == "a"
 "abcde"[0...2] == "abc"
 "abcde"[2..<4] == "cd"
 */
extension String {
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}

// convert to khmer time
func convertToKhmerDate(date:NSDate)->String{
    let format="yyyy-MM-dd'"
    let dateFmt = NSDateFormatter()
    dateFmt.dateFormat = format
    let newreadableDate = dateFmt.stringFromDate(date)
    // split string
    let month = newreadableDate.characters.split{$0 == "-"}.map(String.init)
    
    switch month[1] {
    case "01":
        return convertFullNumber(month[2]) + " មករា " + convertFullNumber(month[0])
    case "02":
        return convertFullNumber(month[2]) + " កម្ភះ " + convertFullNumber(month[0])
    case "03":
        return convertFullNumber(month[2]) + " មិនា " + convertFullNumber(month[0])
    case "04":
        return convertFullNumber(month[2]) + " មេសា " + convertFullNumber(month[0])
    case "05":
        return convertFullNumber(month[2]) + " ឧសភា " + convertFullNumber(month[2])
    case "06":
        return convertFullNumber(month[2])  + " មិថុនា " + convertFullNumber(month[2])
    case "07":
        return convertFullNumber(month[2])  + " កក្តដា " + convertFullNumber(month[2])
    case "08":
        return convertFullNumber(month[2])  + " សីហា " + convertFullNumber(month[2])
    case "09":
        return convertFullNumber(month[2])  + " កញ្ញា " + convertFullNumber(month[2])
    case "10":
        return convertFullNumber(month[2])  + " តុលា " + convertFullNumber(month[2])
    case "11":
        return convertFullNumber(month[2])  + " វិច្ខិកា " + convertFullNumber(month[2])
    case "12":
        return convertFullNumber(month[2]) + " ធ្នូ " + convertFullNumber(month[2])
    default:
        return ""
    }
}

