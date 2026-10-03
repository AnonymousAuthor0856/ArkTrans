import { UIAbility } from '@kit.AbilityKit';
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
        Button({ type: ButtonType.Circle }) {
          Text('☰', { fontSize: 24 })
        }
        .backgroundColor(Color.Transparent)
        .fontColor(Color.Gray)
        .width(48)
        .height(48)

        Column({ space: 2 }) {
          Text('LIVING ROOM', { fontSize: 12, fontWeight: FontWeight.Bold, fontColor: Color.Gray })
            .letterSpacing(2)
          if (this.isPowerOn) {
            Text('Active', { fontSize: 10, fontColor: '#4CAF50' })
          } else {
            Text('Off', { fontSize: 10, fontColor: Color.LightGray })
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Button({ type: ButtonType.Circle }) {
          Text('⚙', { fontSize: 24 })
        }
        .backgroundColor(Color.Transparent)
        .fontColor(Color.Gray)
        .width(48)
        .height(48)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column() {
        // Temperature Control
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .fill(Color.White)
            .stroke('#EEEEEE', 1)
            .width(280)
            .height(280)

          Column({ space: 4 }) {
            Text(`${this.targetTemp}°`, { fontSize: 96, fontWeight: FontWeight.Light })
              .fontColor(this.isPowerOn ? Color.Black : Color.LightGray)
            Text(`CURRENT: ${this.currentTemp}°`, { fontSize: 14, fontColor: Color.Gray })
          }
          .alignItems(HorizontalAlign.Center)

          if (this.isPowerOn) {
            // Increase button
            Button({ type: ButtonType.Circle }) {
              Text('+', { fontSize: 24 })
            }
            .width(48)
            .height(48)
            .backgroundColor('#F5F5F5')
            .fontColor(Color.Black)
            .position({ x: 212, y: 116 })
            .onClick(() => {
              this.targetTemp++;
            })

            // Decrease button
            Button({ type: ButtonType.Circle }) {
              Text('−', { fontSize: 24 })
            }
            .width(48)
            .height(48)
            .backgroundColor('#F5F5F5')
            .fontColor(Color.Black)
            .position({ x: 20, y: 116 })
            .onClick(() => {
              this.targetTemp--;
            })
          }
        }
        .width(280)
        .height(280)
        .margin({ top: 10 })

        // Mode Selection
        Column({ space: 16 }) {
          Text('MODE', { fontSize: 10, fontWeight: FontWeight.Bold, fontColor: Color.Gray })
            .letterSpacing(1)
          Row({ space: 12 }) {
            this.ModeButton('⌂', 'Auto', this.selectedMode === 'Auto', this.isPowerOn, () => {
              this.selectedMode = 'Auto';
            })
            this.ModeButton('⟳', 'Fan', this.selectedMode === 'Fan', this.isPowerOn, () => {
              this.selectedMode = 'Fan';
            })
            this.ModeButton('★', 'Cool', this.selectedMode === 'Cool', this.isPowerOn, () => {
              this.selectedMode = 'Cool';
            })
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 20 })

        // Info Cards
        Row({ space: 16 }) {
          this.InfoCard('Humidity', '45%', 'ℹ')
          this.InfoCard('Energy', '12 kWh', '↑')
        }
        .width('100%')
        .margin({ top: 20 })

        // Power Switch
        Row() {
          Column({ space: 4 }) {
            Text('Master Power', { fontSize: 16, fontWeight: FontWeight.Medium })
            Text(this.isPowerOn ? 'System is running' : 'System is off', { fontSize: 12, fontColor: Color.Gray })
          }
          .layoutWeight(1)

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .selectedColor(Color.Black)
            .onChange((isOn: boolean) => {
              this.isPowerOn = isOn;
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20, bottom: 40 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  ModeButton(icon: string, label: string, isSelected: boolean, enabled: boolean, onClick: () => void) {
    Column({ space: 8 }) {
      Button({ type: ButtonType.Circle }) {
        Text(icon, { fontSize: 24 })
      }
      .width(60)
      .height(60)
      .backgroundColor(isSelected && enabled ? Color.Black : (enabled ? Color.White : '#F5F5F5'))
      .fontColor(isSelected && enabled ? Color.White : (enabled ? Color.Black : Color.LightGray))
      .border({
        width: isSelected ? 0 : 1,
        color: isSelected && enabled ? Color.Black : '#E0E0E0',
        radius: 30
      })
      .enabled(enabled)
      .onClick(onClick)

      Text(label, { fontSize: 10, fontColor: enabled ? Color.Gray : Color.LightGray })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  InfoCard(title: string, value: string, icon: string) {
    Column({ space: 8 }) {
      Text(icon, { fontSize: 20, fontColor: Color.Gray })
      Text(value, { fontSize: 20, fontWeight: FontWeight.Bold })
      Text(title, { fontSize: 12, fontColor: Color.Gray })
    }
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0', radius: 16 })
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct Index {
  build() {
    ThermostatScreen()
  }
}