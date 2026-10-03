import { router } from '@kit.ArkUI';

// MARK: - AppTokens (设计系统令牌)
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#020617';
    export const secondary: string = '#4ADE80';
    export const tertiary: string = '#64748B';
    export const background: string = '#F8FAFC';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#F1F5F9';
    export const outline: string = '#E2E8F0';
    export const success: string = '#22C55E';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#020617';
    export const onTertiary: string = '#FFFFFF';
    export const onBackground: string = '#020617';
    export const onSurface: string = '#020617';
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 16;
    export const lg: number = 24;
    export const xl: number = 32;
    export const xxl: number = 48;
  }

  export namespace Typography {
    export const displaySize: number = 48;
    export const headlineSize: number = 28;
    export const titleSize: number = 20;
    export const bodySize: number = 16;
    export const labelSize: number = 12;
  }

  export namespace Shapes {
    export const small: number = 8;
    export const medium: number = 16;
    export const large: number = 24;
  }

  export namespace Elevation {
    export const level1: ShadowOptions = {
      radius: 3,
      color: '#0D000000',
      offsetX: 0,
      offsetY: 1
    };
    export const level2: ShadowOptions = {
      radius: 8,
      color: '#14000000',
      offsetX: 0,
      offsetY: 2
    };
    export const level3: ShadowOptions = {
      radius: 12,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 4
    };
  }
}

// MARK: - Data Models (数据模型)
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

// MARK: - RootScreen Entry
@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home';

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

  // Top App Bar
  @Builder
  TopAppBar() {
    Row() {
      Button() {
        Circle()
          .fill(AppTokens.Colors.surfaceVariant)
          .width(28)
          .height(28)
      }
      .backgroundColor(Color.Transparent)
      .width(28)
      .height(28)

      Blank()

      Text('My Wallet')
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Button() {
        Circle()
          .fill(AppTokens.Colors.surfaceVariant)
          .width(28)
          .height(28)
      }
      .backgroundColor(Color.Transparent)
      .width(28)
      .height(28)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }

  // Total Balance Card
  @Builder
  TotalBalanceCard() {
    Column({ space: 0 }) {
      Text('Total Balance')
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor('#B3FFFFFF')

      Blank().height(AppTokens.Spacing.sm)

      Text('$ 1,145.14')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onPrimary)
        .letterSpacing(-0.5)

      Blank().height(AppTokens.Spacing.xs)

      Row({ space: AppTokens.Spacing.sm }) {
        Circle()
          .fill(AppTokens.Colors.secondary)
          .width(10)
          .height(10)

        Text('+$234.10 today')
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Shapes.large)
    .shadow(AppTokens.Elevation.level2)
  }

  // Control Actions Row
  @Builder
  ControlActionsRow() {
    Row({ space: 0 }) {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppTokens.Spacing.sm }) {
          Button() {
            RoundedRect()
              .radiusWidth(AppTokens.Shapes.small)
              .radiusHeight(AppTokens.Shapes.small)
              .fill(AppTokens.Colors.primary)
              .width(24)
              .height(24)
          }
          .width(64)
          .height(64)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(32)
          .shadow(AppTokens.Elevation.level1)
          .padding(0)

          Text(action.label)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .letterSpacing(0.2)
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      }, (action: ControlAction) => action.label)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
  }

  // Recent Activity Header
  @Builder
  RecentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Button('View All')
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.tertiary)
        .letterSpacing(0.2)
        .backgroundColor(Color.Transparent)
        .padding(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  // Transaction Card
  @Builder
  TransactionCard(transaction: Transaction) {
    Row({ space: AppTokens.Spacing.md }) {
      RoundedRect()
        .radiusWidth(AppTokens.Shapes.medium)
        .radiusHeight(AppTokens.Shapes.medium)
        .fill(AppTokens.Colors.surfaceVariant)
        .width(48)
        .height(48)

      Column({ space: 2 }) {
        Text(transaction.name)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Text(transaction.detail)
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.tertiary)
          .letterSpacing(0.2)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(transaction.amount)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.End)
    }
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }

  // Bottom Navigation Bar
  @Builder
  BottomNavigationBar() {
    Row({ space: 0 }) {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          Column({ space: AppTokens.Spacing.xs }) {
            Circle()
              .fill(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)
              .width(24)
              .height(24)

            Text(item.label)
              .fontSize(AppTokens.Typography.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
              .letterSpacing(0.2)
          }
          .alignItems(HorizontalAlign.Center)
          .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .width('100%')
          .backgroundColor(
            this.selectedNavItem === item.label ? AppTokens.Colors.surfaceVariant : Color.Transparent
          )
          .borderRadius(AppTokens.Shapes.medium)
        }
        .onClick(() => {
          this.selectedNavItem = item.label;
        })
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
      }, (item: NavItem) => item.label)
    }
    .width('100%')
    .height(80)
    .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow(AppTokens.Elevation.level3)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      // Top App Bar
      this.TopAppBar()

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          this.TotalBalanceCard()
          this.ControlActionsRow()
          this.RecentActivityHeader()

          ForEach(this.transactions, (transaction: Transaction) => {
            this.TransactionCard(transaction)
          }, (transaction: Transaction) => transaction.id.toString())
        }
        .padding({
          left: AppTokens.Spacing.md,
          right: AppTokens.Spacing.md,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')

      // Bottom Navigation Bar
      this.BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}