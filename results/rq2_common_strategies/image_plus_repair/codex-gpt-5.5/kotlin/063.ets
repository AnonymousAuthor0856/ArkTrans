class AppColors {
  static readonly primary: string = '#3B82F6'
  static readonly secondary: string = '#22C55E'
  static readonly background: string = '#F5F5F4'
  static readonly surface: string = '#FFFFFF'
  static readonly outline: string = '#D4D4D8'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onBackground: string = '#111827'
  static readonly accent: string = '#F59E0B'
}

@Component
struct CarChargeIcon {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(48)
      .height(48)
      .onReady(() => {
        let ctx = this.context
        ctx.clearRect(0, 0, 48, 48)
        ctx.lineWidth = 4
        ctx.lineCap = 'round'
        ctx.lineJoin = 'round'
        ctx.strokeStyle = AppColors.primary
        ctx.fillStyle = AppColors.primary

        ctx.beginPath()
        ctx.moveTo(12, 19)
        ctx.lineTo(15, 9)
        ctx.quadraticCurveTo(16, 7, 18, 7)
        ctx.lineTo(32, 7)
        ctx.quadraticCurveTo(34, 7, 35, 9)
        ctx.lineTo(39, 19)
        ctx.lineTo(39, 30)
        ctx.lineTo(11, 30)
        ctx.lineTo(11, 19)
        ctx.closePath()
        ctx.stroke()

        ctx.beginPath()
        ctx.arc(17, 30, 2.8, 0, Math.PI * 2)
        ctx.arc(33, 30, 2.8, 0, Math.PI * 2)
        ctx.fill()

        ctx.lineWidth = 3
        ctx.beginPath()
        ctx.moveTo(25, 34)
        ctx.lineTo(25, 39)
        ctx.lineTo(18, 39)
        ctx.lineTo(29, 46)
        ctx.lineTo(29, 41)
        ctx.lineTo(36, 41)
        ctx.stroke()
      })
  }
}

@Component
struct GearIcon {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(48)
      .height(48)
      .onReady(() => {
        let ctx = this.context
        ctx.clearRect(0, 0, 48, 48)
        ctx.fillStyle = AppColors.accent
        ctx.strokeStyle = AppColors.accent
        ctx.lineWidth = 5
        ctx.lineCap = 'round'

        for (let i = 0; i < 8; i++) {
          let angle = i * Math.PI / 4
          let x1 = 24 + Math.cos(angle) * 13
          let y1 = 24 + Math.sin(angle) * 13
          let x2 = 24 + Math.cos(angle) * 18
          let y2 = 24 + Math.sin(angle) * 18
          ctx.beginPath()
          ctx.moveTo(x1, y1)
          ctx.lineTo(x2, y2)
          ctx.stroke()
        }

        ctx.beginPath()
        ctx.arc(24, 24, 14, 0, Math.PI * 2)
        ctx.fill()
        ctx.fillStyle = AppColors.surface
        ctx.beginPath()
        ctx.arc(24, 24, 6, 0, Math.PI * 2)
        ctx.fill()
      })
  }
}

@Component
struct BatteryChargeIcon {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Rect({ width: 24, height: 14, radius: 0 })
        .fill(AppColors.primary)
        .position({ x: 24, y: 0 })
      Rect({ width: 60, height: 108, radius: 8 })
        .fill(AppColors.primary)
        .position({ x: 6, y: 12 })
      Polygon()
        .width(44)
        .height(80)
        .points([[28, 0], [4, 45], [19, 45], [10, 80], [40, 32], [25, 32]])
        .fill(AppColors.surface)
        .position({ x: 18, y: 30 })
    }
    .width(72)
    .height(120)
  }
}

@Component
struct ProgressBar {
  @Link progress: number

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row() {
        Blank()
      }
      .width('100%')
      .height(14)
      .backgroundColor(AppColors.surface)
      .border({ width: 1, color: AppColors.outline, radius: 7 })

      Row() {
        Blank()
      }
      .width(`${this.progress * 100}%`)
      .height(12)
      .backgroundColor(AppColors.primary)
      .borderRadius(6)
      .margin({ left: 1 })

      Circle({ width: 7, height: 7 })
        .fill(AppColors.primary)
        .position({ x: '97%', y: 3.5 })
    }
    .width('80%')
    .height(14)
  }
}

@Entry
@Component
struct ChargingProgressPage {
  @State progress: number = 0.45

  build() {
    Column() {
      Row() {
        CarChargeIcon()
          .width(48)
          .height(48)

        Text('Charging Progress')
          .fontSize(46)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        GearIcon()
          .width(48)
          .height(48)
      }
      .width('100%')
      .height(128)
      .padding({ left: 28, right: 28, top: 32 })
      .alignItems(VerticalAlign.Top)
      .backgroundColor(AppColors.surface)

      Column({ space: 38 }) {
        BatteryChargeIcon()
          .margin({ top: 40 })

        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(80)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)

        ProgressBar({ progress: $progress })
          .margin({ top: 10 })

        Button('Simulate Charge')
          .width(308)
          .height(80)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(40)
          .margin({ top: 10 })
          .onClick(() => {
            this.progress += 0.1
            if (this.progress > 1) {
              this.progress = 0
            }
          })

        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(34)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1 ? AppColors.primary : AppColors.secondary)
          .textAlign(TextAlign.Center)
          .margin({ top: 8 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
