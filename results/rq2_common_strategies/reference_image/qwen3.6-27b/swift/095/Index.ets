import { window } from '@kit.ArkUI';

@Entry
@Component
struct ReceiptApp {
  build() {
    Column() {
      ReceiptScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ReceiptScreen {
  build() {
    Column() {
      // Header Section
      Column() {
        SuccessIcon()
        
        Text("Payment Success")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#9E9E9E')
          .margin({ top: 16 })
        
        Text("$1,249.00")
          .fontSize(45)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      
      Spacer().size({ width: '100%', height: 32 })
      
      // Receipt Card
      ReceiptDetailsCard()
      
      Spacer()
      
      // Action Buttons
      ActionButtons()
    }
    .padding(24)
    .width('100%')
    .height('100%')
  }
}

@Component
struct SuccessIcon {
  build() {
    Row() {
      SymbolGlyph($r('sys.symbol.checkmark'))
        .fontSize(36)
        .fontColor('#2E7D32')
    }
    .width(72)
    .height(72)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(36)
    .backgroundColor('#E8F5E9')
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      // Recipient
      RowDetail(
        label: "To Merchant",
        value: "TechSpace Solutions",
        symbolName: $r('sys.symbol.info.circle.fill')
      )
      
      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)
      
      // Date
      RowDetail(
        label: "Date",
        value: "Dec 02, 2025 - 11:30 PM",
        symbolName: $r('sys.symbol.calendar')
      )
      
      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)
      
      // Transaction ID
      Row() {
        Text("Ref Number")
          .fontSize(14)
          .fontColor('#9E9E9E')
        
        Text("009281-XX-99")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      
      // Payment Method
      Row() {
        Text("Payment Method")
          .fontSize(14)
          .fontColor('#9E9E9E')
        
        Text("Credit Card •••• 4242")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct RowDetail {
  @Prop label: string
  @Prop value: string
  @Prop symbolName: Resource
  
  build() {
    Row() {
      Row({ space: 8 }) {
        SymbolGlyph(this.symbolName)
          .fontSize(18)
          .fontColor('#9E9E9E')
        
        Text(this.label)
          .fontSize(14)
          .fontColor('#9E9E9E')
      }
      
      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#000000')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      Button("Done") {
        // Action
      }
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.White)
      .backgroundColor('#000000')
      .borderRadius(8)
      .width('100%')
      .height(50)
      
      Button() {
        Row({ space: 8 }) {
          SymbolGlyph($r('sys.symbol.square.and.arrow.up'))
            .fontSize(18)
            .fontColor('#000000')
          
          Text("Share Receipt")
            .fontSize(16)
            .fontColor('#000000')
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: '#DDDDDD', radius: 8 })
      .width('100%')
      .height(50)
    }
    .width('100%')
  }
}