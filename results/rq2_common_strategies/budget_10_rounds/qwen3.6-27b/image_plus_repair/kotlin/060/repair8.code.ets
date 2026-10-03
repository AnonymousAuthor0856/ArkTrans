@Entry
@Component
struct UnitConverter {
  // AppTokens Colors
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

  // State
  @State activeUnit: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    Column() {
      // Main Container with Gradient Background
      Column() {
        .width('100%')
        .height('100%')
        .padding(14) // Spacing.lg
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['#38BDF8', 0.15], // Secondary alpha
            ['#2563EB', 0.15]  // Primary alpha
          ]
        })

        // Title
        Text('Unit Converter')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackground)
          .margin({ bottom: 14 }) // Spacing.lg

        // Map Area Visualization
        Column() {
          Text('Unit Map Visualization')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
          
          Text(`Active Unit: ${this.activeUnit}`)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor(this.onSurface)
            .margin({ top: 10 }) // Spacing.md
        }
        .width('100%')
        .height(240)
        .backgroundColor(this.surfaceVariant)
        .border({ width: 1, color: this.outline })
        .borderRadius(14) // Shapes.large
        .padding(14) // Spacing.lg
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ bottom: 14 }) // Spacing.lg

        // Marker List
        ForEach(this.markers, (unit: string) => {
          this.MarkerBox(unit, this.activeUnit === unit)
        })

        Spacer().height(10) // Spacing.md

        // Action Buttons Row
        Row() {
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          
          ForEach(this.markers, (unit: string) => {
            Button(unit)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.activeUnit === unit ? this.onPrimary : this.onSurface)
              .backgroundColor(this.activeUnit === unit ? this.primary : this.surfaceVariant)
              .borderRadius(10) // Shapes.medium
              .onClick(() => {
                this.activeUnit = unit
              })
          })
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }

  @Builder
  MarkerBox(unit: string, isActive: boolean) {
    Column() {
      Text(unit)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurface)
      
      Text('Tap to convert')
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.onSurface)
        .margin({ top: 2 })
    }
    .width('100%')
    .height(80)
    .backgroundColor(isActive ? '#38BDF8' : this.surface)
    .border({ width: 1, color: this.outline })
    .borderRadius(10) // Shapes.medium
    .padding(10) // Spacing.md
    .margin({ bottom: 14 }) // Spacing.lg
    .onClick(() => {
      this.activeUnit = unit
    })
  }
}