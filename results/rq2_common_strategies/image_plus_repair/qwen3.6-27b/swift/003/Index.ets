// App.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct AnalyticsDashboard {
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
    Column() {
      // Header
      Row() {
        Blank()
        Row({ space: 4 }) {
          Rectangle()
            .fill('#0EA5E9')
            .width(20)
            .height(20)
            .borderRadius(4)
          
          Text('Analytics')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
        }
        Blank()
      }
      .padding({ top: 48, bottom: 12 })
      .backgroundColor('#F7FAFC')
      
      Divider().color('#D4D9E1')

      // Content
      Scroll() {
        Column({ space: 6 }) {
          // Date Range Selector
          Scroll() {
            Column() {
              Row({ space: 4 }) {
                ForEach(this.ranges, (range: string) => {
                  this.rangeButton(range)
                })
              }
              .padding({ top: 4, bottom: 4 })
              
              Row({ space: 4 }) {
                ForEach(this.ranges2, (range: string) => {
                  this.rangeButton(range)
                })
                Blank()
              }
              .padding({ top: 8, bottom: 8 })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          // Comparison Options
          Row({ space: 4 }) {
            Text('Compare')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
            
            ForEach(this.flags, (flag: string) => {
              this.flagButton(flag)
            })
            
            Row({ space: 2 }) {
              Text('Dark')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              
              Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                .onChange((isOn: boolean) => {
                  this.darkMode = isOn
                })
                .selectedColor('#0EA5E9')
                .scale({ x: 0.8, y: 0.8 })
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.Start)
          }
          .padding({ top: 6, bottom: 6 })

          // Metrics Grid
          GridContainer()
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('auto auto auto')
            .gaps({ rowGap: 8, columnGap: 8 })
            .childWidth('100%')
            .childHeight('auto')
            .align(Alignment.Top)
            .width('100%')
          {
            ForEach(this.kpis, (metric: MetricCardUi) => {
              MetricCardView({ metric: metric })
            })
            
            ForEach(this.charts, (chart: ChartCardUi) => {
              ChartCardView({ chart: chart })
            })
          }
          
          Blank().height(80)
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      }
      .backgroundColor('#F7FAFC')
      .layoutWeight(1)

      // Bottom Notification Bar
      Column() {
        Divider().color('#D4D9E1').opacity(0.3)
        
        Row() {
          Column({ space: 2 }) {
            Text('Notifications')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
            
            Text(`${this.notificationCount} pending`)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0B1220')
          }
          
          Blank()
          
          Button('Mark All Read')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
            .backgroundColor('#22C55E')
            .borderRadius(12)
            .width(140)
            .height(44)
            .onClick(() => {
              this.notificationCount = 0
            })
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#00000022', offsetY: -2 })
      }
    }
    .backgroundColor('#F7FAFC')
    .width('100%')
    .height('100%')
  }

  @Builder
  rangeButton(range: string) {
    Button(range) {
      Text(range)
        .fontSize(this.selectedRange === range ? 14 : 12)
        .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.selectedRange === range ? '#FFFFFF' : '#0B1220')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    }
    .backgroundColor(this.selectedRange === range ? '#0EA5E9' : '#FFFFFF')
    .border({ width: 1, color: '#D4D9E1', radius: 8 })
    .onClick(() => {
      this.selectedRange = range
    })
  }

  @Builder
  flagButton(flag: string) {
    Button(flag) {
      Text(flag)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedFlags.includes(flag) ? '#0F172A' : '#0B1220')
        .maxLines(1)
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
    }
    .backgroundColor(this.selectedFlags.includes(flag) ? '#22C55E' : '#FFFFFF')
    .border({ width: 1, color: '#D4D9E1', radius: 6 })
    .onClick(() => {
      const index = this.selectedFlags.indexOf(flag)
      if (index > -1) {
        this.selectedFlags.splice(index, 1)
      } else {
        this.selectedFlags.push(flag)
      }
    })
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

@Component
struct MetricCardView {
  metric: MetricCardUi = { id: 0, title: '', value: '', delta: '', color: '' }

  build() {
    Column({ space: 4 }) {
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        
        Blank()
        
        Rectangle()
          .fill(this.metric.color)
          .width(16)
          .height(16)
          .borderRadius(4)
      }
      
      Text(this.metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
      
      Row({ space: 2 }) {
        Rectangle()
          .fill(this.metric.delta.startsWith('+') ? '#16A34A' : '#EF4444')
          .width(6)
          .height(6)
          .borderRadius(2)
        
        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith('+') ? '#16A34A' : '#EF4444')
      }
      
      Blank()
    }
    .padding(8)
    .height(120)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D4D9E1' })
    .shadow({ radius: 4, color: '#00000024', offsetY: 2 })
  }
}

@Component
struct ChartCardView {
  chart: ChartCardUi = { id: 0, title: '', color: '' }

  build() {
    Column({ space: 6 }) {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')
      
      Stack() {
        Rectangle()
          .fill(this.chart.color)
          .borderRadius(8)
          .width('100%')
          .height(80)
        
        Row({ space: 4 }) {
          this.bar('#0EA5E9', 40)
          this.bar('#22C55E', 30)
          this.bar('#F59E0B', 48)
          this.bar('#D4D9E1', 22)
          this.bar('#0EA5E9', 32)
          this.bar('#22C55E', 42)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('100%')
      }
      .aspectRatio(1.6)
      .width('100%')
      
      Row({ space: 4 }) {
        Rectangle()
          .fill('#0EA5E9')
          .width(8)
          .height(8)
          .borderRadius(2)
        
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        
        Rectangle()
          .fill('#22C55E')
          .width(8)
          .height(8)
          .borderRadius(2)
        
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
      }
    }
    .padding(8)
    .height(180)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D4D9E1' })
    .shadow({ radius: 4, color: '#00000024', offsetY: 2 })
  }

  @Builder
  bar(color: string, height: number) {
    Rectangle()
      .fill(color)
      .width(6)
      .height(height)
      .borderRadius(2)
  }
}