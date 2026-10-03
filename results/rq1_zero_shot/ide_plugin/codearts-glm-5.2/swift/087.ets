class TeaColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly gray80: string = '#CC808080'
  static readonly primary: string = '#FF6D4C41'
  static readonly secondary: string = '#FFA1887F'
  static readonly surfaceVariant: string = '#FFFAFAFA'
  static readonly outline: string = '#FFEEEEEE'
  static readonly backgroundTint: string = '#FFF5F5F5'
  static readonly teaLeafDetail: string = '#FF8D6E63'
  static readonly favoriteTint: string = '#FFFFCDD2'
  static readonly iconCircleBg: string = '#FFEFEBE9'
  static readonly buttonStroke: string = '#FFE0E0E0'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(14)
              .fontColor(TeaColors.gray)
            Text('Tea Master')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(TeaColors.black)
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('⚙')
            .fontSize(24)
            .fontColor(TeaColors.black)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(TeaColors.backgroundTint)
            .borderRadius(24)
        }
        .margin({ top: 24, bottom: 32 })

        Row() {
          Stack() {
            Circle({ width: 60, height: 60 })
              .fill(TeaColors.iconCircleBg)
            CustomLeafIcon()
              .width(30)
              .height(30)
          }

          Column() {
            Text('Earl Grey Reserve')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(TeaColors.black)
            Text('Black Tea • 95°C')
              .fontSize(12)
              .fontColor(TeaColors.teaLeafDetail)
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 16 })

          Blank()

          Text('♥')
            .fontSize(24)
            .fontColor(TeaColors.favoriteTint)
        }
        .padding(20)
        .backgroundColor(TeaColors.surfaceVariant)
        .borderRadius(24)
        .border({ width: 1, color: TeaColors.outline })
        .margin({ bottom: 32 })

        TimerDisplay({ time: '02:00' })
          .margin({ bottom: 40 })

        Row() {
          Text('↺')
            .fontSize(24)
            .fontColor(TeaColors.gray)
            .width(60)
            .height(60)
            .textAlign(TextAlign.Center)
            .backgroundColor(TeaColors.white)
            .borderRadius(30)
            .border({ width: 1, color: TeaColors.buttonStroke })

          Row() {
            Text('▶')
              .fontSize(18)
              .fontColor(TeaColors.white)
            Text('Start')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(TeaColors.white)
              .margin({ left: 8 })
          }
          .width(120)
          .height(60)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(TeaColors.primary)
          .borderRadius(24)
          .margin({ left: 24 })

          Text('+')
            .fontSize(24)
            .fontColor(TeaColors.gray)
            .width(60)
            .height(60)
            .textAlign(TextAlign.Center)
            .backgroundColor(TeaColors.white)
            .borderRadius(30)
            .border({ width: 1, color: TeaColors.buttonStroke })
            .margin({ left: 24 })
        }

        Blank()

        Column() {
          Text('PREPARATION')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(TeaColors.gray80)
            .margin({ bottom: 12 })

          StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
          Column() { Blank() }.width('100%').height(1).backgroundColor(TeaColors.backgroundTint)
          StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
          Column() { Blank() }.width('100%').height(1).backgroundColor(TeaColors.backgroundTint)
          StepItem({ step: '3', text: 'Pour water and wait for timer' })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ bottom: 24 })
      }
      .padding({ left: 24, right: 24 })
    }
    .backgroundColor(TeaColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct CustomLeafIcon {
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .onReady(() => {
        let w = this.ctx.width
        let h = this.ctx.height
        let r = Math.min(w, h) / 2
        this.ctx.strokeStyle = TeaColors.primary
        this.ctx.lineWidth = 2
        this.ctx.beginPath()
        this.ctx.arc(w / 2, h / 2, r - 1, 0, Math.PI * 2)
        this.ctx.stroke()
        this.ctx.beginPath()
        this.ctx.moveTo(w / 2, h / 4)
        this.ctx.lineTo(w / 2, h * 0.75)
        this.ctx.stroke()
      })
  }
}

@Component
struct TimerDisplay {
  @Prop time: string = ''
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Stack() {
      Canvas(this.ctx)
        .width(220)
        .height(220)
        .onReady(() => {
          let cx = 110
          let cy = 110
          let r = 104
          this.ctx.strokeStyle = TeaColors.backgroundTint
          this.ctx.lineWidth = 12
          this.ctx.beginPath()
          this.ctx.arc(cx, cy, r, 0, Math.PI * 2)
          this.ctx.stroke()

          this.ctx.strokeStyle = TeaColors.primary
          this.ctx.lineWidth = 12
          this.ctx.lineCap = 'round'
          this.ctx.beginPath()
          let startAngle = -210 * Math.PI / 180
          let endAngle = startAngle + 0.66 * Math.PI * 2
          this.ctx.arc(cx, cy, r, startAngle, endAngle)
          this.ctx.stroke()
        })

      Column() {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(TeaColors.gray)

        Text(this.time)
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TeaColors.black)
          .margin({ top: 4 })
      }
    }
  }
}

@Component
struct StepItem {
  @Prop step: string = ''
  @Prop text: string = ''

  build() {
    Row() {
      Text(this.step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(TeaColors.black)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor(TeaColors.backgroundTint)
        .borderRadius(12)

      Text(this.text)
        .fontSize(14)
        .fontColor(TeaColors.gray)
        .margin({ left: 12 })
        .layoutWeight(1)

      Text('✓')
        .fontSize(12)
        .fontColor(TeaColors.outline)
    }
    .padding({ top: 8, bottom: 8 })
  }
}