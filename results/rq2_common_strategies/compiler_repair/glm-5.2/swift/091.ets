// Index.ets
import { SymbolGlyphModifier } from '@kit.ArkUI';

@Entry
@Component
struct ThermostatApp {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Stack() {
      Column() {
        // Top Bar
        TopBar({ isPowerOn: this.isPowerOn })
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        Blank().height(10)

        // Temperature Circle Control
        TemperatureControl({
          currentTemp: this.currentTemp,
          targetTemp: this.targetTemp,
          isPowerOn: this.isPowerOn,
          onDecrease: () => this.targetTemp--,
          onIncrease: () => this.targetTemp++
        })

        Blank()

        // Mode Selection
        ModeSelection({
          selectedMode: this.selectedMode,
          isPowerOn: this.isPowerOn,
          onSelect: (mode: string) => this.selectedMode = mode
        })

        Blank()

        // Info Cards
        InfoCardsRow()
          .padding({ left: 24, right: 24 })

        Blank()

        // Master Power Switch
        PowerSwitch({ isPowerOn: this.isPowerOn })
          .padding({ left: 24, right: 24, bottom: 40 })
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
  }
}

@Component
struct TopBar {
  @Prop isPowerOn: boolean = false;

  build() {
    Row() {
      Button() {
        SymbolGlyph($r('sys.symbol.list_bullet'))
          .fontSize(24)
          .fontColor([Color.Gray])
      }
      .backgroundColor(Color.Transparent)

      Blank()

      Column() {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor(Color.Gray)

        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4CAF50' : Color.Gray)
      }

      Blank()

      Button() {
        SymbolGlyph($r('sys.symbol.gearshape_fill'))
          .fontSize(24)
          .fontColor([Color.Gray])
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }
}

@Component
struct TemperatureControl {
  @Prop currentTemp: number = 0;
  @Prop targetTemp: number = 0;
  @Prop isPowerOn: boolean = false;
  onDecrease: () => void = () => {};
  onIncrease: () => void = () => {};

  build() {
    Stack() {
      // Background Circle
      Circle()
        .width(280)
        .height(280)
        .fill(Color.White)
        .stroke('#EEEEEE')
        .strokeWidth(1)

      // Text Content
      Column() {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? Color.Black : '#D4D4D4')

        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor(Color.Gray)
      }

      // Buttons
      if (this.isPowerOn) {
        Row() {
          // Decrease Button
          Button() {
            SymbolGlyph($r('sys.symbol.chevron_down'))
              .fontSize(24)
              .fontColor([Color.Black])
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .onClick(() => this.onDecrease())

          Blank()

          // Increase Button
          Button() {
            SymbolGlyph($r('sys.symbol.plus'))
              .fontSize(24)
              .fontColor([Color.Black])
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .onClick(() => this.onIncrease())
        }
        .width(280)
        .padding({ left: 20, right: 20 })
      }
    }
    .width(280)
    .height(280)
  }
}

@Component
struct ModeSelection {
  @Prop selectedMode: string = '';
  @Prop isPowerOn: boolean = false;
  onSelect: (mode: string) => void = () => {};

  build() {
    Column() {
      Text('MODE')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .margin({ bottom: 16 })

      Row({ space: 12 }) {
        ModeButton({
          iconName: $r('sys.symbol.house_fill'),
          label: 'Auto',
          isSelected: this.selectedMode === 'Auto',
          isEnabled: this.isPowerOn,
          action: () => this.onSelect('Auto')
        })
        ModeButton({
          iconName: $r('sys.symbol.arrow_clockwise'),
          label: 'Fan',
          isSelected: this.selectedMode === 'Fan',
          isEnabled: this.isPowerOn,
          action: () => this.onSelect('Fan')
        })
        ModeButton({
          iconName: $r('sys.symbol.star_fill'),
          label: 'Cool',
          isSelected: this.selectedMode === 'Cool',
          isEnabled: this.isPowerOn,
          action: () => this.onSelect('Cool')
        })
      }
    }
  }
}

@Component
struct ModeButton {
  iconName: Resource = $r('app.media.startIcon');
  label: string = '';
  @Prop isSelected: boolean = false;
  @Prop isEnabled: boolean = false;
  action: () => void = () => {};

  build() {
    Column() {
      Button() {
        SymbolGlyph(this.iconName)
          .fontSize(24)
          .fontColor([this.isSelected && this.isEnabled ? Color.White : (this.isEnabled ? Color.Black : '#D4D4D4')])
      }
      .width(60)
      .height(60)
      .backgroundColor(this.isSelected && this.isEnabled ? Color.Black : Color.White)
      .borderRadius(30)
      .border({ width: 1, color: !this.isSelected ? '#E0E0E0' : Color.Transparent })
      .enabled(this.isEnabled)
      .onClick(() => this.action())

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? Color.Gray : '#D4D4D4')
        .margin({ top: 8 })
    }
  }
}

@Component
struct InfoCardsRow {
  build() {
    Row({ space: 16 }) {
      InfoCard({ title: 'Humidity', value: '45%', iconName: $r('sys.symbol.info_circle_fill') })
      InfoCard({ title: 'Energy', value: '12 kWh', iconName: $r('sys.symbol.chevron_up') })
    }
    .width('100%')
  }
}

@Component
struct InfoCard {
  title: string = '';
  value: string = '';
  iconName: Resource = $r('app.media.startIcon');

  build() {
    Column() {
      SymbolGlyph(this.iconName)
        .fontSize(20)
        .fontColor([Color.Gray])

      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 8 })

      Text(this.title)
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
  }
}

@Component
struct PowerSwitch {
  @Prop isPowerOn: boolean = false;

  build() {
    Row() {
      Column() {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => this.isPowerOn = isOn)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
  }
}