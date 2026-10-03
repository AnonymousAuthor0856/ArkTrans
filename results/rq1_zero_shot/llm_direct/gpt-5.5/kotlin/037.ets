const NAME: string = '448_BudgetPie_en'
const UI_TYPE: string = 'Finance'
const STYLE_THEME: string = 'Cold Gradient'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

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

class AppTypographyTokens {
  static readonly displaySize: number = 36
  static readonly headlineSize: number = 24
  static readonly titleSize: number = 18
  static readonly bodySize: number = 16
  static readonly labelSize: number = 14
}

class AppShapes {
  static readonly small: number = 4
  static readonly medium: number = 8
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 16
  static readonly lg: number = 24
  static readonly xl: number = 32
  static readonly xxl: number = 48
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.05)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 6, 2, 0.07)
  static readonly level3: ShadowSpec = new ShadowSpec(8, 15, 5, 0.10)
}

class GradientSpec {
  start: string
  end: string

  constructor(start: string, end: string) {
    this.start = start
    this.end = end
  }
}

class BudgetItem {
  name: string
  value: number
  gradient: GradientSpec

  constructor(name: string, value: number, gradient: GradientSpec) {
    this.name = name
    this.value = value
    this.gradient = gradient
  }
}

const budgetData: BudgetItem[] = [
  new BudgetItem('Housing', 1250.00, new GradientSpec('#63B3ED', '#4299E1')),
  new BudgetItem('Food', 480.50, new GradientSpec('#4FD1C5', '#38B2AC')),
  new BudgetItem('Transport', 210.75, new GradientSpec('#667EEA', '#5A67D8')),
  new BudgetItem('Entertainment', 150.00, new GradientSpec('#ED64A6', '#D53F8C')),
  new BudgetItem('Utilities', 320.00, new GradientSpec('#F6AD55', '#ED8936'))
]

function rgbaFromHex(hex: string, opacity: number): string {
  let value = hex.replace('#', '')
  if (value.length === 8) {
    value = value.substring(2)
  }
  const r = parseInt(value.substring(0, 2), 16)
  const g = parseInt(value.substring(2, 4), 16)
  const b = parseInt(value.substring(4, 6), 16)
  return `rgba(${r}, ${g}, ${b}, ${opacity})`
}

function formatCurrency(value: number): string {
  const fixed = value.toFixed(2)
  const parts = fixed.split('.')
  const intPart = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',')
  return `$${intPart}.${parts[1]}`
}

@Builder
function BottomBarItem(text: string, active: boolean) {
  Column({ space: AppSpacing.xs }) {
    Circle()
      .width(24)
      .height(24)
      .fill(rgbaFromHex(active ? AppColors.primary : AppColors.tertiary, 0.2))

    Text(text)
      .fontSize(AppTypographyTokens.labelSize)
      .fontWeight(FontWeight.Medium)
      .letterSpacing(0.5)
      .fontColor(active ? AppColors.primary : AppColors.tertiary)
      .textAlign(TextAlign.Center)
  }
  .alignItems(HorizontalAlign.Center)
}

@Component
struct PieChart {
  @Prop items: BudgetItem[] = budgetData
  @Prop strokeWidth: number = 20

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private totalValue(): number {
    let total = 0
    this.items.forEach((item: BudgetItem) => {
      total += item.value
    })
    return total
  }

  private drawChart(): void {
    const width = this.context.width
    const height = this.context.height

    if (width <= 0 || height <= 0) {
      return
    }

    const total = this.totalValue()
    const cx = width / 2
    const cy = height / 2
    const radius = Math.min(width, height) / 2 - this.strokeWidth / 2

    this.context.clearRect(0, 0, width, height)
    this.context.lineWidth = this.strokeWidth
    this.context.lineCap = 'butt'

    let startAngle = -90

    this.items.forEach((item: BudgetItem) => {
      const sweepAngle = item.value / total * 360
      const startRadians = startAngle * Math.PI / 180
      const endRadians = (startAngle + sweepAngle) * Math.PI / 180
      const gradient = this.context.createLinearGradient(0, 0, 0, height)

      gradient.addColorStop(0, item.gradient.start)
      gradient.addColorStop(1, item.gradient.end)

      this.context.beginPath()
      this.context.strokeStyle = gradient
      this.context.arc(cx, cy, radius, startRadians, endRadians, false)
      this.context.stroke()

      startAngle += sweepAngle
    })
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawChart()
        })
        .onAreaChange(() => {
          this.drawChart()
        })

      Column() {
        Text('Total Spent')
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(AppColors.secondary)

        Text(formatCurrency(this.totalValue()))
          .fontSize(AppTypographyTokens.headlineSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(240)
    .height(240)
  }
}

@Component
struct BudgetItemRow {
  @Prop item: BudgetItem

  build() {
    Row() {
      Row({ space: AppSpacing.md }) {
        Column()
          .width(20)
          .height(20)
          .borderRadius(10)
          .linearGradient({
            angle: 180,
            colors: [
              [this.item.gradient.start, 0.0],
              [this.item.gradient.end, 1.0]
            ]
          })

        Text(this.item.name)
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Text(formatCurrency(this.item.value))
        .fontSize(AppTypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .padding({
      top: AppSpacing.md,
      bottom: AppSpacing.md,
      left: AppSpacing.md,
      right: AppSpacing.md
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Text('Monthly Budget')
            .fontSize(AppTypographyTokens.headlineSize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.background)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            PieChart({ items: budgetData, strokeWidth: 20 })
              .margin({ top: AppSpacing.md })

            Blank()
              .height(AppSpacing.sm)

            ForEach(budgetData, (item: BudgetItem) => {
              Column() {
                BudgetItemRow({ item: item })
              }
              .width('100%')
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.large)
              .shadow({
                radius: AppElevationMapping.level1.radius,
                color: rgbaFromHex('#000000', AppElevationMapping.level1.opacity),
                offsetX: 0,
                offsetY: AppElevationMapping.level1.dy
              })
            }, (item: BudgetItem) => item.name)

            Blank()
              .height(AppSpacing.xxl)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor(AppColors.background)

        Row() {
          BottomBarItem('Home', true)
          BottomBarItem('Reports', false)

          Blank()
            .width(AppSpacing.xl)

          BottomBarItem('Goals', false)
          BottomBarItem('Settings', false)
        }
        .width('100%')
        .height(80)
        .padding({
          left: AppSpacing.sm,
          right: AppSpacing.sm
        })
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: AppElevationMapping.level3.radius,
          color: rgbaFromHex('#000000', AppElevationMapping.level3.opacity),
          offsetX: 0,
          offsetY: -AppElevationMapping.level3.dy
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Button('+', { type: ButtonType.Circle, stateEffect: true })
        .width(56)
        .height(56)
        .fontSize(AppTypographyTokens.headlineSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .margin({
          right: AppSpacing.lg,
          bottom: 52
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct MainActivity {
  build() {
    RootScreen()
  }
}