// Index.ets

interface BudgetItem {
  name: string;
  value: number;
  color: string;
  gradientStart: string;
  gradientEnd: string;
}

const budgetData: BudgetItem[] = [
  { name: 'Housing', value: 1250.00, color: '#4299E1', gradientStart: '#63B3ED', gradientEnd: '#4299E1' },
  { name: 'Food', value: 480.50, color: '#38B2AC', gradientStart: '#4FD1C5', gradientEnd: '#38B2AC' },
  { name: 'Transport', value: 210.75, color: '#5A67D8', gradientStart: '#667EEA', gradientEnd: '#5A67D8' },
  { name: 'Entertainment', value: 150.00, color: '#D53F8C', gradientStart: '#ED64A6', gradientEnd: '#D53F8C' },
  { name: 'Utilities', value: 320.00, color: '#ED8936', gradientStart: '#F6AD55', gradientEnd: '#ED8936' },
];

function formatCurrency(value: number): string {
  return '$' + value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

function getTotalValue(): number {
  let total = 0;
  for (const item of budgetData) {
    total += item.value;
  }
  return total;
}

@Component
struct PieChartCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width(240)
      .height(240)
      .onReady(() => {
        this.drawPieChart();
      })
  }

  drawPieChart() {
    const ctx = this.context;
    const total = getTotalValue();
    const cx = 120;
    const cy = 120;
    const radius = 90;
    const strokeWidth = 30;
    let startAngle = -Math.PI / 2;

    for (const item of budgetData) {
      const sweepAngle = (item.value / total) * 2 * Math.PI;
      ctx.beginPath();
      ctx.arc(cx, cy, radius, startAngle, startAngle + sweepAngle);
      ctx.strokeStyle = item.color;
      ctx.lineWidth = strokeWidth;
      ctx.lineCap = 'butt';
      ctx.stroke();
      startAngle += sweepAngle;
    }
  }
}

@Component
struct BudgetItemRow {
  item: BudgetItem = budgetData[0];

  build() {
    Row() {
      Row() {
        Circle()
          .width(20)
          .height(20)
          .fill(this.item.color)
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1A202C')
          .margin({ left: 16 })
      }
      .alignItems(VerticalAlign.Center)

      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A202C')
    }
    .width('100%')
    .padding({ top: 16, bottom: 16, left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomBarItem {
  label: string = '';
  active: boolean = false;

  build() {
    Column() {
      Circle()
        .width(24)
        .height(24)
        .fill(this.active ? '#334155' : '#A0AEC0')
        .fillOpacity(0.2)
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? '#4A5568' : '#A0AEC0')
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top App Bar
        Row() {
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4A5568')
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .width('100%')
        .height(56)
        .backgroundColor('#F7FAFC')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Scrollable content
        Scroll() {
          Column() {
            // Pie Chart
            Stack({ alignContent: Alignment.Center }) {
              PieChartCanvas()

              Column() {
                Text('Total Spent')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#718096')
                Text(formatCurrency(getTotalValue()))
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#4A5568')
              }
              .alignItems(HorizontalAlign.Center)
            }
            .width(240)
            .height(240)
            .margin({ top: 16, bottom: 24 })

            // Budget item cards
            ForEach(budgetData, (item: BudgetItem) => {
              Column() {
                BudgetItemRow({ item: item })
              }
              .width('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })
              .margin({ bottom: 16 })
            })

            // Bottom spacer
            Column()
              .height(48)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // Bottom App Bar
        Row() {
          BottomBarItem({ label: 'Home', active: true })
          BottomBarItem({ label: 'Reports', active: false })
          Column().width(64)
          BottomBarItem({ label: 'Goals', active: false })
          BottomBarItem({ label: 'Settings', active: false })
        }
        .width('100%')
        .height(64)
        .backgroundColor('#FFFFFF')
        .padding({ left: 8, right: 8 })
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .shadow({ radius: 15, color: '#1A000000', offsetX: 0, offsetY: -5 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7FAFC')

      // FAB
      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor('#4A5568')
        .fontColor('#FFFFFF')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ right: 16, bottom: 80 })
        .shadow({ radius: 6, color: '#12000000', offsetX: 0, offsetY: 2 })
    }
    .width('100%')
    .height('100%')
  }
}