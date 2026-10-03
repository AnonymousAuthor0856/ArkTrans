// AppTokens.ts (Design System Tokens)
export class AppTokens {
  static Colors = {
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
  }

  static Typography = {
    display: { size: 48, weight: FontWeight.Bold },
    headline: { size: 28, weight: FontWeight.SemiBold },
    title: { size: 20, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes = {
    small: 8,
    medium: 16,
    large: 24
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  }

  static Elevation = {
    level1: { radius: 3, dy: 1, opacity: 0.05 },
    level2: { radius: 8, dy: 2, opacity: 0.08 },
    level3: { radius: 12, dy: 4, opacity: 0.10 }
  }
}

// Data Models
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

  // Static data
  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ];

  private controlActions: ControlAction[] = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Add' },
    { label: 'More' }
  ];

  private navItems: NavItem[] = [
    { label: 'Home' },
    { label: 'Cards' },
    { label: 'Activity' },
    { label: 'Profile' }
  ];

  build() {
    Column() {
      // Top App Bar
      this.topAppBar();

      // Main Content Area
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Total Balance Card
          this.totalBalanceCard();

          // Control Actions Row
          this.controlActionsRow();

          // Recent Activity Header
          this.recentActivityHeader();

          // Transaction List
          ForEach(this.transactions, (transaction: Transaction) => {
            this.transactionCard(transaction);
          });
        }
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      this.bottomNavigationBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .statusBarMode(StatusBarMode.Custom)
    .systemNavigation(SystemNavigation.FullScreen)
  }

  // MARK: - Subviews

  @Builder
  topAppBar() {
    Row() {
      Button() {
        Circle()
          .fill(AppTokens.Colors.surfaceVariant)
          .width(28)
          .height(28)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)

      Spacer()

      Text('My Wallet')
        .font-size(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Spacer()

      Button() {
        Circle()
          .fill(AppTokens.Colors.surfaceVariant)
          .width(28)
          .height(28)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
  }

  @Builder
  totalBalanceCard() {
    Column({ space: 0 }) {
      Text('Total Balance')
        .font-size(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .opacity(0.7)

      Blank().height(AppTokens.Spacing.sm)

      Text('$ 1,145.14')
        .font-size(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .letterSpacing(-0.5)
        .fontColor(AppTokens.Colors.onPrimary)

      Blank().height(AppTokens.Spacing.xs)

      Row({ space: AppTokens.Spacing.sm }) {
        Circle()
          .fill(AppTokens.Colors.secondary)
          .width(10)
          .height(10)

        Text('+$234.10 today')
          .font-size(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level2.radius,
      color: Color.Black.opacity(AppTokens.Elevation.level2.opacity),
      offsetX: 0,
      offsetY: AppTokens.Elevation.level2.dy
    })
  }

  @Builder
  controlActionsRow() {
    Row({ space: 0 }) {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppTokens.Spacing.sm }) {
          Button() {
            Circle()
              .fill(AppTokens.Colors.primary)
              .width(24)
              .height(24)
          }
          .type(ButtonType.Normal)
          .width(64)
          .height(64)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(32) // Half of width/height for circle
          .shadow({
            radius: AppTokens.Elevation.level1.radius,
            color: Color.Black.opacity(AppTokens.Elevation.level1.opacity),
            offsetX: 0,
            offsetY: AppTokens.Elevation.level1.dy
          })

          Text(action.label)
            .font-size(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .letterSpacing(0.2)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      })
    }
    .width('100%')
  }

  @Builder
  recentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .font-size(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Spacer()

      Button() {
        Text('View All')
          .font-size(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .letterSpacing(0.2)
          .fontColor(AppTokens.Colors.tertiary)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }

  @Builder
  transactionCard(transaction: Transaction) {
    Row({ space: AppTokens.Spacing.md }) {
      // Icon Placeholder
      Rectangle()
        .fill(AppTokens.Colors.surfaceVariant)
        .width(48)
        .height(48)
        .borderRadius(AppTokens.Shapes.medium)

      // Text Info
      Column({ space: 4 }) {
        Text(transaction.name)
          .font-size(AppTokens.Typography.body.size)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)

        Text(transaction.detail)
          .font-size(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .letterSpacing(0.2)
          .fontColor(AppTokens.Colors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Amount
      Text(transaction.amount)
        .font-size(AppTokens.Typography.body.size)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.End)
    }
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }

  @Builder
  bottomNavigationBar() {
    Row({ space: 0 }) {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          Column({ space: AppTokens.Spacing.xs }) {
            Circle()
              .fill(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)
              .width(24)
              .height(24)

            Text(item.label)
              .font-size(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .letterSpacing(0.2)
              .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(this.selectedNavItem === item.label ? AppTokens.Colors.surfaceVariant : Color.Transparent)
          .borderRadius(AppTokens.Shapes.medium)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .onClick(() => {
          this.selectedNavItem = item.label;
        })
      })
    }
    .width('100%')
    .height(80)
    .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.Elevation.level3.radius,
      color: Color.Black.opacity(AppTokens.Elevation.level3.opacity),
      offsetX: 0,
      offsetY: AppTokens.Elevation.level3.dy
    })
  }
}