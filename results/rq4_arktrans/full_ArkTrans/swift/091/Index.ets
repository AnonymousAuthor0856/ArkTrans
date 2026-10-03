@Entry
@Component
struct Index {
  @State isPowerOn: boolean = true
  @State targetTemp: number = 24
  @State currentTemp: number = 22
  @State selectedMode: string = 'Cool'

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Header
        Row() {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#999999')
          }
          .backgroundColor(Color.Transparent)

          Blank()

          Column({ space: 2 }) {
            Text('LIVING ROOM')
              .fontColor('#999999')
              .letterSpacing(2)
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
            
            Text(this.isPowerOn ? 'Active' : 'Off')
              .fontColor(this.isPowerOn ? '#4CAF50' : '#999999')
              .fontSize(11)
          }

          Blank()

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#999999')
          }
          .backgroundColor(Color.Transparent)
        }.width('100%').padding({ left: 20, right: 20, top: 20 })

        Blank().height(10)

        // Main Circle Control
        Stack() {
          // Background Circle
          Circle()
            .width(280)
            .height(280)
            .fill(Color.White)
            .stroke('#EDEDED')
            .strokeWidth(1)

          // Center Content
          Column() {
            Text(`${this.targetTemp}°`)
              .fontColor(this.isPowerOn ? '#000000' : '#D3D3D3')
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
            
            Text(`CURRENT: ${this.currentTemp}°`)
              .fontColor('#999999')
              .fontSize(14)
          }

          // Temperature Controls
          Row() {
            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#000000')
            }
            .backgroundColor('#F5F5F5')
            .borderRadius(100)
            .width(48)
            .height(48)
            .onClick(() => {
              this.targetTemp -= 1
            })
            .margin({ left: 20 })

            Blank()

            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#000000')
            }
            .backgroundColor('#F5F5F5')
            .borderRadius(100)
            .width(48)
            .height(48)
            .onClick(() => {
              this.targetTemp += 1
            })
            .margin({ right: 20 })
          }.width(280)
        }.margin({ top: 20 })

        Blank().layoutWeight(1)

        // Mode Selection
        Column({ space: 16 }) {
          Text('MODE')
            .fontColor('#999999')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
          
          Row({ space: 12 }) {
            this.ModeButtonComponent('Auto', 'house.fill', this.selectedMode === 'Auto')
            this.ModeButtonComponent('Fan', 'arrow.clockwise', this.selectedMode === 'Fan')
            this.ModeButtonComponent('Cool', 'star.fill', this.selectedMode === 'Cool')
          }
        }

        Blank().height(20)

        // Info Cards
        Row({ space: 16 }) {
          this.InfoCardComponent('Humidity', '45%', 'info.circle.fill')
          this.InfoCardComponent('Energy', '12 kWh', 'chevron.up')
        }.width('100%').padding({ left: 20, right: 20 })

        Blank().height(20)

        // Master Power Toggle
        Row() {
          Column({ space: 0 }) {
            Text('Master Power')
              .fontColor('#000000')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
            
            Text(this.isPowerOn ? 'System is running' : 'System is off')
              .fontColor('#999999')
              .fontSize(12)
          }

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .onChange((isOn: boolean) => {
              this.isPowerOn = isOn
            })
            .selectedColor('#000000')
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#FAFAFA')
        .borderRadius(16)
        .margin({ left: 20, right: 20, bottom: 20 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }.width('100%').height('100%')
  }

  @Builder
  ModeButtonComponent(label: string, iconName: string, isSelected: boolean) {
    Column({ space: 8 }) {
      Button() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(isSelected ? Color.White : '#000000')
      }
      .backgroundColor(isSelected ? '#000000' : Color.White)
      .borderRadius(100)
      .width(60)
      .height(60)
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {
        if (this.isPowerOn) {
          this.selectedMode = label
        }
      })
      
      Text(label)
        .fontColor(isSelected ? '#000000' : '#999999')
        .fontSize(12)
    }
  }

  @Builder
  InfoCardComponent(title: string, value: string, iconName: string) {
    Column({ space: 8 }) {
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#999999')
        
        Blank()
      }
      
      Text(value)
        .fontColor('#000000')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
      
      Text(title)
        .fontColor('#999999')
        .fontSize(14)
    }
    .width('48%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(16)
  }
}