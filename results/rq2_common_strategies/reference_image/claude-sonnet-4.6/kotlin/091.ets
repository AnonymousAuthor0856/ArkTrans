// entry/src/main/ets/pages/ThermostatScreen.ets

@Component
struct InfoCard {
  @Prop title: string = '';
  @Prop value: string = '';
  @Prop icon: string = '';

  build() {
    Column({ space: 8 }) {
      Text(this.icon)
        .fontSize(18)
        .fontColor(Color.Gray)
      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text(this.title)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .backgroundColor(Color(0xFFF9F9F9))
    .borderRadius(16)
    .border({ width: 1, color: Color(0xFFF0F0F0) })
  }
}

@Component
struct ModeButton {
  @Prop icon: string = '';
  @Prop label: string = '';
  @Prop isSelected: boolean = false;
  @Prop enabled: boolean = true;
  onClick: () => void = () => {};

  build() {
    Column({ space: 8 }) {
      Button({ type: ButtonType.Circle }) {
        Text(this.icon)
          .fontSize(20)
          .fontColor(this.isSelected && this.enabled
            ? Color.White
            : (this.enabled ? Color.Black : Color(0xFFD3D3D3)))
      }
      .width(60)
      .height(60)
      .padding(0)
      .backgroundColor(this.isSelected && this.enabled ? Color.Black : Color.White)
      .border({
        width: 1,
        color: this.isSelected && this.enabled ? Color.Black : Color(0xFFE0E0E0)
      })
      .onClick(() => {
        if (this.enabled) {
          this.onClick();
        }
      })

      Text(this.label)
        .fontSize(10)
        .fontColor(this.enabled ? Color.Gray : Color(0xFFD3D3D3))
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  private adjustTemp(delta: number): void {
    const next: number = this.targetTemp + delta;
    this.targetTemp = Math.max(16, Math.min(30, next));
  }

  build() {
    Column() {
      // ---------- Top bar ----------
      Row() {
        Button({ type: ButtonType.Circle }) {
          // swap for SymbolGlyph($r('sys.symbol.line_3_horizontal')) if you prefer system icons
          Text('☰')
            .fontSize(20)
            .fontColor(Color.Gray)
        }
        .width(40)
        .height(40)
        .padding(0)
        .backgroundColor(Color.Transparent)
        .onClick(() => {})

        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
            .letterSpacing(2)
          Text(this.isPowerOn ? 'Active' : 'Off')
            .fontSize(10)
            .fontColor(this.isPowerOn ? Color(0xFF4CAF50) : Color(0xFFD3D3D3))
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Center)

        Button({ type: ButtonType.Circle }) {
          Text('⚙')
            .fontSize(20)
            .fontColor(Color.Gray)
        }
        .width(40)
        .height(40)
        .padding(0)
        .backgroundColor(Color.Transparent)
        .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // ---------- Main content ----------
      Column() {
        // --- Dial ---
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 280, height: 280 })
            .fill(Color.White)
            .stroke(Color(0xFFEEEEEE))
            .strokeWidth(1)

          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? Color.Black : Color(0xFFD3D3D3))
            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)

          if (this.isPowerOn) {
            Row() {
              Button({ type: ButtonType.Circle }) {
                Text('⌄')
                  .fontSize(22)
                  .fontColor(Color.Black)
              }
              .width(48)
              .height(48)
              .padding(0)
              .backgroundColor(Color(0xFFF5F5F5))
              .onClick(() => this.adjustTemp(-1))

              Button({ type: ButtonType.Circle }) {
                Text('+')
                  .fontSize(22)
                  .fontColor(Color.Black)
              }
              .width(48)
              .height(48)
              .padding(0)
              .backgroundColor(Color(0xFFF5F5F5))
              .onClick(() => this.adjustTemp(1))
            }
            .width(280)
            .height(48)
            .padding({ left: 20, right: 20 })
            .justifyContent(FlexAlign.SpaceBetween)
          }
        }
        .width(280)
        .height(280)

        // --- Mode selection ---
        Column() {
          Text('MODE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
            .letterSpacing(1)
            .margin({ bottom: 16 })

          Row({ space: 12 }) {
            ModeButton({
              icon: '⌂',
              label: 'Auto',
              isSelected: this.selectedMode === 'Auto',
              enabled: this.isPowerOn,
              onClick: () => { this.selectedMode = 'Auto'; }
            })
            ModeButton({
              icon: '↻',
              label: 'Fan',
              isSelected: this.selectedMode === 'Fan',
              enabled: this.isPowerOn,
              onClick: () => { this.selectedMode = 'Fan'; }
            })
            ModeButton({
              icon: '★',
              label: 'Cool',
              isSelected: this.selectedMode === 'Cool',
              enabled: this.isPowerOn,
              onClick: () => { this.selectedMode = 'Cool'; }
            })
          }
        }
        .alignItems(HorizontalAlign.Center)

        // --- Info cards ---
        Row({ space: 16 }) {
          Column() {
            InfoCard({ title: 'Humidity', value: '45%', icon: 'ⓘ' })
          }
          .layoutWeight(1)

          Column() {
            InfoCard({ title: 'Energy', value: '12 kWh', icon: '⌃' })
          }
          .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        // --- Master power ---
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

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .selectedColor(Color.Black)
            .switchPointColor(Color.White)
            .onChange((isOn: boolean) => {
              this.isPowerOn = isOn;
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor(Color(0xFFF9F9F9))
        .borderRadius(16)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}