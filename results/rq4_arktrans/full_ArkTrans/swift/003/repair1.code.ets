@Entry
@Component
struct Index {
  @State selectedRange: string = '7 Days'
  @State selectedFlags: string[] = []
  @State darkMode: boolean = false

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days']
  private ranges2: string[] = ['YTD', 'Custom']
  private flags: string[] = ['Prev Period', 'Goal']

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Blank()
          Row({ space: 8 }) {
            Rect().width(20).height(20).borderRadius(4).fill('#0EA5E9')
            Text('Analytics').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
          }
          Blank()
        }.width('100%').padding({ top: 48, bottom: 12 }).backgroundColor('#F7FAFC')

        Scroll() {
          Column({ space: 16 }) {
            // Time Range Selectors
            Column() {
              Row({ space: 8 }) {
                ForEach(this.ranges, (range: string) => {
                  Button(range)
                    .type(ButtonType.Normal)
                    .backgroundColor(this.selectedRange === range ? '#0EA5E9' : '#FFFFFF')
                    .fontColor(this.selectedRange === range ? '#FFFFFF' : '#0B1220')
                    .borderWidth(1)
                    .borderColor('#D4D9E1')
                    .borderRadius(8)
                    .onClick(() => { this.selectedRange = range })
                })
              }
              Row({ space: 8 }) {
                ForEach(this.ranges2, (range: string) => {
                  Button(range)
                    .type(ButtonType.Normal)
                    .backgroundColor('#FFFFFF')
                    .fontColor('#0B1220')
                    .borderWidth(1)
                    .borderColor('#D4D9E1')
                    .borderRadius(8)
                    .onClick(() => { this.selectedRange = range })
                })
                Blank()
              }.margin({ top: 8 })
            }

            // Compare & Dark Mode
            Row({ space: 8 }) {
              Text('Compare').fontSize(10).fontColor('#0B1220')
              ForEach(this.flags, (flag: string) => {
                Button(flag)
                  .type(ButtonType.Normal)
                  .backgroundColor(this.selectedFlags.includes(flag) ? '#22C55E' : '#FFFFFF')
                  .fontColor(this.selectedFlags.includes(flag) ? '#FFFFFF' : '#0B1220')
                  .borderWidth(1)
                  .borderColor('#D4D9E1')
                  .borderRadius(8)
                  .onClick(() => {
                    if (this.selectedFlags.includes(flag)) {
                      const index = this.selectedFlags.indexOf(flag)
                      this.selectedFlags.splice(index, 1)
                    } else {
                      this.selectedFlags.push(flag)
                    }
                  })
              })
              Row({ space: 4 }) {
                Text('Dark').fontSize(10).fontColor('#0B1220')
                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .onChange((isOn: boolean) => { this.darkMode = isOn })
                  .selectedColor('#0EA5E9')
                  .scale({ x: 0.8, y: 0.8 })
              }
            }

            // Metrics Grid
            Grid() {
              // Revenue
              GridItem() {
                Column({ space: 8 }) {
                  Row() {
                    Text('Revenue').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                    Blank()
                    Rect().width(16).height(16).borderRadius(4).fill('#22C55E')
                  }
                  Text('$24,560').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
                  Row({ space: 4 }) {
                    Rect().width(6).height(6).borderRadius(2).fill('#16A34A')
                    Text('+8.2%').fontSize(10).fontColor('#16A34A')
                  }
                  Blank()
                }
                .width('100%')
                .height(120)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 8, color: '#1F000000', offsetY: 2 })
                .padding(16)
              }

              // Orders
              GridItem() {
                Column({ space: 8 }) {
                  Row() {
                    Text('Orders').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                    Blank()
                    Rect().width(16).height(16).borderRadius(4).fill('#0EA5E9')
                  }
                  Text('1,284').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
                  Row({ space: 4 }) {
                    Rect().width(6).height(6).borderRadius(2).fill('#16A34A')
                    Text('+3.1%').fontSize(10).fontColor('#16A34A')
                  }
                  Blank()
                }
                .width('100%')
                .height(120)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 8, color: '#1F000000', offsetY: 2 })
                .padding(16)
              }

              // Refunds
              GridItem() {
                Column({ space: 8 }) {
                  Row() {
                    Text('Refunds').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                    Blank()
                    Rect().width(16).height(16).borderRadius(4).fill('#EF4444')
                  }
                  Text('42').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
                  Row({ space: 4 }) {
                    Rect().width(6).height(6).borderRadius(2).fill('#EF4444')
                    Text('-1.4%').fontSize(10).fontColor('#EF4444')
                  }
                  Blank()
                }
                .width('100%')
                .height(120)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 8, color: '#1F000000', offsetY: 2 })
                .padding(16)
              }

              // Active Users
              GridItem() {
                Column({ space: 8 }) {
                  Row() {
                    Text('Active Users').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                    Blank()
                    Rect().width(16).height(16).borderRadius(4).fill('#F59E0B')
                  }
                  Text('8,921').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
                  Row({ space: 4 }) {
                    Rect().width(6).height(6).borderRadius(2).fill('#16A34A')
                    Text('+5.6%').fontSize(10).fontColor('#16A34A')
                  }
                  Blank()
                }
                .width('100%')
                .height(120)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 8, color: '#1F000000', offsetY: 2 })
                .padding(16)
              }

              // Sales Trend Chart
              GridItem() {
                Column({ space: 12 }) {
                  Text('Sales Trend').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  Stack() {
                    Row({ space: 4 }) {
                      Rect().width(6).height(40).borderRadius(2).fill('#0EA5E9')
                      Rect().width(6).height(30).borderRadius(2).fill('#22C55E')
                      Rect().width(6).height(48).borderRadius(2).fill('#F59E0B')
                      Rect().width(6).height(22).borderRadius(2).fill('#D4D9E1')
                      Rect().width(6).height(32).borderRadius(2).fill('#0EA5E9')
                      Rect().width(6).height(42).borderRadius(2).fill('#22C55E')
                    }.alignItems(VerticalAlign.Bottom)
                  }
                  .width('100%')
                  .height(60)
                  .backgroundColor('#E0F2FE')
                  .borderRadius(8)
                  .alignContent(Alignment.Center)

                  Row({ space: 8 }) {
                    Rect().width(8).height(8).borderRadius(2).fill('#0EA5E9')
                    Text('Series A').fontSize(10).fontColor('#0B1220')
                    Rect().width(8).height(8).borderRadius(2).fill('#22C55E')
                    Text('Series B').fontSize(10).fontColor('#0B1220')
                  }
                }
                .width('100%')
                .height(180)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 8, color: '#1F000000', offsetY: 2 })
                .padding(16)
              }

              // Conversion Funnel Chart
              GridItem() {
                Column({ space: 12 }) {
                  Text('Conversion Funnel').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  Stack() {
                    Row({ space: 4 }) {
                      Rect().width(6).height(40).borderRadius(2).fill('#0EA5E9')
                      Rect().width(6).height(30).borderRadius(2).fill('#22C55E')
                      Rect().width(6).height(48).borderRadius(2).fill('#F59E0B')
                      Rect().width(6).height(22).borderRadius(2).fill('#D4D9E1')
                      Rect().width(6).height(32).borderRadius(2).fill('#0EA5E9')
                      Rect().width(6).height(42).borderRadius(2).fill('#22C55E')
                    }.alignItems(VerticalAlign.Bottom)
                  }
                  .width('100%')
                  .height(60)
                  .backgroundColor('#E0F2FE')
                  .borderRadius(8)
                  .alignContent(Alignment.Center)

                  Row({ space: 8 }) {
                    Rect().width(8).height(8).borderRadius(2).fill('#0EA5E9')
                    Text('Series A').fontSize(10).fontColor('#0B1220')
                    Rect().width(8).height(8).borderRadius(2).fill('#22C55E')
                    Text('Series B').fontSize(10).fontColor('#0B1220')
                  }
                }
                .width('100%')
                .height(180)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 8, color: '#1F000000', offsetY: 2 })
                .padding(16)
              }
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(16)
            .rowsGap(16)

            Blank().height(80)
          }
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        }.backgroundColor('#F7FAFC')
      }.width('100%').height('100%')

      // Bottom Notification Bar
      Row() {
        Column({ space: 4 }) {
          Text('Notifications').fontSize(14).fontColor('#0B1220')
          Text('2 pending').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#0B1220')
        }
        Blank()
        Button('Mark All Read')
          .backgroundColor('#22C55E')
          .fontColor('#FFFFFF')
          .borderRadius(16)
          .height(48)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(80)
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: -80 }) // Overlay at bottom
      .shadow({ radius: 8, color: '#1F000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Bottom)
  }
}