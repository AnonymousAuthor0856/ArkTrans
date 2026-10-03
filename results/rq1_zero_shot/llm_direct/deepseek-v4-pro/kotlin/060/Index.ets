@Entry
@Component
struct UnitConverterApp {
  @State activeUnit: string = 'Length';
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];

  // AppTokens Colors
  private primary: string = '#2563EB';
  private secondary: string = '#38BDF8';
  private tertiary: string = '#60A5FA';
  private background: string = '#F8FAFC';
  private surface: string = '#FFFFFF';
  private surfaceVariant: string = '#E2E8F0';
  private outline: string = '#CBD5E1';
  private onPrimary: string = '#FFFFFF';
  private onSecondary: string = '#0F172A';
  private onTertiary: string = '#FFFFFF';
  private onBackground: string = '#0F172A';
  private onSurface: string = '#1E293B';

  @Builder
  MarkerBox(unit: string, value: string, active: boolean) {
    Column() {
      Text(unit, {
        fontSize: 18,
        fontWeight: FontWeight.SemiBold,
        fontColor: this.onSurface
      })
      Text(value, {
        fontSize: 12,
        fontWeight: FontWeight.Normal,
        fontColor: this.onSurface
      })
    }
    .width('100%')
    .height(80)
    .padding(10)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(active ? '#38BDF84D' : this.surface)
    .borderRadius(10)
    .border({ width: 1, color: this.outline })
  }

  @Builder
  MapArea(selected: string) {
    Column() {
      Text('Unit Map Visualization', {
        fontSize: 18,
        fontWeight: FontWeight.SemiBold,
        fontColor: this.onSurface
      })
      Blank().height(10)
      Text(`Active Unit: ${selected}`, {
        fontSize: 12,
        fontWeight: FontWeight.Normal,
        fontColor: this.onSurface
      })
    }
    .width('100%')
    .height(240)
    .padding(14)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.surfaceVariant)
    .borderRadius(14)
    .border({ width: 1, color: this.outline })
  }

  @Builder
  ActionButton(label: string, active: boolean) {
    Button({ type: ButtonType.Normal }) {
      Text(label, {
        fontSize: 14,
        fontWeight: FontWeight.Medium,
        fontColor: active ? this.onPrimary : this.onSurface
      })
    }
    .backgroundColor(active ? this.primary : this.surfaceVariant)
    .borderRadius(6)
    .onClick(() => {
      this.activeUnit = label;
    })
  }

  build() {
    Column() {
      // Header
      Text('Unit Converter', {
        fontSize: 24,
        fontWeight: FontWeight.Bold,
        fontColor: this.onBackground
      })
      .margin({ bottom: 14 })

      // Map Area
      this.MapArea(this.activeUnit)

      // Marker Boxes
      ForEach(this.markers, (item: string) => {
        this.MarkerBox(item, 'Tap to convert', this.activeUnit === item)
      }, (item: string) => item)

      Blank().height(10)

      // Action Buttons Row
      Row({ space: 10 }) {
        ForEach(this.markers, (item: string) => {
          this.ActionButton(item, this.activeUnit === item)
        }, (item: string) => item)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [['#38BDF826', 0.0], ['#2563EB26', 1.0]]
    })
    .backgroundColor(this.background)
  }
}