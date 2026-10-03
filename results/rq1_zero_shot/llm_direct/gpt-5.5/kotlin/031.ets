const NAME: string = '032_WalletDashFinance_en'
const UI_TYPE: string = 'Finance/Wallet'
const STYLE_THEME: string = 'Monochrome Comfortable'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

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

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 16
  static readonly lg: number = 24
  static readonly xl: number = 32
  static readonly xxl: number = 48
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 16
  static readonly large: number = 24
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
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
  label: string

  constructor(label: string) {
    this.label = label
  }
}

class NavItem {
  label: string

  constructor(label: string) {
    this.label = label
  }
}

function shadowColor(opacity: number): string {
  return `rgba(2, 6, 23, ${opacity})`
}

@Entry
@Component
struct Index {
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

  @Builder
  TopBar() {
    Row() {
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Row() {}
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor(AppColors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .padding(0)
      .backgroundColor(Color.Transparent)

      Text('My Wallet')
        .layoutWeight(1)
        .fontSize(20)
        .fontWeight(500)
        .lineHeight(28)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Row() {}
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor(AppColors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .padding(0)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.md, right: AppSpacing.md })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.Transparent)
  }

  @Builder
  BalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontWeight(FontWeight.Normal)
        .lineHeight(24)
        .fontColor('rgba(255, 255, 255, 0.70)')

      Blank()
        .height(AppSpacing.sm)

      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .lineHeight(56)
        .fontColor(AppColors.onPrimary)

      Blank()
        .height(AppSpacing.xs)

      Row() {
        Row() {}
          .width(10)
          .height(10)
          .borderRadius(5)
          .backgroundColor(AppColors.secondary)

        Blank()
          .width(AppSpacing.sm)

        Text('+$234.10 today')
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .lineHeight(24)
          .fontColor(AppColors.secondary)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .borderRadius(AppShapes.large)
    .backgroundColor(AppColors.primary)
    .shadow({
      radius: AppElevationMapping.level2.radius,
      color: shadowColor(AppElevationMapping.level2.opacity),
      offsetX: 0,
      offsetY: AppElevationMapping.level2.dy
    })
  }

  @Builder
  ControlActions() {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppSpacing.sm }) {
          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Row() {}
              .width(24)
              .height(24)
              .borderRadius(AppShapes.small)
              .backgroundColor(AppColors.primary)
          }
          .width(64)
          .height(64)
          .padding(0)
          .backgroundColor(AppColors.surface)
          .shadow({
            radius: AppElevationMapping.level1.radius,
            color: shadowColor(AppElevationMapping.level1.opacity),
            offsetX: 0,
            offsetY: AppElevationMapping.level1.dy
          })

          Text(action.label)
            .fontSize(12)
            .fontWeight(500)
            .lineHeight(16)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Center)
      }, (action: ControlAction) => action.label)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SectionHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(500)
        .lineHeight(28)
        .fontColor(AppColors.onSurface)

      Text('View All')
        .fontSize(12)
        .fontWeight(500)
        .lineHeight(16)
        .fontColor(AppColors.tertiary)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .onClick(() => {
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TransactionItem(transaction: Transaction) {
    Row({ space: AppSpacing.md }) {
      Row() {}
        .width(48)
        .height(48)
        .borderRadius(AppShapes.medium)
        .backgroundColor(AppColors.surfaceVariant)

      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(600)
          .lineHeight(24)
          .fontColor(AppColors.onSurface)

        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(500)
          .lineHeight(16)
          .fontColor(AppColors.tertiary)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(transaction.amount)
        .minWidth(88)
        .fontSize(16)
        .fontWeight(600)
        .lineHeight(24)
        .fontColor(transaction.isCredit ? AppColors.success : AppColors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .borderRadius(AppShapes.medium)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  BottomBar() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: 4 }) {
          Row() {}
            .width(24)
            .height(24)
            .borderRadius(12)
            .backgroundColor(this.selectedNavItem === item.label ? AppColors.primary : AppColors.outline)

          Text(item.label)
            .fontSize(12)
            .fontWeight(500)
            .lineHeight(16)
            .fontColor(this.selectedNavItem === item.label ? AppColors.primary : AppColors.tertiary)
        }
        .layoutWeight(1)
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .borderRadius(AppShapes.medium)
        .backgroundColor(this.selectedNavItem === item.label ? AppColors.surfaceVariant : Color.Transparent)
        .onClick(() => {
          this.selectedNavItem = item.label
        })
      }, (item: NavItem) => item.label)
    }
    .width('100%')
    .height(80)
    .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevationMapping.level3.radius,
      color: shadowColor(AppElevationMapping.level3.opacity),
      offsetX: 0,
      offsetY: -AppElevationMapping.level3.dy
    })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.BalanceCard()
          this.ControlActions()
          this.SectionHeader()

          ForEach(this.transactions, (transaction: Transaction) => {
            this.TransactionItem(transaction)
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
      .width('100%')
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}