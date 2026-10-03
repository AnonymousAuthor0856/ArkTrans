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
      
      Column()
        .width('100%')
        .height(32)
      
      // Receipt Card
      ReceiptDetailsCard()
      
      Column()
        .layoutWeight(1)
      
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
    Stack() {
      Circle()
        .fill('#E8F5E9')
        .width(72)
        .height(72)
      
      Image($r('app.media.ic_check'))
        .width(36)
        .height(36)
        .objectFit(ImageFit.Contain)
        .fillColor('#2E7D32')
    }
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      RowDetail({ label: "To Merchant", value: "TechSpace Solutions", iconName: $r('app.media.ic_info') })
      
      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)
      
      RowDetail({ label: "Date", value: "Dec 02, 2025 - 11:30 PM", iconName: $r('app.media.ic_calendar') })
      
      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)
      
      Row({ space: 10 }) {
        Text("Ref Number")
          .fontSize(14)
          .fontColor('#9E9E9E')
        
        Blank()
        
        Text("009281-XX-99")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      
      Row({ space: 10 }) {
        Text("Payment Method")
          .fontSize(14)
          .fontColor('#9E9E9E')
        
        Blank()
        
        Text("Credit Card •••• 4242")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
    }
    .padding(20)
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
    Row({ space: 10 }) {
      Row({ space: 8 }) {
        Image(this.iconName)
          .width(18)
          .height(18)
          .objectFit(ImageFit.Contain)
          .fillColor('#9E9E9E')
        
        Text(this.label)
          .fontSize(14)
          .fontColor('#9E9E9E')
      }
      
      Blank()
      
      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
    }
    .width('100%')
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      Button("Done")
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor('#000000')
        .borderRadius(8)
        .height(50)
        .width('100%')
      
      Button() {
        Row({ space: 8 }) {
          Image($r('app.media.ic_share'))
            .width(18)
            .height(18)
            .objectFit(ImageFit.Contain)
            .fillColor('#000000')
          
          Text("Share Receipt")
            .fontSize(16)
            .fontColor('#000000')
        }
        .justifyContent(FlexAlign.Center)
      }
      .height(50)
      .width('100%')
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: '#DDDDDD', radius: 8 })
    }
  }
}