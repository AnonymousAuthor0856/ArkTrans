@Entry
@Component
struct Index {
  @State showBalance: boolean = true
  @State selected: string = "Month"
  @State r: string = ""
  @State Hide: string = ""
  @State isOn: boolean = false
  @State aName: string = ""
  @State Manage: string = ""
  @State Transfer: string = ""
  @State Details: string = ""
  @State RecentActivity: string = ""
  @State Income: string = ""
  @State Expense: string = ""
  @State tTitle: string = ""
  @State tSubtitle: string = ""
  @State tAmount: string = ""
  @State Wallet: string = ""
  @State TotalBalance: string = ""
  @State AddMoney: string = ""

  // Mock data for iteration to satisfy structure requirements
  private range: string[] = ["Month", "Week", "Day"]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      List({ space: 8 }) {
        ListItem() {
          Row({ space: 0 }) {
            Row({ space: 4 }) {
              ForEach(this.range, (item: string) => {
                Button(item)
                  .fontColor(this.selected === item ? '#FFFFFF' : '#0B1220')
                  .backgroundColor(this.selected === item ? '#6366F1' : '#FFFFFF')
                  .borderWidth(1)
                  .borderColor('#E5E7EB')
                  .borderRadius(16)
                  .onClick(() => {
                    this.selected = item
                  })
              })
            }.alignItems(VerticalAlign.Center)

            Row({ space: 4 }) {
              Text('Hide').fontColor('#0B1220').fontSize(14)
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn
                })
            }.alignItems(VerticalAlign.Center)
          }.alignItems(VerticalAlign.Center).width('100%')
        }

        ListItem() {
          Column() {
            Column({ space: 4 }) {
              Row({ space: 0 }) {
                Row({ space: 4 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 16, height: 16 }).fill('#6366F1')
                  }
                  Text(this.aName || 'Account Name').fontColor('#0B1220').fontSize(16).fontWeight(FontWeight.Medium)
                }.alignItems(VerticalAlign.Center)

                Button('Manage')
                  .fontColor('#0B1220')
                  .fontSize(12)
                  .backgroundColor('#E5E7EB')
                  .borderWidth(1)
                  .borderColor('#E5E7EB')
                  .borderRadius(16)
                  .height(24)
              }.alignItems(VerticalAlign.Center).width('100%')

              Stack({ alignContent: Alignment.Center }) {
                Text(this.showBalance ? '$26,395.75' : '•••••••')
                  .fontColor('#0B1220')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
              }
              .width('100%')
              .aspectRatio(2.8)
              .backgroundColor('#E5E7EB')
              .borderRadius(8)

              Row({ space: 4 }) {
                Button('Transfer')
                  .fontColor('#0B1220')
                  .fontSize(12)
                  .backgroundColor('#E5E7EB')
                  .borderWidth(1)
                  .borderColor('#E5E7EB')
                  .borderRadius(16)
                  .height(24)

                Button('Details')
                  .fontColor('#0B1220')
                  .fontSize(12)
                  .backgroundColor('#FFFFFF')
                  .borderWidth(1)
                  .borderColor('#E5E7EB')
                  .borderRadius(16)
                  .height(24)
              }.alignItems(VerticalAlign.Center)
            }.alignItems(HorizontalAlign.Start).width('100%').padding(8)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
        }

        ListItem() {
          Row({ space: 0 }) {
            Text('Recent Activity').fontColor('#0B1220').fontSize(24).fontWeight(FontWeight.Bold)
            
            Row({ space: 4 }) {
              Button('Income')
                .fontColor('#0B1220')
                .fontSize(12)
                .backgroundColor('#E5E7EB')
                .borderWidth(1)
                .borderColor('#E5E7EB')
                .borderRadius(16)
                .height(24)

              Button('Expense')
                .fontColor('#0B1220')
                .fontSize(12)
                .backgroundColor('#E5E7EB')
                .borderWidth(1)
                .borderColor('#E5E7EB')
                .borderRadius(16)
                .height(24)
            }.alignItems(VerticalAlign.Center)
          }.alignItems(VerticalAlign.Center).width('100%')
        }

        ListItem() {
          Column() {
            Row({ space: 0 }) {
              Row({ space: 6 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle({ width: 32, height: 32 }).fill('#EF4444')
                }
                
                Column({ space: 2 }) {
                  Text(this.tTitle || 'Transaction Title').fontColor('#0B1220').fontSize(16).fontWeight(FontWeight.Medium)
                  Text(this.tSubtitle || 'Transaction Subtitle').fontColor('#0B1220').fontSize(14)
                }.alignItems(HorizontalAlign.Start)
              }.alignItems(VerticalAlign.Center)

              Text(this.tAmount || '-$120.00').fontColor('#EF4444').fontSize(16).fontWeight(FontWeight.Medium)
            }.alignItems(VerticalAlign.Center).width('100%').padding(8)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
        }

        ListItem() {
          Column() {
            Blank().height(16)
          }
        }
      }
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .width('100%')
      .height('100%')

      // Top App Bar Simulation
      Row({ space: 4 }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 20, height: 20 }).fill('#1F2937')
        }
        Text('Wallet').fontColor('#0B1220').fontSize(32).fontWeight(FontWeight.Bold)
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding(16)
      .position({ x: 0, y: 0 })

      // Bottom Surface Simulation
      Column() {
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text('Total Balance').fontColor('#0B1220').fontSize(14)
            Text(this.showBalance ? "$26,395.75" : "•••••••")
              .fontColor('#0B1220')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
          }.alignItems(HorizontalAlign.Start)

          Button('Add Money')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .height(44)
            .width(140)
            .backgroundColor('#6366F1')
            .borderRadius(24)
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      }
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000' })
      .position({ x: 0, y: -100 }) // Positioned arbitrarily as per skeleton stack logic, usually bottom in real app
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}