import { LengthMetrics } from '@kit.ArkUI'

@Entry
@Component
struct ReceiptApp {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    ReceiptScreen()
  }
}

@Component
struct ReceiptScreen {
  build() {
    Stack() {
      Column({ space: 0 }) {
        Blank().height(20)

        SuccessIcon()

        Blank().height(16)

        Text('Payment Success')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#9E9E9E')

        Blank().height(8)

        Text('$1,249.00')
          .fontSize(45)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Blank().height(32)

        ReceiptDetailsCard()

        Blank().layoutWeight(1)

        ActionButtons()

        Blank().height(16)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .padding(24)
      .backgroundColor(Color.White)
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
        .fill(Color.Transparent)
        .width(72)
        .height(72)
        .backgroundColor('#E8F5E9')

      Image($r('sys.media.ohos_ic_public_ok'))
        .width(36)
        .height(36)
        .fillColor('#2E7D32')
        .objectFit(ImageFit.Contain)
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
      RowDetail({
        label: 'To Merchant',
        value: 'TechSpace Solutions',
        iconResource: $r('sys.media.ohos_ic_public_info')
      })

      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)

      RowDetail({
        label: 'Date',
        value: 'Dec 02, 2025 - 11:30 PM',
        iconResource: $r('sys.media.ohos_ic_public_calendar')
      })

      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)

      Row() {
        Text('Ref Number')
          .fontSize(14)
          .fontColor('#9E9E9E')

        Blank()

        Text('009281-XX-99')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Text('Payment Method')
          .fontSize(14)
          .fontColor('#9E9E9E')

        Blank()

        Text('Credit Card •••• 4242')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({
      width: 1,
      color: '#EEEEEE',
      radius: 12
    })
  }
}

@Component
struct RowDetail {
  label: string = ''
  value: string = ''
  iconResource: Resource = $r('sys.media.ohos_ic_public_info')

  build() {
    Row() {
      Row({ space: 8 }) {
        Image(this.iconResource)
          .width(18)
          .height(18)
          .fillColor('#9E9E9E')
          .objectFit(ImageFit.Contain)

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
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      Button('Done')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .width('100%')
        .height(50)
        .backgroundColor('#000000')
        .borderRadius(8)

      Row({ space: 8 }) {
        Image($r('sys.media.ohos_ic_public_share'))
          .width(18)
          .height(18)
          .fillColor('#000000')
          .objectFit(ImageFit.Contain)

        Text('Share Receipt')
          .fontSize(16)
          .fontColor('#000000')
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.Center)
      .border({
        width: 1,
        color: '#DDDDDD',
        radius: 8
      })
    }
    .width('100%')
  }
}