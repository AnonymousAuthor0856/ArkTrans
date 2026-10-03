// ============================================================
// AppTokens - Design System Tokens
// ============================================================
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#020617'
    export const secondary: string = '#4ADE80'
    export const tertiary: string = '#64748B'
    export const background: string = '#F8FAFC'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#F1F5F9'
    export const outline: string = '#E2E8F0'
    export const success: string = '#22C55E'
    export const warning: string = '#F59E0B'
    export const error: string = '#EF4444'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#020617'
    export const onTertiary: string = '#FFFFFF'
    export const onBackground: string = '#020617'
    export const onSurface: string = '#020617'
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 16
    export const lg: number = 24
    export const xl: number = 32
    export const xxl: number = 48
  }

  export namespace Typography {
    export const displaySize: number = 48
    export const headlineSize: number = 28
    export const titleSize: number = 20
    export const bodySize: number = 16
    export const labelSize: number = 12
  }

  export namespace Radius {
    export const small: number = 8
    export const medium: number = 16
    export const large: number = 24
  }

  export namespace Elevation {
    export const level1Radius: number = 3
    export const level1Opacity: number = 0.05
    export const level2Radius: number = 8
    export const level2Opacity: number = 0.08
    export const level3Radius: number = 12
    export const level3Opacity: number = 0.10
  }
}

// ============================================================
// Data Models
// ============================================================
interface Transaction {
  id: number
  name: string
  detail: string
  amount: string
  isCredit: boolean
}

interface ControlAction {
  label: string
}

interface NavItem {
  label: string
}

// ============================================================
// Main Entry
// ============================================================
@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home'

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true },
  ]

  private controlActions: ControlAction[] = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Add' },
    { label: 'More' },
  ]

  private navItems: NavItem[] = [
    { label: 'Home' },
    { label: 'Cards' },
    { label: 'Activity' },
    { label: 'Profile' },
  ]

  // ── Top App Bar ──────────────────────────────────────────
  @Builder
  TopAppBar() {
    Row() {
      Circle()
        .fill(AppTokens.Colors.surfaceVariant)
        .width(28)
        .height(28)

      Blank()

      Text('My Wallet')
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Circle()
        .fill(AppTokens.Colors.surfaceVariant)
        .width(28)
        .height(28)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }

  // ── Total Balance Card ───────────────────────────────────
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
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Radius.large)
    .shadow({
      radius: AppTokens.Elevation.level2Radius,
      color: `rgba(0,0,0,${AppTokens.Elevation.level2Opacity})`,
      offsetX: 0,
      offsetY: 2
    })
  }

  // ── Control Actions Row ──────────────────────────────────
  @Builder
  ControlActionsRow() {
    Row({ space: 0 }) {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppTokens.Spacing.sm }) {
          Stack() {
            Circle()
              .fill(AppTokens.Colors.surface)
              .width(64)
              .height(64)
              .shadow({
                radius: AppTokens.Elevation.level1Radius,
                color: `rgba(0,0,0,${AppTokens.Elevation.level1Opacity})`,
                offsetX: 0,
                offsetY: 1
              })

            // Inner icon placeholder using Column with borderRadius
            Column()
              .width(24)
              .height(24)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Radius.small)
          }
          .width(64)
          .height(64)

          Text(action.label)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .letterSpacing(0.2)
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
  }

  // ── Recent Activity Header ───────────────────────────────
  @Builder
  RecentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Text('View All')
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.tertiary)
        .letterSpacing(0.2)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  // ── Transaction Card ─────────────────────────────────────
  @Builder
  TransactionCard(transaction: Transaction) {
    Row({ space: AppTokens.Spacing.md }) {
      // Icon placeholder using Column with borderRadius
      Column()
        .width(48)
        .height(48)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Radius.medium)

      // Name + detail
      Column({ space: 4 }) {
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

      // Amount
      Text(transaction.amount)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Radius.medium })
  }

  // ── Bottom Navigation Bar ────────────────────────────────
  @Builder
  BottomNavigationBar() {
    Row({ space: 0 }) {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: AppTokens.Spacing.xs }) {
          Circle()
            .fill(this.selectedNavItem === item.label
              ? AppTokens.Colors.primary
              : AppTokens.Colors.outline)
            .width(24)
            .height(24)

          Text(item.label)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNavItem === item.label
              ? AppTokens.Colors.primary
              : AppTokens.Colors.tertiary)
            .letterSpacing(0.2)
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .height('100%')
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(this.selectedNavItem === item.label
          ? AppTokens.Colors.surfaceVariant
          : Color.Transparent)
        .borderRadius(AppTokens.Radius.medium)
        .onClick(() => {
          this.selectedNavItem = item.label
        })
      })
    }
    .width('100%')
    .height(80)
    .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.Elevation.level3Radius,
      color: `rgba(0,0,0,${AppTokens.Elevation.level3Opacity})`,
      offsetX: 0,
      offsetY: -2
    })
  }

  // ── Build ────────────────────────────────────────────────
  build() {
    Column({ space: 0 }) {
      // Top bar
      this.TopAppBar()

      // Scrollable content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          this.TotalBalanceCard()
          this.ControlActionsRow()
          this.RecentActivityHeader()

          ForEach(this.transactions, (tx: Transaction) => {
            this.TransactionCard(tx)
          })
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.md,
          right: AppTokens.Spacing.md,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // Bottom nav
      this.BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}