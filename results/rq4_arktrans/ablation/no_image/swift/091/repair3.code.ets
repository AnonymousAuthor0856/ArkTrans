interface ModeButtonParams {
  iconName: string
  label: string
  isSelected: boolean
  isEnabled: boolean
  action: () => void
}

interface InfoCardParams {
  title: string
  value: string
  iconName: string
}

@Entry
@Component
struct Index {
  @State isPowerOn: boolean = false
  @State targetTemp: number = 24
  @State currentTemp: number = 26
  @State selectedMode: string = 'Auto'

  build() {
    Stack() {
      Column({ space: 0 }) {
        Row() {
          Button('Menu')
            .type(ButtonType.Capsule)
            .backgroundColor(Color.White)
            .width(80)
            .height(36)
            .borderRadius(18)
            .fontColor('#333333')
            .fontSize(14)
        
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
          
          Button('Settings')
            .type(ButtonType.Capsule)
            .backgroundColor(Color.White)
            .width(80)
            .height(36)
            .borderRadius(18)
            .fontColor('#333333')
            .fontSize(14)
        }.width('100%').padding({ left: 20, right: 20 })

        Blank().height(10)

        Stack() {
          Circle()
            .width(280)
            .height(280)
            .fill(Color.White)
            .stroke('#EDEDED')
            .strokeWidth(1)

          Column() {
            Text(`${this.targetTemp}°`)
              .fontColor(this.isPowerOn ? '#000000' : '#D3D3D3')
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
            
            Text(`CURRENT: ${this.currentTemp}°`)
              .fontColor('#999999')
              .fontSize(14)
          }

          Row() {
            Button('-')
              .type(ButtonType.Circle)
              .backgroundColor(Color.White)
              .width(40)
              .height(40)
              .fontColor('#333333')
              .fontSize(24)
              .onClick(() => {
                if (this.targetTemp > 16) this.targetTemp -= 1
              })
              .margin({ left: 20 })
            
            Blank()
            
            Button('+')
              .type(ButtonType.Circle)
              .backgroundColor(Color.White)
              .width(40)
              .height(40)
              .fontColor('#333333')
              .fontSize(24)
              .onClick(() => {
                if (this.targetTemp < 30) this.targetTemp += 1
              })
              .margin({ right: 20 })
          }.width(280)
        }

        Blank()

        Column({ space: 16 }) {
          Text('MODE')
            .fontColor('#999999')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
          
          Row({ space: 12 }) {
            this.ModeButton({ iconName: 'house.fill', label: 'Auto', isSelected: this.selectedMode === 'Auto', isEnabled: this.isPowerOn, action: () => { this.selectedMode = 'Auto' } })
            this.ModeButton({ iconName: 'arrow.clockwise', label: 'Fan', isSelected: this.selectedMode === 'Fan', isEnabled: this.isPowerOn, action: () => { this.selectedMode = 'Fan' } })
            this.ModeButton({ iconName: 'star.fill', label: 'Cool', isSelected: this.selectedMode === 'Cool', isEnabled: this.isPowerOn, action: () => { this.selectedMode = 'Cool' } })
          }
        }

        Blank()

        Row({ space: 16 }) {
          this.InfoCard({ title: 'Humidity', value: '45%', iconName: 'info.circle.fill' })
          this.InfoCard({ title: 'Energy', value: '12 kWh', iconName: 'chevron.up' })
        }

        Blank()

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
            .showMark(false)
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#FAFAFA')
        .borderRadius(16)
      }
    }.width('100%').height('100%').backgroundColor('#F5F5F5')
  }

  @Builder
  ModeButton(params: ModeButtonParams) {
    Column({ space: 4 }) {
      Image($r('app.media.startIcon'))
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
        .opacity(params.isEnabled ? (params.isSelected ? 1 : 0.5) : 0.3)
      
      Text(params.label)
        .fontSize(12)
        .fontColor(params.isEnabled ? (params.isSelected ? '#000000' : '#666666') : '#CCCCCC')
        .fontWeight(params.isSelected ? FontWeight.Medium : FontWeight.Normal)
    }
    .width(70)
    .height(60)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(params.isSelected ? '#EADDFF' : '#FFFFFF')
    .borderRadius(12)
    .onClick(() => {
      if (params.isEnabled) params.action()
    })
  }

  @Builder
  InfoCard(params: InfoCardParams) {
    Column({ space: 8 }) {
      Row({ space: 8 }) {
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
        
        Text(params.title)
          .fontSize(12)
          .fontColor('#666666')
      }
      
      Text(params.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
    }
    .width('45%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}