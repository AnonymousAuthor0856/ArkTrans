import { common } from '@kit.AbilityKit'

@Entry
@Component
struct ChargingProgressPage {
  @State progress: number = 0.45
  private readonly primaryColor: string = '#3B82F6'
  private readonly secondaryColor: string = '#22C55E'
  private readonly backgroundColor: ResourceColor = Color('#F5F5F4')
  private readonly surfaceColor: ResourceColor = Color('#FFFFFF')
  private readonly outlineColor: ResourceColor = Color('#D4D4D8')
  private readonly onBackgroundColor: ResourceColor = Color('#111827')
  private readonly accentColor: ResourceColor = Color('#F59E0B')

  build() {
    Column() {
      // Top Bar
      Row() {
        Image('app.media.ic_electric_car')
          .width(24)
          .height(24)
          .fillColor(this.primaryColor)
          .margin({ left: 8 })

        Text("Charging Progress")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Image('app.media.ic_settings')
          .width(24)
          .height(24)
          .fillColor(this.accentColor)
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .backgroundColor(this.surfaceColor)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column() {
        // Battery Icon
        Image('app.media.ic_battery_charging')
          .width(72)
          .height(72)
          .fillColor(this.primaryColor)
          .margin({ top: 20 })

        // Percentage Text
        Text(`${Math.round(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .margin({ top: 10 })

        // Progress Bar
        Row() {
          Progress({ value: this.progress, total: 1.0 })
            .width('100%')
            .height(14)
            .linearProgressStyle({
              trackColor: Color.Gray,
              color: this.primaryColor,
              borderRadius: 7
            })
        }
        .width('80%')
        .margin({ top: 20 })
        .border({ width: 1, color: this.outlineColor, radius: 7 })

        // Simulate Button
        Button("Simulate Charge")
          .width(160)
          .height(40)
          .backgroundColor(this.secondaryColor)
          .fontColor(Color.White)
          .borderRadius(20)
          .margin({ top: 20 })
          .onClick(() => {
            this.progress += 0.1
            if (this.progress > 1) {
              this.progress = 0
            }
          })

        // Status Text
        Text(this.progress < 1 ? "Charging..." : "Fully Charged!")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1 ? this.primaryColor : this.secondaryColor)
          .margin({ top: 10 })
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .padding(14)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}