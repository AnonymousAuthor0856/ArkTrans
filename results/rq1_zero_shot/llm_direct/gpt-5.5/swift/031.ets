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

class AppTypographyTokens {
  static readonly displaySize: number = 48
  static readonly displayWeight: string = '700'

  static readonly headlineSize: number = 28
  static readonly headlineWeight: string = '600'

  static readonly titleSize: number = 20
  static readonly titleWeight: string = '500'

  static readonly bodySize: number = 16
  static readonly bodyWeight: string = '400'

  static readonly labelSize: number = 12
  static readonly labelWeight: string = '500'
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 16
  static readonly large: number = 24
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 16
  static readonly lg: number = 24
  static readonly xl: number = 32
  static readonly xxl: number = 48
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
  color: string

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
    this.color = `rgba(0, 0, 0, ${opacity})`
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.05)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 2, 0.08)
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 4, 0.10)
}

class Transaction {
  id: number
  name: string
  detail: string
  amount: string
  isCredit: boolean

  constructor(id: number, name: string, detail: string, amount: string, isCredit: boolean) {
    this.id = id
    this.name = name
    this.detail = detail
    this.amount = amount
    this.isCredit = isCredit
  }
}

class ControlAction {
  id: string
  label: string

  constructor(label: string) {
    this.id = label
    this.label = label
  }
}

class NavItem {
  id: string
  label: string

  constructor(label: string) {
    this.id = label
    this.label = label
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home'

  private transactions: Transaction[] = [
    new Transaction(1, 'Spotify', 'Subscription', '-$9.99', false),
    new Transaction(2, 'Income', 'Monthly Salary', '+$2,500.00', true),
    new Transaction(3, 'Starbucks', 'Coffee', '-$5.75', false),
    new Transaction(4, 'Amazon', 'Shopping', '-$124.50', false),
    new Transaction(5, 'Refund', 'Amazon Return', '+$32.00', true)
  ]

  private controlActions: ControlAction[] = [
    new ControlAction('Send'),
    new ControlAction('Receive'),
    new ControlAction('Add'),
    new ControlAction('More')
  ]

  private navItems: NavItem[] = [
    new NavItem('Home'),
    new NavItem('Cards'),
    new NavItem('Activity'),
    new NavItem('Profile')
  ]

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.topAppBar()

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            this.totalBalanceCard()
            this.controlActionsRow()
            this.recentActivityHeader()

            ForEach(this.transactions, (transaction: Transaction) => {
              this.transactionCard(transaction)
            }, (transaction: Transaction) => transaction.id.toString())
          }
          .width('100%')
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.sm,
            bottom: AppSpacing.sm
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .padding({ bottom: AppSpacing.sm })

        this.bottomNavigationBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  private topAppBar() {
    Row() {
      Circle()
        .width(28)
        .height(28)
        .fill(AppColors.surfaceVariant)
        .onClick(() => {
        })

      Blank()
        .layoutWeight(1)

      Text('My Wallet')
        .fontSize(AppTypographyTokens.titleSize)
        .fontWeight(AppTypographyTokens.titleWeight)
        .fontColor(AppColors.onBackground)

      Blank()
        .layoutWeight(1)

      Circle()
        .width(28)
        .height(28)
        .fill(AppColors.surfaceVariant)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(56)
    .padding({
      left: AppSpacing.md,
      right: AppSpacing.md,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor('rgba(248, 250, 252, 0.01)')
  }

  @Builder
  private totalBalanceCard() {
    Column({ space: 0 }) {
      Text('Total Balance')
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(AppTypographyTokens.bodyWeight)
        .fontColor(AppColors.onPrimary)
        .opacity(0.7)

      Blank()
        .height(AppSpacing.sm)

      Text('$ 1,145.14')
        .fontSize(AppTypographyTokens.displaySize)
        .fontWeight(AppTypographyTokens.displayWeight)
        .fontColor(AppColors.onPrimary)
        .letterSpacing(-0.5)

      Blank()
        .height(AppSpacing.xs)

      Row({ space: AppSpacing.sm }) {
        Circle()
          .width(10)
          .height(10)
          .fill(AppColors.secondary)

        Text('+$234.10 today')
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(AppTypographyTokens.bodyWeight)
          .fontColor(AppColors.secondary)
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.primary)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevationMapping.level2.radius,
      color: AppElevationMapping.level2.color,
      offsetX: 0,
      offsetY: AppElevationMapping.level2.dy
    })
  }

  @Builder
  private controlActionsRow() {
    Row({ space: 0 }) {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppSpacing.sm }) {
          Stack({ alignContent: Alignment.Center }) {
            Row()
              .width(24)
              .height(24)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.small)
          }
          .width(64)
          .height(64)
          .backgroundColor(AppColors.surface)
          .borderRadius(32)
          .shadow({
            radius: AppElevationMapping.level1.radius,
            color: AppElevationMapping.level1.color,
            offsetX: 0,
            offsetY: AppElevationMapping.level1.dy
          })
          .onClick(() => {
          })

          Text(action.label)
            .fontSize(AppTypographyTokens.labelSize)
            .fontWeight(AppTypographyTokens.labelWeight)
            .fontColor(AppColors.onBackground)
            .letterSpacing(0.2)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }, (action: ControlAction) => action.id)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private recentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(AppTypographyTokens.titleSize)
        .fontWeight(AppTypographyTokens.titleWeight)
        .fontColor(AppColors.onBackground)

      Blank()
        .layoutWeight(1)

      Text('View All')
        .fontSize(AppTypographyTokens.labelSize)
        .fontWeight(AppTypographyTokens.labelWeight)
        .fontColor(AppColors.tertiary)
        .letterSpacing(0.2)
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private transactionCard(transaction: Transaction) {
    Row({ space: AppSpacing.md }) {
      Row()
        .width(48)
        .height(48)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Column() {
        Text(transaction.name)
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight('600')
          .fontColor(AppColors.onSurface)

        Text(transaction.detail)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.tertiary)
          .letterSpacing(0.2)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(transaction.amount)
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight('600')
        .fontColor(transaction.isCredit ? AppColors.success : AppColors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({
      width: 1,
      color: AppColors.outline
    })
  }

  @Builder
  private bottomNavigationBar() {
    Row({ space: 0 }) {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: AppSpacing.xs }) {
          Circle()
            .width(24)
            .height(24)
            .fill(this.selectedNavItem === item.label ? AppColors.primary : AppColors.outline)

          Text(item.label)
            .fontSize(AppTypographyTokens.labelSize)
            .fontWeight(AppTypographyTokens.labelWeight)
            .fontColor(this.selectedNavItem === item.label ? AppColors.primary : AppColors.tertiary)
            .letterSpacing(0.2)
        }
        .layoutWeight(1)
        .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(this.selectedNavItem === item.label ? AppColors.surfaceVariant : 'rgba(0, 0, 0, 0)')
        .borderRadius(AppShapes.medium)
        .onClick(() => {
          this.selectedNavItem = item.label
        })
      }, (item: NavItem) => item.id)
    }
    .width('100%')
    .height(80)
    .padding({ left: AppSpacing.xs, right: AppSpacing.xs })
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevationMapping.level3.radius,
      color: AppElevationMapping.level3.color,
      offsetX: 0,
      offsetY: AppElevationMapping.level3.dy
    })
  }
}