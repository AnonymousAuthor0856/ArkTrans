import { Component, State } from '@ohos/arkui';

@Entry
@Component
struct ChargingProgressScreen {
  @State private progress: number = 0.45;

  private readonly primaryColor: string = '#3B82F6';
  private readonly secondaryColor: string = '#22C55E';
  private readonly backgroundColor: string = '#F5F5F4';
  private readonly surfaceColor: string = '#FFFFFF';
  private readonly outlineColor: string = '#D4D4D8';
  private readonly onPrimaryColor: string = '#FFFFFF';
  private readonly onBackgroundColor: string = '#111827';
  private readonly onSurfaceColor: string = '#1F2937';
  private readonly accentColor: string = '#F59E0B';

  private simulateCharge(): void {
    this.progress += 0.1;
    if (this.progress > 1) {
      this.progress = 0;
    }
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Image($r('sys.media.ohos_ic_public_car'))
          .width(28)
          .height(28)
          .fillColor(this.primaryColor)
          .margin({ left: 16, right: 8 })

        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Image($r('sys.media.ohos_ic_public_settings'))
          .width(28)
          .height(28)
          .fillColor(this.accentColor)
          .margin({ left: 8, right: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(this.surfaceColor)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column() {
        // Battery Icon
        Image($r('sys.media.ohos_ic_public_battery'))
          .width(72)
          .height(72)
          .fillColor(this.primaryColor)
          .margin({ top: 20 })

        // Percentage Text
        Text(`${Math.round(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .margin({ top: 20 })

        // Progress Bar
        Stack() {
          // Track
          Row()
            .width('80%')
            .height(14)
            .backgroundColor(this.surfaceColor)
            .borderRadius(7)
            .border({ width: 1, color: this.outlineColor })

          // Progress Fill
          Row()
            .width(`${this.progress * 80}%`)
            .height(14)
            .backgroundColor(this.primaryColor)
            .borderRadius(7)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20 })

        // Simulate Charge Button
        Button('Simulate Charge')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onPrimaryColor)
          .backgroundColor(this.secondaryColor)
          .borderRadius(24)
          .padding({ left: 24, right: 24, top: 10, bottom: 10 })
          .margin({ top: 20 })
          .onClick(() => {
            this.simulateCharge();
          })

        // Status Text
        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1 ? this.primaryColor : this.secondaryColor)
          .margin({ top: 20 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.backgroundColor)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}