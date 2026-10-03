import { FlowRow } from '@ohos/flutter_flow'

@Entry
@Component
struct Index {
  @State selectedRange: string = "7 Days"
  @State darkSwitch: boolean = false
  @State r: string = ""
  @State Compare: string = ""
  @State PrevPeriod: string = ""
  @State Goal: string = ""
  @State Dark: string = ""
  @State isOn: boolean = false
  @State mTitle: string = ""
  @State mValue: string = ""
  @State mDelta: string = ""
  @State cTitle: string = ""
  @State SeriesA: string = ""
  @State SeriesB: string = ""
  @State Analytics: string = ""
  @State Notifications: string = ""
  @State notif: number = 0
  @State MarkAllRead: string = ""

  private ranges: string[] = ["7 Days", "30 Days", "90 Days"]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        FlowRow({ space: 2, horizontalSpacing: 4, verticalSpacing: 2 }) {
          ForEach(this.ranges, (it: string) => {
            Button({ type: ButtonType.Capsule }) {
              Text(it).fontColor(this.selectedRange === it ? '#FFFFFF' : '#0B1220')
            }
            .backgroundColor(this.selectedRange === it ? '#0EA5E9' : '#F7FAFC')
            .borderWidth(1)
            .borderColor('#D4D9E1')
            .onClick(() => {
              this.selectedRange = it
            })
          })
        }.width('100%')

        Blank().height(6)

        FlowRow({ space: 2, horizontalSpacing: 4, verticalSpacing: 2 }) {
          Text('Compare').fontSize(12).fontColor('#0B1220')

          Button({ type: ButtonType.Capsule }) {
            Text('Prev Period').fontColor(this.PrevPeriod ? '#FFFFFF' : '#0B1220')
          }
          .backgroundColor(this.PrevPeriod ? '#22C55E' : '#F7FAFC')
          .borderWidth(1)
          .borderColor('#D4D9E1')
          .onClick(() => {
            this.PrevPeriod = !this.PrevPeriod ? "true" : ""
          })

          Button({ type: ButtonType.Capsule }) {
            Text('Goal').fontColor(this.Goal ? '#FFFFFF' : '#0B1220')
          }
          .backgroundColor(this.Goal ? '#22C55E' : '#F7FAFC')
          .borderWidth(1)
          .borderColor('#D4D9E1')
          .onClick(() => {
            this.Goal = !this.Goal ? "true" : ""
          })

          Row({ space: 2 }) {
            Text('Dark').fontSize(12).fontColor('#0B1220')
            Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
              .onChange((isOn: boolean) => {
                this.darkSwitch = isOn
              })
          }.alignItems(VerticalAlign.Center)
        }.width('100%')

        Blank().height(8)

        Grid() {
          // Card 1
          GridItem() {
            Column() {
              Column({ space: 4 }) {
                Row({ space: 0 }) {
                  Text(this.mTitle || 'Metric Title').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  Blank()
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 16, height: 16 }).fill('#0EA5E9')
                  }
                }.width('100%').alignItems(VerticalAlign.Center)

                Text(this.mValue || '$1,234').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')

                Row({ space: 2 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 6, height: 6 }).fill('#EF4444')
                  }
                  Text(this.mDelta || '-5.2%').fontSize(12).fontColor('#EF4444')
                }.alignItems(VerticalAlign.Center)
              }.width('100%').padding(8).alignItems(HorizontalAlign.Start)
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .width('100%')
            .height(120)
          }

          // Card 2
          GridItem() {
            Column() {
              Column({ space: 6 }) {
                Text(this.cTitle || 'Chart Title').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')

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
                  }.alignItems(VerticalAlign.Center)
                }
                .width('100%')
                .aspectRatio(1.6)
                .backgroundColor('#F7FAFC')
                .borderRadius(8)

                Row({ space: 4 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 8, height: 8 }).fill('#0EA5E9')
                  }
                  Text(this.SeriesA || 'Series A').fontSize(12).fontColor('#0B1220')
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 8, height: 8 }).fill('#22C55E')
                  }
                  Text(this.SeriesB || 'Series B').fontSize(12).fontColor('#0B1220')
                }.width('100%').alignItems(VerticalAlign.Center)
              }.width('100%').padding(8).alignItems(HorizontalAlign.Start)
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .width('100%')
            .height(180)
          }
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .alignItems(HorizontalAlign.Start)

      // Top App Bar Simulation
      Row({ space: 4 }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 20, height: 20 }).fill('#0EA5E9')
        }
        Text(this.Analytics || 'Analytics').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#0B1220')
      }
      .alignItems(VerticalAlign.Center)
      .position({ x: 8, y: 8 })

      // Bottom Sheet / Surface Simulation
      Column() {
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text(this.Notifications || 'Notifications').fontSize(12).fontColor('#0B1220')
            Text(`${this.notif} pending`).fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
          }.alignItems(HorizontalAlign.Start)

          Button() {
            Text(this.MarkAllRead || 'Mark All Read').fontColor('#FFFFFF')
          }
          .height(44)
          .width(140)
          .backgroundColor('#22C55E')
          .borderRadius(8)
          .onClick(() => {
            this.notif = 0
          })
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .alignItems(VerticalAlign.Center)
      }
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000' })
      .position({ x: 0, y: -100 }) // Positioned off-screen or as overlay depending on intent, here simplified to stack order
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}