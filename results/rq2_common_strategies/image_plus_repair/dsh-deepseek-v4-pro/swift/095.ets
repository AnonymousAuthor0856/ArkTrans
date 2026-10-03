@Entry
@Component
struct ReceiptApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    // .preferredColorScheme(.light) and .statusBarHidden(true) are iOS-specific
    // and have no direct ArkUI equivalent.
    ReceiptScreen()
  }
}

@Component
struct ReceiptScreen {
  build() {
    Stack() {
      Column({ space: 0 }) {
        // Header
        Blank().height(20)

        SuccessIcon()

        Blank().height(16)

        Text("Payment Success")
          .fontSize(16)
          .fontWeight(500) // TitleMedium approx
          .fontColor(Color.Gray)

        Blank().height(8)

        Text("$1,249.00")
          .fontSize(45)
          .fontWeight(700) // DisplayMedium approx
          .fontColor(Color.Black)

        Blank().height(32)

        // Receipt Card
        ReceiptDetailsCard()

        Blank()

        // Action Buttons
        ActionButtons()

        Blank().height(16)
      }
      .padding(24)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack() {
      Circle()
        .fill('#E8F5E9') // #E8F5E9 (Light Green)
        .width(72)
        .height(72)

      // Image(systemName: "checkmark") approximation
      Text('✓')
        .fontSize(36)
        .fontWeight(700) // Make checkmark thicker
        .fontColor('#2E7D32') // #2E7D32 (Darker Green)
    }
    .width(72)
    .height(72)
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      // Recipient
      RowDetail({
        label: "To Merchant",
        value: "TechSpace Solutions",
        iconName: "ⓘ" // info.circle.fill
      })

      Divider()
        .color('#E0E0E0') // #E0E0E0

      // Date
      RowDetail({
        label: "Date",
        value: "Dec 02, 2025 - 11:30 PM",
        iconName: "📅" // calendar
      })

      Divider()
        .color('#E0E0E0') // #E0E0E0

      // Transaction ID
      Row() {
        Text("Ref Number")
          .fontSize(14) // BodyMedium approx
          .fontColor(Color.Gray)

        Blank()

        Text("009281-XX-99")
          .fontSize(14)
          .fontWeight(500)
          .fontColor(Color.Black)
      }
      .width('100%')

      // Payment Method
      Row() {
        Text("Payment Method")
          .fontSize(14)
          .fontColor(Color.Gray)

        Blank()

        Text("Credit Card •••• 4242")
          .fontSize(14)
          .fontWeight(500)
          .fontColor(Color.Black)
      }
      .width('100%')
    }
    .padding(20)
    .backgroundColor('#F8F9FA') // #F8F9FA
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE', radius: 12 }) // #EEEEEE
  }
}

@Component
struct RowDetail {
  label: string = ''
  value: string = ''
  iconName: string = ''

  build() {
    Row() {
      Row({ space: 8 }) {
        // Image(systemName: iconName) approximation
        Text(this.iconName)
          .fontSize(18)
          .fontColor(Color.Gray)

        Text(this.label)
          .fontSize(14)
          .fontColor(Color.Gray)
      }

      Blank()

      Text(this.value)
        .fontSize(14)
        .fontWeight(600)
        .fontColor(Color.Black)
    }
    .width('100%')
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      Button({ type: ButtonType.Normal }) {
        Text("Done")
          .fontSize(16)
          .fontWeight(700) // BodyLarge + Bold
          .fontColor(Color.White)
          .width('100%')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Black)
      .borderRadius(8)
      .onClick(() => {})

      Button({ type: ButtonType.Normal }) {
        Row({ space: 8 }) {
          // Image(systemName: "square.and.arrow.up") // Share icon approximation
          Text('⤴')
            .fontSize(18)
            .fontColor(Color.Black)

          Text("Share Receipt")
            .fontSize(16) // BodyLarge
            .fontColor(Color.Black)
        }
        .width('100%')
        .height(50)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(50)
      .border({ width: 1, color: '#DDDDDD', radius: 8 }) // #DDDDDD
      .onClick(() => {})
    }
    .width('100%')
  }
}
