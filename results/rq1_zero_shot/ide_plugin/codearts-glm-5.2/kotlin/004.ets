const AppColors = {
  primary: '#1F2937',
  secondary: '#10B981',
  tertiary: '#3B82F6',
  background: '#F3F4F6',
  surface: '#FFFFFF',
  surfaceVariant: '#E5E7EB',
  outline: '#D1D5DB',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#0B1220',
  onTertiary: '#FFFFFF',
  onBackground: '#0B1220',
  onSurface: '#0B1220'
}

const AppSpacing = {
  xs: 2,
  sm: 4,
  md: 6,
  lg: 8,
  xl: 12,
  xxl: 16,
  xxxl: 24
}

interface AccountCardUi {
  id: number
  name: string
  balance: string
  accent: string
}

interface TxItemUi {
  id: number
  title: string
  subtitle: string
  amount: string
  positive: boolean
}

@Component
struct AccountCardView {
  private account: AccountCardUi = { id: 0, name: '', balance: '', accent: '' }
  @Prop showBalance: boolean

  build() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Row({ space: AppSpacing.sm }) {
          Column()
            .width(16)
            .height(16)
            .backgroundColor(this.account.accent)
            .borderRadius(4)
          Text(this.account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(VerticalAlign.Center)

        Text('Manage')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .border({ width: 1, color: AppColors.outline, radius: 4 })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(this.showBalance ? this.account.balance : '•••••••')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .aspectRatio(2.8)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(8)
        .textAlign(TextAlign.Center)

      Row({ space: AppSpacing.sm }) {
        Text('Transfer')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .border({ width: 1, color: AppColors.outline, radius: 4 })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        Text('Details')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surface)
          .border({ width: 1, color: AppColors.outline, radius: 4 })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
  }
}

@Component
struct TxItemView {
  private tx: TxItemUi = { id: 0, title: '', subtitle: '', amount: '', positive: false }

  build() {
    Row() {
      Row({ space: AppSpacing.md }) {
        Column()
          .width(32)
          .height(32)
          .backgroundColor(this.tx.positive ? AppColors.success : AppColors.error)
          .borderRadius(4)
        Column({ space: AppSpacing.xs }) {
          Text(this.tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(this.tx.subtitle)
            .fontSize(12)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)

      Text(this.tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.tx.positive ? AppColors.success : AppColors.error)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct Index {
  @State showBalance: boolean = true
  @State selected: string = 'Month'
  @State flags: string[] = []
  private range: string[] = ['All', 'Week', 'Month', 'Year']
  private accounts: AccountCardUi[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ]
  private txs: TxItemUi[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ]

  build() {
    Column() {
      Row({ space: AppSpacing.sm }) {
        Column()
          .width(20)
          .height(20)
          .backgroundColor(AppColors.primary)
          .borderRadius(4)
        Text('Wallet')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .padding(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      List({ space: AppSpacing.lg }) {
        ListItem() {
          this.RangeAndHideRow()
        }

        ForEach(this.accounts, (a: AccountCardUi) => {
          ListItem() {
            AccountCardView({ account: a, showBalance: this.showBalance })
          }
        }, (a: AccountCardUi) => a.id.toString())

        ListItem() {
          this.RecentActivityHeader()
        }

        ForEach(this.txs, (t: TxItemUi) => {
          ListItem() {
            TxItemView({ tx: t })
          }
        }, (t: TxItemUi) => t.id.toString())

        ListItem() {
          Blank().height(AppSpacing.xxl)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.xxxl })
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  RangeAndHideRow() {
    Row() {
      Row({ space: AppSpacing.sm }) {
        ForEach(this.range, (r: string) => {
          Text(r)
            .fontSize(r === this.selected ? 14 : 12)
            .fontWeight(r === this.selected ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(r === this.selected ? AppColors.onPrimary : AppColors.onSurface)
            .backgroundColor(r === this.selected ? AppColors.primary : AppColors.surface)
            .border({ width: 1, color: AppColors.outline, radius: 8 })
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .onClick(() => {
              this.selected = r
            })
        }, (r: string) => r)
      }
      .alignItems(VerticalAlign.Center)

      Row({ space: AppSpacing.sm }) {
        Text('Hide')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
          .selectedColor(AppColors.primary)
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

  @Builder
  RecentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Row({ space: AppSpacing.sm }) {
        Text('Income')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.flags.includes('Income') ? AppColors.onSecondary : AppColors.onSurface)
          .backgroundColor(this.flags.includes('Income') ? AppColors.secondary : AppColors.surface)
          .border({ width: 1, color: AppColors.outline, radius: 4 })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .onClick(() => {
            const idx = this.flags.indexOf('Income')
            if (idx >= 0) {
              this.flags.splice(idx, 1)
            } else {
              this.flags.push('Income')
            }
          })
        Text('Expense')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.flags.includes('Expense') ? AppColors.onSecondary : AppColors.onSurface)
          .backgroundColor(this.flags.includes('Expense') ? AppColors.secondary : AppColors.surface)
          .border({ width: 1, color: AppColors.outline, radius: 4 })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .onClick(() => {
            const idx = this.flags.indexOf('Expense')
            if (idx >= 0) {
              this.flags.splice(idx, 1)
            } else {
              this.flags.push('Expense')
            }
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Total Balance')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.showBalance ? '$26,395.75' : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Add Money')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
        .height(44)
        .width(140)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}