@Entry
@Component
struct Index {
  private budgetData: BudgetItem[] = [
    { name: 'Housing', value: 1250.00, color1: '#63B3ED', color2: '#4299E1' },
    { name: 'Food', value: 480.50, color1: '#4FD1C5', color2: '#38B2AC' },
    { name: 'Transport', value: 210.75, color1: '#667EEA', color2: '#5A67D8' },
    { name: 'Entertainment', value: 150.00, color1: '#ED64A6', color2: '#D53F8C' },
    { name: 'Utilities', value: 320.00, color1: '#F6AD55', color2: '#ED8936' }
  ]

  private bottomItems: string[] = ['Home', 'Reports', 'Goals', 'Settings']
  @State activeIndex: number = 0
  @State totalSpent: number = 0

  private pieCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  aboutToAppear() {
    this.totalSpent = this.budgetData.reduce((sum, item) => sum + item.value, 0)
  }

  aboutToDismiss() {
  }

  private formatCurrency(value: number): string {
    return '$' + value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',')
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main content
      Column() {
        // Top bar title
        Text('Monthly Budget')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4A5568')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 48, bottom: 24 })
          .backgroundColor('#FFFFFF')

        Scroll() {
          Column() {
            // Donut chart with center text
            Stack({ alignContent: Alignment.Center }) {
              Canvas(this.pieCtx)
                .width(320)
                .height(320)
                .onReady(() => {
                  this.drawPieChart()
                })

              Column({ space: 4 }) {
                Text('Total Spent')
                  .fontSize(24)
                  .fontColor('#718096')
                Text(this.formatCurrency(this.totalSpent))
                  .fontSize(48)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#4A5568')
              }
              .alignItems(HorizontalAlign.Center)
            }
            .width('100%')
            .padding({ top: 16, bottom: 32 })

            // Budget item list
            Column({ space: 24 }) {
              ForEach(this.budgetData, (item: BudgetItem) => {
                Row() {
                  Row() {
                    Column()
                      .width(36)
                      .height(36)
                      .borderRadius(18)
                      .backgroundColor(item.color1)
                      .margin({ right: 20 })
                    Text(item.name)
                      .fontSize(28)
                      .fontColor('#1A202C')
                  }
                  .layoutWeight(1)
                  .alignItems(VerticalAlign.Center)

                  Text(this.formatCurrency(item.value))
                    .fontSize(32)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1A202C')
                }
                .width('100%')
                .padding(24)
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .shadow({
                  radius: 4,
                  color: 'rgba(0, 0, 0, 0.08)',
                  offsetX: 0,
                  offsetY: 2
                })
              })
            }
            .width('100%')
            .padding({ left: 24, right: 24, bottom: 140 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .layoutWeight(1)
        .backgroundColor('#F7FAFC')
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)

        // Bottom navigation bar
        Row() {
          ForEach(this.bottomItems, (item: string, index: number) => {
            Column({ space: 4 }) {
              Column()
                .width(36)
                .height(36)
                .borderRadius(18)
                .backgroundColor(this.activeIndex === index ? '#4A5568' : '#CBD5E0')
                .opacity(this.activeIndex === index ? 1.0 : 0.3)
              Text(item)
                .fontSize(20)
                .fontColor(this.activeIndex === index ? '#4A5568' : '#A0AEC0')
                .fontWeight(this.activeIndex === index ? FontWeight.Medium : FontWeight.Normal)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.activeIndex = index
            })
          })
        }
        .width('100%')
        .height(100)
        .backgroundColor('#E2E8F0')
      }
      .width('100%')
      .height('100%')

      // Floating action button
      Button('+')
        .width(80)
        .height(80)
        .fontSize(40)
        .fontColor('#FFFFFF')
        .backgroundColor('#4A5568')
        .borderRadius(40)
        .shadow({
          radius: 16,
          color: 'rgba(0, 0, 0, 0.2)',
          offsetX: 0,
          offsetY: 6
        })
        .margin({ right: 32, bottom: 130 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7FAFC')
  }

  private drawPieChart() {
    const ctx = this.pieCtx
    const centerX = 160
    const centerY = 160
    const radius = 140
    const strokeWidth = 24
    const total = this.totalSpent

    ctx.clearRect(0, 0, 320, 320)
    ctx.lineWidth = strokeWidth
    ctx.lineCap = 'butt'

    let startAngle = -Math.PI / 2

    for (let i = 0; i < this.budgetData.length; i++) {
      const item = this.budgetData[i]
      const sweepAngle = (item.value / total) * Math.PI * 2

      const gradient = ctx.createLinearGradient(0, 0, 320, 320)
      gradient.addColorStop(0, item.color1)
      gradient.addColorStop(1, item.color2)

      ctx.beginPath()
      ctx.strokeStyle = gradient
      ctx.arc(centerX, centerY, radius, startAngle, startAngle + sweepAngle)
      ctx.stroke()

      startAngle += sweepAngle
    }
  }
}

interface BudgetItem {
  name: string
  value: number
  color1: string
  color2: string
}
