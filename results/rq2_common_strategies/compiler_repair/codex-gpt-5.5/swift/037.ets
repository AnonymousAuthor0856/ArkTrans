class BudgetItem {
  name: string
  value: number
  colorStart: string
  colorEnd: string

  constructor(name: string, value: number, colorStart: string, colorEnd: string) {
    this.name = name
    this.value = value
    this.colorStart = colorStart
    this.colorEnd = colorEnd
  }
}

@Entry
@Component
struct Index {
  private budgetData: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, '#63B3ED', '#4299E1'),
    new BudgetItem('Food', 480.50, '#4FD1C5', '#38B2AC'),
    new BudgetItem('Transport', 210.75, '#667EEA', '#5A67D8'),
    new BudgetItem('Entertainment', 150.00, '#ED64A6', '#D53F8C'),
    new BudgetItem('Utilities', 320.00, '#F6AD55', '#ED8936')
  ]

  private totalValue(): number {
    let total = 0
    this.budgetData.forEach((item: BudgetItem) => {
      total += item.value
    })
    return total
  }

  private formatCurrency(value: number): string {
    return `$${value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',')}`
  }

  private itemPercent(item: BudgetItem): number {
    return item.value / this.totalValue()
  }

  @Builder
  PieChart() {
    Stack() {
      Circle()
        .width(240)
        .height(240)
        .fill('#EDF2F7')

      ForEach(this.budgetData, (item: BudgetItem) => {
        Circle()
          .width(224)
          .height(224)
          .fill(item.colorStart)
          .opacity(0.18 + this.itemPercent(item))
          .scale({ x: 0.72 + this.itemPercent(item) * 0.4, y: 0.72 + this.itemPercent(item) * 0.4 })
      }, (item: BudgetItem) => item.name)

      Circle()
        .width(154)
        .height(154)
        .fill('#F7FAFC')

      Column() {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#718096')
        Text(this.formatCurrency(this.totalValue()))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4A5568')
          .margin({ top: 4 })
      }
    }
    .width(240)
    .height(240)
  }

  @Builder
  BudgetRow(item: BudgetItem) {
    Row() {
      Row() {
        Circle()
          .width(20)
          .height(20)
          .linearGradient({ angle: 180, colors: [[item.colorStart, 0.0], [item.colorEnd, 1.0]] })
        Text(item.name)
          .fontSize(16)
          .fontColor('#1A202C')
          .margin({ left: 16 })
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)

      Text(this.formatCurrency(item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A202C')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 3, color: '#0D000000', offsetY: 1 })
  }

  @Builder
  BottomBarItem(text: string, active: boolean) {
    Column() {
      Circle()
        .width(24)
        .height(24)
        .fill(active ? '#334A5568' : '#33A0AEC0')
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(active ? '#4A5568' : '#A0AEC0')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4A5568')
            .padding({ top: 16, bottom: 16 })
          Blank()
        }
        .width('100%')
        .backgroundColor('#F7FAFC')

        Scroll() {
          Column() {
            Column() {
              this.PieChart()
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            .padding({ top: 24, bottom: 24 })

            Column() {
              ForEach(this.budgetData, (item: BudgetItem) => {
                Column() {
                  this.BudgetRow(item)
                }
                .margin({ bottom: 16 })
              }, (item: BudgetItem) => item.name)
            }
            .width('100%')

            Blank()
              .height(128)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7FAFC')

      Stack({ alignContent: Alignment.Top }) {
        Row() {
          this.BottomBarItem('Home', true)
          Blank()
          this.BottomBarItem('Reports', false)
          Blank()
          Blank().width(56)
          Blank()
          this.BottomBarItem('Goals', false)
          Blank()
          this.BottomBarItem('Settings', false)
        }
        .width('100%')
        .height(80)
        .padding({ left: 24, right: 24 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 15, color: '#1A000000', offsetY: -5 })
        .alignItems(VerticalAlign.Center)

        Button('+')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .width(56)
          .height(56)
          .backgroundColor('#4A5568')
          .borderRadius(28)
          .shadow({ radius: 4, color: '#33000000', offsetY: 4 })
          .translate({ y: -28 })
      }
      .width('100%')
      .height(108)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7FAFC')
  }
}
