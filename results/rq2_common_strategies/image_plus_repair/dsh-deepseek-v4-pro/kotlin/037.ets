class BudgetItem {
  name: string
  value: number
  color1: string
  color2: string

  constructor(name: string, value: number, color1: string, color2: string) {
    this.name = name
    this.value = value
    this.color1 = color1
    this.color2 = color2
  }
}

class AppColors {
  static readonly primary: string = '#4A5568'
  static readonly secondary: string = '#718096'
  static readonly tertiary: string = '#A0AEC0'
  static readonly background: string = '#F7FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#EDF2F7'
  static readonly outline: string = '#E2E8F0'
  static readonly success: string = '#48BB78'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#F56565'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#1A202C'
  static readonly onBackground: string = '#1A202C'
  static readonly onSurface: string = '#1A202C'
}

const budgetData: BudgetItem[] = [
  new BudgetItem('Housing', 1250.00, '#63B3ED', '#4299E1'),
  new BudgetItem('Food', 480.50, '#4FD1C5', '#38B2AC'),
  new BudgetItem('Transport', 210.75, '#667EEA', '#5A67D8'),
  new BudgetItem('Entertainment', 150.00, '#ED64A6', '#D53F8C'),
  new BudgetItem('Utilities', 320.00, '#F6AD55', '#ED8936')
]

function totalBudget(items: BudgetItem[]): number {
  let sum: number = 0
  for (let i = 0; i < items.length; i++) {
    sum += items[i].value
  }
  return sum
}

function formatCurrency(value: number): string {
  const fixed: string = value.toFixed(2)
  const parts: string[] = fixed.split('.')
  const intPart: string = parts[0]
  let grouped: string = ''
  for (let i = 0; i < intPart.length; i++) {
    if (i > 0 && (intPart.length - i) % 3 === 0) {
      grouped += ','
    }
    grouped += intPart.charAt(i)
  }
  return '$' + grouped + '.' + parts[1]
}

@Entry
@Component
struct BudgetPage {
  private items: BudgetItem[] = budgetData
  private totalValue: number = totalBudget(budgetData)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  drawPieChart(): void {
    const ctx: CanvasRenderingContext2D = this.context
    const w: number = ctx.width
    const h: number = ctx.height
    const strokeW: number = 20
    const radius: number = Math.min(w, h) / 2 - strokeW / 2
    const cx: number = w / 2
    const cy: number = h / 2
    let start: number = -90
    ctx.lineWidth = strokeW
    for (let i = 0; i < this.items.length; i++) {
      const item: BudgetItem = this.items[i]
      const sweep: number = (item.value / this.totalValue) * 360
      const grad: CanvasGradient = ctx.createLinearGradient(0, 0, 0, h)
      grad.addColorStop(0, item.color1)
      grad.addColorStop(1, item.color2)
      ctx.strokeStyle = grad
      ctx.beginPath()
      ctx.arc(cx, cy, radius, (start * Math.PI) / 180, ((start + sweep) * Math.PI) / 180)
      ctx.stroke()
      start += sweep
    }
  }

  @Builder
  PieChartBuilder() {
    Stack() {
      Canvas(this.context)
        .width(240)
        .height(240)
        .onReady(() => {
          this.drawPieChart()
        })
      Column() {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
        Text(formatCurrency(this.totalValue))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(240)
    .height(240)
  }

  @Builder
  BudgetItemRowBuilder(item: BudgetItem) {
    Row() {
      Row({ space: 16 }) {
        Row()
          .width(20)
          .height(20)
          .borderRadius(10)
          .linearGradient({
            angle: 180,
            colors: [[item.color1, 0.0], [item.color2, 1.0]]
          })
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
      Text(formatCurrency(item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .padding({ top: 16, bottom: 16, left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBarItemBuilder(text: string, active: boolean) {
    Column({ space: 4 }) {
      Row()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(active ? '#334A5568' : '#33A0AEC0')
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(active ? AppColors.primary : AppColors.tertiary)
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
            .fontColor(AppColors.primary)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surface)

        Scroll() {
          Column({ space: 16 }) {
            Column() {
              this.PieChartBuilder()
              Row().height(24)
            }
            ForEach(this.items, (item: BudgetItem) => {
              Column() {
                this.BudgetItemRowBuilder(item)
              }
              .width('100%')
              .backgroundColor(AppColors.surface)
              .borderRadius(16)
              .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })
            }, (item: BudgetItem) => item.name)
            Row().height(48)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Center)
        }
        .layoutWeight(1)

        Row() {
          this.BottomBarItemBuilder('Home', true)
          this.BottomBarItemBuilder('Reports', false)
          Row().width(32)
          this.BottomBarItemBuilder('Goals', false)
          this.BottomBarItemBuilder('Settings', false)
        }
        .width('100%')
        .height(80)
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surface)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Button() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
      }
      .width(56)
      .height(56)
      .backgroundColor(AppColors.primary)
      .borderRadius(28)
      .margin({ right: 16, bottom: 96 })
      .onClick(() => {
      })
    }
    .width('100%')
    .height('100%')
  }
}
