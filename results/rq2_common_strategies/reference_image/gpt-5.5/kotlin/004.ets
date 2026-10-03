class AccountCard {
  id: number
  name: string
  balance: string
  accent: string

  constructor(id: number, name: string, balance: string, accent: string) {
    this.id = id
    this.name = name
    this.balance = balance
    this.accent = accent
  }
}

class TxItem {
  id: number
  title: string
  subtitle: string
  amount: string
  positive: boolean

  constructor(id: number, title: string, subtitle: string, amount: string, positive: boolean) {
    this.id = id
    this.title = title
    this.subtitle = subtitle
    this.amount = amount
    this.positive = positive
  }
}

const PRIMARY: string = '#1F2937'
const SECONDARY: string = '#10B981'
const TERTIARY: string = '#3B82F6'
const BACKGROUND: string = '#F3F4F6'
const SURFACE: string = '#FFFFFF'
const SURFACE_VARIANT: string = '#E5E7EB'
const OUTLINE: string = '#D1D5DB'
const SUCCESS: string = '#16A34A'
const WARNING: string = '#F59E0B'
const ERROR: string = '#EF4444'
const ON_SECONDARY: string = '#0B1220'
const ON_SURFACE: string = '#0B1220'

@Entry
@Component
struct FinanceWalletPage {
  @State showBalance: boolean = true
  @State selected: string = 'Month'
  @State flags: string[] = []

  private ranges: string[] = ['All', 'Week', 'Month', 'Year']

  private accounts: AccountCard[] = [
    new AccountCard(1, 'Wallet', '$2,845.20', SECONDARY),
    new AccountCard(2, 'Savings', '$8,120.00', TERTIARY),
    new AccountCard(3, 'Investments', '$15,430.55', WARNING)
  ]

  private txs: TxItem[] = [
    new TxItem(1, 'Grocery Market', 'Today • 12:40', '-$32.18', false),
    new TxItem(2, 'Salary', 'Yesterday • 09:00', '+$3,200.00', true),
    new TxItem(3, 'Coffee Shop', 'Yesterday • 15:22', '-$4.90', false),
    new TxItem(4, 'ETF Purchase', 'Mon • 10:05', '-$250.00', false),
    new TxItem(5, 'Refund', 'Sun • 18:40', '+$18.99', true)
  ]

  private chipWidth(label: string): number {
    if (label === 'All') {
      return 46
    }
    if (label === 'Week') {
      return 62
    }
    if (label === 'Month') {
      return 72
    }
    return 56
  }

  private isFlagSelected(flag: string): boolean {
    return this.flags.includes(flag)
  }

  private toggleFlag(flag: string): void {
    if (this.flags.includes(flag)) {
      const next: string[] = []
      this.flags.forEach((item: string) => {
        if (item !== flag) {
          next.push(item)
        }
      })
      this.flags = next
    } else {
      const next: string[] = this.flags.slice()
      next.push(flag)
      this.flags = next
    }
  }

  @Builder
  TopBar() {
    Row() {
      Row() {
        Row()
          .width(20)
          .height(20)
          .borderRadius(6)
          .backgroundColor(PRIMARY)

        Text('Wallet')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE)
          .lineHeight(30)
          .margin({ left: 4 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(88)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE)
  }

  @Builder
  FilterChip(label: string) {
    Row() {
      Text(label)
        .fontSize(label === this.selected ? 14 : 12)
        .fontWeight(label === this.selected ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(label === this.selected ? '#FFFFFF' : ON_SURFACE)
    }
    .width(this.chipWidth(label))
    .height(32)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(8)
    .backgroundColor(label === this.selected ? PRIMARY : SURFACE)
    .border({ width: 1, color: OUTLINE })
    .margin({ right: label === 'Year' ? 0 : 6 })
    .onClick(() => {
      this.selected = label
    })
  }

  @Builder
  AssistChip(label: string, filled: boolean, widthValue: number, rightMargin: number) {
    Row() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(filled ? ON_SECONDARY : ON_SURFACE)
        .lineHeight(14)
    }
    .width(widthValue)
    .height(32)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(6)
    .backgroundColor(filled ? SECONDARY : SURFACE)
    .border({ width: 1, color: OUTLINE })
    .margin({ right: rightMargin })
    .onClick(() => {
    })
  }

  @Builder
  FilterFlagChip(label: string) {
    Row() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isFlagSelected(label) ? ON_SECONDARY : ON_SURFACE)
        .lineHeight(14)
    }
    .height(32)
    .padding({ left: 10, right: 10 })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(6)
    .backgroundColor(this.isFlagSelected(label) ? SECONDARY : SURFACE)
    .border({ width: 1, color: OUTLINE })
    .margin({ left: 4 })
    .onClick(() => {
      this.toggleFlag(label)
    })
  }

  @Builder
  FilterRow() {
    Row() {
      Row() {
        ForEach(this.ranges, (item: string) => {
          this.FilterChip(item)
        }, (item: string) => item)
      }
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('Hide')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
          .lineHeight(14)
          .margin({ right: 6 })

        Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
          .width(52)
          .height(32)
          .selectedColor(PRIMARY)
          .switchPointColor('#CBD5E1')
          .onChange((isOn: boolean) => {
            this.showBalance = !isOn
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(64)
    .padding({ left: 8, right: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  AccountCardView(account: AccountCard) {
    Column() {
      Row() {
        Row() {
          Row()
            .width(16)
            .height(16)
            .borderRadius(6)
            .backgroundColor(account.accent)

          Text(account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE)
            .lineHeight(18)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)

        this.AssistChip('Manage', true, 68, 0)
      }
      .width('100%')
      .height(32)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        Text(this.showBalance ? account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE)
          .lineHeight(24)
      }
      .width('100%')
      .height(117)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .borderRadius(12)
      .backgroundColor(SURFACE_VARIANT)
      .margin({ top: 8 })

      Row() {
        this.AssistChip('Transfer', true, 69, 8)
        this.AssistChip('Details', false, 62, 0)
      }
      .width('100%')
      .height(32)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 8 })
    }
    .width('100%')
    .height(236)
    .padding(16)
    .borderRadius(12)
    .backgroundColor(SURFACE)
    .border({ width: 1, color: OUTLINE })
    .shadow({ radius: 4, color: '#33000000', offsetX: 0, offsetY: 1 })
    .margin({ left: 8, right: 8, bottom: 8 })
  }

  @Builder
  RecentHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE)
        .lineHeight(24)

      Row() {
        this.FilterFlagChip('Income')
        this.FilterFlagChip('Expense')
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(48)
    .padding({ left: 8, right: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TxRow(item: TxItem) {
    Row() {
      Row() {
        Row()
          .width(32)
          .height(32)
          .borderRadius(6)
          .backgroundColor(item.positive ? SUCCESS : ERROR)

        Column() {
          Text(item.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE)
            .lineHeight(18)

          Text(item.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Regular)
            .fontColor(ON_SURFACE)
            .lineHeight(16)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 6 })
      }
      .alignItems(VerticalAlign.Center)

      Text(item.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(item.positive ? SUCCESS : ERROR)
        .lineHeight(18)
    }
    .width('100%')
    .minHeight(72)
    .padding(8)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .borderRadius(12)
    .backgroundColor(SURFACE)
    .border({ width: 1, color: OUTLINE })
    .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 1 })
    .margin({ left: 8, right: 8, bottom: 8 })
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Total Balance')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
          .lineHeight(14)

        Text(this.showBalance ? '$26,395.75' : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE)
          .lineHeight(24)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Add Money', { type: ButtonType.Normal, stateEffect: true })
        .width(140)
        .height(44)
        .borderRadius(22)
        .backgroundColor(SECONDARY)
        .fontColor(ON_SECONDARY)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(62)
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE)
    .shadow({ radius: 6, color: '#26000000', offsetX: 0, offsetY: -1 })
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        Scroll() {
          Column() {
            this.FilterRow()

            ForEach(this.accounts, (account: AccountCard) => {
              this.AccountCardView(account)
            }, (account: AccountCard) => account.id.toString())

            this.RecentHeader()

            ForEach(this.txs, (item: TxItem) => {
              this.TxRow(item)
            }, (item: TxItem) => item.id.toString())

            Row()
              .width('100%')
              .height(16)
          }
          .width('100%')
        }
        .width('100%')
        .height('100%')
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(BACKGROUND)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}