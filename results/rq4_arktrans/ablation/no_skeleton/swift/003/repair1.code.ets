@Entry
@Component
struct CompactOneShot {
  @State selectedRange: string = '7 Days'
  @State selectedFlags: string[] = []
  @State darkMode: boolean = false
  @State notificationCount: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days']
  private ranges2: string[] = ['YTD', 'Custom']
  private flags: string[] = ['Prev Period', 'Goal']

  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: '#22C55E' },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: '#0EA5E9' },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: '#EF4444' },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: '#F59E0B' }
  ]

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' }
  ]

  build() {
    // === Column ===
    // props: { space: 0 }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#F7FAFC' }
    // children: 3
    Column() {
      // === Header ===
      // === Row ===
      // props: { space: 4 }
      // modifier: { justifyContent: FlexAlign.Center, padding: { top: 48, bottom: 12 } }
      // children: 2
      Row() {
        // === Image ===
        // modifier: { width: 20, height: 20, borderRadius: 4, backgroundColor: '#0EA5E9' }
        Image($r('app.media.startIcon')).width(20).height(20).borderRadius(4).backgroundColor('#0EA5E9')
        // === Text ===
        // props: { text: 'Analytics' }
        // modifier: { fontSize: 24, fontWeight: FontWeight.Semibold, fontColor: '#0B1220' }
        Text('Analytics').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#0B1220')
      }.justifyContent(FlexAlign.Center).padding({ top: 48, bottom: 12 })

      // === Divider ===
      // modifier: { color: '#D4D9E1' }
      Divider().color('#D4D9E1')

      // === ScrollView ===
      // modifier: { layoutWeight: 1 }
      // children: 1
      Scroll() {
        // === Column ===
        // props: { space: 6 }
        // modifier: { padding: { left: 8, right: 8, top: 6, bottom: 6 } }
        // children: 5
        Column({ space: 6 }) {
          // === Date Range Selector ===
          // === Scroll ===
          // props: { scrollable: ScrollDirection.Horizontal, barState: BarState.Off }
          // modifier: { width: '100%' }
          // children: 2
          Scroll() {
            // === Column ===
            // props: { space: 8 }
            // modifier: { width: '100%' }
            // children: 2
            Column({ space: 8 }) {
              // === Row ===
              // props: { space: 4 }
              // modifier: { width: '100%' }
              // children: 4
              Row({ space: 4 }) {
                ForEach(this.ranges, (range: string) => {
                  // === Button ===
                  // modifier: { type: ButtonType.Normal, stateEffect: true, backgroundColor: this.selectedRange === range ? '#0EA5E9' : '#FFF', borderColor: '#D4D9E1', borderWidth: 1, borderRadius: 8, padding: { left: 16, right: 16, top: 8, bottom: 8 } }
                  // children: 1
                  Button() {
                    // === Text ===
                    // props: { text: range }
                    // modifier: { fontSize: this.selectedRange === range ? 14 : 12, fontWeight: this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular, fontColor: this.selectedRange === range ? '#FFF' : '#0B1220' }
                    Text(range).fontSize(this.selectedRange === range ? 14 : 12).fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular).fontColor(this.selectedRange === range ? '#FFF' : '#0B1220')
                  }.type(ButtonType.Normal).stateEffect(true).backgroundColor(this.selectedRange === range ? '#0EA5E9' : '#FFF').borderColor('#D4D9E1').borderWidth(1).borderRadius(8).padding({ left: 16, right: 16, top: 8, bottom: 8 }).onClick(() => {
                    this.selectedRange = range
                  })
                })
              }.width('100%')

              // === Row ===
              // props: { space: 4 }
              // modifier: { width: '100%' }
              // children: 3
              Row({ space: 4 }) {
                ForEach(this.ranges2, (range: string) => {
                  // === Button ===
                  // modifier: { type: ButtonType.Normal, stateEffect: true, backgroundColor: this.selectedRange === range ? '#0EA5E9' : '#FFF', borderColor: '#D4D9E1', borderWidth: 1, borderRadius: 8, padding: { left: 16, right: 16, top: 10, bottom: 10 } }
                  // children: 1
                  Button() {
                    // === Text ===
                    // props: { text: range }
                    // modifier: { fontSize: this.selectedRange === range ? 14 : 12, fontWeight: this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular, fontColor: this.selectedRange === range ? '#FFF' : '#0B1220' }
                    Text(range).fontSize(this.selectedRange === range ? 14 : 12).fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular).fontColor(this.selectedRange === range ? '#FFF' : '#0B1220')
                  }.type(ButtonType.Normal).stateEffect(true).backgroundColor(this.selectedRange === range ? '#0EA5E9' : '#FFF').borderColor('#D4D9E1').borderWidth(1).borderRadius(8).padding({ left: 16, right: 16, top: 10, bottom: 10 }).onClick(() => {
                    this.selectedRange = range
                  })
                })
                Blank()
              }.width('100%')
            }.width('100%')
          }.scrollable(ScrollDirection.Horizontal).width('100%')

          // === Comparison Options ===
          // === Row ===
          // props: { space: 4 }
          // modifier: { width: '100%', padding: { top: 6, bottom: 6 } }
          // children: 5
          Row({ space: 4 }) {
            // === Text ===
            // props: { text: 'Compare' }
            // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
            Text('Compare').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#0B1220')

            ForEach(this.flags, (flag: string) => {
              // === Button ===
              // modifier: { type: ButtonType.Normal, stateEffect: true, backgroundColor: this.selectedFlags.includes(flag) ? '#22C55E' : '#FFF', borderColor: '#D4D9E1', borderWidth: 1, borderRadius: 6, padding: { left: 16, right: 16, top: 10, bottom: 10 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: flag }
                // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: this.selectedFlags.includes(flag) ? '#0F172A' : '#0B1220', maxLines: 1 }
                Text(flag).fontSize(10).fontWeight(FontWeight.Medium).fontColor(this.selectedFlags.includes(flag) ? '#0F172A' : '#0B1220').maxLines(1)
              }.type(ButtonType.Normal).stateEffect(true).backgroundColor(this.selectedFlags.includes(flag) ? '#22C55E' : '#FFF').borderColor('#D4D9E1').borderWidth(1).borderRadius(6).padding({ left: 16, right: 16, top: 10, bottom: 10 }).onClick(() => {
                if (this.selectedFlags.includes(flag)) {
                  this.selectedFlags = this.selectedFlags.filter(f => f !== flag)
                } else {
                  this.selectedFlags.push(flag)
                }
              })
            })

            // === Dark Mode Toggle ===
            // === Row ===
            // props: { space: 2 }
            // modifier: { layoutWeight: 1, justifyContent: FlexAlign.Start }
            // children: 2
            Row({ space: 2 }) {
              // === Text ===
              // props: { text: 'Dark' }
              // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
              Text('Dark').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#0B1220')
              // === Switch ===
              // props: { checked: this.darkMode }
              // modifier: { onChange: () => { this.darkMode = !this.darkMode } }
              Switch({ type: SwitchType.Button, checked: this.darkMode }).onChange((isOn: boolean) => {
                this.darkMode = isOn
              })
            }.layoutWeight(1).justifyContent(FlexAlign.Start)
          }.width('100%').padding({ top: 6, bottom: 6 })

          // === Metrics Grid ===
          // === Grid ===
          // props: { columnsTemplate: '1fr 1fr', columnsGap: 8, rowsGap: 8 }
          // modifier: { width: '100%' }
          // children: 6
          Grid() {
            ForEach(this.kpis, (metric: MetricCardUi) => {
              // === GridItem ===
              // children: 1
              GridItem() {
                // === Column ===
                // props: { space: 4 }
                // modifier: { width: '100%', height: 120, padding: 8, backgroundColor: '#FFF', borderRadius: 12, shadow: { radius: 4, color: '#24000000', offsetY: 2 }, borderColor: '#D4D9E1', borderWidth: 1 }
                // children: 3
                Column({ space: 4 }) {
                  // === Row ===
                  // props: { space: 4 }
                  // modifier: { width: '100%' }
                  // children: 2
                  Row({ space: 4 }) {
                    // === Text ===
                    // props: { text: metric.title }
                    // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
                    Text(metric.title).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                    Blank()
                    // === Image ===
                    // modifier: { width: 16, height: 16, borderRadius: 4, backgroundColor: metric.color }
                    Image('').width(16).height(16).borderRadius(4).backgroundColor(metric.color)
                  }.width('100%')

                  // === Text ===
                  // props: { text: metric.value }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Semibold, fontColor: '#0B1220' }
                  Text(metric.value).fontSize(18).fontWeight(FontWeight.Bold).fontColor('#0B1220')

                  // === Row ===
                  // props: { space: 2 }
                  // modifier: { width: '100%' }
                  // children: 2
                  Row({ space: 2 }) {
                    // === Image ===
                    // modifier: { width: 6, height: 6, borderRadius: 2, backgroundColor: metric.delta.startsWith('+') ? '#16A34A' : '#EF4444' }
                    Image('').width(6).height(6).borderRadius(2).backgroundColor(metric.delta.startsWith('+') ? '#16A34A' : '#EF4444')
                    // === Text ===
                    // props: { text: metric.delta }
                    // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: metric.delta.startsWith('+') ? '#16A34A' : '#EF4444' }
                    Text(metric.delta).fontSize(10).fontWeight(FontWeight.Medium).fontColor(metric.delta.startsWith('+') ? '#16A34A' : '#EF4444')
                  }.width('100%')
                }.width('100%').height(120).padding(8).backgroundColor('#FFF').borderRadius(12).shadow({ radius: 4, color: '#24000000', offsetY: 2 }).borderColor('#D4D9E1').borderWidth(1)
              }
            })

            ForEach(this.charts, (chart: ChartCardUi) => {
              // === GridItem ===
              // children: 1
              GridItem() {
                // === Column ===
                // props: { space: 6 }
                // modifier: { width: '100%', height: 180, padding: 8, backgroundColor: '#FFF', borderRadius: 12, shadow: { radius: 4, color: '#24000000', offsetY: 2 }, borderColor: '#D4D9E1', borderWidth: 1 }
                // children: 3
                Column({ space: 6 }) {
                  // === Text ===
                  // props: { text: chart.title }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
                  Text(chart.title).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#0B1220')

                  // === ZStack ===
                  // modifier: { width: '100%', aspectRatio: 1.6 }
                  // children: 2
                  Stack() {
                    // === Image ===
                    // modifier: { width: '100%', height: '100%', borderRadius: 8, backgroundColor: chart.color }
                    Image('').width('100%').height('100%').borderRadius(8).backgroundColor(chart.color)

                    // === Row ===
                    // props: { space: 4 }
                    // modifier: { justifyContent: FlexAlign.Center, alignItems: ItemAlign.End, height: '100%' }
                    // children: 6
                    Row({ space: 4 }) {
                      // === Image ===
                      // modifier: { width: 6, height: 40, borderRadius: 2, backgroundColor: '#0EA5E9' }
                      Image('').width(6).height(40).borderRadius(2).backgroundColor('#0EA5E9')
                      // === Image ===
                      // modifier: { width: 6, height: 30, borderRadius: 2, backgroundColor: '#22C55E' }
                      Image('').width(6).height(30).borderRadius(2).backgroundColor('#22C55E')
                      // === Image ===
                      // modifier: { width: 6, height: 48, borderRadius: 2, backgroundColor: '#F59E0B' }
                      Image('').width(6).height(48).borderRadius(2).backgroundColor('#F59E0B')
                      // === Image ===
                      // modifier: { width: 6, height: 22, borderRadius: 2, backgroundColor: '#D4D9E1' }
                      Image('').width(6).height(22).borderRadius(2).backgroundColor('#D4D9E1')
                      // === Image ===
                      // modifier: { width: 6, height: 32, borderRadius: 2, backgroundColor: '#0EA5E9' }
                      Image('').width(6).height(32).borderRadius(2).backgroundColor('#0EA5E9')
                      // === Image ===
                      // modifier: { width: 6, height: 42, borderRadius: 2, backgroundColor: '#22C55E' }
                      Image('').width(6).height(42).borderRadius(2).backgroundColor('#22C55E')
                    }.justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Bottom).height('100%')
                  }.width('100%').aspectRatio(1.6)

                  // === Row ===
                  // props: { space: 4 }
                  // modifier: { width: '100%' }
                  // children: 4
                  Row({ space: 4 }) {
                    // === Image ===
                    // modifier: { width: 8, height: 8, borderRadius: 2, backgroundColor: '#0EA5E9' }
                    Image('').width(8).height(8).borderRadius(2).backgroundColor('#0EA5E9')
                    // === Text ===
                    // props: { text: 'Series A' }
                    // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
                    Text('Series A').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                    // === Image ===
                    // modifier: { width: 8, height: 8, borderRadius: 2, backgroundColor: '#22C55E' }
                    Image('').width(8).height(8).borderRadius(2).backgroundColor('#22C55E')
                    // === Text ===
                    // props: { text: 'Series B' }
                    // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
                    Text('Series B').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  }.width('100%')
                }.width('100%').height(180).padding(8).backgroundColor('#FFF').borderRadius(12).shadow({ radius: 4, color: '#24000000', offsetY: 2 }).borderColor('#D4D9E1').borderWidth(1)
              }
            })
          }.columnsTemplate('1fr 1fr').columnsGap(8).rowsGap(8).width('100%')

          // === Spacer ===
          // modifier: { height: 80 }
          Blank().height(80)
        }.padding({ left: 8, right: 8, top: 6, bottom: 6 })
      }.layoutWeight(1)

      // === Bottom Notification Bar ===
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%' }
      // children: 2
      Column() {
        // === Divider ===
        // modifier: { color: '#D4D9E1', opacity: 0.3 }
        Divider().color('#D4D9E1').opacity(0.3)

        // === Row ===
        // props: { space: 4 }
        // modifier: { width: '100%', padding: { left: 8, right: 8, top: 6, bottom: 6 }, backgroundColor: '#FFF', shadow: { radius: 4, color: '#1A000000', offsetY: -2 } }
        // children: 2
        Row({ space: 4 }) {
          // === Column ===
          // props: { space: 2 }
          // modifier: { alignment: HorizontalAlign.Start }
          // children: 2
          Column({ space: 2 }) {
            // === Text ===
            // props: { text: 'Notifications' }
            // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
            Text('Notifications').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#0B1220')
            // === Text ===
            // props: { text: `${this.notificationCount} pending` }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Semibold, fontColor: '#0B1220' }
            Text(`${this.notificationCount} pending`).fontSize(18).fontWeight(FontWeight.Bold).fontColor('#0B1220')
          }.alignItems(HorizontalAlign.Start)

          Blank()

          // === Button ===
          // modifier: { type: ButtonType.Normal, stateEffect: true, backgroundColor: '#22C55E', borderRadius: 12, width: 140, height: 44 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Mark All Read' }
            // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#0F172A' }
            Text('Mark All Read').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#0F172A')
          }.type(ButtonType.Normal).stateEffect(true).backgroundColor('#22C55E').borderRadius(12).width(140).height(44).onClick(() => {
            this.notificationCount = 0
          })
        }.width('100%').padding({ left: 8, right: 8, top: 6, bottom: 6 }).backgroundColor('#FFF').shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
      }.width('100%')
    }.width('100%').height('100%').backgroundColor('#F7FAFC')
  }
}

interface MetricCardUi {
  id: number
  title: string
  value: string
  delta: string
  color: string
}

interface ChartCardUi {
  id: number
  title: string
  color: string
}