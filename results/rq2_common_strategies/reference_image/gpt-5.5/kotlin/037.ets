const PRIMARY: string = '#4A5568'
const SECONDARY: string = '#718096'
const TERTIARY: string = '#A0AEC0'
const BACKGROUND: string = '#F7FAFC'
const SURFACE: string = '#FFFFFF'
const OUTLINE: string = '#E2E8F0'
const ON_SURFACE: string = '#1A202C'

const SPACING_XS: number = 4
const SPACING_SM: number = 8
const SPACING_MD: number = 16
const SPACING_LG: number = 24
const SPACING_XL: number = 32
const SPACING_XXL: number = 48

interface BudgetItem {
  name: string
  value: number
  startColor: string
  endColor: string
  chartColor: string
}

const budgetData: BudgetItem[] = [
  {
    name: 'Housing',
    value: 1250.00,
    startColor: '#63B3ED',
    endColor: '#4299E1',
    chartColor: '#4299E1'
  },
  {
    name: 'Food',
    value: 480.50,
    startColor: '#4FD1C5',
    endColor: '#38B2AC',
    chartColor: '#38B2AC'
  },
  {
    name: 'Transport',
    value: 210.75,
    startColor: '#667EEA',
    endColor: '#5A67D8',
    chartColor: '#5A67D8'
  },
  {
    name: 'Entertainment',
    value: 150.00,
    startColor: '#ED64A6',
    endColor: '#D53F8C',
    chartColor: '#D53F8C'
  },
  {
    name: 'Utilities',
    value: 320.00,
    startColor: '#F6AD55',
    endColor: '#ED8936',
    chartColor: '#ED8936'
  }
]

function formatCurrency(value: number): string {
  let fixedValue: string = value.toFixed(2)
  let parts: string[] = fixedValue.split('.')
  let integerPart: string = parts[0]
  let decimalPart: string = parts[1]
  let result: string = ''

  for (let i = 0; i < integerPart.length; i++) {
    let remaining: number = integerPart.length - i
    result += integerPart.charAt(i)
    if (remaining > 1 && remaining % 3 === 1) {
      result += ','
    }
  }

  return '$' + result + '.' + decimalPart
}

function totalBudgetValue(items: BudgetItem[]): number {
  let total: number = 0
  items.forEach((item: BudgetItem) => {
    total += item.value
  })
  return total
}

@Component
struct PieChart {
  items: BudgetItem[] = []
  private chartSize: number = 240
  private strokeWidth: number = 20
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawChart(): void {
    const total: number = totalBudgetValue(this.items)
    const center: number = this.chartSize / 2
    const radius: number = (this.chartSize - this.strokeWidth) / 2
    let startAngle: number = -Math.PI / 2

    this.context.clearRect(0, 0, this.chartSize, this.chartSize)
    this.context.lineWidth = this.strokeWidth
    this.context.lineCap = 'butt'

    this.items.forEach((item: BudgetItem) => {
      const sweepAngle: number = item.value / total * Math.PI * 2
      const gradient = this.context.createLinearGradient(0, 0, 0, this.chartSize)
      gradient.addColorStop(0, item.startColor)
      gradient.addColorStop(1, item.endColor)

      this.context.beginPath()
      this.context.strokeStyle = gradient
      this.context.arc(center, center, radius, startAngle, startAngle + sweepAngle)
      this.context.stroke()

      startAngle += sweepAngle
    })
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(this.chartSize)
        .height(this.chartSize)
        .onReady(() => {
          this.drawChart()
        })

      Column() {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(SECONDARY)
          .letterSpacing(0.5)
          .lineHeight(20)

        Text(formatCurrency(totalBudgetValue(this.items)))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY)
          .letterSpacing(0)
          .lineHeight(34)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(this.chartSize)
    .height(this.chartSize)
  }
}

@Component
struct BudgetItemRow {
  item: BudgetItem = {
    name: '',
    value: 0,
    startColor: '#FFFFFF',
    endColor: '#FFFFFF',
    chartColor: '#FFFFFF'
  }

  build() {
    Row() {
      Row({ space: SPACING_MD }) {
        Blank()
          .width(20)
          .height(20)
          .borderRadius(10)
          .linearGradient({
            angle: 180,
            colors: [[this.item.startColor, 0], [this.item.endColor, 1]]
          })

        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(ON_SURFACE)
          .lineHeight(24)
      }
      .alignItems(VerticalAlign.Center)

      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE)
        .lineHeight(26)
    }
    .width('100%')
    .height(54)
    .padding({ left: SPACING_XL, right: SPACING_XL })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE)
    .borderRadius(16)
    .border({ width: 1, color: OUTLINE })
    .shadow({
      radius: 6,
      color: '#14000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Component
struct BottomBarItem {
  text: string = ''
  active: boolean = false

  build() {
    Column({ space: SPACING_XS }) {
      Blank()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.active ? '#334A5568' : '#33A0AEC0')

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? PRIMARY : TERTIARY)
        .letterSpacing(0.5)
        .textAlign(TextAlign.Center)
        .lineHeight(20)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct BottomBar {
  build() {
    Row() {
      BottomBarItem({ text: 'Home', active: true })
      BottomBarItem({ text: 'Reports', active: false })

      Blank()
        .width(SPACING_XL)

      BottomBarItem({ text: 'Goals', active: false })
      BottomBarItem({ text: 'Settings', active: false })
    }
    .width('100%')
    .height(90)
    .padding({ left: SPACING_SM, right: SPACING_SM, top: 10, bottom: 8 })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE)
    .shadow({
      radius: 15,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -3
    })
  }
}

@Component
struct FloatingAddButton {
  build() {
    Button() {
      Text('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .textAlign(TextAlign.Center)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(PRIMARY)
    .padding(0)
    .shadow({
      radius: 15,
      color: '#33000000',
      offsetX: 0,
      offsetY: 6
    })
  }
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(PRIMARY)
            .letterSpacing(-0.5)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(BACKGROUND)

        Scroll() {
          Column() {
            PieChart({ items: budgetData })
              .margin({ top: 0 })

            Blank()
              .height(40)

            ForEach(budgetData, (item: BudgetItem) => {
              BudgetItemRow({ item: item })
                .margin({ bottom: SPACING_MD })
            }, (item: BudgetItem) => item.name)

            Blank()
              .height(120)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ left: SPACING_LG, right: SPACING_LG })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BACKGROUND)

      BottomBar()
        .align(Alignment.Bottom)

      FloatingAddButton()
        .align(Alignment.BottomEnd)
        .margin({ right: SPACING_XL, bottom: 64 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}