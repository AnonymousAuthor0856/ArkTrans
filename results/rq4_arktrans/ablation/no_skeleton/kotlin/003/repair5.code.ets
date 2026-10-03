// src/main/ets/view/RootScreen.ets

interface MetricCardUi {
  id: number;
  title: string;
  value: string;
  delta: string;
  color: string;
}

interface ChartCardUi {
  id: number;
  title: string;
  color: string;
}

@Entry
@Component
struct RootScreen {
  @State selectedRange: string = "7 Days"
  @State flags: string[] = []
  @State darkSwitch: boolean = false
  @State notifCount: number = 2

  private ranges: string[] = ["Today", "7 Days", "30 Days", "90 Days", "YTD", "Custom"]

  private kpis: MetricCardUi[] = [
    { id: 1, title: "Revenue", value: "$24,560", delta: "+8.2%", color: '#22C55E' },
    { id: 2, title: "Orders", value: "1,284", delta: "+3.1%", color: '#0EA5E9' },
    { id: 3, title: "Refunds", value: "42", delta: "-1.4%", color: '#EF4444' },
    { id: 4, title: "Active Users", value: "8,921", delta: "+5.6%", color: '#F59E0B' }
  ]

  private charts: ChartCardUi[] = [
    { id: 1, title: "Sales Trend", color: '#E0F2FE' },
    { id: 2, title: "Conversion Funnel", color: '#EFF6FF' },
    { id: 3, title: "Geo Distribution", color: '#ECFDF5' },
    { id: 4, title: "Device Breakdown", color: '#FFFFFBEB' }
  ]

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Image($r('app.media.startIcon'))
            .width(20)
            .height(20)
            .borderRadius(6)
          Text("Analytics")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
            .margin({ left: 4 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 40, bottom: 16 })

        // Range Chips (FlowRow equivalent using Flex)
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
          ForEach(this.ranges, (range: string) => {
            this.buildFilterChip(range)
          })
        }
        .width('100%')
        .itemGap(2)
        .columnGap(4)
        .padding({ left: 8, right: 8 })

        // Compare Section
        Column() {
          Row() {
            Text("Compare")
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
            
            Blank()

            this.buildAssistChip("Prev Period")
            this.buildAssistChip("Goal")

            Row() {
              Text("Dark")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
                .onChange((isOn: boolean) => {
                  this.darkSwitch = isOn
                })
                .selectedColor('#0EA5E9')
                .margin({ left: 4 })
            }.alignItems(VerticalAlign.Center).margin({ left: 2 })
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .margin({ left: 4 })
        }
        .padding({ top: 6, left: 8, right: 8 })

        // Grid Content
        List({ space: 8 }) {
          // KPI Cards
          ForEach(this.kpis, (item: MetricCardUi) => {
            ListItem() {
              this.buildKpiCard(item)
            }
          })

          // Chart Cards
          ForEach(this.charts, (item: ChartCardUi) => {
            ListItem() {
              this.buildChartCard(item)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 8, right: 8, bottom: 80 }) // Bottom padding for fixed bar
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7FAFC')

      // Bottom Bar
      Row() {
        Column() {
          Text("Notifications")
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
          Text(`${this.notifCount} pending`)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 2 })

        Blank()

        Button("Mark All Read")
          .type(ButtonType.Normal)
          .backgroundColor('#22C55E')
          .fontColor('#0F172A')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
          .width(140)
          .height(44)
          .onClick(() => {
            this.notifCount = 0
          })
      }
      .width('100%')
      .height(80)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
      .position({ x: 0, y: '100%' })
      .translate({ y: -80 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildFilterChip(label: string) {
    let isSelected = this.selectedRange === label
    Button(label) {
      Text(label)
        .fontSize(isSelected ? 14 : 12)
        .fontWeight(isSelected ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(isSelected ? '#FFFFFF' : '#0B1220')
    }
    .type(ButtonType.Capsule)
    .backgroundColor(isSelected ? '#0EA5E9' : '#FFFFFF')
    .border({ width: 1, color: '#D4D9E1', radius: 8 })
    .onClick(() => {
      this.selectedRange = label
    })
    .margin({ right: 4, bottom: 2 })
  }

  @Builder
  buildAssistChip(label: string) {
    let isActive = this.flags.includes(label)
    Button(label) {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(isActive ? '#0F172A' : '#0B1220')
    }
    .type(ButtonType.Capsule)
    .backgroundColor(isActive ? '#22C55E' : '#FFFFFF')
    .border({ width: 1, color: '#D4D9E1', radius: 6 })
    .onClick(() => {
      if (isActive) {
        const index = this.flags.indexOf(label)
        if (index > -1) this.flags.splice(index, 1)
      } else {
        this.flags.push(label)
      }
    })
    .margin({ right: 4 })
  }

  @Builder
  buildKpiCard(item: MetricCardUi) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        
        Blank()

        Circle({ width: 16, height: 16 })
          .fill(item.color)
          .borderRadius(6)
      }
      .width('100%')

      Text(item.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .margin({ top: 4 })

      Row() {
        Circle({ width: 6, height: 6 })
          .fill(item.delta.startsWith("+") ? '#16A34A' : '#EF4444')
          .borderRadius(6)
        
        Text(item.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(item.delta.startsWith("+") ? '#16A34A' : '#EF4444')
          .margin({ left: 2 })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 2 })
    }
    .width('100%')
    .padding(8)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D4D9E1' })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
    .height(120)
  }

  @Builder
  buildChartCard(item: ChartCardUi) {
    Column() {
      Text(item.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')

      // Mock Chart Area
      Row() {
        // Simulating bars with simple rectangles
        Rect().width(6).height(40).fill('#0EA5E9').borderRadius(6)
        Rect().width(6).height(30).fill('#22C55E').borderRadius(6).margin({ left: 4 })
        Rect().width(6).height(48).fill('#F59E0B').borderRadius(6).margin({ left: 4 })
        Rect().width(6).height(22).fill('#D4D9E1').borderRadius(6).margin({ left: 4 })
        Rect().width(6).height(32).fill('#0EA5E9').borderRadius(6).margin({ left: 4 })
        Rect().width(6).height(42).fill('#22C55E').borderRadius(6).margin({ left: 4 })
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Bottom)
      .backgroundColor(item.color)
      .borderRadius(8)
      .margin({ top: 6 })

      Row() {
        Circle({ width: 8, height: 8 }).fill('#0EA5E9').borderRadius(6)
        Text("Series A").fontSize(10).fontWeight(FontWeight.Medium).fontColor('#0B1220').margin({ left: 4 })
        Circle({ width: 8, height: 8 }).fill('#22C55E').borderRadius(6).margin({ left: 8 })
        Text("Series B").fontSize(10).fontWeight(FontWeight.Medium).fontColor('#0B1220').margin({ left: 4 })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 6 })
    }
    .width('100%')
    .padding(8)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D4D9E1' })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
    .height(180)
  }
}