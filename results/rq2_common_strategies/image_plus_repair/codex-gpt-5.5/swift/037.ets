interface BudgetItem {
  name: string
  value: number
  color: string
}

@Entry
@Component
struct BudgetPieApp {
  private readonly items: BudgetItem[] = [
    { name: 'Housing', value: 1250.00, color: '#57A5DF' },
    { name: 'Food', value: 480.50, color: '#35B2AA' },
    { name: 'Transport', value: 210.75, color: '#5D70D8' },
    { name: 'Entertainment', value: 150.00, color: '#DD438F' },
    { name: 'Utilities', value: 320.00, color: '#F5A647' }
  ]

  private readonly total: number = 2411.25
  private chartContext: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  @State private selectedTab: string = 'Home'
  @State private toastText: string = ''

  private formatCurrency(value: number): string {
    return '$' + value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',')
  }

  private showMessage(message: string): void {
    this.toastText = message
    setTimeout(() => {
      this.toastText = ''
    }, 1200)
  }

  private drawChart(): void {
    const context = this.chartContext
    const centerX = 140
    const centerY = 140
    const radius = 120
    const width = 20
    const total = this.total
    let start = -Math.PI / 2

    context.clearRect(0, 0, 280, 280)
    context.lineWidth = width
    context.lineCap = 'butt'

    this.items.forEach((item: BudgetItem) => {
      const sweep = item.value / total * Math.PI * 2
      context.beginPath()
      context.strokeStyle = item.color
      context.arc(centerX, centerY, radius, start, start + sweep, false)
      context.stroke()
      start += sweep
    })
  }

  @Builder
  private budgetRow(item: BudgetItem): void {
    Row() {
      Row({ space: 16 }) {
        Circle()
          .width(20)
          .height(20)
          .fill(item.color)

        Text(item.name)
          .fontSize(18)
          .fontColor('#1A202C')
      }
      .alignItems(VerticalAlign.Center)

      Blank()
        .layoutWeight(1)

      Text(this.formatCurrency(item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A202C')
    }
    .width('100%')
    .height(72)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: '#12000000', offsetY: 1 })
  }

  @Builder
  private navItem(label: string, active: boolean): void {
    Column({ space: 6 }) {
      Circle()
        .width(24)
        .height(24)
        .fill(active ? '#4A5568' : '#A0AEC0')
        .opacity(0.2)

      Text(label)
        .fontSize(14)
        .fontColor(active ? '#4A5568' : '#A0AEC0')
        .fontWeight(active ? FontWeight.Medium : FontWeight.Regular)
    }
    .width(64)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.selectedTab = label
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text('Monthly Budget')
          .width('100%')
          .height(72)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4A5568')
          .textAlign(TextAlign.Center)
          .padding({ top: 20 })

        Scroll() {
          Column({ space: 16 }) {
            Stack() {
              Canvas(this.chartContext)
                .width(280)
                .height(280)
                .onReady(() => {
                  this.drawChart()
                })

              Column({ space: 2 }) {
                Text('Total Spent')
                  .fontSize(14)
                  .fontColor('#718096')

                Text(this.formatCurrency(this.total))
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#4A5568')
              }
            }
            .width(280)
            .height(280)
            .margin({ top: 8, bottom: 8 })

            Column({ space: 16 }) {
              ForEach(this.items, (item: BudgetItem) => {
                this.budgetRow(item)
              }, (item: BudgetItem) => item.name)
            }
            .width('100%')

            Blank()
              .height(100)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7FAFC')

      Row() {
        this.navItem('Home', this.selectedTab === 'Home')
        Blank().layoutWeight(1)
        this.navItem('Reports', this.selectedTab === 'Reports')
        Blank().layoutWeight(1)
        Blank().width(56)
        Blank().layoutWeight(1)
        this.navItem('Goals', this.selectedTab === 'Goals')
        Blank().layoutWeight(1)
        this.navItem('Settings', this.selectedTab === 'Settings')
      }
      .width('100%')
      .height(80)
      .padding({ left: 24, right: 24 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 15, color: '#18000000', offsetY: -5 })

      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(38)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .backgroundColor('#4A5568')
      .shadow({ radius: 8, color: '#40000000', offsetY: 4 })
      .margin({ bottom: 52 })
      .onClick(() => {
        this.showMessage('Add expense')
      })

      if (this.toastText.length > 0) {
        Text(this.toastText)
          .fontSize(14)
          .fontColor('#FFFFFF')
          .backgroundColor('#4A5568')
          .borderRadius(20)
          .padding({ left: 16, right: 16, top: 9, bottom: 9 })
          .margin({ bottom: 145 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7FAFC')
  }
}
