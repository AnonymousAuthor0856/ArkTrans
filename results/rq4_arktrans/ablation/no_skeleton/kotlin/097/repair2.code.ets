@Entry
@Component
struct ClimateControllerApp {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  // Constants matching Kotlin colors and dimensions
  private readonly PureWhite: string = '#FFFFFF'
  private readonly TextBlack: string = '#1C1C1E'
  private readonly TextGray: string = '#8E8E93'
  private readonly AccentBlue: string = '#007AFF'
  private readonly SoftGrayBg: string = '#F2F2F7'
  
  build() {
    Column() {
      // === Header Section ===
      Row() {
        // Menu Icon (Left)
        Image($r('app.media.startIcon'))
          .width(24).height(24).objectFit(ImageFit.Contain)
          .onClick(() => {})

        Blank()

        // Center Text
        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor(this.TextGray)
          
          Text('Connected')
            .fontSize(12)
            .fontColor(this.AccentBlue)
            .margin({ top: 4 })
        }

        Blank()

        // Settings Icon (Right) - Reusing startIcon as placeholder per rules
        Image($r('app.media.startIcon'))
          .width(24).height(24).objectFit(ImageFit.Contain)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ top: 16, left: 24, right: 24 })

      Spacer().height(40)

      // === Temperature Dial Section ===
      Column() {
        Stack() {
          // Background Circle (Soft Gray)
          CanvasRenderingContext2D()
            .drawCircle((ctx: CanvasRenderingContext2D, size: Size) => {
              ctx.beginPath()
              ctx.arc(size.width / 2, size.height / 2, size.width / 2 - 20, 0, Math.PI * 2)
              ctx.lineWidth = 40
              ctx.strokeStyle = this.SoftGrayBg
              ctx.stroke()
            })
            .width(240).height(240)

          // Animated Arc Indicator
          CanvasRenderingContext2D()
            .drawArc((ctx: CanvasRenderingContext2D, size: Size) => {
              const strokeWidth = 40
              const radius = (size.width / 2) - (strokeWidth / 2)
              const centerX = size.width / 2
              const centerY = size.height / 2
              
              // Normalize temp 16..30 to 0..1
              const progress = (this.targetTemp - 16) / (30 - 16)
              
              // Start angle 135 deg, sweep 270 deg total
              const startAngle = 135 * (Math.PI / 180)
              const totalSweep = 270 * (Math.PI / 180)
              const currentSweep = totalSweep * progress

              ctx.beginPath()
              ctx.arc(centerX, centerY, radius, startAngle, startAngle + currentSweep)
              ctx.lineWidth = strokeWidth
              ctx.lineCap = 'round'
              ctx.strokeStyle = this.isActive ? this.AccentBlue : this.TextGray
              ctx.stroke()

              // Draw Knob Indicator
              const knobAngle = startAngle + currentSweep
              const knobX = centerX + radius * Math.cos(knobAngle)
              const knobY = centerY + radius * Math.sin(knobAngle)

              // Outer white circle
              ctx.beginPath()
              ctx.arc(knobX, knobY, 16, 0, Math.PI * 2)
              ctx.fillStyle = this.PureWhite
              ctx.fill()

              // Inner colored circle
              ctx.beginPath()
              ctx.arc(knobX, knobY, 10, 0, Math.PI * 2)
              ctx.fillStyle = this.isActive ? this.AccentBlue : this.TextGray
              ctx.fill()
            })
            .width(240).height(240)

          // Center Text
          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.isActive ? this.TextBlack : this.TextGray)
            
            Text(this.isActive ? 'COOLING' : 'OFF')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.TextGray)
              .margin({ top: 4 })
          }
        }
        .width(280).height(280)

        Spacer().height(32)

        // Temp Controls Row
        Row() {
          // Down Button
          Button() {
            Image($r('app.media.startIcon'))
              .width(28).height(28).objectFit(ImageFit.Contain)
          }
          .width(56).height(56)
          .backgroundColor(this.SoftGrayBg)
          .borderRadius(28)
          .enabled(this.isActive)
          .onClick(() => {
            if (this.targetTemp > 16) {
              this.targetTemp = parseFloat((this.targetTemp - 0.5).toFixed(1))
            }
          })

          // Power Switch
          Toggle({
            type: ToggleType.Switch,
            isOn: this.isActive
          })
          .selectedColor(this.TextBlack)
          .onChange((isSelect: boolean) => {
            this.isActive = isSelect
          })

          // Up Button
          Button() {
            Image($r('app.media.startIcon'))
              .width(28).height(28).objectFit(ImageFit.Contain)
          }
          .width(56).height(56)
          .backgroundColor(this.SoftGrayBg)
          .borderRadius(28)
          .enabled(this.isActive)
          .onClick(() => {
            if (this.targetTemp < 30) {
              this.targetTemp = parseFloat((this.targetTemp + 0.5).toFixed(1))
            }
          })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Center)

      Spacer().height(40)

      // === Control Grid Section ===
      Column() {
        Text('QUICK ACTIONS')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.TextGray)
          .margin({ bottom: 16 })

        // Row 1
        Row() {
          // Fan Speed Card
          Column() {
            Image($r('app.media.startIcon'))
              .width(24).height(24).objectFit(ImageFit.Contain)
            
            Text('Fan Speed')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.TextBlack)
              .margin({ top: 8 })
            
            Text('Auto')
              .fontSize(12)
              .fontColor(this.TextGray)
          }
          .width('100%').height(100)
          .padding(16)
          .backgroundColor(this.SoftGrayBg)
          .borderRadius(20)
          .alignItems(HorizontalAlign.Start)

          // Eco Mode Card (Active)
          Column() {
            Image($r('app.media.startIcon'))
              .width(24).height(24).objectFit(ImageFit.Contain)
              .fillColor(this.PureWhite) // Override tint
            
            Text('Eco Mode')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.PureWhite)
              .margin({ top: 8 })
            
            Text('On')
              .fontSize(12)
              .fontColor(this.TextGray)
          }
          .width('100%').height(100)
          .padding(16)
          .backgroundColor(this.TextBlack)
          .borderRadius(20)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Spacer().height(16)

        // Row 2
        Row() {
          // Timer Card
          Column() {
            Image($r('app.media.startIcon'))
              .width(24).height(24).objectFit(ImageFit.Contain)
            
            Text('Timer')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.TextBlack)
              .margin({ top: 8 })
            
            Text('Set 2h')
              .fontSize(12)
              .fontColor(this.TextGray)
          }
          .width('100%').height(100)
          .padding(16)
          .backgroundColor(this.SoftGrayBg)
          .borderRadius(20)
          .alignItems(HorizontalAlign.Start)

          // Away Card
          Column() {
            Image($r('app.media.startIcon'))
              .width(24).height(24).objectFit(ImageFit.Contain)
            
            Text('Away')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.TextBlack)
              .margin({ top: 8 })
            
            Text('Off')
              .fontSize(12)
              .fontColor(this.TextGray)
          }
          .width('100%').height(100)
          .padding(16)
          .backgroundColor(this.SoftGrayBg)
          .borderRadius(20)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.PureWhite)
    .padding({ left: 24, right: 24 })
  }
}