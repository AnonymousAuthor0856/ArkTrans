class ZenColors {
  static readonly green: string = '#FF6A8E6A'
  static readonly greenLight: string = '#FFE8F5E9'
  static readonly brown: string = '#FF8D6E63'
  static readonly textPrimary: string = '#FF2C3E50'
  static readonly textSecondary: string = '#FF7F8C8D'
  static readonly white: string = '#FFFFFFFF'
  static readonly accent: string = '#FFD4E157'
  static readonly statusBg: string = '#FFF7F9F9'
  static readonly statusBorder: string = '#FFECEFF1'
  static readonly careLogBg: string = '#FFFAFAFA'
  static readonly careLogBorder: string = '#FFF0F0F0'
  static readonly careLogSubtitle: string = '#FF9E9E9E'
  static readonly navInactive: string = '#FFCFD8DC'
  static readonly divider: string = '#FFF5F5F5'
  static readonly lightGrayCircle: string = '#FFE0E0E0'
  static readonly trunk: string = '#FF5D4037'
  static readonly healthRed: string = '#FFE57373'
  static readonly waterBlue: string = '#FF64B5F6'
  static readonly brown80: string = '#CC8D6E63'
  static readonly green80: string = '#CC6A8E6A'
  static readonly green90: string = '#E66A8E6A'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            Column() {
              Text('JUNIPER · #04')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(ZenColors.textSecondary)
              Text('Zen Garden')
                .fontSize(36)
                .fontWeight(FontWeight.Lighter)
                .fontColor(ZenColors.textPrimary)
                .margin({ top: 8 })
            }
            .margin({ top: 24 })

            Blank().height(32)

            BonsaiVisual()
              .width(220)
              .height(220)

            Blank().height(32)

            Row() {
              Blank()
              StatusItem({ icon: '♥', label: 'Health', value: '98%', tint: ZenColors.healthRed })
              Blank()
              StatusItem({ icon: '📅', label: 'Age', value: '4 Yrs', tint: ZenColors.brown })
              Blank()
              StatusItem({ icon: '☑', label: 'Water', value: '2 Days', tint: ZenColors.waterBlue })
              Blank()
            }

            Blank().height(32)

            Column() {
              Row() {
                Text('Care Schedule')
                  .fontSize(16)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(ZenColors.textPrimary)
                Blank()
                Stack() {
                  Text('+')
                    .fontSize(20)
                    .fontColor(ZenColors.green)
                }
                .width(28)
                .height(28)
                .backgroundColor(ZenColors.greenLight)
                .borderRadius(14)
              }

              Blank().height(16)

              CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })
              CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })
              CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 24 })
          }
          .padding({ left: 24, right: 24, bottom: 80 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        Column() {
          Column() { Blank() }
            .width('100%')
            .height(1)
            .backgroundColor(ZenColors.divider)

          Row() {
            NavIcon({ icon: '⌂', isSelected: true })
            NavIcon({ icon: 'ⓘ', isSelected: false })
            NavIcon({ icon: '⚙', isSelected: false })
          }
          .height(80)
          .backgroundColor(ZenColors.white)
        }
      }
    }
    .backgroundColor(ZenColors.white)
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Bottom)
  }
}

@Component
struct StatusItem {
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop tint: string = '#FFFFFF'

  build() {
    Column() {
      Stack() {
        Circle({ width: 50, height: 50 })
          .fill(ZenColors.statusBg)
          .border({ width: 1, color: ZenColors.statusBorder })
        Text(this.icon)
          .fontSize(24)
          .fontColor(this.tint)
      }

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZenColors.textPrimary)
        .margin({ top: 8 })

      Text(this.label)
        .fontSize(11)
        .fontColor(ZenColors.textSecondary)
    }
  }
}

@Component
struct CareLogItem {
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop isDone: boolean = false

  build() {
    Row() {
      Circle({ width: 12, height: 12 })
        .fill(this.isDone ? ZenColors.green : ZenColors.lightGrayCircle)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontColor(this.isDone ? ZenColors.textPrimary : ZenColors.textSecondary)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(ZenColors.careLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      if (this.isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor(ZenColors.green)
      }
    }
    .padding(16)
    .backgroundColor(ZenColors.careLogBg)
    .borderRadius(12)
    .border({ width: 1, color: ZenColors.careLogBorder })
    .margin({ top: 12 })
  }
}

@Component
struct NavIcon {
  @Prop icon: string = ''
  @Prop isSelected: boolean = false

  build() {
    Column() {
      Text(this.icon)
        .fontSize(28)
        .fontColor(this.isSelected ? ZenColors.green : ZenColors.navInactive)

      if (this.isSelected) {
        Circle({ width: 4, height: 4 })
          .fill(ZenColors.green)
          .margin({ top: 4 })
      }
    }
    .layoutWeight(1)
  }
}

@Component
struct BonsaiVisual {
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawCanvas()
      })
  }

  drawCanvas() {
    let w = this.ctx.width
    let h = this.ctx.height

    let potWidth = w * 0.5
    let potHeight = h * 0.15
    let potTop = h * 0.85

    this.ctx.fillStyle = ZenColors.brown
    this.ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    this.ctx.fillStyle = ZenColors.brown80
    this.ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    this.ctx.strokeStyle = ZenColors.trunk
    this.ctx.lineWidth = 25
    this.ctx.lineCap = 'round'
    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.5, potTop)
    this.ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    this.ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    this.ctx.stroke()

    this.ctx.lineWidth = 15
    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.38, h * 0.55)
    this.ctx.lineTo(w * 0.25, h * 0.45)
    this.ctx.stroke()

    this.ctx.fillStyle = ZenColors.green
    this.ctx.beginPath()
    this.ctx.ellipse(w * 0.6, h * 0.25, 45, 45, 0, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.fillStyle = ZenColors.green80
    this.ctx.beginPath()
    this.ctx.ellipse(w * 0.68, h * 0.28, 35, 35, 0, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.fillStyle = ZenColors.green90
    this.ctx.beginPath()
    this.ctx.ellipse(w * 0.55, h * 0.22, 30, 30, 0, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.fillStyle = ZenColors.green
    this.ctx.beginPath()
    this.ctx.ellipse(w * 0.35, h * 0.5, 35, 35, 0, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.fillStyle = ZenColors.green80
    this.ctx.beginPath()
    this.ctx.ellipse(w * 0.30, h * 0.45, 25, 25, 0, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.fillStyle = ZenColors.green
    this.ctx.beginPath()
    this.ctx.ellipse(w * 0.22, h * 0.42, 25, 25, 0, 0, Math.PI * 2)
    this.ctx.fill()
  }
}