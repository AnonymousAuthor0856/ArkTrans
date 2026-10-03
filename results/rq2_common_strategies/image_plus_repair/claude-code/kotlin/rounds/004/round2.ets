@Entry
@Component
struct WalletPage {
  @State showBalance: boolean = true;
  @State selectedRange: string = "Month";
  @State incomeFilter: boolean = false;
  @State expenseFilter: boolean = false;

  private ranges: string[] = ["All", "Week", "Month", "Year"];

  private accounts: AccountCard[] = [
    new AccountCard(1, "Wallet", "$2,845.20", "#10B981"),
    new AccountCard(2, "Savings", "$8,120.00", "#3B82F6"),
    new AccountCard(3, "Investments", "$15,430.55", "#F59E0B")
  ];

  private txs: TxItem[] = [
    new TxItem(1, "Grocery Market", "Today • 12:40", "-$32.18", false),
    new TxItem(2, "Salary", "Yesterday • 09:00", "+$3,200.00", true),
    new TxItem(3, "Coffee Shop", "Yesterday • 15:22", "-$4.90", false),
    new TxItem(4, "ETF Purchase", "Mon • 10:05", "-$250.00", false),
    new TxItem(5, "Refund", "Sun • 18:40", "+$18.99", true)
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Column()
            .width(20)
            .height(20)
            .backgroundColor("#1F2937")
            .borderRadius(6)
          Text("Wallet")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor("#0B1220")
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width("100%")
        .height(56)
      }
      .width("100%")
      .backgroundColor("#FFFFFF")

      // Main scrollable content
      Scroll() {
        Column() {
          // Range filter row + Hide toggle
          Row() {
            Row() {
              ForEach(this.ranges, (r: string) => {
                Text(r)
                  .fontSize(r === this.selectedRange ? 14 : 12)
                  .fontWeight(r === this.selectedRange ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(r === this.selectedRange ? "#FFFFFF" : "#0B1220")
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .backgroundColor(r === this.selectedRange ? "#1F2937" : "#FFFFFF")
                  .border({ width: 1, color: "#D1D5DB" })
                  .borderRadius(8)
                  .margin({ right: 4 })
                  .onClick(() => {
                    this.selectedRange = r;
                  })
              }, (r: string) => r)
            }
            .justifyContent(FlexAlign.Start)
            .alignItems(VerticalAlign.Center)

            Row() {
              Text("Hide")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor("#0B1220")
                .margin({ right: 4 })
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .selectedColor("#1F2937")
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn;
                })
            }
            .justifyContent(FlexAlign.End)
            .alignItems(VerticalAlign.Center)
          }
          .width("100%")
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 6, bottom: 8 })

          // Account cards
          ForEach(this.accounts, (a: AccountCard) => {
            Column() {
              // Header row: name + Manage
              Row() {
                Row() {
                  Column()
                    .width(16)
                    .height(16)
                    .backgroundColor(a.accent)
                    .borderRadius(6)
                    .margin({ right: 4 })
                  Text(a.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor("#0B1220")
                }
                .alignItems(VerticalAlign.Center)

                Text("Manage")
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#0B1220")
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .backgroundColor("#10B981")
                  .border({ width: 1, color: "#D1D5DB" })
                  .borderRadius(6)
              }
              .width("100%")
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .margin({ bottom: 4 })

              // Balance display area
              Row() {
                Text(this.showBalance ? a.balance : "•••••••")
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor("#0B1220")
              }
              .width("100%")
              .height(120)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor("#E5E7EB")
              .borderRadius(8)
              .margin({ bottom: 4 })

              // Action chips: Transfer + Details
              Row() {
                Text("Transfer")
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#0B1220")
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .backgroundColor("#10B981")
                  .border({ width: 1, color: "#D1D5DB" })
                  .borderRadius(6)
                Text("Details")
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#0B1220")
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .backgroundColor("#FFFFFF")
                  .border({ width: 1, color: "#D1D5DB" })
                  .borderRadius(6)
                  .margin({ left: 4 })
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)
            }
            .width("100%")
            .padding(8)
            .backgroundColor("#FFFFFF")
            .borderRadius(12)
            .border({ width: 1, color: "#D1D5DB" })
            .margin({ bottom: 8 })
          }, (a: AccountCard) => a.id.toString())

          // Recent Activity header
          Row() {
            Text("Recent Activity")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor("#0B1220")

            Row() {
              Text("Income")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor("#0B1220")
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .backgroundColor(this.incomeFilter ? "#10B981" : "#FFFFFF")
                .border({ width: 1, color: "#D1D5DB" })
                .borderRadius(6)
                .onClick(() => {
                  this.incomeFilter = !this.incomeFilter;
                })
              Text("Expense")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor("#0B1220")
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .backgroundColor(this.expenseFilter ? "#10B981" : "#FFFFFF")
                .border({ width: 1, color: "#D1D5DB" })
                .borderRadius(6)
                .margin({ left: 4 })
                .onClick(() => {
                  this.expenseFilter = !this.expenseFilter;
                })
            }
            .justifyContent(FlexAlign.End)
            .alignItems(VerticalAlign.Center)
          }
          .width("100%")
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 4, bottom: 8 })

          // Transaction items
          ForEach(this.txs, (t: TxItem) => {
            Row() {
              Row() {
                Column()
                  .width(32)
                  .height(32)
                  .backgroundColor(t.positive ? "#16A34A" : "#EF4444")
                  .borderRadius(6)
                  .margin({ right: 6 })
                Column() {
                  Text(t.title)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor("#0B1220")
                  Text(t.subtitle)
                    .fontSize(12)
                    .fontWeight(FontWeight.Normal)
                    .fontColor("#0B1220")
                    .margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.Start)
              }
              .alignItems(VerticalAlign.Center)

              Text(t.amount)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(t.positive ? "#16A34A" : "#EF4444")
            }
            .width("100%")
            .padding(8)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .backgroundColor("#FFFFFF")
            .borderRadius(12)
            .border({ width: 1, color: "#D1D5DB" })
            .margin({ bottom: 8 })
          }, (t: TxItem) => t.id.toString())

          // Bottom spacing
          Blank()
            .height(16)
        }
        .width("100%")
        .padding({ left: 8, right: 8, top: 6, bottom: 24 })
      }
      .layoutWeight(1)
      .width("100%")
      .backgroundColor("#F3F4F6")
      .scrollBar(BarState.Off)

      // Bottom bar: Total Balance + Add Money
      Row() {
        Column() {
          Text("Total Balance")
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor("#0B1220")
          Text(this.showBalance ? "$26,395.75" : "•••••••")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor("#0B1220")
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Button("Add Money")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor("#0B1220")
          .backgroundColor("#10B981")
          .borderRadius(12)
          .height(44)
          .width(140)
      }
      .width("100%")
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor("#FFFFFF")
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#F3F4F6")
  }
}

class AccountCard {
  id: number;
  name: string;
  balance: string;
  accent: string;

  constructor(id: number, name: string, balance: string, accent: string) {
    this.id = id;
    this.name = name;
    this.balance = balance;
    this.accent = accent;
  }
}

class TxItem {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;

  constructor(id: number, title: string, subtitle: string, amount: string, positive: boolean) {
    this.id = id;
    this.title = title;
    this.subtitle = subtitle;
    this.amount = amount;
    this.positive = positive;
  }
}
