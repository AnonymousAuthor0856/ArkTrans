// Translated from SwiftUI (091.swift) to ArkTS (HarmonyOS ArkUI).
// "import SwiftUI" -> ArkUI components are globally available; no import required.

// Maps a SwiftUI SF Symbol name to a Unicode glyph placeholder used by ArkUI.
function symbolGlyph(name: string): string {
  if (name === 'line.3.horizontal') { return '☰'; }
  if (name === 'gearshape.fill') { return '⚙'; }
  if (name === 'chevron.down') { return '⌄'; }
  if (name === 'plus') { return '+'; }
  if (name === 'house.fill') { return '⌂'; }
  if (name === 'arrow.clockwise') { return '⟳'; }
  if (name === 'star.fill') { return '★'; }
  if (name === 'info.circle.fill') { return 'ⓘ'; }
  if (name === 'chevron.up') { return '⌃'; }
  return '●';
}

@Entry
@Component
struct ThermostatApp {
  build() {
    // WindowGroup { ContentView() }
    Stack() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    ThermostatScreen()
    // .preferredColorScheme(.light)  ->  light color scheme (page-level)
    // .statusBarHidden(true)         ->  status bar hidden (window-level)
  }
}

// MARK: - Main Screen
@Component
struct ThermostatScreen {
  // State
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top Bar
        TopBar({ isPowerOn: this.isPowerOn })
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        Blank().height(10)

        // Temperature Circle Control
        TemperatureControl({
          currentTemp: this.currentTemp,
          targetTemp: $targetTemp,
          isPowerOn: this.isPowerOn
        })

        Blank()

        // Mode Selection
        ModeSelection({
          selectedMode: $selectedMode,
          isPowerOn: this.isPowerOn
        })

        Blank()

        // Info Cards
        InfoCardsRow()
          .padding({ left: 24, right: 24 })

        Blank()

        // Master Power Switch
        PowerSwitch({ isPowerOn: $isPowerOn })
          .padding({ bottom: 40, left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF') // Color.white.ignoresSafeArea()
  }
}

// MARK: - Subcomponents

@Component
struct TopBar {
  isPowerOn: boolean = false;

  build() {
    Row() {
      Text('☰') // Image(systemName: "line.3.horizontal")
        .fontSize(24)
        .fontColor('#9E9E9E') // .gray
        .onClick(() => {})

      Blank()

      Column({ space: 2 }) {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2) // .tracking(2)
          .fontColor('#9E9E9E') // .gray

        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4CAF50' : '#9E9E9E') // #4CAF50 or gray
      }

      Blank()

      Text('⚙') // Image(systemName: "gearshape.fill")
        .fontSize(24)
        .fontColor('#9E9E9E') // .gray
        .onClick(() => {})
    }
    .width('100%')
  }
}

@Component
struct TemperatureControl {
  currentTemp: number = 0;
  @Link targetTemp: number;
  isPowerOn: boolean = false;

  build() {
    Stack() {
      // Background Circle
      Circle()
        .fill('#FFFFFF')
        .stroke('#EEEEEE') // #EEEEEE
        .strokeWidth(1)
        .width(280)
        .height(280)

      // Text Content
      Column() {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Lighter) // .light
          .fontColor(this.isPowerOn ? '#000000' : '#D4D4D4') // black or light gray

        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor('#9E9E9E') // .gray
      }

      // Buttons
      if (this.isPowerOn) {
        Row() {
          // Decrease Button (Left)
          Text('⌄') // Image(systemName: "chevron.down")
            .fontSize(24)
            .fontColor('#000000')
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor('#F5F5F5') // #F5F5F5
            .borderRadius(24) // .clipShape(Circle())
            .onClick(() => { this.targetTemp -= 1 })
            .padding({ left: 20 })

          Blank()

          // Increase Button (Right)
          Text('+') // Image(systemName: "plus")
            .fontSize(24)
            .fontColor('#000000')
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor('#F5F5F5') // #F5F5F5
            .borderRadius(24) // .clipShape(Circle())
            .onClick(() => { this.targetTemp += 1 })
            .padding({ right: 20 })
        }
        .width(280) // Match circle width
      }
    }
  }
}

@Component
struct ModeSelection {
  @Link selectedMode: string;
  isPowerOn: boolean = false;

  build() {
    Column({ space: 16 }) {
      Text('MODE')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#9E9E9E') // .gray

      Row({ space: 12 }) {
        ModeButton({
          iconName: 'house.fill',
          label: 'Auto',
          isSelected: this.selectedMode === 'Auto',
          isEnabled: this.isPowerOn,
          action: () => { this.selectedMode = 'Auto' }
        })
        ModeButton({
          iconName: 'arrow.clockwise',
          label: 'Fan',
          isSelected: this.selectedMode === 'Fan',
          isEnabled: this.isPowerOn,
          action: () => { this.selectedMode = 'Fan' }
        })
        ModeButton({
          iconName: 'star.fill',
          label: 'Cool',
          isSelected: this.selectedMode === 'Cool',
          isEnabled: this.isPowerOn,
          action: () => { this.selectedMode = 'Cool' }
        })
      }
    }
  }
}

@Component
struct ModeButton {
  iconName: string = '';
  label: string = '';
  isSelected: boolean = false;
  isEnabled: boolean = false;
  action: () => void = () => {};

  build() {
    Column({ space: 8 }) {
      Text(symbolGlyph(this.iconName))
        .fontSize(24)
        .width(60)
        .height(60)
        .textAlign(TextAlign.Center)
        .fontColor(this.isSelected && this.isEnabled ? '#FFFFFF'
          : (this.isEnabled ? '#000000' : '#D4D4D4'))
        .backgroundColor(this.isSelected && this.isEnabled ? '#000000' : '#FFFFFF')
        .borderRadius(30) // .clipShape(Circle())
        .border({
          width: 1,
          color: !this.isSelected ? '#E0E0E0' : '#00FFFFFF' // stroke or clear
        })
        .onClick(() => {
          if (this.isEnabled) {
            this.action()
          }
        })

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? '#9E9E9E' : '#D4D4D4')
    }
  }
}

@Component
struct InfoCardsRow {
  build() {
    Row({ space: 16 }) {
      InfoCard({
        title: 'Humidity',
        value: '45%',
        iconName: 'info.circle.fill'
      })
      InfoCard({
        title: 'Energy',
        value: '12 kWh',
        iconName: 'chevron.up'
      })
    }
    .width('100%')
  }
}

@Component
struct InfoCard {
  title: string = '';
  value: string = '';
  iconName: string = '';

  build() {
    Column({ space: 8 }) {
      Text(symbolGlyph(this.iconName))
        .fontSize(20)
        .fontColor('#9E9E9E') // .gray

      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold) // HeadlineSmall approx
        .fontColor('#000000')

      Text(this.title)
        .fontSize(12)
        .fontColor('#9E9E9E') // .gray
    }
    .alignItems(HorizontalAlign.Start) // VStack(alignment: .leading)
    .padding(16)
    .width('100%') // maxWidth: .infinity
    .backgroundColor('#F9F9F9') // #F9F9F9
    .borderRadius(16) // .cornerRadius(16)
    .border({ width: 1, color: '#F0F0F0' }) // RoundedRectangle stroke #F0F0F0
  }
}

@Component
struct PowerSwitch {
  @Link isPowerOn: boolean;

  build() {
    Row() {
      Column({ space: 0 }) {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.Medium) // .semibold
          .fontColor('#000000')
        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor('#9E9E9E') // .gray
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .selectedColor('#000000') // SwitchToggleStyle(tint: .black)
        .onChange((isOn: boolean) => { this.isPowerOn = isOn })
    }
    .padding(20)
    .backgroundColor('#F9F9F9') // #F9F9F9
    .borderRadius(16)
    .width('100%')
  }
}
