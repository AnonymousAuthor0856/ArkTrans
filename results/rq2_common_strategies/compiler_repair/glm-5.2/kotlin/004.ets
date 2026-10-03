// 007_FinanceWallect_en - Finance Wallet - High-Contrast Accessible - en - 1280x720

interface AccountCard {
  id: number;
  name: string;
  balance: string;
  accent: ResourceColor;
}

interface TxItem {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;
}

@Entry
@Component
struct RootScreen {
  @State showBalance: boolean = true;
  @State selected: string = 'Month';
  @State flags: string[] = [];
  private range: string[] = ['All', 'Week', 'Month', 'Year'];
  private accounts: AccountCard[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ];
  private txs: TxItem[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Column()
            .width(20)
            .height(20)
            .backgroundColor('#1F2937')
            .borderRadius(6)

          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .margin({ left: 4 })
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // Content List
      Scroll() {
        Column() {
          // Filters and Hide Balance
          Row() {
            Row() {
              ForEach(this.range, (r: string) => {
                Text(r)
                  .fontSize(this.selected === r ? 14 : 12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selected === r ? '#FFFFFF' : '#0B1220')
                  .backgroundColor(this.selected === r ? '#1F2937' : '#FFFFFF')
                  .borderRadius(8)
                  .border({ width: 1, color: '#D1D5DB' })
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .margin({ right: 4 })
                  .onClick(() => {
                    this.selected = r;
                  })
              })
            }

            Row() {
              Text('Hide')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
                .margin({ right: 4 })

              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .selectedColor('#1F2937')
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn;
                })
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ bottom: 8 })

          // Account Cards
          ForEach(this.accounts, (a: AccountCard) => {
            Column() {
              Row() {
                Row() {
                  Column()
                    .width(16)
                    .height(16)
                    .backgroundColor(a.accent)
                    .borderRadius(6)

                  Text(a.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                    .margin({ left: 4 })
                }

                Text('Manage')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                  .backgroundColor('#10B981')
                  .borderRadius(6)
                  .border({ width: 1, color: '#D1D5DB' })
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ bottom: 4 })

              Row() {
                Text(this.showBalance ? a.balance : '•••••••')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
              }
              .width('100%')
              .height(80)
              .backgroundColor('#E5E7EB')
              .borderRadius(8)
              .justifyContent(FlexAlign.Center)
              .margin({ top: 4, bottom: 4 })

              Row() {
                Text('Transfer')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                  .backgroundColor('#10B981')
                  .borderRadius(6)
                  .border({ width: 1, color: '#D1D5DB' })
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .margin({ right: 4 })

                Text('Details')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                  .backgroundColor('#FFFFFF')
                  .borderRadius(6)
                  .border({ width: 1, color: '#D1D5DB' })
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              }
              .margin({ top: 4 })
            }
            .width('100%')
            .padding(8)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .border({ width: 1, color: '#D1D5DB' })
            .margin({ bottom: 8 })
          })

          // Recent Activity Header
          Row() {
            Text('Recent Activity')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')

            Row() {
              Text('Income')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.flags.includes('Income') ? '#0B1220' : '#0B1220')
                .backgroundColor(this.flags.includes('Income') ? '#10B981' : '#FFFFFF')
                .borderRadius(6)
                .border({ width: 1, color: '#D1D5DB' })
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .margin({ right: 4 })
                .onClick(() => {
                  if (this.flags.includes('Income')) {
                    this.flags = this.flags.filter(f => f !== 'Income');
                  } else {
                    this.flags.push('Income');
                  }
                })

              Text('Expense')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
                .backgroundColor(this.flags.includes('Expense') ? '#10B981' : '#FFFFFF')
                .borderRadius(6)
                .border({ width: 1, color: '#D1D5DB' })
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .onClick(() => {
                  if (this.flags.includes('Expense')) {
                    this.flags = this.flags.filter(f => f !== 'Expense');
                  } else {
                    this.flags.push('Expense');
                  }
                })
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 8, bottom: 8 })

          // Transaction Items
          ForEach(this.txs, (t: TxItem) => {
            Row() {
              Row() {
                Column()
                  .width(32)
                  .height(32)
                  .backgroundColor(t.positive ? '#16A34A' : '#EF4444')
                  .borderRadius(6)

                Column() {
                  Text(t.title)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')

                  Text(t.subtitle)
                    .fontSize(12)
                    .fontColor('#0B1220')
                    .margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 6 })
              }

              Text(t.amount)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(t.positive ? '#16A34A' : '#EF4444')
            }
            .width('100%')
            .padding(8)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .border({ width: 1, color: '#D1D5DB' })
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ bottom: 8 })
          })

          Column()
            .height(16)
            .width('100%')
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      // Bottom Bar
      Row() {
        Column() {
          Text('Total Balance')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')

          Text(this.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Add Money')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .backgroundColor('#10B981')
          .borderRadius(12)
          .height(44)
          .width(140)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .border({ width: 1, color: '#D1D5DB' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}