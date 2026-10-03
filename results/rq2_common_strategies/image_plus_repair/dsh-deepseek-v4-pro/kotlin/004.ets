// Finance Wallet — translated from Kotlin/Jetpack Compose (004.kt)
// High-Contrast Accessible theme

const PRIMARY = '#1F2937'
const SECONDARY = '#10B981'
const TERTIARY = '#3B82F6'
const BACKGROUND = '#F3F4F6'
const SURFACE = '#FFFFFF'
const SURFACE_VARIANT = '#E5E7EB'
const OUTLINE = '#D1D5DB'
const SUCCESS = '#16A34A'
const WARNING = '#F59E0B'
const ERROR = '#EF4444'
const ON_PRIMARY = '#FFFFFF'
const ON_SECONDARY = '#0B1220'
const ON_TERTIARY = '#FFFFFF'
const ON_BACKGROUND = '#0B1220'
const ON_SURFACE = '#0B1220'

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

@Entry
@Component
struct FinanceWalletPage {
  @State showBalance: boolean = true
  @State selected: string = 'Month'
  @State flags: string[] = []
  private range: string[] = ['All', 'Week', 'Month', 'Year']
  private accounts: AccountCard[] = [
    new AccountCard(1, 'Wallet', '$2,845.20', '#10B981'),
    new AccountCard(2, 'Savings', '$8,120.00', '#3B82F6'),
    new AccountCard(3, 'Investments', '$15,430.55', '#F59E0B')
  ]
  private txs: TxItem[] = [
    new TxItem(1, 'Grocery Market', 'Today • 12:40', '-$32.18', false),
    new TxItem(2, 'Salary', 'Yesterday • 09:00', '+$3,200.00', true),
    new TxItem(3, 'Coffee Shop', 'Yesterday • 15:22', '-$4.90', false),
    new TxItem(4, 'ETF Purchase', 'Mon • 10:05', '-$250.00', false),
    new TxItem(5, 'Refund', 'Sun • 18:40', '+$18.99', true)
  ]

  @Builder
  FilterChipItem(r: string) {
    Text(r)
      .fontSize(this.selected === r ? 14 : 12)
      .fontWeight(this.selected === r ? 500 : 400)
      .fontColor(this.selected === r ? ON_PRIMARY : ON_SURFACE)
      .backgroundColor(this.selected === r ? PRIMARY : SURFACE)
      .borderRadius(8)
      .border({ width: 1, color: OUTLINE })
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .onClick(() => {
        this.selected = r
      })
  }

  @Builder
  FlagChip(label: string) {
    Text(label)
      .fontSize(10)
      .fontWeight(500)
      .fontColor(this.flags.indexOf(label) >= 0 ? ON_SECONDARY : ON_SURFACE)
      .backgroundColor(this.flags.indexOf(label) >= 0 ? SECONDARY : SURFACE)
      .borderRadius(6)
      .border({ width: 1, color: OUTLINE })
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .onClick(() => {
        if (this.flags.indexOf(label) >= 0) {
          this.flags = this.flags.filter((f: string) => f !== label)
        } else {
          this.flags = this.flags.concat(label)
        }
      })
  }

  @Builder
  AccountCardItem(a: AccountCard) {
    Column({ space: 4 }) {
      Row() {
        Row({ space: 4 }) {
          Row()
            .width(16)
            .height(16)
            .backgroundColor(a.accent)
            .borderRadius(6)
          Text(a.name)
            .fontSize(14)
            .fontWeight(500)
            .fontColor(ON_SURFACE)
        }
        .alignItems(VerticalAlign.Center)

        Text('Manage')
          .fontSize(10)
          .fontWeight(500)
          .fontColor(ON_SECONDARY)
          .backgroundColor(SECONDARY)
          .borderRadius(6)
          .border({ width: 1, color: OUTLINE })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.showBalance ? a.balance : '•••••••')
          .fontSize(18)
          .fontWeight(600)
          .fontColor(ON_SURFACE)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(SURFACE_VARIANT)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Row({ space: 4 }) {
        Text('Transfer')
          .fontSize(10)
          .fontWeight(500)
          .fontColor(ON_SECONDARY)
          .backgroundColor(SECONDARY)
          .borderRadius(6)
          .border({ width: 1, color: OUTLINE })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        Text('Details')
          .fontSize(10)
          .fontWeight(500)
          .fontColor(ON_SURFACE)
          .backgroundColor(SURFACE)
          .borderRadius(6)
          .border({ width: 1, color: OUTLINE })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(8)
    .backgroundColor(SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: OUTLINE })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 1 })
    .constraintSize({ minHeight: 120 })
  }

  @Builder
  TxItemRow(t: TxItem) {
    Row() {
      Row({ space: 6 }) {
        Row()
          .width(32)
          .height(32)
          .backgroundColor(t.positive ? SUCCESS : ERROR)
          .borderRadius(6)
        Column({ space: 2 }) {
          Text(t.title)
            .fontSize(14)
            .fontWeight(500)
            .fontColor(ON_SURFACE)
          Text(t.subtitle)
            .fontSize(12)
            .fontWeight(400)
            .fontColor(ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Text(t.amount)
        .fontSize(14)
        .fontWeight(500)
        .fontColor(t.positive ? SUCCESS : ERROR)
    }
    .width('100%')
    .padding(8)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: OUTLINE })
    .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 1 })
    .constraintSize({ minHeight: 72 })
  }

  build() {
    Column() {
      // Top app bar
      Row() {
        Row({ space: 4 }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(PRIMARY)
            .borderRadius(6)
          Text('Wallet')
            .fontSize(24)
            .fontWeight(600)
            .fontColor(ON_SURFACE)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(SURFACE)

      // Scrollable content
      Scroll() {
        Column({ space: 8 }) {
          // Range filter chips + hide switch
          Row() {
            Row({ space: 4 }) {
              ForEach(this.range, (r: string) => {
                this.FilterChipItem(r)
              }, (r: string) => r)
            }
            .alignItems(VerticalAlign.Center)

            Row({ space: 4 }) {
              Text('Hide')
                .fontSize(10)
                .fontWeight(500)
                .fontColor(ON_SURFACE)
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn
                })
                .selectedColor(PRIMARY)
                .switchPointColor(ON_PRIMARY)
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Account cards
          ForEach(this.accounts, (a: AccountCard) => {
            this.AccountCardItem(a)
          }, (a: AccountCard) => a.id.toString())

          // Recent Activity header
          Row() {
            Text('Recent Activity')
              .fontSize(18)
              .fontWeight(600)
              .fontColor(ON_SURFACE)
            Row({ space: 4 }) {
              this.FlagChip('Income')
              this.FlagChip('Expense')
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Transaction items
          ForEach(this.txs, (t: TxItem) => {
            this.TxItemRow(t)
          }, (t: TxItem) => t.id.toString())

          // Bottom spacer
          Row().height(16)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 24 })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollable(ScrollDirection.Vertical)

      // Bottom bar
      Row() {
        Column({ space: 2 }) {
          Text('Total Balance')
            .fontSize(10)
            .fontWeight(500)
            .fontColor(ON_SURFACE)
          Text(this.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(18)
            .fontWeight(600)
            .fontColor(ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Add Money')
          .height(44)
          .width(140)
          .fontSize(14)
          .fontWeight(500)
          .fontColor(ON_SECONDARY)
          .backgroundColor(SECONDARY)
          .borderRadius(12)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(SURFACE)
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
