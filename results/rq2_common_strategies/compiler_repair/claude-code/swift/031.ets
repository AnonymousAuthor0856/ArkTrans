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

interface ColorTokens {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  success: string
  warning: string
  error: string
  onPrimary: string
  onSecondary: string
  onTertiary: string
  onBackground: string
  onSurface: string
}

interface SpacingTokens {
  xs: number
  sm: number
  md: number
  lg: number
  xl: number
  xxl: number
}

interface ShapeTokens {
  small: number
  medium: number
  large: number
}

interface ElevationLevel {
  radius: number
  dy: number
  color: string
}

interface ElevationTokens {
  level1: ElevationLevel
  level2: ElevationLevel
  level3: ElevationLevel
}

class AppTokens {
  static readonly Colors: ColorTokens = {
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

  static readonly Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  }

  static readonly Shapes: ShapeTokens = {
    small: 8,
    medium: 16,
    large: 24,
  }

  static readonly Elevation: ElevationTokens = {
    level1: { radius: 3, dy: 1, color: 'rgba(0, 0, 0, 0.05)' },
    level2: { radius: 8, dy: 2, color: 'rgba(0, 0, 0, 0.08)' },
    level3: { radius: 12, dy: 4, color: 'rgba(0, 0, 0, 0.10)' },
  }
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
    Stack() {
      Column() {
        this.TopAppBar()

        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            this.TotalBalanceCard()

            this.ControlActionsRow()

            this.RecentActivityHeader()

            ForEach(this.transactions, (item: Transaction) => {
              this.TransactionCard(item)
            }, (item: Transaction) => item.id.toString())
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md,
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm,
          })
        }
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Vertical)
        .layoutWeight(1)

        this.BottomNavigationBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  TopAppBar() {
    Row() {
      Button() {
        Circle()
          .width(28)
          .height(28)
          .fill(AppTokens.Colors.surfaceVariant)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .padding(0)

      Blank()

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Button() {
        Circle()
          .width(28)
          .height(28)
          .fill(AppTokens.Colors.surfaceVariant)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .padding(0)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
  }

  @Builder
  TotalBalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.onPrimary)
        .opacity(0.7)

      Blank().height(AppTokens.Spacing.sm)

      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onPrimary)
        .letterSpacing(-0.5)

      Blank().height(AppTokens.Spacing.xs)

      Row({ space: AppTokens.Spacing.sm }) {
        Circle()
          .width(10)
          .height(10)
          .fill(AppTokens.Colors.secondary)

        Text('+$234.10 today')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level2.radius,
      color: AppTokens.Elevation.level2.color,
      offsetX: 0,
      offsetY: AppTokens.Elevation.level2.dy,
    })
  }

  @Builder
  ControlActionsRow() {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppTokens.Spacing.sm }) {
          Button() {
            Column() {
              Stack() {
              }
              .width(24)
              .height(24)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.small)
            }
            .width(64)
            .height(64)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(32)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .padding(0)
          .shadow({
            radius: AppTokens.Elevation.level1.radius,
            color: AppTokens.Elevation.level1.color,
            offsetX: 0,
            offsetY: AppTokens.Elevation.level1.dy,
          })

          Text(action.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .letterSpacing(0.2)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }, (action: ControlAction) => action.label)
    }
    .width('100%')
  }

  @Builder
  RecentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Button() {
        Text('View All')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.tertiary)
          .letterSpacing(0.2)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .padding(0)
    }
    .width('100%')
  }

  @Builder
  TransactionCard(transaction: Transaction) {
    Row({ space: AppTokens.Spacing.md }) {
      Stack() {
      }
      .width(48)
      .height(48)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)

      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.tertiary)
          .letterSpacing(0.2)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
  }

  @Builder
  BottomNavigationBar() {
    Row({ space: 0 }) {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          Column({ space: AppTokens.Spacing.xs }) {
            Circle()
              .width(24)
              .height(24)
              .fill(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)

            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
              .letterSpacing(0.2)
          }
          .width('100%')
          .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(this.selectedNavItem === item.label ? AppTokens.Colors.surfaceVariant : Color.Transparent)
          .borderRadius(AppTokens.Shapes.medium)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .padding(0)
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
      radius: AppTokens.Elevation.level3.radius,
      color: AppTokens.Elevation.level3.color,
      offsetX: 0,
      offsetY: AppTokens.Elevation.level3.dy,
    })
  }
}
