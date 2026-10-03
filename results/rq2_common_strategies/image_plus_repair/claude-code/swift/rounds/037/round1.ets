// Monthly Budget App - ArkTS

// Budget item model
interface BudgetItem {
  name: string;
  value: number;
  color: string;
}

// Slice data interface
interface SliceData {
  startAngle: number;
  sweepAngle: number;
  color: string;
}

// Format currency
function formatCurrency(value: number): string {
  return '$' + value.toLocaleString('en-US', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  });
}

// Color constants
const COLOR_PRIMARY: string = '#4A5568';
const COLOR_SECONDARY: string = '#718096';
const COLOR_TERTIARY: string = '#A0AEC0';
const COLOR_BACKGROUND: string = '#F7FAFC';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_ON_SURFACE: string = '#1A202C';
const COLOR_ON_PRIMARY: string = '#FFFFFF';

// Gradient color arrays
const GRADIENT_1: string[] = ['#63B3ED', '#4299E1'];
const GRADIENT_2: string[] = ['#4FD1C5', '#38B2AC'];
const GRADIENT_3: string[] = ['#667EEA', '#5A67D8'];
const GRADIENT_4: string[] = ['#ED64A6', '#D53F8C'];
const GRADIENT_5: string[] = ['#F6AD55', '#ED8936'];

// Spacing
const SPACING_XS: number = 4;
const SPACING_SM: number = 8;
const SPACING_MD: number = 16;
const SPACING_LG: number = 24;
const SPACING_XL: number = 32;
const SPACING_XXL: number = 48;

// Shapes
const SHAPE_LARGE: number = 16;

// Typography
const FONT_HEADLINE: number = 30;
const FONT_TITLE: number = 28;
const FONT_BODY: number = 22;
const FONT_LABEL: number = 20;
const FONT_NUMBER: number = 34;

// Pie chart data
const budgetData: BudgetItem[] = [
  { name: 'Housing', value: 1250.00, color: '#4299E1' },
  { name: 'Food', value: 480.50, color: '#38B2AC' },
  { name: 'Transport', value: 210.75, color: '#5A67D8' },
  { name: 'Entertainment', value: 150.00, color: '#D53F8C' },
  { name: 'Utilities', value: 320.00, color: '#ED8936' }
];

// Compute total
function getTotal(): number {
  let total: number = 0;
  for (let i: number = 0; i < budgetData.length; i++) {
    total += budgetData[i].value;
  }
  return total;
}

// Canvas drawing for each pie slice
@Component
struct CanvasDraw {
  @Prop startAngle: number = 0;
  @Prop sweepAngle: number = 0;
  @Prop sliceColor: string = '#000000';
  @Prop chartSize: number = 300;
  @Prop strokeWidth: number = 24;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    this.drawSlice();
  }

  aboutToUpdate(): void {
    this.drawSlice();
  }

  drawSlice(): void {
    let ctx: CanvasRenderingContext2D = this.context;
    ctx.clearRect(0, 0, this.chartSize, this.chartSize);

    let centerX: number = this.chartSize / 2;
    let centerY: number = this.chartSize / 2;
    let radius: number = (this.chartSize - this.strokeWidth) / 2;

    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, this.startAngle, this.startAngle + this.sweepAngle);
    ctx.strokeStyle = this.sliceColor;
    ctx.lineWidth = this.strokeWidth;
    ctx.lineCap = 'butt';
    ctx.stroke();
  }

  build() {
    Canvas(this.context)
      .width(this.chartSize)
      .height(this.chartSize)
  }
}

// Donut chart component
@Component
struct DonutChart {
  private totalValue: number = getTotal();
  private strokeWidth: number = 24;
  private chartSize: number = 300;

  // Compute slice angles (in radians, starting from -PI/2 = top)
  getSlices(): SliceData[] {
    let slices: SliceData[] = [];
    let current: number = -Math.PI / 2;
    for (let i: number = 0; i < budgetData.length; i++) {
      let sweep: number = (budgetData[i].value / this.totalValue) * Math.PI * 2;
      let slice: SliceData = {
        startAngle: current,
        sweepAngle: sweep,
        color: budgetData[i].color
      };
      slices.push(slice);
      current += sweep;
    }
    return slices;
  }

  build() {
    Stack() {
      // Draw each donut slice
      ForEach(this.getSlices(), (slice: SliceData, index: number) => {
        CanvasDraw({
          startAngle: slice.startAngle,
          sweepAngle: slice.sweepAngle,
          sliceColor: slice.color,
          chartSize: this.chartSize,
          strokeWidth: this.strokeWidth
        })
      }, (slice: SliceData, index: number) => index.toString())

      // Center text
      Column() {
        Text('Total Spent')
          .fontSize(FONT_LABEL + 6)
          .fontColor(COLOR_SECONDARY)
          .margin({ bottom: 4 })
        Text(formatCurrency(this.totalValue))
          .fontSize(FONT_TITLE + 8)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_PRIMARY)
      }
    }
    .width(this.chartSize)
    .height(this.chartSize)
  }
}

// Budget item row
@Component
struct BudgetItemRow {
  @Prop item: BudgetItem = { name: '', value: 0, color: '#000000' };

  build() {
    Row() {
      Row() {
        Circle({ width: 28, height: 28 })
          .fill(this.item.color)
          .margin({ right: SPACING_MD })
        Text(this.item.name)
          .fontSize(FONT_BODY + 8)
          .fontColor(COLOR_ON_SURFACE)
      }

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(FONT_BODY + 14)
        .fontColor(COLOR_ON_SURFACE)
    }
    .padding({
      left: SPACING_MD,
      right: SPACING_MD,
      top: SPACING_MD + 4,
      bottom: SPACING_MD + 4
    })
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(SHAPE_LARGE)
    .shadow({
      radius: 6,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

// Bottom bar item
@Component
struct BottomBarItem {
  @Prop text: string = '';
  @Prop active: boolean = false;

  build() {
    Column() {
      Circle({ width: 36, height: 36 })
        .fill(COLOR_TERTIARY)
        .opacity(this.active ? 0.5 : 0.2)
        .margin({ bottom: SPACING_XS })
      Text(this.text)
        .fontSize(FONT_LABEL + 6)
        .fontColor(this.active ? COLOR_PRIMARY : COLOR_TERTIARY)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

// Main page
@Entry
@Component
struct MonthlyBudgetPage {
  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(COLOR_BACKGROUND)

      Column() {
        // Title
        Row() {
          Text('Monthly Budget')
            .fontSize(44)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_PRIMARY)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: SPACING_XL, bottom: SPACING_LG })

        // Scrollable content
        Scroll() {
          Column() {
            // Donut chart
            Row() {
              DonutChart()
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .padding({ top: SPACING_LG, bottom: SPACING_LG })

            // Budget items list
            Column() {
              ForEach(budgetData, (item: BudgetItem, index: number) => {
                BudgetItemRow({ item: item })
                  .margin({ bottom: index < budgetData.length - 1 ? SPACING_MD : 0 })
              }, (item: BudgetItem, index: number) => index.toString())
            }
            .width('100%')
            .padding({ left: SPACING_LG, right: SPACING_LG })

            // Bottom spacer
            Blank()
              .height(SPACING_XXL + 100)
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .flexGrow(1)
      }
      .width('100%')
      .height('100%')

      // Bottom bar + FAB
      Column() {
        Blank()

        Stack({ alignContent: Alignment.Top }) {
          // Bottom bar
          Row() {
            BottomBarItem({ text: 'Home', active: true })
              .layoutWeight(1)
            BottomBarItem({ text: 'Reports', active: false })
              .layoutWeight(1)
            // Placeholder for FAB
            Column()
              .width(80)
              .layoutWeight(1)
            BottomBarItem({ text: 'Goals', active: false })
              .layoutWeight(1)
            BottomBarItem({ text: 'Settings', active: false })
              .layoutWeight(1)
          }
          .width('100%')
          .height(100)
          .backgroundColor(COLOR_SURFACE)
          .shadow({
            radius: 20,
            color: '#1A000000',
            offsetX: 0,
            offsetY: -6
          })
          .padding({ left: SPACING_LG, right: SPACING_LG })

          // FAB
          Button() {
            Text('+')
              .fontSize(44)
              .fontColor(COLOR_ON_PRIMARY)
              .fontWeight(FontWeight.Bold)
          }
          .width(76)
          .height(76)
          .borderRadius(38)
          .backgroundColor(COLOR_PRIMARY)
          .shadow({
            radius: 10,
            color: '#40000000',
            offsetX: 0,
            offsetY: 4
          })
          .margin({ top: -38 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}
