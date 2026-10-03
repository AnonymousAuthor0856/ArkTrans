const Colors = {
  primary: '#2563EB',
  secondary: '#38BDF8',
  tertiary: '#60A5FA',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#CBD5E1',
  onPrimary: '#FFFFFF',
  onSecondary: '#0F172A',
  onTertiary: '#FFFFFF',
  onBackground: '#0F172A',
  onSurface: '#1E293B'
}

@Entry
@Component
struct Index {
  @State active: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    Column({ space: 14 }) {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onBackground)

      this.MapArea(this.active)

      ForEach(this.markers, (item: string) => {
        this.MarkerBox(item, 'Tap to convert', this.active === item)
      }, (item: string) => item)

      Blank().height(10)

      Row({ space: 10 }) {
        ForEach(this.markers, (item: string) => {
          Button(item, { type: ButtonType.Normal })
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(this.active === item ? Colors.primary : Colors.surfaceVariant)
            .fontColor(this.active === item ? Colors.onPrimary : Colors.onSurface)
            .borderRadius(10)
            .padding({ left: 12, right: 12 })
            .onClick(() => {
              this.active = item
            })
        }, (item: string) => item)
      }
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]]
    })
    .backgroundColor(Colors.background)
  }

  @Builder
  MarkerBox(unit: string, value: string, active: boolean) {
    Row() {
      Column() {
        Text(unit)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
        Text(value)
          .fontSize(12)
          .fontColor(Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(80)
    .padding(10)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(active ? '#4D38BDF8' : Colors.surface)
    .borderRadius(10)
    .border({ width: 1, color: Colors.outline })
  }

  @Builder
  MapArea(selected: string) {
    Column({ space: 10 }) {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)
      Text('Active Unit: ' + selected)
        .fontSize(12)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .height(240)
    .padding(14)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(14)
    .border({ width: 1, color: Colors.outline })
  }
}
