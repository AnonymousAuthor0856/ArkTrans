@Entry
@Component
struct Index {
  @State selectedRange: string = "7 Days"
  @State darkSwitch: boolean = false
  @State prevPeriodSelected: boolean = false
  @State goalSelected: boolean = false
  @State notifCount: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom']

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Main Content Column ===
      Column({ space: 0 }) {
        // === FlowRow (Ranges) ===
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          ForEach(this.ranges, (range: string) => {
            Button(range)
              .type(ButtonType.Capsule)
              .backgroundColor(this.selectedRange === range ? '#0EA5E9' : '#FFFFFF')
              .fontColor(this.selectedRange === range ? '#FFFFFF' : '#0B1220')
              .borderWidth(1)
              .borderColor('#D4D9E1')
              .margin({ right: 8, bottom: 8 })
              .onClick(() => {
                this.selectedRange = range
              })
          }, (item: string) => item)
        }.width('100%')

        Blank().height(6)

        // === Compare Row ===
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Text('Compare').fontSize(14).fontColor('#0B1220').margin({ right: 8 })

          Button('Prev Period')
            .type(ButtonType.Capsule)
            .backgroundColor(this.prevPeriodSelected ? '#22C55E' : '#FFFFFF')
            .fontColor(this.prevPeriodSelected ? '#FFFFFF' : '#0B1220')
            .borderWidth(1)
            .borderColor('#D4D9E1')
            .margin({ right: 8, bottom: 8 })
            .onClick(() => {
              this.prevPeriodSelected = !this.prevPeriodSelected
            })

          Button('Goal')
            .type(ButtonType.Capsule)
            .backgroundColor(this.goalSelected ? '#22C55E' : '#FFFFFF')
            .fontColor(this.goalSelected ? '#FFFFFF' : '#0B1220')
            .borderWidth(1)
            .borderColor('#D4D9E1')
            .margin({ right: 8, bottom: 8 })
            .onClick(() => {
              this.goalSelected = !this.goalSelected
            })

          Row({ space: 2 }) {
            Text('Dark').fontSize(14).fontColor('#0B1220')
            Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
              .onChange((isOn: boolean) => {
                this.darkSwitch = isOn
              })
          }
        }.width('100%')

        Blank().height(8)

        // === LazyVerticalGrid (Cards) ===
        Grid() {
          // Card 1: Revenue
          GridItem() {
            Column() {
              Column({ space: 4 }) {
                Row({ space: 0 }) {
                  Text('Revenue').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  Blank()
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 16, height: 16 }).fill('#22C55E')
                  }
                }.width('100%')

                Text('$24,560').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')

                Row({ space: 2 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 6, height: 6 }).fill('#22C55E')
                  }
                  Text('+8.2%').fontSize(12).fontColor('#22C55E')
                }
              }.alignItems(HorizontalAlign.Start).width('100%').padding(8)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
          }

          // Card 2: Orders
          GridItem() {
            Column() {
              Column({ space: 4 }) {
                Row({ space: 0 }) {
                  Text('Orders').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  Blank()
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 16, height: 16 }).fill('#0EA5E9')
                  }
                }.width('100%')

                Text('1,284').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')

                Row({ space: 2 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 6, height: 6 }).fill('#22C55E')
                  }
                  Text('+3.1%').fontSize(12).fontColor('#22C55E')
                }
              }.alignItems(HorizontalAlign.Start).width('100%').padding(8)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
          }

          // Card 3: Refunds
          GridItem() {
            Column() {
              Column({ space: 4 }) {
                Row({ space: 0 }) {
                  Text('Refunds').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  Blank()
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 16, height: 16 }).fill('#EF4444')
                  }
                }.width('100%')

                Text('42').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')

                Row({ space: 2 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 6, height: 6 }).fill('#EF4444')
                  }
                  Text('-1.4%').fontSize(12).fontColor('#EF4444')
                }
              }.alignItems(HorizontalAlign.Start).width('100%').padding(8)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
          }

          // Card 4: Active Users
          GridItem() {
            Column() {
              Column({ space: 4 }) {
                Row({ space: 0 }) {
                  Text('Active Users').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  Blank()
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 16, height: 16 }).fill('#F59E0B')
                  }
                }.width('100%')

                Text('8,921').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')

                Row({ space: 2 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 6, height: 6 }).fill('#22C55E')
                  }
                  Text('+5.6%').fontSize(12).fontColor('#22C55E')
                }
              }.alignItems(HorizontalAlign.Start).width('100%').padding(8)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
          }

          // Card 5: Sales Trend
          GridItem() {
            Column() {
              Column({ space: 6 }) {
                Text('Sales Trend').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                
                Stack({ alignContent: Alignment.Center }) {
                  Row({ space: 4 }) {
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 40 }).fill('#0EA5E9')
                    }
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 30 }).fill('#22C55E')
                    }
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 48 }).fill('#F59E0B')
                    }
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 22 }).fill('#D4D9E1')
                    }
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 32 }).fill('#0EA5E9')
                    }
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 42 }).fill('#22C55E')
                    }
                  }.alignItems(VerticalAlign.Bottom)
                }.width('100%').height(60).backgroundColor('#E0F2FE').borderRadius(8)
              }.alignItems(HorizontalAlign.Start).width('100%').padding(8)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
          }

          // Card 6: Conversion Funnel
          GridItem() {
            Column() {
              Column({ space: 6 }) {
                Text('Conversion Funnel').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                
                Stack({ alignContent: Alignment.Center }) {
                  Row({ space: 4 }) {
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 40 }).fill('#0EA5E9')
                    }
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 30 }).fill('#22C55E')
                    }
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 48 }).fill('#F59E0B')
                    }
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 22 }).fill('#D4D9E1')
                    }
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 32 }).fill('#0EA5E9')
                    }
                    Stack({ alignContent: Alignment.Center }) {
                      Rect({ width: 6, height: 42 }).fill('#22C55E')
                    }
                  }.alignItems(VerticalAlign.Bottom)
                }.width('100%').height(60).backgroundColor('#E0F2FE').borderRadius(8)
              }.alignItems(HorizontalAlign.Start).width('100%').padding(8)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
          }
        }.columnsTemplate('1fr 1fr').columnsGap(8).rowsGap(8).width('100%')
      }.alignItems(HorizontalAlign.Start).width('100%').height('100%').padding({ left: 8, right: 8, top: 6, bottom: 6 })

      // === Top App Bar ===
      Row({ space: 4 }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 20, height: 20 }).fill('#0EA5E9')
        }
        Text('Analytics').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#0B1220')
      }.alignItems(VerticalAlign.Center).position({ x: 0, y: 0 }).width('100%').justifyContent(FlexAlign.Center).padding({ top: 20 })

      // === Bottom Notification Surface ===
      Column() {
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text('Notifications').fontSize(14).fontColor('#0B1220')
            Text(`${this.notifCount} pending`).fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
          }.alignItems(HorizontalAlign.Start)
          
          Blank()
          
          Button('Mark All Read')
            .type(ButtonType.Capsule)
            .backgroundColor('#22C55E')
            .fontColor('#FFFFFF')
            .height(44)
            .width(140)
            .onClick(() => {
              this.notifCount = 0
            })
        }.alignItems(VerticalAlign.Center).width('100%').padding({ left: 8, right: 8, top: 6, bottom: 6 })
      }.backgroundColor('#FFFFFF').shadow({ radius: 4, color: '#1A000000' }).position({ x: 0, y: -1 }).width('100%')
    }.width('100%').height('100%').backgroundColor('#F7FAFC')
  }
}