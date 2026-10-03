const NAME: string = '007_FinanceWallect_en'
const UI_TYPE: string = 'Finance Wallet'
const STYLE_THEME: string = 'High-Contrast Accessible'
const LANG: string = 'en'
const BASELINE_SIZE: string = '1280x720'

class AppColors {
  static readonly primary: string = '#1F2937'
  static readonly secondary: string = '#10B981'
  static readonly tertiary: string = '#3B82F6'
  static readonly background: string = '#F3F4F6'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E5E7EB'
  static readonly outline: string = '#D1D5DB'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#0B1220'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0B1220'
  static readonly onSurface: string = '#0B1220'
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 6
  static readonly lg: number = 8
  static readonly xl: number = 12
  static readonly xxl: number = 16
  static readonly xxxl: number = 24
}

class AppRadius {
  static readonly small: number = 6
  static readonly medium: number = 8
  static readonly large: number = 12
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

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 2, 0.5, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(2, 4, 1, 0.14)
  static readonly level3: ShadowSpec = new ShadowSpec(3, 6, 1.5, 0.16)
  static readonly level4: ShadowSpec = new ShadowSpec(4, 8, 2, 0.18)
  static readonly level5: ShadowSpec = new ShadowSpec(5, 10, 2.5, 0.2)
}

interface AccountCard {
  id: number
  name: string
  balance: string
  accent: string
}

interface TxItem {
  id: number
  title: string
  subtitle: string
  amount: string
  positive: boolean
}

@Entry
@Component
struct RootScreen {
  @State private showBalance: boolean = true
  @State private selected: string = 'Month'
  @State private flags: string[] = []

  private range: string[] = ['All', 'Week', 'Month', 'Year']

  private accounts: AccountCard[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: AppColors.secondary },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: AppColors.tertiary },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: AppColors.warning }
  ]

  private txs: TxItem[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ]

  private hasFlag(flag: string): boolean {
    return this.flags.indexOf(flag) >= 0
  }

  private toggleFlag(flag: string): void {
    if (this.hasFlag(flag)) {
      this.flags = this.flags.filter((item: string) => item !== flag)
    } else {
      this.flags = [...this.flags, flag]
    }
  }

  @Builder
  DisplayText(value: string, color: string = AppColors.onSurface) {
    Text(value)
      .fontSize(24)
      .fontWeight(FontWeight.SemiBold)
      .lineHeight(30)
      .fontColor(color)
  }

  @Builder
  HeadlineText(value: string, color: string = AppColors.onSurface) {
    Text(value)
      .fontSize(18)
      .fontWeight(FontWeight.SemiBold)
      .lineHeight(24)
      .fontColor(color)
  }

  @Builder
  TitleText(value: string, color: string = AppColors.onSurface) {
    Text(value)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .lineHeight(18)
      .fontColor(color)
  }

  @Builder
  BodyText(value: string, color: string = AppColors.onSurface) {
    Text(value)
      .fontSize(12)
      .fontWeight(FontWeight.Normal)
      .lineHeight(16)
      .fontColor(color)
  }

  @Builder
  LabelText(value: string, color: string = AppColors.onSurface) {
    Text(value)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .lineHeight(14)
      .fontColor(color)
  }

  @Builder
  TopBar() {
    Row({ space: AppSpacing.sm }) {
      Blank()
        .width(20)
        .height(20)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppRadius.small)

      this.DisplayText('Wallet')
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  FilterChip(label: string) {
    Button({ type: ButtonType.Normal }) {
      Text(label)
        .fontSize(this.selected === label ? 14 : 12)
        .fontWeight(this.selected === label ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(this.selected === label ? AppColors.onPrimary : AppColors.onSurface)
    }
    .height(32)
    .padding({ left: 12, right: 12 })
    .backgroundColor(this.selected === label ? AppColors.primary : AppColors.surface)
    .borderRadius(AppRadius.medium)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.selected = label
    })
  }

  @Builder
  AssistChip(label: string, active: boolean = false, darkText: boolean = false) {
    Button({ type: ButtonType.Normal }) {
      this.LabelText(label, active ? AppColors.onSecondary : darkText ? AppColors.onSecondary : AppColors.onSurface)
    }
    .height(30)
    .padding({ left: 10, right: 10 })
    .backgroundColor(active ? AppColors.secondary : AppColors.surface)
    .borderRadius(AppRadius.small)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  ToggleChip(label: string) {
    Button({ type: ButtonType.Normal }) {
      this.LabelText(label, this.hasFlag(label) ? AppColors.onSecondary : AppColors.onSurface)
    }
    .height(30)
    .padding({ left: 10, right: 10 })
    .backgroundColor(this.hasFlag(label) ? AppColors.secondary : AppColors.surface)
    .borderRadius(AppRadius.small)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.toggleFlag(label)
    })
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        this.LabelText('Total Balance')
        this.HeadlineText(this.showBalance ? '$26,395.75' : '•••••••')
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Normal }) {
        this.TitleText('Add Money', AppColors.onSecondary)
      }
      .width(140)
      .height(44)
      .backgroundColor(AppColors.secondary)
      .borderRadius(AppRadius.large)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevation.level3.radius,
      color: '#29000000',
      offsetX: 0,
      offsetY: AppElevation.level3.dy
    })
  }

  @Builder
  AccountItem(account: AccountCard) {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Row({ space: AppSpacing.sm }) {
          Blank()
            .width(16)
            .height(16)
            .backgroundColor(account.accent)
            .borderRadius(AppRadius.small)

          this.TitleText(account.name)
        }
        .alignItems(VerticalAlign.Center)

        Button({ type: ButtonType.Normal }) {
          this.LabelText('Manage', AppColors.onSecondary)
        }
        .height(30)
        .padding({ left: 10, right: 10 })
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppRadius.small)
        .border({ width: 1, color: AppColors.outline })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        this.HeadlineText(this.showBalance ? account.balance : '•••••••')
      }
      .width('100%')
      .aspectRatio(2.8)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppRadius.medium)

      Row({ space: AppSpacing.sm }) {
        Button({ type: ButtonType.Normal }) {
          this.LabelText('Transfer', AppColors.onSecondary)
        }
        .height(30)
        .padding({ left: 10, right: 10 })
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppRadius.small)
        .border({ width: 1, color: AppColors.outline })

        Button({ type: ButtonType.Normal }) {
          this.LabelText('Details')
        }
        .height(30)
        .padding({ left: 10, right: 10 })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppRadius.small)
        .border({ width: 1, color: AppColors.outline })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .constraintSize({ minHeight: 120 })
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: AppElevation.level2.radius,
      color: '#24000000',
      offsetX: 0,
      offsetY: AppElevation.level2.dy
    })
  }

  @Builder
  TransactionItem(tx: TxItem) {
    Row() {
      Row({ space: AppSpacing.md }) {
        Blank()
          .width(32)
          .height(32)
          .backgroundColor(tx.positive ? AppColors.success : AppColors.error)
          .borderRadius(AppRadius.small)

        Column({ space: AppSpacing.xs }) {
          this.TitleText(tx.title)
          this.BodyText(tx.subtitle)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      this.TitleText(tx.amount, tx.positive ? AppColors.success : AppColors.error)
    }
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: AppElevation.level1.radius,
      color: '#1F000000',
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
  }

  build() {
    Column() {
      this.TopBar()

      List({ space: AppSpacing.lg }) {
        ListItem() {
          Row() {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.range, (item: string) => {
                this.FilterChip(item)
              }, (item: string) => item)
            }
            .alignItems(VerticalAlign.Center)

            Row({ space: AppSpacing.sm }) {
              this.LabelText('Hide')

              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .selectedColor(AppColors.primary)
                .switchPointColor(AppColors.onPrimary)
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }

        ForEach(this.accounts, (account: AccountCard) => {
          ListItem() {
            this.AccountItem(account)
          }
        }, (account: AccountCard) => account.id.toString())

        ListItem() {
          Row() {
            this.HeadlineText('Recent Activity')

            Row({ space: AppSpacing.sm }) {
              this.ToggleChip('Income')
              this.ToggleChip('Expense')
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }

        ForEach(this.txs, (tx: TxItem) => {
          ListItem() {
            this.TransactionItem(tx)
          }
        }, (tx: TxItem) => tx.id.toString())

        ListItem() {
          Blank()
            .height(AppSpacing.xxl)
        }
      }
      .layoutWeight(1)
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.xxxl
      })
      .backgroundColor(AppColors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}