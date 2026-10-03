import { drawing } from '@kit.ArkGraphics2D';

interface BudgetItemData {
  name: string;
  value: number;
  colors: string[];
}

const budgetData: BudgetItemData[] = [
  { name: 'Housing', value: 1250.00, colors: ['#63B3ED', '#4299E1'] },
  { name: 'Food', value: 480.50, colors: ['#4FD1C5', '#38B2AC'] },
  { name: 'Transport', value: 210.75, colors: ['#667EEA', '#5A67D8'] },
  { name: 'Entertainment', value: 150.00, colors: ['#ED64A6', '#D53F8C'] },
  { name: 'Utilities', value: 320.00, colors: ['#F6AD55', '#ED8936'] },
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
struct PieChartComponent {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(240)
        .height(240)
        .onReady(() => {
          this.drawPieChart();
        })

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
  }

  drawPieChart() {
    const ctx = this.context;
    const total = getTotalValue();
    const cx = 120;
    const cy = 120;
    const radius = 90;
    const strokeWidth = 30;
    let startAngle = -Math.PI / 2;

    ctx.clearRect(0, 0, 240, 240);

    for (const item of budgetData) {
      const sweepAngle = (item.value / total) * 2 * Math.PI;
      const endAngle = startAngle + sweepAngle;

      ctx.beginPath();
      ctx.arc(cx, cy, radius, startAngle, endAngle);
      ctx.strokeStyle = item.colors[0];
      ctx.lineWidth = strokeWidth;
      ctx.lineCap = 'butt';
      ctx.stroke();

      startAngle = endAngle;
    }
  }
}

@Component
struct BudgetItemRow {
  item: BudgetItemData = { name: '', value: 0, colors: ['#000000', '#000000'] };

  build() {
    Row() {
      Row({ space: 16 }) {
        Circle()
          .width(20)
          .height(20)
          .fill(this.item.colors[0])

        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1A202C')
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
struct BottomBarItemComponent {
  text: string = '';
  active: boolean = false;

  build() {
    Column({ space: 4 }) {
      Circle()
        .width(24)
        .height(24)
        .fill(this.active ? '#4A556833' : '#A0AEC033')

      Text(this.text)
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
struct Index {
  @State selectedTab: number = 0;

  @Builder
  TopBar() {
    Row() {
      Text('Monthly Budget')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#4A5568')
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  BottomBar() {
    Row() {
      BottomBarItemComponent({ text: 'Home', active: true })
      BottomBarItemComponent({ text: 'Reports', active: false })
      Row()
        .width(32)
      BottomBarItemComponent({ text: 'Goals', active: false })
      BottomBarItemComponent({ text: 'Settings', active: false })
    }
    .width('100%')
    .height(60)
    .padding({ left: 8, right: 8 })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
  }

  build() {
    Column() {
      this.TopBar()

      Stack({ alignContent: Alignment.BottomEnd }) {
        Scroll() {
          Column({ space: 16 }) {
            PieChartComponent()
              .margin({ top: 16 })

            Blank().height(24)

            ForEach(budgetData, (item: BudgetItemData) => {
              Column() {
                BudgetItemRow({ item: item })
              }
              .width('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 3, color: '#0000000D', offsetX: 0, offsetY: 1 })
            })

            Blank().height(48)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        Button('+')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor('#4A5568')
          .fontColor('#FFFFFF')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 80, right: 16 })
          .shadow({ radius: 6, color: '#00000020', offsetX: 0, offsetY: 2 })
      }
      .layoutWeight(1)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7FAFC')
  }
}