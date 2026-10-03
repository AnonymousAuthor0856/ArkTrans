// BudgetPieApp.ets
import { display } from '@kit.ArkUI';

// App Tokens
class AppTokens {
  static readonly Colors = {
    primary: '#4A5568',
    secondary: '#718096',
    tertiary: '#A0AEC0',
    background: '#F7FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#EDF2F7',
    outline: '#E2E8F0',
    success: '#48BB78',
    warning: '#F59E0B',
    error: '#F56565',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#1A202C',
    onBackground: '#1A202C',
    onSurface: '#1A202C',
    gradient1Start: '#63B3ED',
    gradient1End: '#4299E1',
    gradient2Start: '#4FD1C5',
    gradient2End: '#38B2AC',
    gradient3Start: '#667EEA',
    gradient3End: '#5A67D8',
    gradient4Start: '#ED64A6',
    gradient4End: '#D53F8C',
    gradient5Start: '#F6AD55',
    gradient5End: '#ED8936'
  };

  static readonly Typography = {
    displaySize: 36,
    headlineSize: 24,
    titleSize: 18,
    bodySize: 16,
    labelSize: 14
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  };

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 16
  };
}

// Budget Item Model
class BudgetItem {
  id: string;
  name: string;
  value: number;
  gradientStart: string;
  gradientEnd: string;

  constructor(name: string, value: number, gradientStart: string, gradientEnd: string) {
    this.id = `${Date.now()}_${Math.random()}`;
    this.name = name;
    this.value = value;
    this.gradientStart = gradientStart;
    this.gradientEnd = gradientEnd;
  }
}

// Slice Data for Pie Chart
class SliceData {
  startAngle: number;
  endAngle: number;
  gradientStart: string;
  gradientEnd: string;

  constructor(startAngle: number, endAngle: number, gradientStart: string, gradientEnd: string) {
    this.startAngle = startAngle;
    this.endAngle = endAngle;
    this.gradientStart = gradientStart;
    this.gradientEnd = gradientEnd;
  }
}

// Helper function to format currency
function formatCurrency(value: number): string {
  return `$${value.toFixed(2)}`;
}

// Pie Chart Component
@Component
struct PieChart {
  @Prop items: BudgetItem[];
  @Prop strokeWidth: number = 20;
  @State slices: SliceData[] = [];
  @State totalValue: number = 0;

  aboutToAppear(): void {
    this.computeSlices();
  }

  computeSlices(): void {
    let total = 0;
    for (let i = 0; i < this.items.length; i++) {
      total += this.items[i].value;
    }
    this.totalValue = total;

    let currentAngle = -90;
    let result: SliceData[] = [];

    for (let i = 0; i < this.items.length; i++) {
      let sweep = (this.items[i].value / total) * 360;
      result.push(new SliceData(
        currentAngle,
        currentAngle + sweep,
        this.items[i].gradientStart,
        this.items[i].gradientEnd
      ));
      currentAngle += sweep;
    }
    this.slices = result;
  }

  build() {
    Stack() {
      // Draw pie slices using Canvas
      Canvas(this.createCanvasContext.bind(this))
        .width(240)
        .height(240)

      Column() {
        Text('Total Spent')
          .fontSize(AppTokens.Typography.labelSize)
          .fontColor(AppTokens.Colors.secondary)
        Text(formatCurrency(this.totalValue))
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(240)
    .height(240)
  }

  private createCanvasContext(context: CanvasRenderingContext2D, width: number, height: number): void {
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = width / 2 - this.strokeWidth / 2;

    for (let i = 0; i < this.slices.length; i++) {
      const slice = this.slices[i];
      const startRad = (slice.startAngle * Math.PI) / 180;
      const endRad = (slice.endAngle * Math.PI) / 180;

      // Create gradient for this slice
      const gradient = context.createLinearGradient(0, 0, width, height);
      gradient.addColorStop(0, slice.gradientStart);
      gradient.addColorStop(1, slice.gradientEnd);

      context.beginPath();
      context.arc(centerX, centerY, radius, startRad, endRad, false);
      context.strokeStyle = gradient;
      context.lineWidth = this.strokeWidth;
      context.lineCap = 'butt';
      context.stroke();
    }
  }
}

// Budget Item Row Component
@Component
struct BudgetItemRow {
  @Prop item: BudgetItem;

  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Circle()
          .width(20)
          .height(20)
          .linearGradient({
            angle: 180,
            colors: [[this.item.gradientStart, 0], [this.item.gradientEnd, 1]]
          })

        Text(this.item.name)
          .fontSize(AppTokens.Typography.bodySize)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .padding({
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md,
      left: AppTokens.Spacing.md,
      right: AppTokens.Spacing.md
    })
    .alignItems(VerticalAlign.Center)
  }
}

// Card View Component
@Component
struct CardView {
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 3,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: 1
    })
  }
}

// Bottom Bar Item Component
@Component
struct BottomBarItem {
  @Prop text: string;
  @Prop active: boolean;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Circle()
        .width(24)
        .height(24)
        .fill(this.active ? 'rgba(74, 85, 104, 0.2)' : 'rgba(160, 174, 192, 0.2)')

      Text(this.text)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// Main Content View
@Component
struct ContentView {
  @State budgetData: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, AppTokens.Colors.gradient1Start, AppTokens.Colors.gradient1End),
    new BudgetItem('Food', 480.50, AppTokens.Colors.gradient2Start, AppTokens.Colors.gradient2End),
    new BudgetItem('Transport', 210.75, AppTokens.Colors.gradient3Start, AppTokens.Colors.gradient3End),
    new BudgetItem('Entertainment', 150.00, AppTokens.Colors.gradient4Start, AppTokens.Colors.gradient4End),
    new BudgetItem('Utilities', 320.00, AppTokens.Colors.gradient5Start, AppTokens.Colors.gradient5End)
  ];

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column() {
        // Top Bar
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.primary)
            .padding({
              top: AppTokens.Spacing.md,
              bottom: AppTokens.Spacing.md
            })
          Blank()
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Pie Chart
            PieChart({
              items: this.budgetData,
              strokeWidth: 20
            })
            .padding({
              top: AppTokens.Spacing.lg,
              bottom: AppTokens.Spacing.lg
            })

            // List Items
            Column({ space: AppTokens.Spacing.md }) {
              ForEach(this.budgetData, (item: BudgetItem) => {
                CardView() {
                  BudgetItemRow({ item: item })
                }
              }, (item: BudgetItem) => item.id)
            }

            // Bottom Spacer
            Row()
              .height(AppTokens.Spacing.xxl + 80)
          }
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar & FAB Overlay
      Column() {
        Blank()

        Stack({ alignContent: Alignment.Top }) {
          // Bottom Bar Background
          Row() {
            BottomBarItem({ text: 'Home', active: true })
            Blank()
            BottomBarItem({ text: 'Reports', active: false })
            Blank()
            // Invisible placeholder for FAB space
            Row()
              .width(56)
              .height(1)
              .backgroundColor(Color.Transparent)
            Blank()
            BottomBarItem({ text: 'Goals', active: false })
            Blank()
            BottomBarItem({ text: 'Settings', active: false })
          }
          .width('100%')
          .height(80)
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({
            radius: 15,
            color: 'rgba(0, 0, 0, 0.1)',
            offsetX: 0,
            offsetY: -5
          })

          // FAB
          Button() {
            // Action
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(AppTokens.Colors.primary)
          .shadow({
            radius: 4,
            color: 'rgba(0, 0, 0, 0.3)',
            offsetX: 0,
            offsetY: 4
          })
          .offset({ y: -28 })
          .align(Alignment.Top)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// Entry Point
@Entry
@Component
struct BudgetPieApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}