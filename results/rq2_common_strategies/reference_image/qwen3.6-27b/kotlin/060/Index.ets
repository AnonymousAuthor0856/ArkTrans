@Entry
@Component
struct UnitConverter {
  // App Tokens / Constants
  private readonly primary: string = '#2563EB'
  private readonly secondary: string = '#38BDF8'
  private readonly tertiary: string = '#60A5FA'
  private readonly background: string = '#F8FAFC'
  private readonly surface: string = '#FFFFFF'
  private readonly surfaceVariant: string = '#E2E8F0'
  private readonly outline: string = '#CBD5E1'
  private readonly onPrimary: string = '#FFFFFF'
  private readonly onSecondary: string = '#0F172A'
  private readonly onTertiary: string = '#FFFFFF'
  private readonly onBackground: string = '#0F172A'
  private readonly onSurface: string = '#1E293B'

  @State activeUnit: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    Column() {
      // Main Container with Gradient Background
      Column() {
        // Title
        Text('Unit Converter')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackground)
          .margin({ bottom: 14 })

        // Map Area Visualization
        Column() {
          Text('Unit Map Visualization')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(this.onSurface)
          
          Text(`Active Unit: ${this.activeUnit}`)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor(this.onSurface)
            .margin({ top: 10 })
        }
        .width('100%')
        .height(240)
        .backgroundColor(this.surfaceVariant)
        .border({ width: 1, color: this.outline })
        .borderRadius(14)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ bottom: 14 })

        // Scrollable List of Markers
        Scroll() {
          Column() {
            ForEach(this.markers, (unit: string) => {
              this.MarkerBox(unit, 'Tap to convert', unit === this.activeUnit)
            }, (item: string) => item)
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .margin({ bottom: 14 })

        // Bottom Action Buttons
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
          ForEach(this.markers, (unit: string) => {
            Button(unit)
              .type(ButtonType.Capsule)
              .backgroundColor(unit === this.activeUnit ? this.primary : this.surfaceVariant)
              .fontColor(unit === this.activeUnit ? this.onPrimary : this.onSurface)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .margin({ right: 10, bottom: 10 })
              .onClick(() => {
                this.activeUnit = unit
              })
          }, (item: string) => item)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#38BDF8', 0.15], ['#2563EB', 0.15]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }

  @Builder
  MarkerBox(unit: string, value: string, isActive: boolean) {
    Row() {
      Column() {
        Text(unit)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.onSurface)
        
        Text(value)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.onSurface)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height(80)
    .backgroundColor(isActive ? Color.Rgba.from('#38BDF8').withAlpha(0.3) : this.surface)
    .border({ width: 1, color: this.outline })
    .borderRadius(10)
    .padding(10)
    .margin({ bottom: 10 })
  }
}