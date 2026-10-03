interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

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

const Colors: ColorTokens = {
  primary: '#0EA5E9',
  secondary: '#22C55E',
  tertiary: '#F59E0B',
  background: '#F7FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#EFF3F7',
  outline: '#D4D9E1',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#0F172A',
  onTertiary: '#111827',
  onBackground: '#0B1220',
  onSurface: '#0B1220'
};

@Entry
@Component
struct RootScreen {
  @State selectedRange: string = '7 Days';
  @State flagsPrevPeriod: boolean = false;
  @State flagsGoal: boolean = false;
  @State darkSwitch: boolean = false;
  @State notif: number = 2;

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom'];
  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: Colors.secondary },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: Colors.primary },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: Colors.error },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: Colors.tertiary }
  ];
  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' },
    { id: 3, title: 'Geo Distribution', color: '#ECFDF5' },
    { id: 4, title: 'Device Breakdown', color: '#FFFBEB' }
  ];

  @Builder
  rangeChip(label: string, active: boolean) {
    Text(label)
      .fontSize(active ? 14 : 12)
      .fontWeight(active ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(active ? Colors.onPrimary : Colors.onSurface)
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .backgroundColor(active ? Colors.primary : Colors.surface)
      .borderRadius(8)
      .border({ width: 1, color: Colors.outline })
      .margin({ right: 4, bottom: 2 })
      .onClick(() => {
        this.selectedRange = label;
      })
  }

  @Builder
  metricCard(m: MetricCardUi) {
    Column({ space: 4 }) {
      Row() {
        Text(m.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
        Stack() {}
          .width(16)
          .height(16)
          .backgroundColor(m.color)
          .borderRadius(6)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(m.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)

      Row({ space: 2 }) {
        Stack() {}
          .width(6)
          .height(6)
          .backgroundColor(m.delta.startsWith('+') ? Colors.success : Colors.error)
          .borderRadius(6)
        Text(m.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(m.delta.startsWith('+') ? Colors.success : Colors.error)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('48%')
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline })
    .constraintSize({ minHeight: 120 })
    .shadow({ radius: 4, color: 0x24000000, offsetY: 1 })
  }

  @Builder
  chartCard(c: ChartCardUi) {
    Column({ space: 6 }) {
      Text(c.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)

      Stack() {
        Row({ space: 4 }) {
          Stack() {}.width(6).height(40).backgroundColor(Colors.primary).borderRadius(6)
          Stack() {}.width(6).height(30).backgroundColor(Colors.secondary).borderRadius(6)
          Stack() {}.width(6).height(48).backgroundColor(Colors.tertiary).borderRadius(6)
          Stack() {}.width(6).height(22).backgroundColor(Colors.outline).borderRadius(6)
          Stack() {}.width(6).height(32).backgroundColor(Colors.primary).borderRadius(6)
          Stack() {}.width(6).height(42).backgroundColor(Colors.secondary).borderRadius(6)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .aspectRatio(1.6)
      .backgroundColor(c.color)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      Row({ space: 4 }) {
        Stack() {}.width(8).height(8).backgroundColor(Colors.primary).borderRadius(6)
        Text('Series A').fontSize(10).fontWeight(FontWeight.Medium).fontColor(Colors.onSurface)
        Stack() {}.width(8).height(8).backgroundColor(Colors.secondary).borderRadius(6)
        Text('Series B').fontSize(10).fontWeight(FontWeight.Medium).fontColor(Colors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('48%')
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline })
    .constraintSize({ minHeight: 180 })
    .shadow({ radius: 4, color: 0x24000000, offsetY: 1 })
  }

  build() {
    Column() {
      Row() {
        Row({ space: 4 }) {
          Stack() {}
            .width(20)
            .height(20)
            .backgroundColor(Colors.primary)
            .borderRadius(6)
          Text('Analytics')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.surface)

      Scroll() {
        Column() {
          Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Start }) {
            ForEach(this.ranges, (r: string) => {
              this.rangeChip(r, r === this.selectedRange)
            }, (r: string) => r)
          }
          .width('100%')

          Blank().height(6)

          Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Start }) {
            Text('Compare')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .margin({ right: 4, bottom: 2 })

            Text('Prev Period')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.flagsPrevPeriod ? Colors.onSecondary : Colors.onSurface)
              .padding({ left: 10, right: 10, top: 4, bottom: 4 })
              .backgroundColor(this.flagsPrevPeriod ? Colors.secondary : Colors.surface)
              .borderRadius(6)
              .border({ width: 1, color: Colors.outline })
              .margin({ right: 4, bottom: 2 })
              .onClick(() => {
                this.flagsPrevPeriod = !this.flagsPrevPeriod;
              })

            Text('Goal')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.flagsGoal ? Colors.onSecondary : Colors.onSurface)
              .padding({ left: 10, right: 10, top: 4, bottom: 4 })
              .backgroundColor(this.flagsGoal ? Colors.secondary : Colors.surface)
              .borderRadius(6)
              .border({ width: 1, color: Colors.outline })
              .margin({ right: 4, bottom: 2 })
              .onClick(() => {
                this.flagsGoal = !this.flagsGoal;
              })

            Row({ space: 2 }) {
              Text('Dark')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
                .selectedColor(Colors.primary)
                .switchPointColor(Colors.onPrimary)
                .onChange((isOn: boolean) => {
                  this.darkSwitch = isOn;
                })
            }
            .alignItems(VerticalAlign.Center)
            .margin({ right: 4, bottom: 2 })
          }
          .width('100%')

          Blank().height(8)

          Column({ space: 8 }) {
            Row() {
              this.metricCard(this.kpis[0])
              this.metricCard(this.kpis[1])
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              this.metricCard(this.kpis[2])
              this.metricCard(this.kpis[3])
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              this.chartCard(this.charts[0])
              this.chartCard(this.charts[1])
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              this.chartCard(this.charts[2])
              this.chartCard(this.charts[3])
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 30 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')

      Row() {
        Column({ space: 2 }) {
          Text('Notifications')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text(this.notif + ' pending')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Mark All Read', { type: ButtonType.Normal })
          .height(44)
          .width(140)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .backgroundColor(Colors.secondary)
          .borderRadius(12)
          .onClick(() => {
            this.notif = 0;
          })
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)
      .shadow({ radius: 6, color: 0x29000000, offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
