@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // Top bar
        Row() {
          Text("Monthly Budget")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4A5568')
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')

        Scroll() {
          Column() {
            // Pie chart
            Stack() {
              // Donut chart background ring
              Circle()
                .fill('#EDF2F7')
                .strokeWidth(0)

              // Pie slices drawn as arc shapes
              PieChartComponent({ items: budgetData })

              // Center text
              Column() {
                Text("Total Spent")
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#718096')
                Text(formatCurrency(totalBudget))
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#4A5568')
              }
              .alignItems(HorizontalAlign.Center)
            }
            .width(240)
            .height(240)
            .margin({ top: 24, bottom: 24 })

            // Budget items list
            ForEach(budgetData, (item: BudgetItem) => {
              Row() {
                Row() {
                  Circle()
                    .width(20)
                    .height(20)
                    .fill(item.colorStart)
                    .margin({ right: 16 })
                  Text(item.name)
                    .fontSize(16)
                    .fontColor('#1A202C')
                }
                .alignItems(VerticalAlign.Center)

                Text(formatCurrency(item.value))
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1A202C')
              }
              .width('100%')
              .padding(16)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .margin({ bottom: 12 })
              .shadow({
                radius: 3,
                color: 'rgba(0, 0, 0, 0.05)',
                offsetY: 1
              })
            })

            // Bottom spacer
            Blank()
              .height(48)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor('#F7FAFC')

        // Bottom bar
        Row() {
          BottomBarItem({ text: "Home", active: true })
          BottomBarItem({ text: "Reports", active: false })
          // Spacer for FAB
          Column()
            .width(64)

          BottomBarItem({ text: "Goals", active: false })
          BottomBarItem({ text: "Settings", active: false })
        }
        .width('100%')
        .height(72)
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .shadow({
          radius: 15,
          color: 'rgba(0, 0, 0, 0.10)',
          offsetY: -5
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7FAFC')

      // FAB
      Stack() {
        Text("+")
          .fontSize(28)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#4A5568')
      .alignContent(Alignment.Center)
      .position({ x: '50%', y: '100%' })
      .translate({ x: -28, y: -88 })
      .shadow({
        radius: 8,
        color: 'rgba(74, 85, 104, 0.3)',
        offsetY: 4
      })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct PieChartComponent {
  @State items: BudgetItem[] = []
  private strokeWidth: number = 20

  build() {
    Canvas(this.pieChartSettings)
      .width(240)
      .height(240)
      .backgroundColor(Color.Transparent)
      .onReady(() => {
        this.drawPieChart()
      })
  }

  private pieChartSettings: CanvasRenderingContext2D | null = null

  drawPieChart() {
    // Canvas drawing approach for pie chart
  }
}

@Component
struct BottomBarItem {
  @State text: string = ""
  @State active: boolean = false

  build() {
    Column() {
      Circle()
        .width(24)
        .height(24)
        .fill(this.active ? 'rgba(74, 85, 104, 0.2)' : 'rgba(160, 174, 192, 0.2)')
      Text(this.text)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? '#4A5568' : '#A0AEC0')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

interface BudgetItem {
  name: string;
  value: number;
  colorStart: string;
}

const budgetData: BudgetItem[] = [
  { name: "Housing", value: 1250.00, colorStart: '#4299E1' },
  { name: "Food", value: 480.50, colorStart: '#38B2AC' },
  { name: "Transport", value: 210.75, colorStart: '#5A67D8' },
  { name: "Entertainment", value: 150.00, colorStart: '#D53F8C' },
  { name: "Utilities", value: 320.00, colorStart: '#ED8936' }
]

const totalBudget: number = budgetData.reduce((sum, item) => sum + item.value, 0)

function formatCurrency(value: number): string {
  return '$' + value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',')
}
