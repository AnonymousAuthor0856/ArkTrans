const NAME = '032_WalletDashFinance_en'
const UI_TYPE = 'Finance/Wallet'
const STYLE_THEME = 'Monochrome Comfortable'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
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
    onSurface: '#020617',
  }

  static TypographyTokens = {
    display: { fontSize: 48, fontWeight: FontWeight.Bold, lineHeight: 56 },
    headline: { fontSize: 28, fontWeight: FontWeight.Medium, lineHeight: 36 },
    title: { fontSize: 20, fontWeight: FontWeight.Medium, lineHeight: 28 },
    body: { fontSize: 16, fontWeight: FontWeight.Normal, lineHeight: 24 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, lineHeight: 16 },
  }

  static Shapes = {
    small: 8,
    medium: 16,
    large: 24,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  }

  static ElevationMapping = {
    level1: { elevation: 1, radius: 3, dy: 1, opacity: 0.05 },
    level2: { elevation: 4, radius: 8, dy: 2, opacity: 0.08 },
    level3: { elevation: 8, radius: 12, dy: 4, opacity: 0.10 },
  }
}

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

  build() {
    Column() {
      Row() {
        Column()
          .width(28)
          .height(28)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(14)

        Text('My Wallet')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Column()
          .width(28)
          .height(28)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(14)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      .alignItems(VerticalAlign.Center)

      List() {
        ListItem() {
          this.BalanceCard()
        }

        ListItem() {
          this.ControlActionsRow()
        }

        ListItem() {
          this.ActivityHeader()
        }

        ForEach(this.transactions, (transaction: Transaction) => {
          ListItem() {
            TransactionCard({ transaction: transaction })
          }
        }, (transaction: Transaction) => transaction.id.toString())
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(AppTokens.Colors.background)

      this.BottomNavBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  BalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor('#B3FFFFFF')

      Text('$ 1,145.14')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Column()
          .width(10)
          .height(10)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(5)

        Text('+$234.10 today')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppTokens.Spacing.xs })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
  }

  @Builder
  ControlActionsRow() {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column() {
          Button() {
            Column()
              .width(24)
              .height(24)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.small)
          }
          .type(ButtonType.Normal)
          .width(64)
          .height(64)
          .borderRadius(32)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })

          Text(action.label)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.sm })
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      }, (action: ControlAction, index: number) => index.toString())
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .margin({ top: AppTokens.Spacing.lg })
  }

  @Builder
  ActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()

      Text('View All')
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(AppTokens.Colors.tertiary)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .margin({ top: AppTokens.Spacing.lg })
  }

  @Builder
  BottomNavBar() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column() {
          Column()
            .width(24)
            .height(24)
            .backgroundColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)
            .borderRadius(12)

          Text(item.label)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
        .onClick(() => {
          this.selectedNavItem = item.label
        })
      }, (item: NavItem) => item.label)
    }
    .width('100%')
    .height(64)
    .backgroundColor(AppTokens.Colors.surface)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: AppTokens.ElevationMapping.level3.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`, offsetY: -AppTokens.ElevationMapping.level3.dy })
  }
}

@Component
struct TransactionCard {
  private transaction: Transaction = { id: 0, name: '', detail: '', amount: '', isCredit: false }

  build() {
    Row() {
      Column()
        .width(48)
        .height(48)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Column() {
        Text(this.transaction.name)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.transaction.detail)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: AppTokens.Spacing.md })

      Text(this.transaction.amount)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .alignItems(VerticalAlign.Center)
  }
}