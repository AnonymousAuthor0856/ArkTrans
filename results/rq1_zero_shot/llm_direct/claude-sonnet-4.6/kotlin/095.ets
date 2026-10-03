import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct ReceiptScreen {
  build() {
    Column({ space: 0 }) {
      Scroll() {
        Column({ space: 0 }) {
          // --- Header Section ---
          Blank().height(20)

          SuccessIcon()

          Blank().height(16)

          Text('Payment Success')
            .fontSize(16)
            .fontColor('#FF9E9E9E')
            .fontWeight(FontWeight.Normal)

          Blank().height(8)

          Text('$1,249.00')
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF000000')

          Blank().height(32)

          // --- Receipt Card ---
          ReceiptDetailsCard()

          Blank().height(32)

          // --- Action Buttons ---
          ActionButtons()

          Blank().height(16)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding({ left: 24, right: 24, top: 0, bottom: 0 })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFFFF')
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle({ width: 72, height: 72 })
        .fill('#FFE8F5E9')

      Image($r('sys.media.ohos_ic_public_ok'))
        .width(36)
        .height(36)
        .fillColor('#FF2E7D32')
    }
    .width(72)
    .height(72)
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      // Recipient Row
      RowDetail({
        label: 'To Merchant',
        value: 'TechSpace Solutions',
        iconResource: $r('sys.media.ohos_ic_public_info')
      })

      Divider()
        .color('#FFE0E0E0')
        .strokeWidth(1)

      // Date Row
      RowDetail({
        label: 'Date',
        value: 'Dec 02, 2025 - 11:30 PM',
        iconResource: $r('sys.media.ohos_ic_public_calendar')
      })

      Divider()
        .color('#FFE0E0E0')
        .strokeWidth(1)

      // Ref Number Row
      Row() {
        Text('Ref Number')
          .fontSize(14)
          .fontColor('#FF9E9E9E')

        Text('009281-XX-99')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Payment Method Row
      Row() {
        Text('Payment Method')
          .fontSize(14)
          .fontColor('#FF9E9E9E')

        Text('Credit Card •••• 4242')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFF8F9FA')
    .borderRadius(12)
    .border({ width: 1, color: '#FFEEEEEE' })
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
          .fillColor('#FF9E9E9E')

        Text(this.label)
          .fontSize(14)
          .fontColor('#FF9E9E9E')
      }
      .alignItems(VerticalAlign.Center)

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF000000')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      // Done Button
      Button('Done')
        .width('100%')
        .height(50)
        .backgroundColor('#FF000000')
        .fontColor('#FFFFFFFF')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(8)

      // Share Receipt Button
      Button() {
        Row({ space: 8 }) {
          Image($r('sys.media.ohos_ic_public_share'))
            .width(18)
            .height(18)
            .fillColor('#FF000000')

          Text('Share Receipt')
            .fontSize(16)
            .fontColor('#FF000000')
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#FFFFFFFF')
      .borderRadius(8)
      .border({ width: 1, color: '#FFDDDDDD' })
    }
    .width('100%')
  }
}