@Entry
@Component
struct Index {
  @State active: string = 'Length'

  build() {
    Stack() {
      Column() {
        Text('Unit Converter')
          .fontColor('#0F172A')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 24 })

        // Visualization Card
        Column() {
          Text('Unit Map Visualization')
            .fontColor('#1E293B')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          
          Text(`Active Unit: ${this.active}`)
            .fontColor('#1E293B')
            .fontSize(16)
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#E2E8F0')
        .borderRadius(24)
        .borderWidth(1)
        .borderColor('#CBD5E1')
        .margin({ bottom: 24 })

        // List of Units
        Column({ space: 16 }) {
          this.buildUnitCard('Length', 'Tap to convert')
          this.buildUnitCard('Weight', 'Tap to convert')
          this.buildUnitCard('Temperature', 'Tap to convert')
          this.buildUnitCard('Speed', 'Tap to convert')
        }
        .layoutWeight(1)

        Blank().height(24)

        // Bottom Navigation Buttons
        Row({ space: 12 }) {
          Button('Length')
            .type(ButtonType.Normal)
            .backgroundColor(this.active === 'Length' ? '#2563EB' : '#F1F5F9')
            .fontColor(this.active === 'Length' ? '#FFFFFF' : '#1E293B')
            .borderRadius(12)
            .height(48)
            .onClick(() => { this.active = 'Length' })

          Button('Weight')
            .type(ButtonType.Normal)
            .backgroundColor(this.active === 'Weight' ? '#2563EB' : '#F1F5F9')
            .fontColor(this.active === 'Weight' ? '#FFFFFF' : '#1E293B')
            .borderRadius(12)
            .height(48)
            .onClick(() => { this.active = 'Weight' })

          Button('Temperature')
            .type(ButtonType.Normal)
            .backgroundColor(this.active === 'Temperature' ? '#2563EB' : '#F1F5F9')
            .fontColor(this.active === 'Temperature' ? '#FFFFFF' : '#1E293B')
            .borderRadius(12)
            .height(48)
            .onClick(() => { this.active = 'Temperature' })

          Button('Speed')
            .type(ButtonType.Normal)
            .backgroundColor(this.active === 'Speed' ? '#2563EB' : '#F1F5F9')
            .fontColor(this.active === 'Speed' ? '#FFFFFF' : '#1E293B')
            .borderRadius(12)
            .height(48)
            .onClick(() => { this.active = 'Speed' })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .linearGradient({
        angle: 180,
        colors: [['#E0F2FE', 0], ['#DBEAFE', 1]]
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildUnitCard(title: string, subtitle: string) {
    Column() {
      Text(title)
        .fontColor('#1E293B')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
      
      Text(subtitle)
        .fontColor('#475569')
        .fontSize(14)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height(80)
    .padding(20)
    .backgroundColor(this.active === title ? '#BAE6FD' : '#FFFFFF')
    .borderRadius(16)
    .borderWidth(1)
    .borderColor('#CBD5E1')
    .onClick(() => { this.active = title })
  }
}