// File 037 - Monthly Budget (Finance)
interface BudgetItem {
  name: string
  value: number
  colorA: string
  colorB: string
}

const Colors = {
  primary: '#4A5568',
  secondary: '#718096',
  tertiary: '#A0AEC0',
  background: '#F7FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#EDF2F7',
  outline: '#E2E8F0',
  success: '#48BB78',
  warning: '#F59E0B',
  error: '#F56565',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#1A202C',
  onBackground: '#1A202C',
  onSurface: '#1A202C'
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48
}

const budgetData: BudgetItem[] = [
  { name: 'Housing', value: 1250.00, colorA: '#63B3ED', colorB: '#4299E1' },
  { name: 'Food', value: 480.50, colorA: '#4FD1C5', colorB: '#38B2AC' },
  { name: 'Transport', value: 210.75, colorA: '#667EEA', colorB: '#5A67D8' },
  { name: 'Entertainment', value: 150.00, colorA: '#ED64A6', colorB: '#D53F8C' },
  { name: 'Utilities', value: 320.00, colorA: '#F6AD55', colorB: '#ED8936' }
]

@Entry
@Component
struct Index {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private totalBudget(): number {
    let sum = 0
    for (const item of budgetData) {
      sum += item.value
    }
    return sum
  }

  private formatCurrency(value: number): string {
    const fixed = value.toFixed(2)
    const dot = fixed.indexOf('.')
    const intPart = fixed.substring(0, dot)
    const frac = fixed.substring(dot)
    let result = ''
    let count = 0
    for (let i = intPart.length - 1; i >= 0; i--) {
      result = intPart.charAt(i) + result
      count++
      if (count % 3 === 0 && i > 0) {
        result = ',' + result
      }
    }
    return '$' + result + frac
  }

  private drawPie() {
    const c = this.context
    const w = c.width
    const h = c.height
    const cx = w / 2
    const cy = h / 2
    const radius = Math.min(w, h) / 2 - 10
    const total = this.totalBudget()
    let start = -Math.PI / 2
    c.clearRect(0, 0, w, h)
    for (const item of budgetData) {
      const sweep = (item.value / total) * Math.PI * 2
      const grad = c.createLinearGradient(0, 0, 0, h)
      grad.addColorStop(0, item.colorA)
      grad.addColorStop(1, item.colorB)
      c.beginPath()
      c.arc(cx, cy, radius, start, start + sweep)
      c.strokeStyle = grad
      c.lineWidth = 20
      c.lineCap = 'butt'
      c.stroke()
      start += sweep
    }
  }

  @Builder
  BottomBarItem(text: string, active: boolean) {
    Column({ space: Spacing.xs }) {
      Stack() {}
        .width(24)
        .height(24)
        .backgroundColor(active ? '#334A5568' : '#33A0AEC0')
        .borderRadius(12)
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(active ? Colors.primary : Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.primary)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)

        Scroll() {
          Column({ space: Spacing.md }) {
            Stack() {
              Canvas(this.context)
                .width(240)
                .height(240)
                .onReady(() => { this.drawPie() })
              Column() {
                Text('Total Spent')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.secondary)
                Text(this.formatCurrency(this.totalBudget()))
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Colors.primary)
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            .width(240)
            .height(240)

            Blank().height(Spacing.lg)

            ForEach(budgetData, (item: BudgetItem) => {
              Column() {
                Row() {
                  Row({ space: Spacing.md }) {
                    Stack() {}
                      .width(20)
                      .height(20)
                      .linearGradient({ angle: 180, colors: [[item.colorA, 0.0], [item.colorB, 1.0]] })
                      .borderRadius(10)
                    Text(item.name)
                      .fontSize(16)
                      .fontColor(Colors.onSurface)
                  }
                  .alignItems(VerticalAlign.Center)
                  Blank().layoutWeight(1)
                  Text(this.formatCurrency(item.value))
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                }
                .width('100%')
                .padding({ top: Spacing.md, bottom: Spacing.md, left: Spacing.md, right: Spacing.md })
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .backgroundColor(Colors.surface)
              .borderRadius(16)
            }, (item: BudgetItem) => item.name)

            Blank().height(Spacing.xxl)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        Row() {
          this.BottomBarItem('Home', true)
          this.BottomBarItem('Reports', false)
          Blank().width(Spacing.xl)
          this.BottomBarItem('Goals', false)
          this.BottomBarItem('Settings', false)
        }
        .width('100%')
        .padding({ left: Spacing.sm, right: Spacing.sm })
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Colors.surface)
      }
      .width('100%')
      .height('100%')

      Button('+', { type: ButtonType.Circle })
        .width(56)
        .height(56)
        .backgroundColor(Colors.primary)
        .fontColor(Colors.onPrimary)
        .fontSize(24)
        .margin({ right: Spacing.lg, bottom: 80 })
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
