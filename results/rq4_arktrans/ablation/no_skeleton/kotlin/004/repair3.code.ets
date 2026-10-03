// src/main/ets/model/DataModel.ets
export interface AccountCard {
  id: number;
  name: string;
  balance: string;
  accent: string; // Hex color string
}

export interface TxItem {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;
}

// src/main/ets/view/components/ChipComponent.ets
import { Colors } from '@kit.ArkUI';

@Component
struct ChipComponent {
  @Prop text: string;
  @Prop selected: boolean;
  @State onClickCallback: () => void = () => {};

  build() {
    Button(this.text) {
      Text(this.text)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selected ? '#FFFFFF' : '#0B1220')
    }
    .width('auto')
    .height(32)
    .backgroundColor(this.selected ? '#1F2937' : '#FFFFFF')
    .borderRadius(8)
    .border({ width: 1, color: '#D1D5DB', style: BorderStyle.Solid })
    .onClick(() => {
      this.onClickCallback();
    })
  }
}

@Component
struct ActionChipComponent {
  @Prop text: string;
  @Prop active: boolean;
  @State onClickCallback: () => void = () => {};

  build() {
    Button(this.text) {
      Text(this.text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? '#0B1220' : '#0B1220')
    }
    .width('auto')
    .height(28)
    .padding({ left: 12, right: 12 })
    .backgroundColor(this.active ? '#10B981' : '#FFFFFF')
    .borderRadius(6)
    .border({ width: 1, color: '#D1D5DB', style: BorderStyle.Solid })
    .onClick(() => {
      this.onClickCallback();
    })
  }
}

// src/main/ets/view/MainPage.ets
import { AccountCard, TxItem } from '../model/DataModel';
import { ChipComponent, ActionChipComponent } from './components/ChipComponent';

@Entry
@Component
struct FinanceWallet {
  @State showBalance: boolean = true;
  @State selectedRange: string = "Month";
  @State flags: string[] = [];

  private accounts: AccountCard[] = [
    { id: 1, name: "Wallet", balance: "$2,845.20", accent: "#10B981" },
    { id: 2, name: "Savings", balance: "$8,120.00", accent: "#3B82F6" },
    { id: 3, name: "Investments", balance: "$15,430.55", accent: "#F59E0B" }
  ];

  private txs: TxItem[] = [
    { id: 1, title: "Grocery Market", subtitle: "Today • 12:40", amount: "-$32.18", positive: false },
    { id: 2, title: "Salary", subtitle: "Yesterday • 09:00", amount: "+$3,200.00", positive: true },
    { id: 3, title: "Coffee Shop", subtitle: "Yesterday • 15:22", amount: "-$4.90", positive: false },
    { id: 4, title: "ETF Purchase", subtitle: "Mon • 10:05", amount: "-$250.00", positive: false },
    { id: 5, title: "Refund", subtitle: "Sun • 18:40", amount: "+$18.99", positive: true }
  ];

  private ranges: string[] = ["All", "Week", "Month", "Year"];

  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .borderRadius(6)
        Text("Wallet")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
          .margin({ left: 4 })
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          // Filter Chips & Switch
          Row() {
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              ForEach(this.ranges, (range: string) => {
                ChipComponent({
                  text: range,
                  selected: this.selectedRange === range,
                  onClickCallback: () => { this.selectedRange = range }
                })
                .margin({ right: 8, bottom: 8 })
              })
            }
            
            Blank()

            Text("Hide")
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
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 12, bottom: 12 })

          // Account Cards
          ForEach(this.accounts, (account: AccountCard) => {
            Column() {
              Row() {
                Row() {
                  Circle({ width: 16, height: 16 })
                    .fill(account.accent)
                  Text(account.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                    .margin({ left: 4 })
                }
                
                Blank()

                ActionChipComponent({
                  text: "Manage",
                  active: true,
                  onClickCallback: () => {}
                })
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              Column() {
                Text(this.showBalance ? account.balance : "•••••••")
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#0B1220')
              }
              .width('100%')
              .aspectRatio(2.8)
              .backgroundColor('#E5E7EB')
              .borderRadius(8)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .margin({ top: 8, bottom: 8 })

              Row() {
                ActionChipComponent({
                  text: "Transfer",
                  active: true,
                  onClickCallback: () => {}
                })
                .margin({ right: 8 })

                ActionChipComponent({
                  text: "Details",
                  active: false,
                  onClickCallback: () => {}
                })
              }
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
            .border({ width: 1, color: '#D1D5DB', style: BorderStyle.Solid })
            .margin({ bottom: 12 })
          })

          // Recent Activity Header
          Row() {
            Text("Recent Activity")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0B1220')
            
            Blank()

            ActionChipComponent({
              text: "Income",
              active: this.flags.includes("Income"),
              onClickCallback: () => {
                if (this.flags.includes("Income")) {
                  this.flags = this.flags.filter(f => f !== "Income");
                } else {
                  this.flags.push("Income");
                }
              }
            })
            .margin({ right: 8 })

            ActionChipComponent({
              text: "Expense",
              active: this.flags.includes("Expense"),
              onClickCallback: () => {
                if (this.flags.includes("Expense")) {
                  this.flags = this.flags.filter(f => f !== "Expense");
                } else {
                  this.flags.push("Expense");
                }
              }
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 12, bottom: 12 })

          // Transaction List
          ForEach(this.txs, (tx: TxItem) => {
            Row() {
              Row() {
                Circle({ width: 32, height: 32 })
                  .fill(tx.positive ? '#16A34A' : '#EF4444')
                
                Column() {
                  Text(tx.title)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                  Text(tx.subtitle)
                    .fontSize(12)
                    .fontColor('#0B1220')
                    .margin({ top: 2 })
                }
                .margin({ left: 12 })
              }

              Blank()

              Text(tx.amount)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(tx.positive ? '#16A34A' : '#EF4444')
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 2, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
            .border({ width: 1, color: '#D1D5DB', style: BorderStyle.Solid })
            .margin({ bottom: 12 })
          })

          Column()
            .height(16)
        }
        .width('100%')
        .padding({ left: 12, right: 12 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Row() {
        Column() {
          Text("Total Balance")
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
          Text(this.showBalance ? "$26,395.75" : "•••••••")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
            .margin({ top: 2 })
        }
        
        Button("Add Money")
        .width(140)
        .height(44)
        .backgroundColor('#10B981')
        .borderRadius(12)
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.1)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}