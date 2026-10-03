// BudgetPieApp.ets
import curves from '@ohos.curves';

// --- App Tokens ---
class AppTokens {
  static readonly Colors = {
    primary: '#FF4A5568',
    secondary: '#FF718096',
    tertiary: '#FFA0AEC0',
    background: '#FFF7FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFEDF2F7',
    outline: '#FFE2E8F0',
    success: '#FF48BB78',
    warning: '#FFF59E0B',
    error: '#FFF56565',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF1A202C',
    onBackground: '#FF1A202C',
    onSurface: '#FF1A202C',
  };

  static readonly Gradients = {
    gradient1: ['#FF63B3ED', '#FF4299E1'],
    gradient2: ['#FF4FD1C5', '#FF38B2AC'],
    gradient3: ['#FF667EEA', '#FF5A67D8'],
    gradient4: ['#FFED64A6', '#FFD53F8C'],
    gradient5: ['#FFF6AD55', '#FFED8936'],
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  };
}

// --- Data Models ---
class BudgetItem {
  name: string;
  value: number;
  colors: string[];

  constructor(name: string, value: number, colors: string[]) {
    this.name = name;
    this.value = value;
    this.colors = colors;
  }
}

const budgetData: BudgetItem[] = [
  new BudgetItem('Housing', 1250.00, AppTokens.Gradients.gradient1),
  new BudgetItem('Food', 480.50, AppTokens.Gradients.gradient2),
  new BudgetItem('Transport', 210.75, AppTokens.Gradients.gradient3),
  new BudgetItem('Entertainment', 150.00, AppTokens.Gradients.gradient4),
  new BudgetItem('Utilities', 320.00, AppTokens.Gradients.gradient5),
];

// --- Utility Functions ---
function formatCurrency(value: number): string {
  return `$${value.toFixed(2)}`;
}

// --- Main Entry Point ---
@Entry
@Component
struct RootScreen {
  private totalValue: number = budgetData.reduce((sum, item) => sum + item.value, 0);

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Monthly Budget')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background);

      // Scrollable Content
      Scroll() {
        Column() {
          // Pie Chart Section
          Column() {
            PieChart({ items: budgetData, totalValue: this.totalValue })
              .width(240)
              .height(240)
              .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center);

          // Budget Items List
          ForEach(budgetData, (item: BudgetItem) => {
            Card({ item: item })
              .width('100%')
              .margin({ bottom: AppTokens.Spacing.md })
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(16)
              .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 });
          });

          // Bottom Spacer to avoid FAB overlap
          Blank().height(80);
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top);

      // Bottom App Bar
      Row() {
        BottomBarItem({ text: 'Home', active: true })
        BottomBarItem({ text: 'Reports', active: false })
        Blank().width(AppTokens.Spacing.xl) // Space for FAB
        BottomBarItem({ text: 'Goals', active: false })
        BottomBarItem({ text: 'Settings', active: false })
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 15, color: '#1A000000', offsetX: 0, offsetY: -5 });

      // Floating Action Button
      // Positioned absolutely relative to the screen
      Stack({ alignContent: Alignment.Center }) {
        Text('+')
          .fontSize(24)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppTokens.Colors.primary)
      .position({ x: '50%', y: '100%' })
      .markAnchor({ x: '50%', y: '100%' })
      .offset({ y: -28 - 56 / 2 }) // Lift above bottom bar
      .shadow({ radius: 6, color: '#33000000', offsetX: 0, offsetY: 2 });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}

// --- Pie Chart Component ---
@Component
struct PieChart {
  private items: BudgetItem[] = [];
  private totalValue: number = 0;
  private strokeWidth: number = 20;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Canvas for drawing arcs
      Canvas(this.context) {
        let startAngle = -90;
        for (let i = 0; i < this.items.length; i++) {
          let item = this.items[i];
          let sweepAngle = (item.value / this.totalValue) * 360;
          
          // Create gradient brush
          let gradient = new LinearGradient({
            angle: 90, // Vertical gradient approximation
            colors: item.colors,
            repeat: false
          });

          // Draw Arc
          this.context.beginPath();
          this.context.lineWidth = this.strokeWidth;
          this.context.strokeStyle = gradient;
          
          // Canvas API uses radians. We calculate the arc manually.
          // Center coordinates
          let cx = 120; // Half of 240 width
          let cy = 120; // Half of 240 height
          let radius = 100; // (240/2) - strokeWidth/2

          let startRad = (startAngle * Math.PI) / 180;
          let endRad = ((startAngle + sweepAngle) * Math.PI) / 180;

          // Arc parameters: x, y, radius, startAngle, endAngle, anticlockwise
          this.context.arc(cx, cy, radius, startRad, endRad, false);
          this.context.stroke();
          
          startAngle += sweepAngle;
        }
      }
      .width('100%')
      .height('100%');

      // Center Text
      Column() {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ bottom: 4 });
        
        Text(formatCurrency(this.totalValue))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary);
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%');
  }
}

// --- Budget Item Card Component ---
@Component
struct Card {
  private item: BudgetItem = new BudgetItem('', 0, []);

  build() {
    Row() {
      Row() {
        // Color Indicator
        Column() {
          Stack() {
            // Gradient background approximation using linear gradient
            Column() {
              Blank().width('100%').height('100%').linearGradient({
                angle: 90,
                colors: this.item.colors,
                repeat: false
              });
            }
            .width('100%')
            .height('100%');
          }
          .width(20)
          .height(20)
          .borderRadius(10);
        }
        .width(20)
        .height(20);

        Text(this.item.name)
          .fontSize(16)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.md });
      }
      .alignItems(VerticalAlign.Center);

      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface);
    }
    .width('100%')
    .padding({ vertical: AppTokens.Spacing.md, horizontal: AppTokens.Spacing.md })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center);
  }
}

// --- Bottom Bar Item Component ---
@Component
struct BottomBarItem {
  private text: string = '';
  private active: boolean = false;

  build() {
    Column() {
      // Icon Placeholder
      Stack() {
        Column() {
          Blank().width('100%').height('100%')
            .backgroundColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
            .opacity(this.active ? 0.2 : 1.0);
        }
        .width('100%')
        .height('100%');
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .margin({ bottom: AppTokens.Spacing.xs });

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center);
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center);
  }
}