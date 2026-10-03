class AppTokens {
  static readonly Colors = {
    primary: '#FF4A5568',
    secondary: '#FF718096',
    tertiary: '#FFA0AEC0',
    background: '#FFF7FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFEDF2F7',
    outline: '#FFE2E8F0',
    success: '#FF48BB78',
    warning: '#FFF59E0B',
    error: '#FFF56565',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF1A202C',
    onBackground: '#FF1A202C',
    onSurface: '#FF1A202C',
    tertiary20: '#33A0AEC0',
    primary20: '#334A5568',
    slice1: '#FF63B3ED',
    slice2: '#FF4FD1C5',
    slice3: '#FF667EEA',
    slice4: '#FFED64A6',
    slice5: '#FFF6AD55'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  }

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 16
  }
}

class BudgetItem {
  name: string
  value: number
  color: string

  constructor(name: string, value: number, color: string) {
    this.name = name
    this.value = value
    this.color = color
  }
}

@Component
struct BudgetItemRow {
  @Prop name: string
  @Prop value: number
  @Prop color: string

  build() {
    Row() {
      Row() {
        Row()
          .width(20)
          .height(20)
          .borderRadius(10)
          .backgroundColor(this.color)
        Text(this.name)
          .fontSize(16)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: 16 })
      }

      Blank()

      Text(`$${this.value.toFixed(2)}`)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .padding(16)
  }
}

@Entry
@Component
struct BudgetPie {
  private budgetData: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, AppTokens.Colors.slice1),
    new BudgetItem('Food', 480.50, AppTokens.Colors.slice2),
    new BudgetItem('Transport', 210.75, AppTokens.Colors.slice3),
    new BudgetItem('Entertainment', 150.00, AppTokens.Colors.slice4),
    new BudgetItem('Utilities', 320.00, AppTokens.Colors.slice5)
  ]

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private getTotal(): number {
    let total = 0
    for (let i = 0; i < this.budgetData.length; i++) {
      total += this.budgetData[i].value
    }
    return total
  }

  private drawPieChart() {
    const ctx = this.canvasContext
    const w: number = 240
    const h: number = 240
    const centerX = w / 2
    const centerY = h / 2
    const radius = 110
    const strokeWidth = 20

    ctx.clearRect(0, 0, w, h)

    const total = this.getTotal()
    let currentAngle = -Math.PI / 2

    for (let i = 0; i < this.budgetData.length; i++) {
      const item = this.budgetData[i]
      const sweep = (item.value / total) * Math.PI * 2
      ctx.beginPath()
      ctx.arc(centerX, centerY, radius, currentAngle, currentAngle + sweep)
      ctx.strokeStyle = item.color
      ctx.lineWidth = strokeWidth
      ctx.stroke()
      currentAngle += sweep
    }
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Semibold)
            .fontColor(AppTokens.Colors.primary)
            .padding({ top: 16, bottom: 16 })
          Blank()
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)

        Scroll() {
          Column() {
            Stack() {
              Canvas(this.canvasContext)
                .width(240)
                .height(240)
                .onReady(() => {
                  this.drawPieChart()
                })

              Column() {
                Text('Total Spent')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.secondary)
                Text(`$${this.getTotal().toFixed(2)}`)
                  .fontSize(24)
                  .fontWeight(FontWeight.Semibold)
                  .fontColor(AppTokens.Colors.primary)
              }
            }
            .width(240)
            .height(240)
            .margin({ top: 24, bottom: 24 })

            ForEach(this.budgetData, (item: BudgetItem) => {
              Column() {
                BudgetItemRow({ name: item.name, value: item.value, color: item.color })
              }
              .borderRadius(16)
              .backgroundColor(AppTokens.Colors.surface)
              .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })
              .margin({ bottom: 16 })
            })
          }
          .padding({ left: 24, right: 24, bottom: 128 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        Stack() {
          Row() {
            Column() {
              Row()
                .width(24)
                .height(24)
                .borderRadius(12)
                .backgroundColor(AppTokens.Colors.primary20)
              Text('Home')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.primary)
            }
            Blank()
            Column() {
              Row()
                .width(24)
                .height(24)
                .borderRadius(12)
                .backgroundColor(AppTokens.Colors.tertiary20)
              Text('Reports')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.tertiary)
            }
            Blank()
            Column() {
              Row()
                .width(24)
                .height(24)
                .borderRadius(12)
                .backgroundColor(AppTokens.Colors.tertiary20)
              Text('Goals')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.tertiary)
            }
            Blank()
            Column() {
              Row()
                .width(24)
                .height(24)
                .borderRadius(12)
                .backgroundColor(AppTokens.Colors.tertiary20)
              Text('Settings')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.tertiary)
            }
          }
          .width('100%')
          .height(80)
          .padding({ left: 24, right: 24 })
          .backgroundColor(AppTokens.Colors.surface)

          Row()
            .width(56)
            .height(56)
            .borderRadius(28)
            .backgroundColor(AppTokens.Colors.primary)
            .shadow({ radius: 4, color: '#66000000', offsetX: 0, offsetY: 4 })
            .position({ x: '50%', y: -28 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}