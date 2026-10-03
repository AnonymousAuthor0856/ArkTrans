import { window } from '@kit.ArkUI';

// --- Tokens & Constants ---

interface AppTokenColors {
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
}

interface AppTokenSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppTokenShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppTokensConfig {
  Colors: AppTokenColors;
  Spacing: AppTokenSpacing;
  Shapes: AppTokenShapes;
}

const AppTokens: AppTokensConfig = {
  Colors: {
    primary: '#020617',
    secondary: '#4ADE80',
    tertiary: '#64748B',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#020617',
    onTertiary: '#FFFFFF',
    onBackground: '#020617',
    onSurface: '#020617'
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
    small: 8,
    medium: 16,
    large: 24
  }
};

interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

interface ControlAction {
  label: string;
}

interface NavItem {
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home';

  private transactions: Transaction[] = [
    { id: 1, name: "Spotify", detail: "Subscription", amount: "-$9.99", isCredit: false },
    { id: 2, name: "Income", detail: "Monthly Salary", amount: "+$2,500.00", isCredit: true },
    { id: 3, name: "Starbucks", detail: "Coffee", amount: "-$5.75", isCredit: false },
    { id: 4, name: "Amazon", detail: "Shopping", amount: "-$124.50", isCredit: false },
    { id: 5, name: "Refund", detail: "Amazon Return", amount: "+$32.00", isCredit: true }
  ];

  private controlActions: ControlAction[] = [
    { label: "Send" },
    { label: "Receive" },
    { label: "Add" },
    { label: "More" }
  ];

  private navItems: NavItem[] = [
    { label: "Home" },
    { label: "Cards" },
    { label: "Activity" },
    { label: "Profile" }
  ];

  aboutToAppear() {
    // Hide system bars for immersive experience similar to the Kotlin code
    let windowClass: window.Window = undefined as unknown as window.Window;
    try {
      windowClass = window.getWindowSync(this.getUIContext().getWindow());
      windowClass.setWindowLayoutFullScreen(true);
    } catch (e) {
      console.error('Failed to set full screen');
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Button() {
          Circle({ width: 28, height: 28 })
            .fill(AppTokens.Colors.surfaceVariant)
        }
        .onClick(() => {})
        .height(28)
        .width(28)
        .backgroundColor(Color.Transparent)

        Text("My Wallet")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Button() {
          Circle({ width: 28, height: 28 })
            .fill(AppTokens.Colors.surfaceVariant)
        }
        .onClick(() => {})
        .height(28)
        .width(28)
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .alignItems(VerticalAlign.Center)

      // Main Content Scrollable Area
      Scroll() {
        Column() {
          // Balance Card
          Column() {
            Text("Total Balance")
              .fontSize(16)
              .fontColor('#B3FFFFFF') // Approx alpha 0.7 of white
              .margin({ bottom: AppTokens.Spacing.sm })

            Text("$ 1,145.14")
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(-0.5)
              .lineHeight(56)
              .fontColor(AppTokens.Colors.onPrimary)
              .margin({ bottom: AppTokens.Spacing.xs })

            Row() {
              Circle({ width: 10, height: 10 })
                .fill(AppTokens.Colors.secondary)
              
              Text("+$234.10 today")
                .fontSize(16)
                .fontColor(AppTokens.Colors.secondary)
                .margin({ left: AppTokens.Spacing.sm })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({ radius: 8, color: '#1A000000', offsetY: 2 }) // Level 2 shadow approx
          .margin({ bottom: AppTokens.Spacing.lg })

          // Control Actions
          Row() {
            ForEach(this.controlActions, (action: ControlAction) => {
              Column() {
                Button() {
                  Rect()
                    .width(24)
                    .height(24)
                    .fill(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.small)
                }
                .width(64)
                .height(64)
                .borderRadius(32)
                .backgroundColor(AppTokens.Colors.surface)
                .shadow({ radius: 3, color: '#0D000000', offsetY: 1 }) // Level 1 shadow approx
                .onClick(() => {})
                
                Text(action.label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.sm })
              }
              .alignItems(HorizontalAlign.Center)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
          .margin({ bottom: AppTokens.Spacing.lg })

          // Recent Activity Header
          Row() {
            Text("Recent Activity")
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            
            Text("View All")
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.tertiary)
              .onClick(() => {})
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: AppTokens.Spacing.sm })

          // Transactions List
          ForEach(this.transactions, (transaction: Transaction) => {
            Row() {
              // Icon Placeholder
              Rect()
                .width(48)
                .height(48)
                .fill(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)

              Column() {
                Text(transaction.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ bottom: 2 })
                
                Text(transaction.detail)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.tertiary)
              }
              .layoutWeight(1)
              .margin({ left: AppTokens.Spacing.md })

              Text(transaction.amount)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
                .textAlign(TextAlign.End)
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ bottom: AppTokens.Spacing.sm })
          })
          
          // Bottom padding for navigation bar
          Blank().height(80) 
        }
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      
      // Bottom Navigation Bar
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column() {
            Circle({ width: 24, height: 24 })
              .fill(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)
            
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.selectedNavItem = item.label;
          })
          .layoutWeight(1)
        })
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 12, color: '#1A000000', offsetY: -4 }) // Level 3 shadow approx
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}