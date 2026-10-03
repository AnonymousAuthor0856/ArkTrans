@Entry
@Component
struct Index {
  @State selectedRange: string = '1D'
  @State selectedFlags: string[] = []
  @State darkMode: boolean = false

  private ranges: string[] = ['1D', '1W', '1M', '3M', '1Y']
  private ranges2: string[] = ['Custom', 'All Time']
  private flags: string[] = ['Flag A', 'Flag B']

  interface Metric {
    title: string;
    value: string;
    delta: string;
    color: number;
  }

  private metrics: Metric[] = [
    { title: 'Revenue', value: '$12,450', delta: '+12%', color: 0xFF0EA5E9 },
    { title: 'Users', value: '1,234', delta: '-5%', color: 0xFF22C55E },
    { title: 'Sessions', value: '8,901', delta: '+8%', color: 0xFFF59E0B },
    { title: 'Bounce', value: '45%', delta: '-2%', color: 0xFFD4D9E1 }
  ]

  build() {
    Stack() {
      Column() {
        Row() {
          Blank()
          Row({ space: 8 }) {
            Rect().width(20).height(20).borderRadius(4).fill(0xFF0EA5E9)
            Text('Analytics').fontColor(0xFF0B1220).fontSize(24)
          }
          Blank()
        }.padding({ top: 48, bottom: 12 }).backgroundColor('#F7FAFC')

        Scroll() {
          Column({ space: 16 }) {
            // Range Selectors
            Scroll({ scroller: new Scroller() }) {
              Column() {
                Row({ space: 8 }) {
                  ForEach(this.ranges, (range: string) => {
                    Button() {
                      Text(range).fontColor(this.selectedRange === range ? '#FFFFFF' : '#0B1220').fontSize(12)
                    }
                    .type(ButtonType.Normal)
                    .backgroundColor(this.selectedRange === range ? 0xFF0EA5E9 : 0xFFFFFFFF)
                    .borderWidth(1)
                    .borderColor(0xFFD4D9E1)
                    .borderRadius(8)
                    .onClick(() => { this.selectedRange = range })
                  })
                }.padding({ top: 4, bottom: 4 })

                Row({ space: 8 }) {
                  ForEach(this.ranges2, (range: string) => {
                    Button() {
                      Text(range).fontColor(this.selectedRange === range ? '#FFFFFF' : '#0B1220').fontSize(12)
                    }
                    .type(ButtonType.Normal)
                    .backgroundColor(this.selectedRange === range ? 0xFF0EA5E9 : 0xFFFFFFFF)
                    .borderWidth(1)
                    .borderColor(0xFFD4D9E1)
                    .borderRadius(8)
                    .onClick(() => { this.selectedRange = range })
                  })
                  Blank()
                }.padding({ top: 8, bottom: 8 })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .barState(BarState.Off)

            // Compare & Flags
            Row({ space: 8 }) {
              Text('Compare').fontColor(0xFF0B1220).fontSize(10)
              
              ForEach(this.flags, (flag: string) => {
                Button() {
                  Text(flag).fontColor(this.selectedFlags.includes(flag) ? '#FFFFFF' : '#0B1220').fontSize(10)
                }
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedFlags.includes(flag) ? 0xFF22C55E : 0xFFFFFFFF)
                .borderWidth(1)
                .borderColor(0xFFD4D9E1)
                .borderRadius(4)
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
                Text('Dark').fontColor(0xFF0B1220).fontSize(10)
                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .scale({ x: 0.8, y: 0.8 })
                  .selectedColor(0xFF0EA5E9)
                  .onChange((isOn: boolean) => { this.darkMode = isOn })
              }.alignItems(VerticalAlign.Center)
            }.padding({ top: 6, bottom: 6 })

            // Metrics Grid
            Grid() {
              ForEach(this.metrics, (metric: Metric) => {
                GridItem() {
                  Column({ space: 8 }) {
                    Row() {
                      Text(metric.title).fontColor(0xFF0B1220).fontSize(16)
                      Blank()
                      Rect().width(16).height(16).borderRadius(4).fill(metric.color)
                    }
                    Text(metric.value).fontColor(0xFF0B1220).fontSize(24)
                    Row({ space: 4 }) {
                      Rect().width(6).height(6).borderRadius(2).fill(metric.delta.startsWith('+') ? 0xFF16A34A : 0xFFEF4444)
                      Text(metric.delta).fontColor(metric.delta.startsWith('+') ? 0xFF16A34A : 0xFFEF4444).fontSize(10)
                    }
                    Blank()
                  }
                  .width('100%')
                  .height(120)
                  .backgroundColor(0xFFFFFFFF)
                  .borderRadius(12)
                  .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
                  .border({ width: 1, color: 0xFFD4D9E1 })
                  .padding(16)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(16)
            .rowsGap(16)
            .width('100%')

            // Charts
            Column({ space: 16 }) {
              Text('Chart Title').fontColor(0xFF0B1220).fontSize(16)
              Stack() {
                Row({ space: 8 }) {
                  Rect().width(6).height(40).borderRadius(2).fill(0xFF0EA5E9)
                  Rect().width(6).height(30).borderRadius(2).fill(0xFF22C55E)
                  Rect().width(6).height(48).borderRadius(2).fill(0xFFF59E0B)
                  Rect().width(6).height(22).borderRadius(2).fill(0xFFD4D9E1)
                  Rect().width(6).height(32).borderRadius(2).fill(0xFF0EA5E9)
                  Rect().width(6).height(42).borderRadius(2).fill(0xFF22C55E)
                }
              }
              .width('100%')
              .aspectRatio(1.6)
              .alignContent(Alignment.Bottom)
              
              Row({ space: 8 }) {
                Rect().width(8).height(8).borderRadius(2).fill(0xFF0EA5E9)
                Text('Series A').fontColor(0xFF0B1220).fontSize(10)
                Rect().width(8).height(8).borderRadius(2).fill(0xFF22C55E)
                Text('Series B').fontColor(0xFF0B1220).fontSize(10)
              }
            }
            .width('100%')
            .height(180)
            .backgroundColor(0xFFFFFFFF)
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
            .border({ width: 1, color: 0xFFD4D9E1 })
            .padding(16)

            Column({ space: 16 }) {
              Text('Chart Title 2').fontColor(0xFF0B1220).fontSize(16)
              Stack() {
                Row({ space: 8 }) {
                  Rect().width(6).height(40).borderRadius(2).fill(0xFF0EA5E9)
                  Rect().width(6).height(30).borderRadius(2).fill(0xFF22C55E)
                  Rect().width(6).height(48).borderRadius(2).fill(0xFFF59E0B)
                  Rect().width(6).height(22).borderRadius(2).fill(0xFFD4D9E1)
                  Rect().width(6).height(32).borderRadius(2).fill(0xFF0EA5E9)
                  Rect().width(6).height(42).borderRadius(2).fill(0xFF22C55E)
                }
              }
              .width('100%')
              .aspectRatio(1.6)
              .alignContent(Alignment.Bottom)
              
              Row({ space: 8 }) {
                Rect().width(8).height(8).borderRadius(2).fill(0xFF0EA5E9)
                Text('Series A').fontColor(0xFF0B1220).fontSize(10)
                Rect().width(8).height(8).borderRadius(2).fill(0xFF22C55E)
                Text('Series B').fontColor(0xFF0B1220).fontSize(10)
              }
            }
            .width('100%')
            .height(180)
            .backgroundColor(0xFFFFFFFF)
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
            .border({ width: 1, color: 0xFFD4D9E1 })
            .padding(16)

            Blank().height(80)
          }
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        }.backgroundColor('#F7FAFC')
      }
    }
    .width('100%')
    .height('100%')
    .ignoreSafeArea([SafeAreaType.SYSTEM])
  }
}