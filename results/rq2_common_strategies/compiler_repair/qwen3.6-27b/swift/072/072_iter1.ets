// entry/src/main/ets/constants/Colors.ets
export class AppColor {
  // Backgrounds
  static readonly RF_BACKGROUND = '#FBF8F3'
  static readonly RF_CARD_BG = '#F7F3EE'
  
  // Header & Summary
  static readonly RF_HEADER_CIRCLE = '#EBE2D6'
  static readonly RF_SUMMARY_ROW = '#EBE2D6'
  
  // Text
  static readonly RF_TEXT_DARK = '#3D352E'
  static readonly RF_TEXT_GRAY = '#8A8A8E'
  static readonly RF_PLACEHOLDER = '#6D5F58'
  
  // Buttons & Borders
  static readonly RF_BORDER = '#C5B8A9'
  static readonly RF_BUTTON_BACK = '#EBE2D6'
  static readonly RF_BUTTON_NEXT = '#B58B5A'
}

// entry/src/main/ets/components/HeaderView.ets
import { AppColor } from '../constants/Colors'

@Component
export struct HeaderView {
  build() {
    Row() {
      Circle()
        .fill(AppColor.RF_HEADER_CIRCLE)
        .width(48)
        .height(48)
      
      Blank()
      
      Column() {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColor.RF_TEXT_DARK)
        
        Text('Civic support intake')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColor.RF_TEXT_GRAY)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      
      Blank()
      
      Circle()
        .fill(AppColor.RF_HEADER_CIRCLE)
        .width(48)
        .height(48)
    }
    .padding({ left: 24, right: 24 })
  }
}

// entry/src/main/ets/components/CustomTextField.ets
import { AppColor } from '../constants/Colors'

@Component
export struct CustomTextField {
  placeholder: string = ''
  @Link text: string
  height: number = 40
  alignment: Alignment = Alignment.Start

  build() {
    TextInput({ placeholder: this.placeholder, text: $text })
      .fontSize(16)
      .fontColor(AppColor.RF_TEXT_DARK)
      .placeholderColor(AppColor.RF_PLACEHOLDER)
      .padding({ left: 16, right: 16 })
      .height(this.height)
      .alignSelf(ItemAlign.Start)
      .backgroundColor(AppColor.RF_BACKGROUND)
      .borderRadius(16)
      .border({ width: 1.5, color: AppColor.RF_BORDER, radius: 16 })
      .type(InputType.Normal)
  }
}

// entry/src/main/ets/components/FormButton.ets
import { AppColor } from '../constants/Colors'

@Component
export struct FormButton {
  label: string = ''
  isPrimary: boolean = false

  build() {
    Button(this.label) {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .backgroundColor(this.isPrimary ? AppColor.RF_BUTTON_NEXT : AppColor.RF_BUTTON_BACK)
    .borderRadius(16)
    .padding({ top: 48, bottom: 48 })
    .width('100%')
  }
}

// entry/src/main/ets/components/SummaryRow.ets
import { AppColor } from '../constants/Colors'

@Component
export struct SummaryRow {
  label: string = ''
  value: string = ''

  build() {
    Row() {
      Text(this.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColor.RF_TEXT_DARK)
      
      Blank()
      
      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .padding(20)
    .backgroundColor(AppColor.RF_SUMMARY_ROW)
    .borderRadius(16)
  }
}

// entry/src/main/ets/components/ApplicantDetailsCard.ets
import { AppColor } from '../constants/Colors'
import { CustomTextField } from './CustomTextField'
import { FormButton } from './FormButton'

@Component
export struct ApplicantDetailsCard {
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  build() {
    Column() {
      Text('Applicant details')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColor.RF_TEXT_DARK)
        .margin({ bottom: 4 })
        .alignSelf(ItemAlign.Start)

      CustomTextField({ placeholder: 'Full name', text: $fullName, height: 18 })
      CustomTextField({ placeholder: 'Organization', text: $organization, height: 18 })
      CustomTextField({ placeholder: 'Contact', text: $contact, height: 18 })
      
      CustomTextField({ 
        placeholder: 'Relief narrative', 
        text: $narrative, 
        height: 18, 
        alignment: Alignment.TopStart 
      })
      .margin({ bottom: 90 })

      Row() {
        FormButton({ label: 'Back', isPrimary: false })
        Blank()
        FormButton({ label: 'Next', isPrimary: true })
      }
      .margin({ top: 80 })
    }
    .padding(24)
    .backgroundColor(AppColor.RF_CARD_BG)
    .borderRadius(32)
  }
}

// entry/src/main/ets/components/SummaryCard.ets
import { AppColor } from '../constants/Colors'
import { SummaryRow } from './SummaryRow'

@Component
export struct SummaryCard {
  build() {
    Column() {
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColor.RF_TEXT_DARK)
        .alignSelf(ItemAlign.Start)
      
      SummaryRow({ label: 'Requested', value: '$4,500' })
    }
    .padding(24)
    .backgroundColor(AppColor.RF_CARD_BG)
    .borderRadius(32)
  }
}

// entry/src/main/ets/pages/ContentView.ets
import { AppColor } from '../constants/Colors'
import { HeaderView } from '../components/HeaderView'
import { ApplicantDetailsCard } from '../components/ApplicantDetailsCard'
import { SummaryCard } from '../components/SummaryCard'

@Entry
@Component
struct ContentView {
  build() {
    Stack() {
      Column() {
        HeaderView()
          .margin({ top: 10, bottom: 20 })
        
        Scroll() {
          Column({ space: 24 }) {
            ApplicantDetailsCard()
            SummaryCard()
          }
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .backgroundColor(AppColor.RF_BACKGROUND)
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
  }
}