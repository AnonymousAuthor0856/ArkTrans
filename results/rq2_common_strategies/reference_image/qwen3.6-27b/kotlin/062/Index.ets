// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct ThermoCurveApp {
  @State targetTemp: number = 22;
  @State currentMode: string = 'Cool';

  // Color Tokens matching AppTokens in Kotlin
  private readonly primaryColor: ResourceColor = '#3B82F6';
  private readonly secondaryColor: ResourceColor = '#06B6D4';
  private readonly surfaceVariantColor: ResourceColor = '#E0F2FE';
  private readonly onSurfaceColor: ResourceColor = '#1E293B';
  private readonly outlineColor: ResourceColor = '#CBD5E1';
  private readonly backgroundColor: ResourceColor = '#F0F9FF';

  build() {
    Column() {
      // Top Bar Area
      Row() {
        // Left Icon (Thermostat)
        Image($r('app.media.ic_thermostat'))
          .width(24)
          .height(24)
          .fillColor(this.primaryColor)
          .margin({ left: 12 })

        Spacer()

        // Title
        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurfaceColor)

        Spacer()

        // Right Icon (Sun)
        Image($r('app.media.ic_sun'))
          .width(24)
          .height(24)
          .fillColor(this.secondaryColor)
          .margin({ right: 12 })
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.surfaceVariantColor)

      // Main Content Area
      Column() {
        // Target Temperature Section
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.onSurfaceColor)
          .margin({ top: 26 })

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryColor)
          .margin({ top: 12 })

        // Controls (+/-)
        Row() {
          Button('-')
            .type(ButtonType.Capsule)
            .backgroundColor(this.primaryColor)
            .fontColor(Color.White)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .width(80)
            .height(48)
            .onClick(() => {
              if (this.targetTemp > 10) this.targetTemp--;
            })

          Button('+')
            .type(ButtonType.Capsule)
            .backgroundColor(this.primaryColor)
            .fontColor(Color.White)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .width(80)
            .height(48)
            .onClick(() => {
              if (this.targetTemp < 35) this.targetTemp++;
            })
        }
        .justifyContent(FlexAlign.Center)
        .margin({ top: 26 })

        // Divider
        Divider()
          .color(this.outlineColor)
          .opacity(0.5)
          .strokeWidth(1)
          .width('80%')
          .margin({ top: 26 })

        // Mode Selection Section
        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.onSurfaceColor)
          .margin({ top: 26 })

        Row() {
          // Cool Button
          this.ModeButtonComponent('Cool', $r('app.media.ic_fan'), 'Cool')
          
          // Heat Button
          this.ModeButtonComponent('Heat', $r('app.media.ic_sun'), 'Heat')
        }
        .justifyContent(FlexAlign.Center)
        .margin({ top: 18 })

        // Status Text
        Text(`Current Mode: ${this.currentMode}`)
          .fontSize(12)
          .fontColor(this.onSurfaceColor)
          .margin({ top: 26 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      // Background Gradient mimicking Brush.verticalGradient
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#06B6D4', 0.15], // Secondary with alpha
          ['#3B82F6', 0.2]   // Primary with alpha
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }

  @Builder
  ModeButtonComponent(label: string, iconRes: string, modeValue: string) {
    Column() {
      Image(iconRes)
        .width(32)
        .height(32)
        .fillColor(this.isModeSelected(modeValue) ? Color.White : this.onSurfaceColor)
      
      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isModeSelected(modeValue) ? Color.White : this.onSurfaceColor)
        .margin({ top: 4 })
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .borderRadius(50) // CircleShape
    .backgroundColor(this.isModeSelected(modeValue) ? this.primaryColor : this.surfaceVariantColor)
    .shadow({ radius: 6, color: '#0000001A', offsetY: 2 })
    .onClick(() => {
      this.currentMode = modeValue;
    })
  }

  isModeSelected(mode: string): boolean {
    return this.currentMode === mode;
  }
}