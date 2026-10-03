@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = "Cool"

  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor('#808080')

        Column({ space: 4 }) {
          Text("LIVING ROOM")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor('#808080')
          
          if (this.isPowerOn) {
            Text("Active")
              .fontSize(12)
              .fontColor('#4CAF50')
          } else {
            Text("Off")
              .fontSize(12)
              .fontColor('#D3D3D3')
          }
        }
        .alignItems(HorizontalAlign.Center)

        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor('#808080')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })

      Column()
        .height(10)

      // Main Temperature Control
      Stack() {
        // Decorative Circle Background
        Column()
          .width(280)
          .height(280)
          .borderRadius(140)
          .border({ width: 1, color: '#EEEEEE' })

        // Center Content
        Column({ space: 8 }) {
          Text(`${this.targetTemp}°`)
            .fontSize(96)
            .fontWeight(FontWeight.Lighter)
            .fontColor(this.isPowerOn ? '#000000' : '#D3D3D3')
          
          Text(`CURRENT: ${this.currentTemp}°`)
            .fontSize(16)
            .fontColor('#808080')
        }

        // Left Button (Decrease)
        if (this.isPowerOn) {
          Column()
            .width(48)
            .height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .onClick(() => { this.targetTemp-- })
            .position({ x: 40, y: 116 }) // Approximate centering relative to stack
            
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#000000')
            .position({ x: 52, y: 128 })
        }

        // Right Button (Increase)
        if (this.isPowerOn) {
          Column()
            .width(48)
            .height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .onClick(() => { this.targetTemp++ })
            .position({ x: 192, y: 116 })

          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#000000')
            .position({ x: 204, y: 128 })
        }
      }
      .width(280)
      .height(280)
      .margin({ top: 20 })

      // Mode Selection
      Column({ space: 16 }) {
        Text("MODE")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        
        Row({ space: 12 }) {
          this.buildModeButton($r('app.media.startIcon'), "Auto", "Auto")
          this.buildModeButton($r('app.media.startIcon'), "Fan", "Fan")
          this.buildModeButton($r('app.media.startIcon'), "Cool", "Cool")
        }
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 20 })

      // Info Cards
      Row({ space: 16 }) {
        this.buildInfoCard($r('app.media.startIcon'), "Humidity", "45%", 1)
        this.buildInfoCard($r('app.media.startIcon'), "Energy", "12 kWh", -1)
      }
      .width('100%')
      .margin({ top: 20 })

      // Power Switch
      Row() {
        Column({ space: 4 }) {
          Text("Master Power")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          
          Text(this.isPowerOn ? "System is running" : "System is off")
            .fontSize(12)
            .fontColor('#808080')
        }

        Toggle({
          type: ToggleType.Switch,
          isOn: this.isPowerOn
        })
        .onChange((isOn: boolean) => {
          this.isPowerOn = isOn
        })
        .selectedColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#F9F9F9')
      .borderRadius(16)
      .margin({ top: 20, bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  buildModeButton(iconRes: Resource, label: string, mode: string) {
    Column({ space: 8 }) {
      Column() {
        Image(iconRes)
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(this.isSelected(mode) && this.isPowerOn ? '#FFFFFF' : (this.isPowerOn ? '#000000' : '#D3D3D3'))
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.isSelected(mode) && this.isPowerOn ? '#000000' : '#FFFFFF')
      .border({ 
        width: this.isSelected(mode) ? 0 : 1, 
        color: this.isSelected(mode) ? '#000000' : '#E0E0E0',
        radius: 30 
      })
      .enabled(this.isPowerOn)
      .onClick(() => { this.selectedMode = mode })

      Text(label)
        .fontSize(12)
        .fontColor(this.isPowerOn ? '#808080' : '#D3D3D3')
    }
  }

  @Builder
  buildInfoCard(iconRes: Resource, title: string, value: string, rotation: number) {
    Column({ space: 8 }) {
      Image(iconRes)
        .width(20)
        .height(20)
        .objectFit(ImageFit.Contain)
        .fillColor('#808080')
        .rotate({ angle: rotation * 90 })

      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
      
      Text(title)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width('50%')
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0', radius: 16 })
  }

  isSelected(mode: string): boolean {
    return this.selectedMode === mode
  }
}