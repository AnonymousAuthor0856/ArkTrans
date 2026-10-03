import { window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@Component
struct PaymentSuccessPage {
  @State amount: string = '$1,249.00'
  @State merchantName: string = 'TechSpace Solutions'
  @State date: string = 'Dec 02, 2025 - 11:30 PM'
  @State refNumber: string = '009281-XX-99'
  @State paymentMethod: string = 'Credit Card •••• 4242'

  aboutToAppear() {
    // Hide system bars for immersive mode
    let windowClass: window.Window | undefined = undefined;
    try {
      windowClass = window.getTopWindow(this.getUIContext().getHostContext());
      if (windowClass) {
        windowClass.setWindowSystemBarEnable([], (err: BusinessError) => {
          if (err) {
            console.error(`Failed to hide system bars. Code: ${err.code}, message: ${err.message}`);
          }
        });
      }
    } catch (exception) {
      const err = exception as BusinessError;
      console.error(`Failed to get window. Code: ${err.code}, message: ${err.message}`);
    }
  }

  build() {
    Column() {
      // Header Section
      Column() {
        // Success Icon
        Row() {
          Text('✓')
            .fontSize(36)
            .fontColor('#2E7D32')
            .fontWeight(FontWeight.Bold)
        }
        .width(72)
        .height(72)
        .backgroundColor('#E8F5E9')
        .borderRadius(36)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Text('Payment Success')
          .fontSize(16)
          .fontColor('#888888')
          .margin({ top: 16 })

        Text(this.amount)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 20 })

      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        Blank().layoutWeight(1)
      }

      // Receipt Details Card
      Column() {
        // To Merchant
        Row() {
          Row() {
            Text('ℹ')
              .fontSize(18)
              .fontColor('#888888')
            Text('To Merchant')
              .fontSize(14)
              .fontColor('#888888')
              .margin({ left: 8 })
          }
          Text(this.merchantName)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 20, right: 20, top: 20, bottom: 16 })

        Divider()
          .color('#E0E0E0')
          .margin({ left: 20, right: 20 })

        // Date
        Row() {
          Row() {
            Text('📅')
              .fontSize(18)
              .fontColor('#888888')
            Text('Date')
              .fontSize(14)
              .fontColor('#888888')
              .margin({ left: 8 })
          }
          Text(this.date)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })

        Divider()
          .color('#E0E0E0')
          .margin({ left: 20, right: 20 })

        // Ref Number
        Row() {
          Text('Ref Number')
            .fontSize(14)
            .fontColor('#888888')
          Text(this.refNumber)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })

        // Payment Method
        Row() {
          Text('Payment Method')
            .fontSize(14)
            .fontColor('#888888')
          Text(this.paymentMethod)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 20, right: 20, top: 0, bottom: 20 })
      }
      .width('100%')
      .backgroundColor('#F8F9FA')
      .borderRadius(12)
      .border({ width: 1, color: '#EEEEEE' })
      .margin({ top: 32 })

      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        Blank().layoutWeight(1)
      }

      // Action Buttons
      Column() {
        Button('Done', { type: ButtonType.Normal, stateEffect: true })
          .width('100%')
          .height(50)
          .backgroundColor('#000000')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .borderRadius(8)

        Button() {
          Row() {
            Text('↗')
              .fontSize(18)
              .fontColor('#000000')
            Text('Share Receipt')
              .fontSize(16)
              .fontColor('#000000')
              .margin({ left: 8 })
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .type(ButtonType.Capsule)
        .width('100%')
        .height(50)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: '#DDDDDD', radius: 8 })
        .margin({ top: 12 })
      }
      .width('100%')
      .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
  }
}