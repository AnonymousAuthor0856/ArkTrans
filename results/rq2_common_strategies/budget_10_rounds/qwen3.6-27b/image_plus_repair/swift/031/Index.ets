import { TextAlign } from '@kit.ArkUI';

// AppTokens.ts (Design System Tokens)
export class AppTokens {
  static Colors: Record<string, string> = {
    primary: '#020617',
    secondary: '#4ADE80',
    tertiary: '#64748B',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#22C55E',
    onPrimary: '#FFFFFF',
    onBackground: '#020617',
    onSurface: '#020617'
  }

  static Typography: Record<string, { size: number; weight: FontWeight }> = {
    display: { size: 48, weight: FontWeight.Bold },
    headline: { size: 28, weight: FontWeight.Medium },
    title: { size: 20, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes: Record<string, number> = {
    small: 8,
    medium: 16,
    large: 24
  }

  static Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
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

@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home'

  // Static data
  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ]

  private controlActions: string[] = ['Send', 'Receive', 'Add', 'More']
  private navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile']

  build() {
    Column() {
      // Top App Bar
      this.topAppBar()
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Total Balance Card
          this.totalBalanceCard()

          // Control Actions Row
          this.controlActionsRow()

          // Recent Activity Header
          this.recentActivityHeader()

          // Transaction List
          ForEach(this.transactions, (transaction: Transaction) => {
            this.transactionCard(transaction)
          })
        }
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      this.bottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
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

      Text('My Wallet')
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ left: 16, right: 16 })

      Blank().layoutWeight(1)

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
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  totalBalanceCard() {
    Column({ space: 0 }) {
      Text('Total Balance')
        .fontSize(AppTokens.Typography.body.size)
        .fontColor('#A1A1AA') // Approximate opacity of onPrimary

      Text('$ 1,145.14')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .letterSpacing(-0.5)
        .fontColor(AppTokens.Colors.onPrimary)
        .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })

      Row() {
        Circle()
          .fill(AppTokens.Colors.secondary)
          .width(10)
          .height(10)

        Text('+$234.10 today')
          .fontSize(AppTokens.Typography.body.size)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ left: AppTokens.Spacing.sm })
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.08)', offsetY: 2 })
  }

  @Builder
  controlActionsRow() {
    Row() {
      ForEach(this.controlActions, (action: string) => {
        Column({ space: AppTokens.Spacing.sm }) {
          Button() {
            Circle()
              .fill(AppTokens.Colors.primary)
              .width(24)
              .height(24)
              .borderRadius(AppTokens.Shapes.small)
          }
          .type(ButtonType.Normal)
          .width(64)
          .height(64)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(32)
          .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetY: 1 })

          Text(action)
            .fontSize(AppTokens.Typography.label.size)
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
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Blank().layoutWeight(1)

      Button() {
        Text('View All')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .letterSpacing(0.2)
          .fontColor(AppTokens.Colors.tertiary)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  transactionCard(transaction: Transaction) {
    Row({ space: AppTokens.Spacing.md }) {
      // Icon Placeholder
      Rect()
        .fill(AppTokens.Colors.surfaceVariant)
        .width(48)
        .height(48)
        .borderRadius(AppTokens.Shapes.medium)

      // Text Info
      Column({ space: 4 }) {
        Text(transaction.name)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Text(transaction.detail)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .letterSpacing(0.2)
          .fontColor(AppTokens.Colors.tertiary)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Amount
      Text(transaction.amount)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(FontWeight.Medium)
        .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }

  @Builder
  bottomNavigationBar() {
    Row() {
      ForEach(this.navItems, (item: string) => {
        Button() {
          Column({ space: AppTokens.Spacing.xs }) {
            Circle()
              .fill(this.selectedNavItem === item ? AppTokens.Colors.primary : AppTokens.Colors.outline)
              .width(24)
              .height(24)

            Text(item)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .letterSpacing(0.2)
              .fontColor(this.selectedNavItem === item ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(this.selectedNavItem === item ? AppTokens.Colors.surfaceVariant : Color.Transparent)
          .borderRadius(AppTokens.Shapes.medium)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .onClick(() => {
          this.selectedNavItem = item
        })
      })
    }
    .width('100%')
    .height(80)
    .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 12, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
  }
}