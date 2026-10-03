@Entry
@Component
struct ThermostatApp {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = "Cool"

  build() {
    // === Stack ===
    // props: {}
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack() {
      // === Color ===
      // modifier: { width: '100%', height: '100%' }
      Circle().fill(Color.White).width('100%').height('100%')

      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%' }
      // children: 9
      Column() {
        // === TopBar ===
        // modifier: { padding: { left: 24, right: 24, top: 24, bottom: 24 } }
        this.TopBar()

        // === Spacer ===
        // modifier: { height: 10 }
        Blank().height(10)

        // === TemperatureControl ===
        this.TemperatureControl()

        // === Spacer ===
        Blank()

        // === ModeSelection ===
        this.ModeSelection()

        // === Spacer ===
        Blank()

        // === InfoCardsRow ===
        // modifier: { padding: { left: 24, right: 24 } }
        Row() {
          this.InfoCard('Humidity', '45%', $r('app.media.startIcon'))
          this.InfoCard('Energy', '12 kWh', $r('app.media.startIcon'))
        }.padding({ left: 24, right: 24 })

        // === Spacer ===
        Blank()

        // === PowerSwitch ===
        // modifier: { padding: { bottom: 40, left: 24, right: 24 } }
        Row() {
          // === Column ===
          // props: { space: 0, alignItems: ItemAlign.Start }
          // children: 2
          Column({ space: 0 }) {
            // === Text ===
            // props: { text: 'Master Power' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.SemiBold, color: '#000' }
            Text('Master Power').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
            
            // === Text ===
            // props: { text: 'System is running' or 'System is off' }
            // modifier: { fontSize: 12, color: '#999999' }
            Text(this.isPowerOn ? 'System is running' : 'System is off').fontSize(12).fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)

          // === Blank ===
          Blank()

          // === Toggle ===
          // props: { type: ToggleType.Switch, isOn: this.isPowerOn }
          // modifier: { color: '#000' }
          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .onChange((isOn: boolean) => {
              this.isPowerOn = isOn
            })
            .selectedColor('#000000')
        }
        .padding(20)
        .width('100%')
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
        .padding({ bottom: 40, left: 24, right: 24 })
      }
    }
  }

  @Builder
  TopBar() {
    // === Row ===
    // props: { space: 0 }
    // children: 5
    Row() {
      // === Button (Menu) ===
      // modifier: { width: 24, height: 24 }
      Button() {
        Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
      }.backgroundColor(Color.Transparent)

      // === Blank ===
      Blank()

      // === Column (Texts) ===
      // props: { space: 2 }
      // children: 2
      Column() {
        // === Text ===
        // props: { text: 'LIVING ROOM' }
        // modifier: { fontSize: 12, fontWeight: FontWeight.Bold, letterSpacing: 2, color: '#999999' }
        Text('LIVING ROOM').fontSize(12).fontWeight(FontWeight.Bold).letterSpacing(2).fontColor('#999999')
        
        // === Text ===
        // props: { text: 'Active' or 'Off' }
        // modifier: { fontSize: 11, color: '#4CAF50' or '#999999' }
        Text(this.isPowerOn ? 'Active' : 'Off').fontSize(11).fontColor(this.isPowerOn ? '#4CAF50' : '#999999')
      }

      // === Blank ===
      Blank()

      // === Button (Settings) ===
      // modifier: { width: 24, height: 24 }
      Button() {
        Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
      }.backgroundColor(Color.Transparent)
    }
  }

  @Builder
  TemperatureControl() {
    // === Stack ===
    // props: {}
    // modifier: { width: 280, height: 280 }
    // children: 3
    Stack() {
      // === Circle (Background) ===
      // modifier: { width: 280, height: 280, borderColor: '#EEEEEE', borderWidth: 1, backgroundColor: '#FFF' }
      Circle().width(280).height(280).border({ width: 1, color: '#EEEEEE' }).backgroundColor('#FFF')

      // === Column (Text Content) ===
      // props: { space: 0 }
      // children: 2
      Column() {
        // === Text ===
        // props: { text: '24°' }
        // modifier: { fontSize: 96, fontWeight: FontWeight.Light, color: '#000' or '#D3D3D3' }
        Text(`${this.targetTemp}°`).fontSize(96).fontWeight(FontWeight.Lighter).fontColor(this.isPowerOn ? '#000000' : '#D3D3D3')
        
        // === Text ===
        // props: { text: 'CURRENT: 22°' }
        // modifier: { fontSize: 14, color: '#999999' }
        Text(`CURRENT: ${this.currentTemp}°`).fontSize(14).fontColor('#999999')
      }

      // === Row (Buttons) ===
      // props: { space: 0 }
      // modifier: { width: 280 }
      // children: 3
      if (this.isPowerOn) {
        Row() {
          // === Button (Decrease) ===
          // modifier: { width: 48, height: 48, margin: { left: 20 }, backgroundColor: '#F5F5F5', borderRadius: 24 }
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
          }.width(48).height(48).margin({ left: 20 }).backgroundColor('#F5F5F5').borderRadius(24)
            .onClick(() => {
              this.targetTemp -= 1
            })

          // === Blank ===
          Blank()

          // === Button (Increase) ===
          // modifier: { width: 48, height: 48, margin: { right: 20 }, backgroundColor: '#F5F5F5', borderRadius: 24 }
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
          }.width(48).height(48).margin({ right: 20 }).backgroundColor('#F5F5F5').borderRadius(24)
            .onClick(() => {
              this.targetTemp += 1
            })
        }.width(280)
      }
    }
  }

  @Builder
  ModeSelection() {
    // === Column ===
    // props: { space: 16 }
    // children: 2
    Column() {
      // === Text ===
      // props: { text: 'MODE' }
      // modifier: { fontSize: 11, fontWeight: FontWeight.Bold, color: '#999999' }
      Text('MODE').fontSize(11).fontWeight(FontWeight.Bold).fontColor('#999999')

      // === Row ===
      // props: { space: 12 }
      // children: 3
      Row() {
        this.ModeButton('Auto', $r('app.media.startIcon'))
        this.ModeButton('Fan', $r('app.media.startIcon'))
        this.ModeButton('Cool', $r('app.media.startIcon'))
      }
    }
  }

  @Builder
  ModeButton(label: string, iconResource: Resource) {
    // === Column ===
    // props: { space: 8 }
    // children: 2
    Column() {
      // === Button ===
      // modifier: { width: 60, height: 60, borderRadius: 30, backgroundColor: isSelected && isEnabled ? '#000' : '#FFF', border: !isSelected ? { width: 1, color: '#E0E0E0' } : {} }
      Button() {
        // === Image ===
        // modifier: { width: 24, height: 24, color: isSelected && isEnabled ? '#FFF' : (isEnabled ? '#000' : '#D3D3D3') }
        Image(iconResource)
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(this.selectedMode === label && this.isPowerOn ? '#FFFFFF' : (this.isPowerOn ? '#000000' : '#D3D3D3'))
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.selectedMode === label && this.isPowerOn ? '#000000' : '#FFFFFF')
      .border({
        width: this.selectedMode === label ? 0 : 1,
        color: '#E0E0E0'
      })
      .enabled(this.isPowerOn)
      .onClick(() => {
        this.selectedMode = label
      })

      // === Text ===
      // props: { text: label }
      // modifier: { fontSize: 11, color: isEnabled ? '#999999' : '#D3D3D3' }
      Text(label).fontSize(11).fontColor(this.isPowerOn ? '#999999' : '#D3D3D3')
    }
  }

  @Builder
  InfoCardsRow() {
    // === Row ===
    // props: { space: 16 }
    // children: 2
    Row() {
      this.InfoCard('Humidity', '45%', $r('app.media.startIcon'))
      this.InfoCard('Energy', '12 kWh', $r('app.media.startIcon'))
    }
  }

  @Builder
  InfoCard(title: string, value: string, iconResource: Resource) {
    // === Column ===
    // props: { space: 8, alignItems: ItemAlign.Start }
    // modifier: { padding: 16, width: '50%', backgroundColor: '#F9F9F9', borderRadius: 16, border: { width: 1, color: '#F0F0F0' } }
    // children: 3
    Column({ space: 8 }) {
      // === Image ===
      // modifier: { width: 20, height: 20, color: '#999999' }
      Image(iconResource).width(20).height(20).objectFit(ImageFit.Contain).fillColor('#999999')

      // === Text ===
      // props: { text: value }
      // modifier: { fontSize: 24, fontWeight: FontWeight.Bold, color: '#000' }
      Text(value).fontSize(24).fontWeight(FontWeight.Bold).fontColor('#000000')

      // === Text ===
      // props: { text: title }
      // modifier: { fontSize: 12, color: '#999999' }
      Text(title).fontSize(12).fontColor('#999999')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('50%')
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
  }

  @Builder
  PowerSwitch() {
    // === Row ===
    // props: { space: 0 }
    // modifier: { padding: 20, width: '100%', backgroundColor: '#F9F9F9', borderRadius: 16 }
    // children: 3
    Row() {
      // === Column ===
      // props: { space: 0, alignItems: ItemAlign.Start }
      // children: 2
      Column({ space: 0 }) {
        // === Text ===
        // props: { text: 'Master Power' }
        // modifier: { fontSize: 16, fontWeight: FontWeight.SemiBold, color: '#000' }
        Text('Master Power').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
        
        // === Text ===
        // props: { text: 'System is running' or 'System is off' }
        // modifier: { fontSize: 12, color: '#999999' }
        Text(this.isPowerOn ? 'System is running' : 'System is off').fontSize(12).fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)

      // === Blank ===
      Blank()

      // === Toggle ===
      // props: { type: ToggleType.Switch, isOn: this.isPowerOn }
      // modifier: { color: '#000' }
      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .onChange((isOn: boolean) => {
          this.isPowerOn = isOn
        })
        .selectedColor('#000000')
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
  }
}