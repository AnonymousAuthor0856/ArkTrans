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

const Colors = {
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

const Spacing = {
  xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
}

@Entry
@Component
struct Index {
  @State showBalance: boolean = true
  @State selected: string = 'Month'
  @State flags: string[] = []
  private range: string[] = ['All', 'Week', 'Month', 'Year']
  private accounts: AccountCard[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ]
  private txs: TxItem[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ]

  toggleFlag(label: string): void {
    const i = this.flags.indexOf(label)
    if (i >= 0) {
      this.flags.splice(i, 1)
    } else {
      this.flags.push(label)
    }
  }

  build() {
    Column() {
      Row() {
        Blank()
          .width(20)
          .height(20)
          .backgroundColor(Colors.primary)
          .borderRadius(6)
        Text('Wallet')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column({ space: Spacing.lg }) {
          Row() {
            Row({ space: Spacing.sm }) {
              ForEach(this.range, (r: string) => {
                Button(r)
                  .fontSize(this.selected === r ? 14 : 12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selected === r ? Colors.onPrimary : Colors.onSurface)
                  .backgroundColor(this.selected === r ? Colors.primary : Colors.surface)
                  .borderRadius(8)
                  .border({ width: 1, color: Colors.outline })
                  .height(36)
                  .padding({ left: Spacing.xl, right: Spacing.xl })
                  .onClick(() => { this.selected = r })
              }, (r: string) => r)
            }
            .alignItems(VerticalAlign.Center)

            Row({ space: Spacing.sm }) {
              Text('Hide')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .selectedColor(Colors.primary)
                .onChange((isOn: boolean) => { this.showBalance = !isOn })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          ForEach(this.accounts, (a: AccountCard) => {
            Column({ space: Spacing.sm }) {
              Row() {
                Row({ space: Spacing.sm }) {
                  Blank().width(16).height(16).backgroundColor(a.accent).borderRadius(6)
                  Text(a.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                }
                .alignItems(VerticalAlign.Center)

                Button('Manage')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSecondary)
                  .backgroundColor(Colors.secondary)
                  .borderRadius(6)
                  .border({ width: 1, color: Colors.outline })
                  .height(32)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Stack() {
                Text(this.showBalance ? a.balance : '•••••••')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Colors.onSurface)
              }
              .width('100%')
              .aspectRatio(2.8)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(8)

              Row({ space: Spacing.sm }) {
                Button('Transfer')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSecondary)
                  .backgroundColor(Colors.secondary)
                  .borderRadius(6)
                  .border({ width: 1, color: Colors.outline })
                  .height(32)
                Button('Details')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .backgroundColor(Colors.surface)
                  .borderRadius(6)
                  .border({ width: 1, color: Colors.outline })
                  .height(32)
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .backgroundColor(Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: Colors.outline })
            .padding(Spacing.lg)
            .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
            .alignItems(HorizontalAlign.Start)
          }, (a: AccountCard) => a.id.toString())

          Row() {
            Text('Recent Activity')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            Row({ space: Spacing.sm }) {
              Button('Income')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.flags.indexOf('Income') >= 0 ? Colors.onSecondary : Colors.onSurface)
                .backgroundColor(this.flags.indexOf('Income') >= 0 ? Colors.secondary : Colors.surface)
                .borderRadius(6)
                .border({ width: 1, color: Colors.outline })
                .height(32)
                .onClick(() => { this.toggleFlag('Income') })
              Button('Expense')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.flags.indexOf('Expense') >= 0 ? Colors.onSecondary : Colors.onSurface)
                .backgroundColor(this.flags.indexOf('Expense') >= 0 ? Colors.secondary : Colors.surface)
                .borderRadius(6)
                .border({ width: 1, color: Colors.outline })
                .height(32)
                .onClick(() => { this.toggleFlag('Expense') })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          ForEach(this.txs, (t: TxItem) => {
            Row() {
              Row({ space: Spacing.md }) {
                Blank()
                  .width(32)
                  .height(32)
                  .backgroundColor(t.positive ? Colors.success : Colors.error)
                  .borderRadius(6)
                Column({ space: Spacing.xs }) {
                  Text(t.title)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(t.subtitle)
                    .fontSize(12)
                    .fontColor(Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .alignItems(VerticalAlign.Center)

              Text(t.amount)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(t.positive ? Colors.success : Colors.error)
            }
            .width('100%')
            .backgroundColor(Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: Colors.outline })
            .padding(Spacing.lg)
            .shadow({ radius: 2, color: '#20000000', offsetY: 0.5 })
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }, (t: TxItem) => t.id.toString())

          Blank().height(Spacing.xxl)
        }
        .width('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)

      Row() {
        Column({ space: Spacing.xs }) {
          Text('Total Balance')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text(this.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Add Money')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .backgroundColor(Colors.secondary)
          .borderRadius(12)
          .height(44)
          .width(140)
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
