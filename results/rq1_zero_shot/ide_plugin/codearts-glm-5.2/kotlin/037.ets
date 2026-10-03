const NAME = '448_BudgetPie_en'
const UI_TYPE = 'Finance'
const STYLE_THEME = 'Cold Gradient'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
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
    onSurface: '#1A202C',
    gradient1Start: '#63B3ED',
    gradient1End: '#4299E1',
    gradient2Start: '#4FD1C5',
    gradient2End: '#38B2AC',
    gradient3Start: '#667EEA',
    gradient3End: '#5A67D8',
    gradient4Start: '#ED64A6',
    gradient4End: '#D53F8C',
    gradient5Start: '#F6AD55',
    gradient5End: '#ED8936',
  }

  static TypographyTokens = {
    display: { fontSize: 36, fontWeight: FontWeight.Bold },
    headline: { fontSize: 24, fontWeight: FontWeight.Medium },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 16, fontWeight: FontWeight.Normal },
    label: { fontSize: 14, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 4,
    medium: 8,
    large: 16,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  }

  static ElevationMapping = {
    level1: { elevation: 1, radius: 3, dy: 1, opacity: 0.05 },
    level2: { elevation: 4, radius: 6, dy: 2, opacity: 0.07 },
    level3: { elevation: 8, radius: 15, dy: 5, opacity: 0.10 },
  }
}

interface BudgetItem {
  name: string
  value: number
  colorStart: string
  colorEnd: string
}

function formatCurrency(value: number): string {
  return '$' + value.toFixed(2)
}

@Entry
@Component
struct RootScreen {
  private budgetData: BudgetItem[] = [
    { name: 'Housing', value: 1250.00, colorStart: AppTokens.Colors.gradient1Start, colorEnd: AppTokens.Colors.gradient1End },
    { name: 'Food', value: 480.50, colorStart: AppTokens.Colors.gradient2Start, colorEnd: AppTokens.Colors.gradient2End },
    { name: 'Transport', value: 210.75, colorStart: AppTokens.Colors.gradient3Start, colorEnd: AppTokens.Colors.gradient3End },
    { name: 'Entertainment', value: 150.00, colorStart: AppTokens.Colors.gradient4Start, colorEnd: AppTokens.Colors.gradient4End },
    { name: 'Utilities', value: 320.00, colorStart: AppTokens.Colors.gradient5Start, colorEnd: AppTokens.Colors.gradient5End },
  ]

  private getTotal(): number {
    let total = 0
    for (const item of this.budgetData) {
      total += item.value
    }
    return total
  }

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    this.drawPieChart()
  }

  drawPieChart() {
    const ctx = this.canvasContext
    const cx = 120
    const cy = 120
    const radius = 100
    const strokeWidth = 20
    const total = this.getTotal()
    let startAngle = -90

    ctx.clearRect(0, 0, 240, 240)

    for (const item of this.budgetData) {
      const sweepAngle = (item.value / total) * 360
      const grad = ctx.createLinearGradient(cx, cy - radius, cx, cy + radius)
      grad.addColorStop(0, item.colorStart)
      grad.addColorStop(1, item.colorEnd)
      ctx.strokeStyle = grad
      ctx.lineWidth = strokeWidth
      ctx.beginPath()
      ctx.arc(cx, cy, radius, (startAngle * Math.PI) / 180, ((startAngle + sweepAngle) * Math.PI) / 180)
      ctx.stroke()
      startAngle += sweepAngle
    }
  }

  build() {
    Column() {
      Row() {
        Text('Monthly Budget')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      List() {
        ListItem() {
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
                  .fontSize(AppTokens.TypographyTokens.label.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                  .fontColor(AppTokens.Colors.secondary)

                Text(formatCurrency(this.getTotal()))
                  .fontSize(AppTokens.TypographyTokens.headline.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
                  .fontColor(AppTokens.Colors.primary)
              }
              .alignItems(HorizontalAlign.Center)
            }
            .width(240)
            .height(240)
            .alignContent(Alignment.Center)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.lg })
        }

        ForEach(this.budgetData, (item: BudgetItem, index: number) => {
          ListItem() {
            BudgetItemCard({ item: item })
          }
        }, (item: BudgetItem, index: number) => index.toString())

        ListItem() {
          Column() {
          }
          .height(AppTokens.Spacing.xxl)
        }
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.background)

      Stack() {
        Row() {
          BottomBarItem({ text: 'Home', active: true })
          BottomBarItem({ text: 'Reports', active: false })
          Column().width(AppTokens.Spacing.xl)
          BottomBarItem({ text: 'Goals', active: false })
          BottomBarItem({ text: 'Settings', active: false })
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: AppTokens.ElevationMapping.level3.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`, offsetY: -AppTokens.ElevationMapping.level3.dy })

        Button('+')
          .type(ButtonType.Normal)
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .position({ x: '50%', y: -28 })
          .markAnchor({ x: '50%', y: 0 })
      }
      .width('100%')
      .height(56)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct BudgetItemCard {
  private item: BudgetItem = { name: '', value: 0, colorStart: '', colorEnd: '' }

  build() {
    Row() {
      Row() {
        Column()
          .width(20)
          .height(20)
          .borderRadius(10)
          .linearGradient({
            angle: 180,
            colors: [[this.item.colorStart, 0.0], [this.item.colorEnd, 1.0]]
          })

        Text(this.item.name)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.md })
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
  }
}

@Component
struct BottomBarItem {
  private text: string = ''
  private active: boolean = false

  build() {
    Column() {
      Column()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.active ? '#334A5568' : '#33A0AEC0')

      Text(this.text)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
        .margin({ top: AppTokens.Spacing.xs })
    }
    .alignItems(HorizontalAlign.Center)
  }
}