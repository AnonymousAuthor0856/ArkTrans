@Entry
@Component
struct Index {
  @State showBalance: boolean = true
  @State selected: string = "Month"

  build() {
    Stack({ alignContent: Alignment.Top }) {
      List({ space: 8 }) {
        ListItem() {
          Row({ space: 0 }) {
            Row({ space: 4 }) {
              ForEach(['All', 'Week', 'Month', 'Year'], (item: string) => {
                Button(item)
                  .backgroundColor(this.selected === item ? '#1F2937' : '#FFFFFF')
                  .fontColor(this.selected === item ? '#FFFFFF' : '#0B1220')
                  .borderRadius(8)
                  .onClick(() => { this.selected = item })
              })
            }.alignItems(VerticalAlign.Center)

            Row({ space: 4 }) {
              Text('Hide').fontSize(14).fontColor('#0B1220')
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .onChange((isOn: boolean) => { this.showBalance = !isOn })
            }.alignItems(VerticalAlign.Center)
          }.alignItems(VerticalAlign.Center).width('100%')
        }

        ListItem() {
          Column() {
            Column({ space: 4 }) {
              Row({ space: 0 }) {
                Row({ space: 4 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 16, height: 16 }).fill('#10B981')
                  }
                  Text('Wallet').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                }.alignItems(VerticalAlign.Center)

                Button('Manage')
                  .backgroundColor('#10B981')
                  .fontColor('#FFFFFF')
                  .borderRadius(8)
                  .margin({ left: 'auto' })
              }.alignItems(VerticalAlign.Center).width('100%')

              Stack({ alignContent: Alignment.Center }) {
                Text('$2,845.20').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
              }
              .width('100%')
              .height(100)
              .backgroundColor('#E5E7EB')
              .borderRadius(12)

              Row({ space: 4 }) {
                Button('Transfer')
                  .backgroundColor('#10B981')
                  .fontColor('#FFFFFF')
                  .borderRadius(8)

                Button('Details')
                  .backgroundColor('#FFFFFF')
                  .fontColor('#0B1220')
                  .borderRadius(8)
                  .border({ width: 1, color: '#D1D5DB' })
              }.alignItems(VerticalAlign.Center)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(16)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 4, color: '#1A000000' })
        }

        ListItem() {
          Column() {
            Column({ space: 4 }) {
              Row({ space: 0 }) {
                Row({ space: 4 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 16, height: 16 }).fill('#3B82F6')
                  }
                  Text('Savings').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                }.alignItems(VerticalAlign.Center)

                Button('Manage')
                  .backgroundColor('#10B981')
                  .fontColor('#FFFFFF')
                  .borderRadius(8)
                  .margin({ left: 'auto' })
              }.alignItems(VerticalAlign.Center).width('100%')

              Stack({ alignContent: Alignment.Center }) {
                Text('$8,120.00').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
              }
              .width('100%')
              .height(100)
              .backgroundColor('#E5E7EB')
              .borderRadius(12)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(16)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 4, color: '#1A000000' })
        }

        ListItem() {
          Column().height(16)
        }
      }
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .width('100%')
      .layoutWeight(1)

      Row({ space: 4 }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 20, height: 20 }).fill('#1F2937')
        }
        Text('Wallet').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#0B1220')
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .padding({ top: 40, bottom: 10 })

      Column() {
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text('Total Balance').fontSize(14).fontColor('#0B1220')
            Text(this.showBalance ? '$26,395.75' : '•••••••').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
          }.alignItems(HorizontalAlign.Start)

          Button('Add Money')
            .backgroundColor('#10B981')
            .fontColor('#FFFFFF')
            .borderRadius(22)
            .height(44)
            .width(140)
            .margin({ left: 'auto' })
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}