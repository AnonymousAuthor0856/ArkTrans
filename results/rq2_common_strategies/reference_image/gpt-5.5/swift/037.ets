import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

class AppColors {
  static readonly primary: string = '#4A5568';
  static readonly secondary: string = '#718096';
  static readonly tertiary: string = '#A0AEC0';
  static readonly background: string = '#F7FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#1A202C';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xxl: number = 48;
}

class AppShapes {
  static readonly large: number = 16;
}

class BudgetItem {
  id: string;
  name: string;
  value: number;
  startColor: string;
  endColor: string;

  constructor(name: string, value: number, startColor: string, endColor: string) {
    this.id = name;
    this.name = name;
    this.value = value;
    this.startColor = startColor;
    this.endColor = endColor;
  }
}

function formatCurrency(value: number): string {
  const fixed: string = value.toFixed(2);
  const dotIndex: number = fixed.indexOf('.');
  const integerPart: string = dotIndex >= 0 ? fixed.substring(0, dotIndex) : fixed;
  const fractionPart: string = dotIndex >= 0 ? fixed.substring(dotIndex + 1) : '00';

  let result: string = '';
  let count: number = 0;

  for (let i = integerPart.length - 1; i >= 0; i--) {
    if (count > 0 && count % 3 === 0) {
      result = ',' + result;
    }
    result = integerPart.charAt(i) + result;
    count++;
  }

  return '$' + result + '.' + fractionPart;
}

@Entry
@Component
struct ContentView {
  private readonly budgetData: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, '#63B3ED', '#4299E1'),
    new BudgetItem('Food', 480.50, '#4FD1C5', '#38B2AC'),
    new BudgetItem('Transport', 210.75, '#667EEA', '#5A67D8'),
    new BudgetItem('Entertainment', 150.00, '#ED64A6', '#D53F8C'),
    new BudgetItem('Utilities', 320.00, '#F6AD55', '#ED8936')
  ];

  aboutToAppear(): void {
    const context = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(context).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
      win.setWindowBackgroundColor(AppColors.background);
    });
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)
            .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppColors.background)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            PieChart({
              items: this.budgetData,
              strokeWidth: 20
            })
              .width(240)
              .height(240)
              .margin({ top: AppSpacing.lg, bottom: AppSpacing.lg })

            Column({ space: AppSpacing.md }) {
              ForEach(this.budgetData, (item: BudgetItem) => {
                BudgetItemCard({ item: item })
              }, (item: BudgetItem) => item.id)
            }

            Blank()
              .height(AppSpacing.xxl + 80)
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct PieChart {
  items: BudgetItem[] = [];
  strokeWidth: number = 20;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private totalValue(): number {
    let total: number = 0;
    for (let i = 0; i < this.items.length; i++) {
      total += this.items[i].value;
    }
    return total;
  }

  private drawPie(): void {
    const size: number = 240;
    const center: number = size / 2;
    const radius: number = (size - this.strokeWidth) / 2;
    const total: number = this.totalValue();

    this.context.clearRect(0, 0, size, size);

    if (total <= 0) {
      return;
    }

    let currentAngle: number = -Math.PI / 2;

    for (let i = 0; i < this.items.length; i++) {
      const item: BudgetItem = this.items[i];
      const sweep: number = item.value / total * Math.PI * 2;
      const endAngle: number = currentAngle + sweep;

      const gradient = this.context.createLinearGradient(0, 0, 0, size);
      gradient.addColorStop(0, item.startColor);
      gradient.addColorStop(1, item.endColor);

      this.context.beginPath();
      this.context.lineWidth = this.strokeWidth;
      this.context.lineCap = 'butt';
      this.context.strokeStyle = gradient;
      this.context.arc(center, center, radius, currentAngle, endAngle);
      this.context.stroke();

      currentAngle = endAngle;
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(240)
        .height(240)
        .onReady(() => {
          this.drawPie();
        })
        .onAreaChange(() => {
          this.drawPie();
        })

      Column() {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)

        Text(formatCurrency(this.totalValue()))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(240)
    .height(240)
  }
}

@Component
struct BudgetItemCard {
  item: BudgetItem = new BudgetItem('', 0, '#000000', '#000000');

  build() {
    Row() {
      Row({ space: AppSpacing.md }) {
        Blank()
          .width(20)
          .height(20)
          .borderRadius(10)
          .backgroundColor(this.item.endColor)

        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Blank()
        .layoutWeight(1)

      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(68)
    .padding({ left: AppSpacing.md, right: AppSpacing.md })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 3,
      color: '#0D000000',
      offsetX: 0,
      offsetY: 1
    })
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Stack({ alignContent: Alignment.TopCenter }) {
      Row() {
        BottomBarItem({ text: 'Home', active: true })

        Blank()
          .layoutWeight(1)

        BottomBarItem({ text: 'Reports', active: false })

        Blank()
          .layoutWeight(1)

        Blank()
          .width(56)

        Blank()
          .layoutWeight(1)

        BottomBarItem({ text: 'Goals', active: false })

        Blank()
          .layoutWeight(1)

        BottomBarItem({ text: 'Settings', active: false })
      }
      .width('100%')
      .height(80)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 15,
        color: '#1A000000',
        offsetX: 0,
        offsetY: -5
      })

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('+')
          .fontSize(40)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .translate({ y: -2 })
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppColors.primary)
      .shadow({
        radius: 8,
        color: '#33000000',
        offsetX: 0,
        offsetY: 4
      })
      .translate({ y: -28 })
      .onClick(() => {
      })
    }
    .width('100%')
    .height(80)
  }
}

@Component
struct BottomBarItem {
  text: string = '';
  active: boolean = false;

  build() {
    Column({ space: AppSpacing.xs }) {
      Blank()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.active ? '#334A5568' : '#33A0AEC0')

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? AppColors.primary : AppColors.tertiary)
        .textAlign(TextAlign.Center)
        .maxLines(1)
    }
    .alignItems(HorizontalAlign.Center)
    .width(64)
  }
}