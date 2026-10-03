@Entry
@Component
struct Index {
  @State targetTemp: number = 22;
  @State currentMode: string = 'Cool';

  private primaryColor: string = '#3B82F6';
  private secondaryColor: string = '#06B6D4';
  private surfaceVariantColor: string = '#E0F2FE';
  private onSurfaceColor: string = '#1E293B';
  private onPrimaryColor: string = '#FFFFFF';

  build() {
    Column() {
      // Top bar
      Row() {
        Text('\u{1F321}')
          .fontSize(28)
          .fontColor(this.primaryColor)
          .margin({ left: 24 })

        Text('ThermoCurve')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('\u{2600}\u{FE0F}')
          .fontSize(32)
          .margin({ right: 24 })
          .onClick(() => { this.targetTemp++; })
      }
      .width('100%')
      .height(100)
      .backgroundColor(this.surfaceVariantColor)
      .alignItems(VerticalAlign.Center)

      // Main content
      Column() {
        Text('Target Temperature')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .margin({ top: 40 })

        Text(`${this.targetTemp}°C`)
          .fontSize(96)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryColor)
          .margin({ top: 24, bottom: 32 })

        // Temperature controls
        Row() {
          Text('−')
            .fontSize(40)
            .fontColor(this.onPrimaryColor)
            .width(140)
            .height(72)
            .textAlign(TextAlign.Center)
            .backgroundColor(this.primaryColor)
            .borderRadius(36)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp--;
              }
            })

          Text('+')
            .fontSize(40)
            .fontColor(this.onPrimaryColor)
            .width(140)
            .height(72)
            .textAlign(TextAlign.Center)
            .backgroundColor(this.primaryColor)
            .borderRadius(36)
            .margin({ left: 24 })
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp++;
              }
            })
        }
        .margin({ bottom: 48 })

        // Divider
        Divider()
          .color('rgba(203, 213, 225, 0.5)')
          .strokeWidth(1)
          .width('80%')
          .margin({ bottom: 32 })

        // Mode section
        Text('Mode')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .margin({ bottom: 32 })

        Row() {
          // Cool button
          Column() {
            Text('\u{1F4A8}')
              .fontSize(48)
            Text('Cool')
              .fontSize(28)
              .fontColor(this.currentMode === 'Cool' ? this.onPrimaryColor : this.onSurfaceColor)
              .margin({ top: 8 })
          }
          .width(160)
          .height(160)
          .borderRadius(80)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(this.currentMode === 'Cool' ? this.primaryColor : this.surfaceVariantColor)
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.2)', offsetX: 0, offsetY: 2 })
          .onClick(() => { this.currentMode = 'Cool'; })

          // Heat button
          Column() {
            Text('\u{1F525}')
              .fontSize(48)
            Text('Heat')
              .fontSize(28)
              .fontColor(this.currentMode === 'Heat' ? this.onPrimaryColor : this.onSurfaceColor)
              .margin({ top: 8 })
          }
          .width(160)
          .height(160)
          .borderRadius(80)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(this.currentMode === 'Heat' ? this.primaryColor : this.surfaceVariantColor)
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.2)', offsetX: 0, offsetY: 2 })
          .margin({ left: 36 })
          .onClick(() => { this.currentMode = 'Heat'; })
        }
        .margin({ bottom: 40 })

        Text(`Current Mode: ${this.currentMode}`)
          .fontSize(24)
          .fontColor(this.onSurfaceColor)
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['rgba(6, 182, 212, 0.15)', 0.0], ['rgba(59, 130, 246, 0.2)', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
