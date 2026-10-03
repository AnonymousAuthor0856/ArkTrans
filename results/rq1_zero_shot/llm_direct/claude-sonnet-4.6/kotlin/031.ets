import { router } from '@kit.ArkUI'

// Token definitions
const Colors = {
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

const Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
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

  @Builder
  BalanceCard() {
    Column() {
      Column({ space: Spacing.sm }) {
        Text('Total Balance')
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor('#B3FFFFFF')
          .lineHeight(24)

        Text('$ 1,145.14')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onPrimary)
          .lineHeight(56)

        Row({ space: Spacing.sm }) {
          Circle({ width: 10, height: 10 })
            .fill(Colors.secondary)

          Text('+$234.10 today')
            .fontSize(16)
            .fontWeight(FontWeight.Normal)
            .fontColor(Colors.secondary)
            .lineHeight(24)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(Spacing.lg)
    }
    .width('100%')
    .backgroundColor(Colors.primary)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#14000000', offsetY: 2 })
  }

  @Builder
  ControlActions() {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: Spacing.sm }) {
          Button({ type: ButtonType.Circle }) {
            Column() {
              Rect({ width: 24, height: 24 })
                .fill(Colors.primary)
                .radius(8)
            }
            .width(24)
            .height(24)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .width(64)
          .height(64)
          .backgroundColor(Colors.surface)
          .shadow({ radius: 3, color: '#0D000000', offsetY: 1 })

          Text(action.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onBackground)
            .lineHeight(16)
            .letterSpacing(0.2)
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  RecentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onBackground)
        .lineHeight(28)

      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.tertiary)
        .lineHeight(16)
        .letterSpacing(0.2)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TransactionItem(transaction: Transaction) {
    Row({ space: Spacing.md }) {
      Column()
        .width(48)
        .height(48)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(16)

      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .lineHeight(24)

        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.tertiary)
          .lineHeight(16)
          .letterSpacing(0.2)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(transaction.isCredit ? Colors.success : Colors.onSurface)
        .lineHeight(24)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(Spacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.surface)
    .borderRadius(16)
    .border({ width: 1, color: Colors.outline })
  }

  @Builder
  TopBar() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Column()
          .width(28)
          .height(28)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(14)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onBackground)
        .lineHeight(28)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Button({ type: ButtonType.Circle }) {
        Column()
          .width(28)
          .height(28)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(14)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(56)
    .padding({ left: Spacing.md, right: Spacing.md })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.Transparent)
  }

  @Builder
  BottomNav() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: Spacing.xs }) {
          Circle({ width: 24, height: 24 })
            .fill(this.selectedNavItem === item.label ? Colors.primary : Colors.outline)

          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNavItem === item.label ? Colors.primary : Colors.tertiary)
            .lineHeight(16)
            .letterSpacing(0.2)
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .height(64)
        .onClick(() => {
          this.selectedNavItem = item.label
        })
      })
    }
    .width('100%')
    .backgroundColor(Colors.surface)
    .shadow({ radius: 12, color: '#1A000000', offsetY: -4 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: Spacing.lg }) {
          this.BalanceCard()
          this.ControlActions()
          this.RecentActivityHeader()

          ForEach(this.transactions, (transaction: Transaction) => {
            this.TransactionItem(transaction)
          })
        }
        .width('100%')
        .padding({
          left: Spacing.md,
          right: Spacing.md,
          top: Spacing.sm,
          bottom: Spacing.sm
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)

      this.BottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}