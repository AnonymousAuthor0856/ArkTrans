@Entry
@Component
struct BudgetPieApp {
  @State budgetData: BudgetItem[] = [
    new BudgetItem("Housing", 1250.00, ['#63B3ED', '#4299E1']),
    new BudgetItem("Food", 480.50, ['#4FD1C5', '#38B2AC']),
    new BudgetItem("Transport", 210.75, ['#667EEA', '#5A67D8']),
    new BudgetItem("Entertainment", 150.00, ['#ED64A6', '#D53F8C']),
    new BudgetItem("Utilities", 320.00, ['#F6AD55', '#ED8936'])
  ];

  build() {
    Stack() {
      Column() {
        // Top App Bar
        Row() {
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4A5568')
            .textAlign(TextAlign.Center)
            .width('100%')
            .padding({ top: 16, bottom: 16 })
        }
        .width('100%')
        .backgroundColor('#F7FAFC')

        // Main Content
        Scroll() {
          Column({ space: 16 }) {
            // Pie Chart
            PieChart({ items: this.budgetData })
              .width(240)
              .height(240)
              .alignSelf(ItemAlign.Center)

            // Budget Items
            ForEach(this.budgetData, (item: BudgetItem) => {
              BudgetItemCard({ item: item })
            })

            // Bottom spacer
            Row()
              .height(48)
          }
          .padding({ left: 24, right: 24, top: 16 })
        }
        .layoutWeight(1)
        .align(Alignment.Top)

        // Bottom App Bar
        Row() {
          BottomBarItem({ text: 'Home', active: true })
          BottomBarItem({ text: 'Reports', active: false })
          Row()
            .width(32)
          BottomBarItem({ text: 'Goals', active: false })
          BottomBarItem({ text: 'Settings', active: false })
        }
        .width('100%')
        .height(64)
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 8, right: 8 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7FAFC')

      // Floating Action Button
      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor('#4A5568')
        .fontColor('#FFFFFF')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .position({ x: '50%', y: '100%' })
        .translate({ x: '-50%', y: '-88px' })
        .shadow({ radius: 8, color: '#1A4A5568', offsetY: 5 })
    }
    .width('100%')
    .height('100%')
  }
}

class BudgetItem {
  name: string;
  value: number;
  gradientColors: string[];

  constructor(name: string, value: number, gradientColors: string[]) {
    this.name = name;
    this.value = value;
    this.gradientColors = gradientColors;
  }
}

@Component
struct PieChart {
  @Prop items: BudgetItem[];

  private totalValue: number = 0;

  aboutToAppear(): void {
    this.totalValue = 0;
    for (let i = 0; i < this.items.length; i++) {
      this.totalValue += this.items[i].value;
    }
  }

  build() {
    Stack() {
      // Pie chart using Canvas
      Canvas(this.renderPieChart)
        .width('100%')
        .height('100%')

      Column({ space: 4 }) {
        Text('Total Spent')
          .fontSize(14)
          .fontColor('#718096')
        Text(this.formatCurrency(this.totalValue))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4A5568')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .alignItems(Alignment.Center)
  }

  private renderPieChart(ctx: CanvasRenderingContext2D, width: number, height: number): void {
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = Math.min(width, height) / 2 - 10;
    const strokeWidth = 20;
    let startAngle = -Math.PI / 2;

    for (let i = 0; i < this.items.length; i++) {
      const item = this.items[i];
      const sweepAngle = (item.value / this.totalValue) * 2 * Math.PI;

      // Create gradient
      const gradient = ctx.createLinearGradient(0, centerY - radius, 0, centerY + radius);
      gradient.addColorStop(0, item.gradientColors[0]);
      gradient.addColorStop(1, item.gradientColors[1]);

      ctx.beginPath();
      ctx.arc(centerX, centerY, radius, startAngle, startAngle + sweepAngle);
      ctx.strokeStyle = gradient;
      ctx.lineWidth = strokeWidth;
      ctx.lineCap = 'butt';
      ctx.stroke();

      startAngle += sweepAngle;
    }
  }

  private formatCurrency(value: number): string {
    return '$' + value.toFixed(2);
  }
}

@Component
struct BudgetItemCard {
  @Prop item: BudgetItem;

  build() {
    Row() {
      Row({ space: 16 }) {
        // Color indicator
        Row()
          .width(20)
          .height(20)
          .borderRadius(10)
          .linearGradient({
            angle: 180,
            colors: [[this.item.gradientColors[0], 0], [this.item.gradientColors[1], 1]]
          })

        Text(this.item.name)
          .fontSize(16)
          .fontColor('#1A202C')
      }
      .alignItems(VerticalAlign.Center)

      Text(this.formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A202C')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 16, bottom: 16, left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 3, color: '#0D000000', offsetY: 1 })
  }

  private formatCurrency(value: number): string {
    return '$' + value.toFixed(2);
  }
}

@Component
struct BottomBarItem {
  @Prop text: string;
  @Prop active: boolean;

  build() {
    Column({ space: 4 }) {
      Row()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.active ? '#1A4A5568' : '#1AA0AEC0')

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? '#4A5568' : '#A0AEC0')
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}