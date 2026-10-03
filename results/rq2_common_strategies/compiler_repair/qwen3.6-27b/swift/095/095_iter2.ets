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
      // Header
      SuccessIcon()
      
      Text('Payment Success')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#9E9E9E')
        .margin({ top: 16 })
      
      Text('$1,249.00')
        .fontSize(45)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 8 })
      
      // Receipt Card
      ReceiptDetailsCard()
        .margin({ top: 32 })
      
      Blank()
      
      // Action Buttons
      ActionButtons()
    }
    .padding(24)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
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
    Column() {
      // Recipient
      RowDetail({
        label: 'To Merchant',
        value: 'TechSpace Solutions',
        iconName: $r('sys.symbol.info.circle.fill')
      })
      
      Divider()
        .color('#E0E0E0')
        .margin({ top: 16, bottom: 16 })
      
      // Date
      RowDetail({
        label: 'Date',
        value: 'Dec 02, 2025 - 11:30 PM',
        iconName: $r('sys.symbol.calendar')
      })
      
      Divider()
        .color('#E0E0E0')
        .margin({ top: 16, bottom: 16 })
      
      // Transaction ID
      Row() {
        Text('Ref Number')
          .fontSize(14)
          .fontColor('#9E9E9E')
        
        Blank()
        
        Text('009281-XX-99')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
      
      // Payment Method
      Row() {
        Text('Payment Method')
          .fontSize(14)
          .fontColor('#9E9E9E')
        
        Blank()
        
        Text('Credit Card •••• 4242')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
      .margin({ top: 16 })
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
  @Prop iconName: Resource
  
  build() {
    Row() {
      Row() {
        SymbolGlyph(this.iconName)
          .fontSize(18)
          .fontColor('#9E9E9E')
        
        Text(this.label)
          .fontSize(14)
          .fontColor('#9E9E9E')
          .margin({ left: 8 })
      }
      
      Blank()
      
      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
    }
    .width('100%')
  }
}

@Component
struct ActionButtons {
  build() {
    Column() {
      Button() {
        Text('Done')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Black)
      .borderRadius(8)
      
      Button() {
        Row() {
          SymbolGlyph($r('sys.symbol.square.and.arrow.up'))
            .fontSize(18)
            .fontColor(Color.Black)
          
          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 8 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: '#DDDDDD', radius: 8 })
      .margin({ top: 12 })
    }
    .width('100%')
  }
}