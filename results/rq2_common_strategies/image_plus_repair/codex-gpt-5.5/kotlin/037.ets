interface BudgetItem {
  name: string;
  value: number;
  topColor: string;
  bottomColor: string;
}

interface AppColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  outline: string;
  onSurface: string;
}

const COLORS: AppColors = {
  primary: '#4A5568',
  secondary: '#718096',
  tertiary: '#A0AEC0',
  background: '#F7FAFC',
  surface: '#FFFFFF',
  outline: '#E2E8F0',
  onSurface: '#1A202C'
};

const BUDGET_DATA: BudgetItem[] = [
  { name: 'Housing', value: 1250.00, topColor: '#63B3ED', bottomColor: '#4299E1' },
  { name: 'Food', value: 480.50, topColor: '#4FD1C5', bottomColor: '#38B2AC' },
  { name: 'Transport', value: 210.75, topColor: '#667EEA', bottomColor: '#5A67D8' },
  { name: 'Entertainment', value: 150.00, topColor: '#ED64A6', bottomColor: '#D53F8C' },
  { name: 'Utilities', value: 320.00, topColor: '#F6AD55', bottomColor: '#ED8936' }
];

@Entry
@Component
struct MonthlyBudgetPage {
  private readonly chartSize: number = 520;
  private readonly chartStroke: number = 40;
  private readonly canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private readonly canvasContext: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(this.canvasSettings);

  private totalSpent(): number {
    let total = 0;
    BUDGET_DATA.forEach((item: BudgetItem) => {
      total += item.value;
    });
    return total;
  }

  private formatCurrency(value: number): string {
    const fixed = value.toFixed(2);
    const parts = fixed.split('.');
    const whole = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    return '$' + whole + '.' + parts[1];
  }

  private drawPieChart(): void {
    const context = this.canvasContext;
    const center = this.chartSize / 2;
    const radius = center - this.chartStroke / 2;
    const total = this.totalSpent();
    let startAngle = -Math.PI / 2;

    context.clearRect(0, 0, this.chartSize, this.chartSize);
    BUDGET_DATA.forEach((item: BudgetItem) => {
      const sweep = item.value / total * Math.PI * 2;

      context.beginPath();
      context.arc(center, center, radius, startAngle, startAngle + sweep);
      context.strokeStyle = item.bottomColor;
      context.lineWidth = this.chartStroke;
      context.lineCap = 'butt';
      context.stroke();
      startAngle += sweep;
    });
  }

  build() {
    Stack() {
      Column() {
        Text('Monthly Budget')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.primary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(70)
          .margin({ top: 36 });

        Scroll() {
          Column() {
            this.PieChart();

            ForEach(BUDGET_DATA, (item: BudgetItem) => {
              this.BudgetRow(item);
            }, (item: BudgetItem) => item.name);

            Blank()
              .height(160);
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center);
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off);

        this.BottomNavigation();
      }
      .width('100%')
      .height('100%')
      .backgroundColor(COLORS.background);

      Button('+')
        .width(112)
        .height(112)
        .borderRadius(56)
        .backgroundColor(COLORS.primary)
        .fontColor(COLORS.surface)
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .padding(0)
        .stateEffect(false)
        .shadow({
          radius: 24,
          color: '#26000000',
          offsetX: 0,
          offsetY: 10
        })
        .position({ right: 32, bottom: 192 })
        .onClick(() => {});
    }
    .width('100%')
    .height('100%');
  }

  @Builder
  private PieChart() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.canvasContext)
        .width(this.chartSize)
        .height(this.chartSize)
        .onReady(() => {
          this.drawPieChart();
        })
        .onAreaChange(() => {
          this.drawPieChart();
        });

      Column() {
        Text('Total Spent')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.secondary)
          .textAlign(TextAlign.Center)
          .height(38);

        Text(this.formatCurrency(this.totalSpent()))
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.primary)
          .textAlign(TextAlign.Center)
          .height(62);
      }
      .width(320)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center);
    }
    .width(this.chartSize)
    .height(this.chartSize)
    .margin({ top: 22, bottom: 60 });
  }

  @Builder
  private BudgetRow(item: BudgetItem) {
    Row() {
      Row() {
        Circle()
          .width(40)
          .height(40)
          .fill(item.bottomColor);

        Text(item.name)
          .fontSize(32)
          .fontWeight(FontWeight.Regular)
          .fontColor(COLORS.onSurface)
          .margin({ left: 32 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis });
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1);

      Text(this.formatCurrency(item.value))
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.onSurface)
        .textAlign(TextAlign.End)
        .width(220)
        .maxLines(1);
    }
    .width(626)
    .height(106)
    .padding({ left: 32, right: 32 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(COLORS.surface)
    .borderRadius(28)
    .border({ width: 1, color: COLORS.outline })
    .shadow({
      radius: 7,
      color: '#18000000',
      offsetX: 0,
      offsetY: 2
    })
    .margin({ bottom: 32 });
  }

  @Builder
  private BottomNavigation() {
    Row() {
      this.BottomBarItem('Home', true);
      this.BottomBarItem('Reports', false);

      Blank()
        .width(100);

      this.BottomBarItem('Goals', false);
      this.BottomBarItem('Settings', false);
    }
    .width('100%')
    .height(178)
    .padding({ left: 36, right: 36, top: 58, bottom: 24 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(COLORS.surface)
    .shadow({
      radius: 10,
      color: '#12000000',
      offsetX: 0,
      offsetY: -2
    });
  }

  @Builder
  private BottomBarItem(label: string, active: boolean) {
    Column() {
      Circle()
        .width(48)
        .height(48)
        .fill(active ? '#CCD2DC' : '#DDE3EA');

      Text(label)
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(active ? COLORS.primary : COLORS.tertiary)
        .textAlign(TextAlign.Center)
        .width(116)
        .height(40)
        .margin({ top: 8 });
    }
    .width(116)
    .height(96)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center);
  }
}
