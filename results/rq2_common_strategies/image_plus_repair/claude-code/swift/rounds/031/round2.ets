// Design System Tokens - Colors
class AppColors {
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

// Design System Tokens - Spacing
class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 16
  static readonly lg: number = 24
  static readonly xl: number = 32
  static readonly xxl: number = 48
}

// Design System Tokens - Shapes
class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 16
  static readonly large: number = 24
}

// Data Models
@Observed
class Transaction {
  id: number = 0
  name: string = ''
  detail: string = ''
  amount: string = ''
  isCredit: boolean = false

  constructor(id: number = 0, name: string = '', detail: string = '', amount: string = '', isCredit: boolean = false) {
    this.id = id
    this.name = name
    this.detail = detail
    this.amount = amount
    this.isCredit = isCredit
  }
}

// Top App Bar Component
@Component
struct TopAppBar {
  build() {
    Row() {
      Circle({ width: 28, height: 28 })
        .fill(AppColors.surfaceVariant)

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onBackground)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Circle({ width: 28, height: 28 })
        .fill(AppColors.surfaceVariant)
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
        .fontColor(AppColors.onPrimary)
        .opacity(0.7)
        .width('100%')

      Blank()
        .height(AppSpacing.sm)

      Text('$1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .width('100%')

      Blank()
        .height(AppSpacing.xs)

      Row() {
        Circle({ width: 10, height: 10 })
          .fill(AppColors.secondary)
        Text('+$234.10 today')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.secondary)
          .margin({ left: AppSpacing.sm })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.primary)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 8,
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
        RoundedRect({ width: 24, height: 24, radius: AppShapes.small })
          .fill(AppColors.primary)
      }
      .width(64)
      .height(64)
      .backgroundColor(AppColors.surface)
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
        .fontColor(AppColors.onBackground)
        .margin({ top: AppSpacing.sm })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

// Control Actions Row Component
@Component
struct ControlActionsRow {
  private actions: string[] = ['Send', 'Receive', 'Add', 'More']

  build() {
    Row() {
      ForEach(this.actions, (item: string) => {
        ControlActionButton({ label: item })
      }, (item: string) => item)
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
        .fontColor(AppColors.onBackground)
        .layoutWeight(1)

      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary)
    }
    .width('100%')
  }
}

// Transaction Card Component
@Component
struct TransactionCard {
  @ObjectLink transaction: Transaction = new Transaction()

  build() {
    Row() {
      RoundedRect({ width: 48, height: 48, radius: AppShapes.medium })
        .fill(AppColors.surfaceVariant)

      Column() {
        Text(this.transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Text(this.transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)
          .width('100%')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: AppSpacing.md })

      Text(this.transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.transaction.isCredit ? AppColors.success : AppColors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({
      width: 1,
      color: AppColors.outline
    })
  }
}

// Bottom Navigation Bar Component
@Component
struct BottomNavigationBar {
  @State selectedNavItem: string = 'Home'
  private navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile']

  build() {
    Row() {
      ForEach(this.navItems, (item: string) => {
        Column() {
          Circle({ width: 24, height: 24 })
            .fill(this.selectedNavItem === item ? AppColors.primary : AppColors.outline)

          Text(item)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNavItem === item ? AppColors.primary : AppColors.tertiary)
            .margin({ top: AppSpacing.xs })
        }
        .layoutWeight(1)
        .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
        .backgroundColor(this.selectedNavItem === item ? AppColors.surfaceVariant : Color.Transparent)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
          this.selectedNavItem = item
        })
      }, (item: string) => item)
    }
    .width('100%')
    .height(80)
    .padding({ left: AppSpacing.xs, right: AppSpacing.xs })
    .backgroundColor(AppColors.surface)
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

  @State transactions: Transaction[] = [
    new Transaction(1, 'Spotify', 'Subscription', '-$9.99', false),
    new Transaction(2, 'Income', 'Monthly Salary', '+$2,500.00', true),
    new Transaction(3, 'Starbucks', 'Coffee', '-$5.75', false),
    new Transaction(4, 'Amazon', 'Shopping', '-$124.50', false),
    new Transaction(5, 'Refund', 'Amazon Return', '+$32.00', true)
  ]

  build() {
    Column() {
      TopAppBar()
        .padding({ left: AppSpacing.md, right: AppSpacing.md })

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
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
        .space(AppSpacing.lg)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
