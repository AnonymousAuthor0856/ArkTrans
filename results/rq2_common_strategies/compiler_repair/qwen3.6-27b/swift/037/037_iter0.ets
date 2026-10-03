import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

// MARK: - App Tokens & Colors
const AppTokens = {
  Colors: {
    primary: '#4A5568',
    secondary: '#718096',
    tertiary: '#A0AEC0',
    background: '#F7FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#EDF2F7',
    outline: '#E2E8F0',
    success: '#48BB78',
    warning: '#F59E0B',
    error: '#F56565',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#1A202C',
    onBackground: '#1A202C',
    onSurface: '#1A202C',
    
    // Gradients defined as arrays of colors for ArkTS LinearGradient
    gradient1: ['#63B3ED', '#4299E1'],
    gradient2: ['#4FD1C5', '#38B2AC'],
    gradient3: ['#667EEA', '#5A67D8'],
    gradient4: ['#ED64A6', '#D53F8C'],
    gradient5: ['#F6AD55', '#ED8936']
  },
  
  Typography: {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.SemiBold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Normal },
    label: { size: 14, weight: FontWeight.Medium }
  },
  
  Spacing: {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  },
  
  Shapes: {
    small: 4,
    medium: 8,
    large: 16
  },
  
  Elevation: {
    level1: 1,
    level2: 4,
    level3: 8
  }
};

// MARK: - Models
interface BudgetItem {
  id: string;
  name: string;
  value: number;
  gradient: string[];
}

// MARK: - Helpers
function formatCurrency(value: number): string {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  }).format(value);
}

// MARK: - Components

@Component
struct PieSlice {
  @Prop startAngle: number;
  @Prop endAngle: number;
  @Prop strokeWidth: number;
  @Prop gradientColors: string[];

  build() {
    // In ArkTS, drawing complex shapes like pie slices often requires Canvas or Path.
    // However, for a simple ring chart, we can use Arc with specific properties.
    // Note: ArkTS Arc draws clockwise by default if start < end in degrees usually, 
    // but let's stick to standard arc logic.
    // To mimic SwiftUI's stroke behavior, we use an Arc component.
    Arc({
      startAngle: this.startAngle,
      angle: this.endAngle - this.startAngle,
      radius: 100, // Relative to the frame, will be scaled
      centerPoint: { x: 50, y: 50 },
      anticlockwise: false
    })
    .fill(false)
    .stroke(LinearGradient({
      angle: 90,
      colors: [
        { color: this.gradientColors[0], offset: 0 },
        { color: this.gradientColors[1], offset: 1 }
      ]
    }))
    .strokeWidth(this.strokeWidth)
    .lineCap(LineCap.Butt)
  }
}

@Component
struct PieChart {
  @ObjectLink items: BudgetItem[];
  strokeWidth: number = 20;

  aboutToAppear() {
    // Ensure data is loaded
  }

  get totalValue(): number {
    return this.items.reduce((sum, item) => sum + item.value, 0);
  }

  getSlices(): Array<{ start: number, end: number, gradient: string[] }> {
    let currentAngle = -90;
    const slices: Array<{ start: number, end: number, gradient: string[] }> = [];
    
    for (const item of this.items) {
      const sweep = (item.value / this.totalValue) * 360;
      slices.push({
        start: currentAngle,
        end: currentAngle + sweep,
        gradient: item.gradient
      });
      currentAngle += sweep;
    }
    return slices;
  }

  build() {
    Stack() {
      ForEach(this.getSlices(), (slice: { start: number, end: number, gradient: string[] }) => {
        PieSlice({
          startAngle: slice.start,
          endAngle: slice.end,
          strokeWidth: this.strokeWidth,
          gradientColors: slice.gradient
        })
      }, (slice: { start: number, end: number, gradient: string[] }) => slice.start.toString())

      Column() {
        Text("Total Spent")
          .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
          .foregroundColor(AppTokens.Colors.secondary)
        
        Text(formatCurrency(this.totalValue))
          .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
          .foregroundColor(AppTokens.Colors.primary)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(240)
    .height(240)
  }
}

@Component
struct CardView {
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content();
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 3,
      color: '#0000000D', // 0.05 opacity black
      offsetX: 0,
      offsetY: 1
    })
  }
}

@Component
struct BudgetItemRow {
  @ObjectLink item: BudgetItem;

  build() {
    Row() {
      Row() {
        Circle()
          .fill(LinearGradient({
            angle: 90,
            colors: [
              { color: this.item.gradient[0], offset: 0 },
              { color: this.item.gradient[1], offset: 1 }
            ]
          }))
          .width(20)
          .height(20)
        
        Text(this.item.name)
          .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
          .foregroundColor(AppTokens.Colors.onSurface)
      }
      .spacing(AppTokens.Spacing.md)
      
      Blank()
      
      Text(formatCurrency(this.item.value))
        .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
        .foregroundColor(AppTokens.Colors.onSurface)
    }
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .width('100%')
  }
}

@Component
struct BottomBarItem {
  text: string;
  active: boolean;

  build() {
    Column() {
      Circle()
        .fill(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .opacity(0.2)
        .width(24)
        .height(24)
      
      Text(this.text)
        .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
        .foregroundColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
    .spacing(AppTokens.Spacing.xs)
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - Root View
@Entry
@Component
struct ContentView {
  private budgetData: BudgetItem[] = [
    { id: '1', name: "Housing", value: 1250.00, gradient: AppTokens.Colors.gradient1 },
    { id: '2', name: "Food", value: 480.50, gradient: AppTokens.Colors.gradient2 },
    { id: '3', name: "Transport", value: 210.75, gradient: AppTokens.Colors.gradient3 },
    { id: '4', name: "Entertainment", value: 150.00, gradient: AppTokens.Colors.gradient4 },
    { id: '5', name: "Utilities", value: 320.00, gradient: AppTokens.Colors.gradient5 }
  ];

  aboutToAppear() {
    // Hide status bar
    try {
      window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
        windowStage.setWindowLayoutFullScreen(true);
        windowStage.setWindowSystemBarEnable([], (err) => {
          if (err) {
            console.error(`Failed to set system bar enable. Code is ${err.code}, message is ${err.message}`);
          }
        });
      }).catch((err: BusinessError) => {
        console.error(`Failed to get last window. Code is ${err.code}, message is ${err.message}`);
      });
    } catch (e) {
      console.error('Error hiding status bar');
    }
  }

  build() {
    Stack() {
      // Background
      Column()
        .backgroundColor(AppTokens.Colors.background)
        .width('100%')
        .height('100%')

      Column() {
        // Top Bar
        Row() {
          Blank()
          Text("Monthly Budget")
            .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
            .foregroundColor(AppTokens.Colors.primary)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          Blank()
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)

        // Scrollable Content
        Scroll() {
          Column() {
            PieChart({ items: this.budgetData, strokeWidth: 20 })
              .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
            
            // List Items
            Column() {
              ForEach(this.budgetData, (item: BudgetItem) => {
                CardView() {
                  BudgetItemRow({ item: item })
                }
              }, (item: BudgetItem) => item.id)
            }
            .spacing(AppTokens.Spacing.md)
            
            // Bottom Spacer
            Blank().height(AppTokens.Spacing.xxl + 80)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar & FAB Overlay
      Column() {
        Blank()
        
        Stack({ align: Alignment.Top }) {
          // Bottom Bar Background
          Row() {
            BottomBarItem({ text: "Home", active: true })
            Blank()
            BottomBarItem({ text: "Reports", active: false })
            Blank()
            // Invisible placeholder for FAB space
            Column().width(56).height(1)
            Blank()
            BottomBarItem({ text: "Goals", active: false })
            Blank()
            BottomBarItem({ text: "Settings", active: false })
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .height(80)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({
            radius: 15,
            color: '#0000001A', // 0.1 opacity black
            offsetX: 0,
            offsetY: -5
          })
          
          // FAB
          Button() {
            // Action
          }
          .type(ButtonType.Circle)
          .backgroundColor(AppTokens.Colors.primary)
          .width(56)
          .height(56)
          .shadow({
            radius: 4,
            color: '#00000040', // Approximate shadow
            offsetX: 0,
            offsetY: 4
          })
          .offset({ y: -28 })
          .onClick(() => {
            // Handle add action
          })
          
          // Plus Icon inside FAB
          Image($r('app.media.ic_plus')) // Assuming a plus icon exists, otherwise use Text
            .width(24)
            .height(24)
            .fillColor(AppTokens.Colors.onPrimary)
            .position({ x: 28, y: 16 }) // Centered in 56x56 button
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}