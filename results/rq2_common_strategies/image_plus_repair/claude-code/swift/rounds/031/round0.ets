// Design System Tokens
class AppTokens {
  static class Colors {
    static readonly primary: string = '#020617'
    static readonly secondary: string = '#4ADE80'
    static readonly tertiary: string = '#64748B'
    static readonly background: string = '#F8FAFC'
    static readonly surface: string = '#FFFFFF'
    static readonly surfaceVariant: string = '#F1F5F9'
    static readonly outline: string = '#E2E8F0'
    static readonly success: string = '#22C55E'
    static readonly warning: string = '#F59E0B'
    static readonly error: string = '#EF4444'
    static readonly onPrimary: string = '#FFFFFF'
    static readonly onSecondary: string = '#020617'
    static readonly onTertiary: string = '#FFFFFF'
    static readonly onBackground: string = '#020617'
    static readonly onSurface: string = '#020617'
  }

  static class Spacing {
    static readonly xs: number = 4
    static readonly sm: number = 8
    static readonly md: number = 16
    static readonly lg: number = 24
    static readonly xl: number = 32
    static readonly xxl: number = 48
  }

  static class Shapes {
    static readonly small: number = 8
    static readonly medium: number = 16
    static readonly large: number = 24
  }
}

// Data Models
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

// Top App Bar Component
@Component
struct TopAppBar {
  build() {
    Row() {
      Circle({ width: 28, height: 28 })
        .fill(AppTokens.Colors.surfaceVariant)

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onBackground)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Circle({ width: 28, height: 28 })
        .fill(AppTokens.Colors.surfaceVariant)
    }
    .width('100%')
    .height(56)
  }
}

// Total Balance Card Component
@Component
struct TotalBalanceCard {
  build() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.onPrimary)
        .opacity(0.7)
        .width('100%')

      Blank()
        .height(AppTokens.Spacing.sm)

      Text('$1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')

      Blank()
        .height(AppTokens.Spacing.xs)

      Row() {
        Circle({ width: 10, height: 10 })
          .fill(AppTokens.Colors.secondary)
        Text('+$234.10 today')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Shapes.medium / 2,
      color: 'rgba(0, 0, 0, 0.08)',
      offsetX: 0,
      offsetY: 2
    })
  }
}

// Control Action Button Component
@Component
struct ControlActionButton {
  label: string = ''

  build() {
    Column() {
      Column() {
        RoundedRect({ width: 24, height: 24, radius: AppTokens.Shapes.small })
          .fill(AppTokens.Colors.primary)
      }
      .width(64)
      .height(64)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(32)
      .justifyContent(FlexAlign.Center)
      .shadow({
        radius: 3,
        color: 'rgba(0, 0, 0, 0.05)',
        offsetX: 0,
        offsetY: 1
      })

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ top: AppTokens.Spacing.sm })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

// Control Actions Row Component
@Component
struct ControlActionsRow {
  private actions: ControlAction[] = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Add' },
    { label: 'More' }
  ]

  build() {
    Row() {
      ForEach(this.actions, (item: ControlAction) => {
        ControlActionButton({ label: item.label })
      }, (item: ControlAction) => item.label)
    }
    .width('100%')
  }
}

// Recent Activity Header Component
@Component
struct RecentActivityHeader {
  build() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onBackground)
        .layoutWeight(1)

      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.tertiary)
    }
    .width('100%')
  }
}

// Transaction Card Component
@Component
struct TransactionCard {
  transaction: Transaction

  build() {
    Row() {
      RoundedRect({ width: 48, height: 48, radius: AppTokens.Shapes.medium })
        .fill(AppTokens.Colors.surfaceVariant)

      Column() {
        Text(this.transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        Text(this.transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.tertiary)
          .width('100%')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: AppTokens.Spacing.md })

      Text(this.transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: AppTokens.Colors.outline
    })
  }
}

// Bottom Navigation Bar Component
@Component
struct BottomNavigationBar {
  @State selectedNavItem: string = 'Home'
  private navItems: NavItem[] = [
    { label: 'Home' },
    { label: 'Cards' },
    { label: 'Activity' },
    { label: 'Profile' }
  ]

  build() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column() {
          Circle({ width: 24, height: 24 })
            .fill(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)

          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .layoutWeight(1)
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(this.selectedNavItem === item.label ? AppTokens.Colors.surfaceVariant : Color.Transparent)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {
          this.selectedNavItem = item.label
        })
      }, (item: NavItem) => item.label)
    }
    .width('100%')
    .height(80)
    .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: 12,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: 4
    })
  }
}

// Root Screen
@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home'

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ]

  build() {
    Column() {
      TopAppBar()
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

      Scroll() {
        Column() {
          TotalBalanceCard()

          ControlActionsRow()

          RecentActivityHeader()

          ForEach(this.transactions, (item: Transaction) => {
            TransactionCard({ transaction: item })
          }, (item: Transaction) => item.id.toString())
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.md,
          right: AppTokens.Spacing.md,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
        .space(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
