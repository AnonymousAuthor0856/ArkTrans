class UnitColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
}

@Entry
@Component
struct Index {
  @State active: string = 'Length';
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];

  @Builder
  MarkerBox(unit: string) {
    Column() {
      Text(unit)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(UnitColors.onSurface)
      Text('Tap to convert')
        .fontSize(12)
        .fontColor(UnitColors.onSurface)
        .margin({ top: 6 })
    }
    .width('100%')
    .height(80)
    .padding(10)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.active === unit ? '#4D38BDF8' : UnitColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: UnitColors.outline })
  }

  @Builder
  MapArea() {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(UnitColors.onSurface)
      Text('Active Unit: ' + this.active)
        .fontSize(12)
        .fontColor(UnitColors.onSurface)
        .margin({ top: 10 })
    }
    .width('100%')
    .height(240)
    .padding(14)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(UnitColors.surfaceVariant)
    .borderRadius(14)
    .border({ width: 1, color: UnitColors.outline })
  }

  build() {
    Column() {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(UnitColors.onBackground)
        .margin({ bottom: 14 })

      this.MapArea()

      ForEach(this.markers, (unit: string) => {
        Column() {
          this.MarkerBox(unit)
        }
        .margin({ top: 14 })
      }, (unit: string) => unit)

      Row() {
        ForEach(this.markers, (unit: string) => {
          Button(unit)
            .height(40)
            .fontSize(12)
            .fontColor(this.active === unit ? UnitColors.onPrimary : UnitColors.onSurface)
            .backgroundColor(this.active === unit ? UnitColors.primary : UnitColors.surfaceVariant)
            .borderRadius(8)
            .layoutWeight(1)
            .margin({ right: unit === 'Speed' ? 0 : 6 })
            .onClick(() => {
              this.active = unit;
            })
        }, (unit: string) => unit)
      }
      .width('100%')
      .margin({ top: 14 })
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]]
    })
    .backgroundColor(UnitColors.background)
  }
}
