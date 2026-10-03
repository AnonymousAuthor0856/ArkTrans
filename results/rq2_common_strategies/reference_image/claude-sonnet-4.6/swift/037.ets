/*
 * BudgetPieApp — ArkTS / ArkUI port of the SwiftUI screen.
 *
 * Note: hiding the status bar (SwiftUI's `prefersStatusBarHidden`) is a window
 * concern in ArkTS, so it belongs in EntryAbility.onWindowStageCreate():
 *
 *   windowStage.getMainWindowSync().setWindowLayoutFullScreen(true);
 *   windowStage.getMainWindowSync().setWindowSystemBarEnable([]);  // no status bar
 */

// ------------------------------- Design tokens -------------------------------

const COLOR_PRIMARY: string = '#4A5568';
const COLOR_SECONDARY: string = '#718096';
const COLOR_TERTIARY: string = '#A0AEC0';
const COLOR_BACKGROUND: string = '#F7FAFC';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#EDF2F7';
const COLOR_OUTLINE: string = '#E2E8F0';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SURFACE: string = '#1A202C';

const SPACE_XS: number = 4;
const SPACE_SM: number = 8;
const SPACE_MD: number = 16;
const SPACE_LG: number = 24;
const SPACE_XL: number = 32;
const SPACE_XXL: number = 48;

const SHAPE_MEDIUM: number = 8;
const SHAPE_LARGE: number = 16;

// ---------------------------------- Model ----------------------------------

class BudgetItem {
  name: string;
  value: number;
  startColor: string;
  endColor: string;

  constructor(name: string, value: number, startColor: string, endColor: string) {
    this.name = name;
    this.value = value;
    this.startColor = startColor;
    this.endColor = endColor;
  }
}

// --------------------------------- Helpers ---------------------------------

function formatCurrency(value: number): string {
  const fixed: string = value.toFixed(2);
  const parts: string[] = fixed.split('.');
  const intPart: string = parts[0];
  let grouped: string = '';
  let count: number = 0;
  for (let i: number = intPart.length - 1; i >= 0; i--) {
    grouped = intPart.charAt(i) + grouped;
    count++;
    if (count % 3 === 0 && i > 0) {
      grouped = ',' + grouped;
    }
  }
  return '$' + grouped + '.' + parts[1];
}

// -------------------------------- Pie chart --------------------------------

@Component
struct PieChart {
  items: BudgetItem[] = [];
  strokeWidth: number = 20;
  size: number = 240;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private totalValue(): number {
    let total: number = 0;
    for (let i: number = 0; i < this.items.length; i++) {
      total += this.items[i].value;
    }
    return total;
  }

  private draw(): void {
    const size: number = this.size;
    const center: number = size / 2;
    const radius: number = (size - this.strokeWidth) / 2;
    const total: number = this.totalValue();
    if (total <= 0) {
      return;
    }

    this.ctx.clearRect(0, 0, size, size);
    this.ctx.lineWidth = this.strokeWidth;
    this.ctx.lineCap = 'butt';

    let start: number = -Math.PI / 2; // start at 12 o'clock, sweep clockwise
    for (let i: number = 0; i < this.items.length; i++) {
      const item: BudgetItem = this.items[i];
      const sweep: number = (item.value / total) * Math.PI * 2;
      const mid: number = start + sweep / 2;
      const half: number = this.strokeWidth / 2;

      const gx0: number = center + Math.cos(mid) * (radius - half);
      const gy0: number = center + Math.sin(mid) * (radius - half);
      const gx1: number = center + Math.cos(mid) * (radius + half);
      const gy1: number = center + Math.sin(mid) * (radius + half);

      const gradient: CanvasGradient = this.ctx.createLinearGradient(gx0, gy0, gx1, gy1);
      gradient.addColorStop(0, item.startColor);
      gradient.addColorStop(1, item.endColor);

      this.ctx.beginPath();
      this.ctx.strokeStyle = gradient;
      this.ctx.arc(center, center, radius, start, start + sweep);
      this.ctx.stroke();

      start += sweep;
    }
  }

  build() {
    Stack() {
      Canvas(this.ctx)
        .width(this.size)
        .height(this.size)
        .onReady(() => {
          this.ctx.width = this.size;
          this.ctx.height = this.size;
          this.draw();
        })

      Column() {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_SECONDARY)
        Text(formatCurrency(this.totalValue()))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_PRIMARY)
          .margin({ top: SPACE_XS })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(this.size)
    .height(this.size)
  }
}

// ------------------------------- Entry page --------------------------------

@Entry
@Component
struct Index {
  private budgetData: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, '#63B3ED', '#4299E1'),
    new BudgetItem('Food', 480.50, '#4FD1C5', '#38B2AC'),
    new BudgetItem('Transport', 210.75, '#667EEA', '#5A67D8'),
    new BudgetItem('Entertainment', 150.00, '#ED64A6', '#D53F8C'),
    new BudgetItem('Utilities', 320.00, '#F6AD55', '#ED8936')
  ];

  @Builder
  ItemCard(item: BudgetItem) {
    Row() {
      Row({ space: SPACE_MD }) {
        Column()
          .width(20)
          .height(20)
          .borderRadius(10)
          .linearGradient({
            angle: 180,
            colors: [[item.startColor, 0.0], [item.endColor, 1.0]]
          })

        Text(item.name)
          .fontSize(16)
          .fontColor(COLOR_ON_SURFACE)
      }

      Blank()

      Text(formatCurrency(item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
    }
    .width('100%')
    .padding(SPACE_MD)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(SHAPE_LARGE)
    .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  BarItem(text: string, active: boolean) {
    Column({ space: SPACE_XS }) {
      Column()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(active ? COLOR_PRIMARY : COLOR_TERTIARY)
        .opacity(0.2)

      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(active ? COLOR_PRIMARY : COLOR_TERTIARY)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  BottomBar() {
    Stack({ alignContent: Alignment.Top }) {
      Row() {
        this.BarItem('Home', true)
        Blank()
        this.BarItem('Reports', false)
        Blank()
        Column().width(56)
        Blank()
        this.BarItem('Goals', false)
        Blank()
        this.BarItem('Settings', false)
      }
      .width('100%')
      .height(80)
      .padding({ left: SPACE_LG, right: SPACE_LG })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)
      .shadow({ radius: 15, color: '#1A000000', offsetX: 0, offsetY: -5 })

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_PRIMARY)
      }
      .width(56)
      .height(56)
      .backgroundColor(COLOR_PRIMARY)
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 4 })
      .offset({ x: 0, y: -28 })
      .onClick(() => {
      })
    }
    .width('100%')
    .height(80)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(COLOR_BACKGROUND)

      Column() {
        Row() {
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_PRIMARY)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: SPACE_MD, bottom: SPACE_MD })
        .backgroundColor(COLOR_BACKGROUND)

        Scroll() {
          Column({ space: SPACE_MD }) {
            PieChart({ items: this.budgetData, strokeWidth: 20, size: 240 })
              .margin({ top: SPACE_LG, bottom: SPACE_LG })

            ForEach(this.budgetData, (item: BudgetItem) => {
              this.ItemCard(item)
            }, (item: BudgetItem) => item.name)

            Column().height(SPACE_XXL + 80)
          }
          .width('100%')
          .padding({ left: SPACE_LG, right: SPACE_LG })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}