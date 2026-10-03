// Index.ets

interface MetricCardUi {
  id: number;
  title: string;
  value: string;
  delta: string;
  color: ResourceColor;
}

interface ChartCardUi {
  id: number;
  title: string;
  color: ResourceColor;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors = {
    primary: '#FF0EA5E9',
    secondary: '#FF22C55E',
    tertiary: '#FFF59E0B',
    background: '#FFF7FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFEFF3F7',
    outline: '#FFD4D9E1',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FF111827',
    onBackground: '#FF0B1220',
    onSurface: '#FF0B1220',
  }
  static Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24,
  }
  static ElevationMapping = {
    level1: { elevation: 1, radius: 2, dy: 0.5, opacity: 0.12 } as ShadowSpec,
    level2: { elevation: 2, radius: 4, dy: 1, opacity: 0.14 } as ShadowSpec,
    level3: { elevation: 3, radius: 6, dy: 1.5, opacity: 0.16 } as ShadowSpec,
    level4: { elevation: 4, radius: 8, dy: 2, opacity: 0.18 } as ShadowSpec,
    level5: { elevation: 5, radius: 10, dy: 2.5, opacity: 0.2 } as ShadowSpec,
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedRange: string = '7 Days';
  @State flags: string[] = [];
  @State darkSwitch: boolean = false;
  @State notif: number = 2;

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom'];
  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: AppTokens.Colors.secondary },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: AppTokens.Colors.primary },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: AppTokens.Colors.error },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: AppTokens.Colors.tertiary }
  ];
  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#FFE0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#FFEFF6FF' },
    { id: 3, title: 'Geo Distribution', color: '#FFECFDF5' },
    { id: 4, title: 'Device Breakdown', color: '#FFFFFBEB' }
  ];

  toggleFlag(flag: string) {
    const index = this.flags.indexOf(flag);
    if (index >= 0) {
      this.flags.splice(index, 1);
    } else {
      this.flags.push(flag);
    }
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Box()
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(6)
          Text('Analytics')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ horizontal: AppTokens.Spacing.lg })

      // Content
      Scroll() {
        Column() {
          // Range Chips
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.ranges, (r: string) => {
              Text(r)
                .fontSize(r === this.selectedRange ? 14 : 12)
                .fontWeight(r === this.selectedRange ? FontWeight.Medium : FontWeight.Normal)
                .fontColor(r === this.selectedRange ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(r === this.selectedRange ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .border({ width: 1, color: AppTokens.Colors.outline, radius: 8 })
                .padding({ horizontal: 12, vertical: 6 })
                .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })
                .onClick(() => {
                  this.selectedRange = r;
                })
            })
          }
          .width('100%')

          // Compare Chips
          Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center }) {
            Text('Compare')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })

            Text('Prev Period')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.flags.includes('Prev Period') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
              .backgroundColor(this.flags.includes('Prev Period') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
              .border({ width: 1, color: AppTokens.Colors.outline, radius: 6 })
              .padding({ horizontal: 8, vertical: 4 })
              .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })
              .onClick(() => this.toggleFlag('Prev Period'))

            Text('Goal')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.flags.includes('Goal') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
              .backgroundColor(this.flags.includes('Goal') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
              .border({ width: 1, color: AppTokens.Colors.outline, radius: 6 })
              .padding({ horizontal: 8, vertical: 4 })
              .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })
              .onClick(() => this.toggleFlag('Goal'))

            Row() {
              Text('Dark')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ right: AppTokens.Spacing.xs })
              Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
                .selectedColor(AppTokens.Colors.primary)
                .onChange((isOn: boolean) => {
                  this.darkSwitch = isOn;
                })
            }
            .alignItems(VerticalAlign.Center)
            .margin({ bottom: AppTokens.Spacing.xs })
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })

          // KPI Grid
          Grid() {
            ForEach(this.kpis, (m: MetricCardUi) => {
              GridItem() {
                Column() {
                  Row() {
                    Text(m.title)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.onSurface)
                    Box()
                      .width(16)
                      .height(16)
                      .backgroundColor(m.color)
                      .borderRadius(6)
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(VerticalAlign.Center)

                  Text(m.value)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.sm })

                  Row() {
                    Box()
                      .width(6)
                      .height(6)
                      .backgroundColor(m.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
                      .borderRadius(6)
                    Text(m.delta)
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(m.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
                      .margin({ left: AppTokens.Spacing.xs })
                  }
                  .alignItems(VerticalAlign.Center)
                  .margin({ top: AppTokens.Spacing.sm })
                }
                .width('100%')
                .height(120)
                .padding(AppTokens.Spacing.lg)
                .backgroundColor(AppTokens.Colors.surface)
                .border({ width: 1, color: AppTokens.Colors.outline, radius: 12 })
                .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.dy })
              }
            })

            ForEach(this.charts, (c: ChartCardUi) => {
              GridItem() {
                Column() {
                  Text(c.title)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)

                  Row() {
                    Box().width(6).height(40).backgroundColor(AppTokens.Colors.primary).borderRadius(6)
                    Box().width(6).height(30).backgroundColor(AppTokens.Colors.secondary).borderRadius(6)
                    Box().width(6).height(48).backgroundColor(AppTokens.Colors.tertiary).borderRadius(6)
                    Box().width(6).height(22).backgroundColor(AppTokens.Colors.outline).borderRadius(6)
                    Box().width(6).height(32).backgroundColor(AppTokens.Colors.primary).borderRadius(6)
                    Box().width(6).height(42).backgroundColor(AppTokens.Colors.secondary).borderRadius(6)
                  }
                  .width('100%')
                  .height(180)
                  .justifyContent(FlexAlign.SpaceEvenly)
                  .alignItems(VerticalAlign.Bottom)
                  .backgroundColor(c.color)
                  .borderRadius(8)
                  .margin({ top: AppTokens.Spacing.md })

                  Row() {
                    Box().width(8).height(8).backgroundColor(AppTokens.Colors.primary).borderRadius(6)
                    Text('Series A')
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.onSurface)
                      .margin({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.sm })

                    Box().width(8).height(8).backgroundColor(AppTokens.Colors.secondary).borderRadius(6)
                    Text('Series B')
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.onSurface)
                      .margin({ left: AppTokens.Spacing.xs })
                  }
                  .alignItems(VerticalAlign.Center)
                  .margin({ top: AppTokens.Spacing.md })
                }
                .width('100%')
                .height(280)
                .padding(AppTokens.Spacing.lg)
                .backgroundColor(AppTokens.Colors.surface)
                .border({ width: 1, color: AppTokens.Colors.outline, radius: 12 })
                .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.dy })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.lg)
          .rowsGap(AppTokens.Spacing.lg)
          .padding({ top: AppTokens.Spacing.lg, bottom: 80 })
          .width('100%')
        }
        .width('100%')
        .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .width('100%')

      // Bottom Bar
      Row() {
        Column() {
          Text('Notifications')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text(`${this.notif} pending`)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Mark All Read')
          .type(ButtonType.Capsule)
          .width(140)
          .height(44)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .onClick(() => {
            this.notif = 0;
          })
      }
      .width('100%')
      .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: AppTokens.ElevationMapping.level3.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`, offsetX: 0, offsetY: -AppTokens.ElevationMapping.level3.dy })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}