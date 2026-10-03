// AppEntry.ets (or main entry file)
import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { common, UIAbility } from '@kit.AbilityKit';

@Entry
@Component
struct BudgetPieApp {
  @State private statusBarHeight: number = 0;

  aboutToAppear() {
    // Attempt to hide status bar for full immersion similar to the Swift code
    try {
      const ctx = getContext(this) as common.UIAbilityContext;
      // getWindowSync is not available in standard ArkTS UI context directly without specific imports or using window module
      // Using window module API which is standard for UI abilities
      const win: window.Window = window.getClass().getWindow(); 
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarProperties({
        statusBarContentColor: '#F7FAFC', // Match background
        statusBarColor: '#F7FAFC'
      });
    } catch (e) {
      console.error(`Failed to set window properties: ${JSON.stringify(e)}`);
    }
  }

  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - App Tokens & Colors
class AppTokens {
  static Colors: AppColors = {
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
    
    // Gradients defined as arrays of colors
    gradient1: ['#63B3ED', '#4299E1'],
    gradient2: ['#4FD1C5', '#38B2AC'],
    gradient3: ['#667EEA', '#5A67D8'],
    gradient4: ['#ED64A6', '#D53F8C'],
    gradient5: ['#F6AD55', '#ED8936']
  };

  static Typography: AppTypography = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.Medium },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Normal },
    label: { size: 14, weight: FontWeight.Medium }
  };

  static Spacing: AppSpacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  };

  static Shapes: AppShapes = {
    small: 4,
    medium: 8,
    large: 16
  };
}

interface AppColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
  gradient1: string[];
  gradient2: string[];
  gradient3: string[];
  gradient4: string[];
  gradient5: string[];
}

interface FontConfig {
  size: number;
  weight: FontWeight;
}

interface AppTypography {
  display: FontConfig;
  headline: FontConfig;
  title: FontConfig;
  body: FontConfig;
  label: FontConfig;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

// MARK: - Models
interface BudgetItem {
  id: string;
  name: string;
  value: number;
  gradient: string[];
}

const budgetData: BudgetItem[] = [
  { id: '1', name: "Housing", value: 1250.00, gradient: AppTokens.Colors.gradient1 },
  { id: '2', name: "Food", value: 480.50, gradient: AppTokens.Colors.gradient2 },
  { id: '3', name: "Transport", value: 210.75, gradient: AppTokens.Colors.gradient3 },
  { id: '4', name: "Entertainment", value: 150.00, gradient: AppTokens.Colors.gradient4 },
  { id: '5', name: "Utilities", value: 320.00, gradient: AppTokens.Colors.gradient5 }
];

// MARK: - Helpers
function formatCurrency(value: number): string {
  return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(value);
}

// MARK: - Components

@Component
struct CardView {
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
  }
}

@Component
struct BudgetItemRow {
  @Prop item: BudgetItem;

  build() {
    Row() {
      Row() {
        Circle()
          .width(20)
          .height(20)
          .linearGradient({
            angle: 90,
            colors: [[this.item.gradient[0], 0], [this.item.gradient[1], 1]]
          })
        
        Text(this.item.name)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.md })
      }

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
  }
}

@Component
struct BottomBarItem {
  @Prop text: string;
  @Prop active: boolean;

  build() {
    Column() {
      Circle()
        .width(24)
        .height(24)
        .fill(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .opacity(0.2)
      
      Text(this.text)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
        .margin({ top: AppTokens.Spacing.xs })
    }
  }
}

@Component
struct PieChart {
  @Prop items: BudgetItem[];
  @Prop strokeWidth: number = 20;

  get totalValue(): number {
    return this.items.reduce((sum, item) => sum + item.value, 0);
  }

  build() {
    Stack() {
      // Draw Slices
      ForEach(this.items, (item: BudgetItem, index: number) => {
        PieSliceComponent({ item: item, allItems: this.items, index: index, strokeWidth: this.strokeWidth })
      })

      // Center Text
      Column() {
        Text("Total Spent")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.secondary)
        
        Text(formatCurrency(this.totalValue))
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: 4 })
      }
    }
  }
}

@Component
struct PieSliceComponent {
  @Prop item: BudgetItem;
  @Prop allItems: BudgetItem[];
  @Prop index: number;
  @Prop strokeWidth: number;

  // Calculate angles
  get startAngle(): number {
    let previousSum = 0;
    for(let i = 0; i < this.index; i++) {
      previousSum += this.allItems[i].value;
    }
    const total = this.allItems.reduce((sum, it) => sum + it.value, 0);
    // Start from -90 degrees (top)
    return (previousSum / total) * 360 - 90;
  }

  get sweepAngle(): number {
    const total = this.allItems.reduce((sum, it) => sum + it.value, 0);
    return (this.item.value / total) * 360;
  }

  build() {
    Path()
      .drawPath((context: CanvasRenderingContext2D) => {
        const centerX = 120; // Half of 240 width
        const centerY = 120; // Half of 240 height
        const radius = 120 - (this.strokeWidth / 2);
        
        const startRad = (this.startAngle * Math.PI) / 180;
        const endRad = ((this.startAngle + this.sweepAngle) * Math.PI) / 180;

        context.beginPath();
        context.arc(centerX, centerY, radius, startRad, endRad, false);
        context.lineWidth = this.strokeWidth;
        context.lineCap = 'butt';
        
        // Apply Gradient
        const gradient = context.createLinearGradient(centerX, centerY - radius, centerX, centerY + radius);
        gradient.addColorStop(0, this.item.gradient[0]);
        gradient.addColorStop(1, this.item.gradient[1]);
        
        context.strokeStyle = gradient;
        context.stroke();
      })
      .width(240)
      .height(240)
  }
}

// MARK: - Root View
@Component
struct ContentView {
  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Monthly Budget")
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          PieChart({ items: budgetData, strokeWidth: 20 })
            .width(240)
            .height(240)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

          // List Items
          Column() {
            ForEach(budgetData, (item: BudgetItem) => {
              CardView() {
                BudgetItemRow({ item: item })
              }
              .margin({ bottom: AppTokens.Spacing.md })
            })
            
            // Bottom Spacer for scrolling past FAB
            Blank().height(AppTokens.Spacing.xxl + 80)
          }
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom App Bar Overlay
      Column() {
        Stack({ alignContent: Alignment.Top }) {
          // Bottom Bar Background
          Row() {
            BottomBarItem({ text: "Home", active: true })
            Blank()
            BottomBarItem({ text: "Reports", active: false })
            Blank()
            // Invisible placeholder for FAB space
            Blank().width(56)
            Blank()
            BottomBarItem({ text: "Goals", active: false })
            Blank()
            BottomBarItem({ text: "Settings", active: false })
          }
          .width('100%')
          .height(80)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({ radius: 15, color: 'rgba(0,0,0,0.1)', offsetY: -5 })

          // FAB
          Button() {
            Column() {
              Text("+")
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onPrimary)
            }
          }
          .width(56)
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(28)
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.2)', offsetY: 4 })
          .position({ y: -28 })
          .alignSelf(ItemAlign.Center)
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}