// ReceiptApp.ets
import { Length } from '@ohos.arkui.component';

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
      Blank().height(20)

      SuccessIcon()

      Blank().height(16)

      Text("Payment Success")
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Gray)

      Blank().height(8)

      Text("$1,249.00")
        .fontSize(45)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank().height(32)

      // Receipt Card
      ReceiptDetailsCard()

      Blank() // Flexible spacer

      // Action Buttons
      ActionButtons()

      Blank().height(16)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack() {
      Circle({ width: 72, height: 72 })
        .fill(Color.Green) // Approximation of light green background
        .opacity(0.2)

      Text('✔')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Green) // Approximation of darker green checkmark
    }
    .width(72)
    .height(72)
    .alignContent(Alignment.Center)
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      // Recipient
      RowDetail({ label: "To Merchant", value: "TechSpace Solutions", iconText: "ℹ" })

      Divider()
        .color(Color.Gray)
        .strokeWidth(0.5)
        .opacity(0.3)

      // Date
      RowDetail({ label: "Date", value: "Dec 02, 2025 - 11:30 PM", iconText: "📅" })

      Divider()
        .color(Color.Gray)
        .strokeWidth(0.5)
        .opacity(0.3)

      // Transaction ID
      Row() {
        Text("Ref Number")
          .fontSize(14)
          .fontColor(Color.Gray)

        Blank() // Spacer

        Text("009281-XX-99")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')

      // Payment Method
      Row() {
        Text("Payment Method")
          .fontSize(14)
          .fontColor(Color.Gray)

        Blank() // Spacer

        Text("Credit Card •••• 4242")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct RowDetail {
  private label: string = "";
  private value: string = "";
  private iconText: string = "";

  build() {
    Row() {
      Row({ space: 8 }) {
        Text(this.iconText)
          .fontSize(14)
          .fontColor(Color.Gray)

        Text(this.label)
          .fontSize(14)
          .fontColor(Color.Gray)
      }

      Blank() // Spacer

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .width('100%')
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      // Done Button
      Button("Done", { type: ButtonType.Normal }) {
        Text("Done")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Black)
      .borderRadius(8)

      // Share Receipt Button
      Button({ type: ButtonType.Normal }) {
        Row({ space: 8 }) {
          Text("↗")
            .fontSize(18)
            .fontColor(Color.Black)

          Text("Share Receipt")
            .fontSize(16)
            .fontColor(Color.Black)
        }
        .height(50)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Transparent)
      .borderRadius(8)
      .border({ width: 1, color: '#DDDDDD' })
    }
    .width('100%')
  }
}