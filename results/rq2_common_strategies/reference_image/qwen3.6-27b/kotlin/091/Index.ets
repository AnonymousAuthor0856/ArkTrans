import { router } from '@kit.ArkUI';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('app.media.ic_menu'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
          .onClick(() => {
            // Menu action
          })

        Column() {
          Text('LIVING ROOM')
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontSize(14)
          
          if (this.isPowerOn) {
            Text('Active')
              .fontColor('#4CAF50')
              .fontSize(12)
          } else {
            Text('Off')
              .fontColor(Color.LightGray)
              .fontSize(12)
          }
        }
        .alignItems(HorizontalAlign.Center)

        Image($r('app.media.ic_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
          .onClick(() => {
            // Settings action
          })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)

      Spacer().height(10)

      // Main Temperature Control
      Stack() {
        Circle()
          .width(280)
          .height(280)
          .borderWidth(1)
          .borderColor('#EEEEEE')

        Column() {
          Text(`${this.targetTemp}°`)
            .fontSize(96)
            .fontWeight(FontWeight.Light)
            .fontColor(this.isPowerOn ? Color.Black : Color.LightGray)
          
          Text(`CURRENT: ${this.currentTemp}°`)
            .fontColor(Color.Gray)
            .fontSize(16)
        }
        .alignItems(HorizontalAlign.Center)

        if (this.isPowerOn) {
          // Decrease Button
          Row() {
            Image($r('app.media.ic_arrow_down'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .position({ x: 30, y: 116 })
          .onClick(() => {
            this.targetTemp--;
          })

          // Increase Button
          Row() {
            Image($r('app.media.ic_add'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .position({ x: 202, y: 116 })
          .onClick(() => {
            this.targetTemp++;
          })
        }
      }
      .width(280)
      .height(280)
      .margin({ top: 20 })

      // Mode Selection
      Column() {
        Text('MODE')
          .fontColor(Color.Gray)
          .fontWeight(FontWeight.Bold)
          .fontSize(12)
          .margin({ bottom: 16 })

        Row() {
          this.ModeButton({
            icon: $r('app.media.ic_home'),
            label: 'Auto',
            isSelected: this.selectedMode === 'Auto',
            enabled: this.isPowerOn,
            onClick: () => { this.selectedMode = 'Auto' }
          })

          this.ModeButton({
            icon: $r('app.media.ic_refresh'),
            label: 'Fan',
            isSelected: this.selectedMode === 'Fan',
            enabled: this.isPowerOn,
            onClick: () => { this.selectedMode = 'Fan' }
          })

          this.ModeButton({
            icon: $r('app.media.ic_star'),
            label: 'Cool',
            isSelected: this.selectedMode === 'Cool',
            enabled: this.isPowerOn,
            onClick: () => { this.selectedMode = 'Cool' }
          })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 20 })

      // Info Cards
      Row() {
        this.InfoCard({
          title: 'Humidity',
          value: '45%',
          icon: $r('app.media.ic_info')
        })

        this.InfoCard({
          title: 'Energy',
          value: '12 kWh',
          icon: $r('app.media.ic_arrow_up')
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 20 })

      // Power Switch
      Row() {
        Column() {
          Text('Master Power')
            .fontWeight(FontWeight.SemiBold)
            .fontSize(16)
          
          Text(this.isPowerOn ? 'System is running' : 'System is off')
            .fontColor(Color.Gray)
            .fontSize(12)
        }

        Toggle({
          type: ToggleType.Switch,
          isOn: this.isPowerOn
        })
        .onChange((isOn: boolean) => {
          this.isPowerOn = isOn;
        })
        .width(50)
        .height(30)
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
    .backgroundColor(Color.White)
  }

  @Builder
  ModeButton(params: {
    icon: Resource,
    label: string,
    isSelected: boolean,
    enabled: boolean,
    onClick: () => void
  }) {
    Column() {
      Row() {
        Image(params.icon)
          .width(24)
          .height(24)
          .fillColor(params.isSelected && params.enabled ? Color.White : 
                     params.enabled ? Color.Black : Color.LightGray)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(params.isSelected && params.enabled ? Color.Black : Color.White)
      .border({
        width: 1,
        color: params.isSelected && params.enabled ? Color.Black : '#E0E0E0'
      })
      .onClick(() => {
        if (params.enabled) {
          params.onClick();
        }
      })

      Text(params.label)
        .fontColor(params.enabled ? Color.Gray : Color.LightGray)
        .fontSize(12)
        .margin({ top: 8 })
    }
  }

  @Builder
  InfoCard(params: {
    title: string,
    value: string,
    icon: Resource
  }) {
    Column() {
      Image(params.icon)
        .width(20)
        .height(20)
        .fillColor(Color.Gray)
      
      Text(params.value)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
        .margin({ top: 8 })
      
      Text(params.title)
        .fontColor(Color.Gray)
        .fontSize(14)
    }
    .width('48%')
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({
      width: 1,
      color: '#F0F0F0'
    })
  }
}