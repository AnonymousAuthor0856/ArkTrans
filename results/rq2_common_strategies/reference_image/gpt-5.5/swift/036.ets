class AppColors {
  static readonly primary: string = '#FFFFA8A8'
  static readonly secondary: string = '#FFFFE1A8'
  static readonly tertiary: string = '#FFA8FFE1'
  static readonly background: string = '#FFFFFCF5'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFF7F7F7'
  static readonly outline: string = '#FFE2E2E2'
  static readonly onSurface: string = '#FF1E1E1E'
  static readonly onPrimary: string = '#FF1E1E1E'
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

@Component
struct FilterChip {
  @Prop text: string
  @Prop isSelected: boolean
  onChipClick: (value: string) => void = () => {
  }

  build() {
    Text(this.text)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onPrimary)
      .padding({
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm
      })
      .minWidth(49)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .onClick(() => {
        this.onChipClick(this.text)
      })
  }
}

@Component
struct CustomSwitch {
  @Link isOn: boolean

  build() {
    Stack({ alignContent: this.isOn ? Alignment.End : Alignment.Start }) {
      Column()
        .width(27)
        .height(27)
        .borderRadius(13.5)
        .backgroundColor(this.isOn ? AppColors.secondary : AppColors.outline)
        .shadow({
          radius: 2,
          color: '#1A000000',
          offsetX: 0,
          offsetY: 1
        })
    }
    .width(51)
    .height(31)
    .padding(2)
    .backgroundColor(this.isOn ? AppColors.primary : AppColors.surfaceVariant)
    .borderRadius(15.5)
    .onClick(() => {
      this.isOn = !this.isOn
    })
  }
}

@Component
struct LinearProgressIndicator {
  @Prop value: number

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Column()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppColors.surfaceVariant)

      Column()
        .width(`${this.value * 100}%`)
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .height(8)
  }
}

@Component
struct WaveChart {
  @Prop progress: number

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawWave(): void {
    const w: number = this.context.width
    const h: number = this.context.height
    const step: number = w / 30

    this.context.clearRect(0, 0, w, h)
    this.context.beginPath()
    this.context.moveTo(-step, h / 2)

    for (let i = 0; i <= 30; i++) {
      const x: number = i * step
      const y: number = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
      this.context.lineTo(x, y)
    }

    this.context.strokeStyle = '#FFFFA8A8'
    this.context.lineWidth = 5
    this.context.lineCap = 'butt'
    this.context.lineJoin = 'miter'
    this.context.stroke()
  }

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawWave()
      })
      .onAreaChange(() => {
        this.drawWave()
      })
  }
}

@Entry
@Component
struct Index {
  @State private selectedChip: string = 'BTC'
  @State private progress: number = 0.6
  @State private isAutoUpdate: boolean = true

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA']

  build() {
    Column() {
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: AppSpacing.lg,
          bottom: AppSpacing.lg
        })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Row({ space: AppSpacing.md }) {
          ForEach(this.chips, (chip: string) => {
            FilterChip({
              text: chip,
              isSelected: this.selectedChip === chip,
              onChipClick: (value: string) => {
                this.selectedChip = value
              }
            })
          }, (chip: string) => chip)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Stack() {
          WaveChart({ progress: this.progress })
            .width('100%')
            .height('100%')
            .padding(AppSpacing.lg)
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 4
        })

        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Center)

        LinearProgressIndicator({ value: this.progress })
          .width('100%')

        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)

          Blank()

          CustomSwitch({ isOn: $isAutoUpdate })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4DFFE1A8', 0.0],
          [AppColors.background, 0.5],
          ['#4DA8FFE1', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}