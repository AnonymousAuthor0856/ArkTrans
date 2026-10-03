interface ColorTokens {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  text: string
  muted: string
  palePurple: string
}

const COLORS: ColorTokens = {
  primary: '#D95F02',
  secondary: '#1B9AAA',
  tertiary: '#FEC601',
  background: '#F9F4EB',
  surface: '#FFFFFF',
  surfaceVariant: '#F0E3D1',
  outline: '#E1CDB2',
  text: '#2E2924',
  muted: '#706D69',
  palePurple: '#E8DDF7'
}

@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.60
  @State ambientGlow: number = 0.35
  @State ecoHold: boolean = false

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']

  build() {
    Column() {
      this.header()

      Scroll() {
        Column({ space: 16 }) {
          this.modeSelector()
          this.orbitalControls()
          this.orbitHealth()
        }
        .width('100%')
        .padding({ left: 32, right: 32, top: 16, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.bottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  header() {
    Row() {
      Text('Dock')
        .fontSize(17)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.text)
        .width('25%')

      Text('Smart Orbit Panel')
        .fontSize(27)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Text('Alerts')
        .fontSize(17)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.secondary)
        .textAlign(TextAlign.End)
        .width('25%')
    }
    .width('100%')
    .height(96)
    .padding({ left: 42, right: 36, top: 18, bottom: 8 })
    .backgroundColor(COLORS.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  modeSelector() {
    Row({ space: 16 }) {
      ForEach(this.modes, (mode: string) => {
        Text(mode)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.text)
          .textAlign(TextAlign.Center)
          .height(62)
          .width(112)
          .backgroundColor(this.activeMode === mode ? '#F7DEC7' : COLORS.surface)
          .border({
            width: this.activeMode === mode ? 0 : 2,
            color: COLORS.outline,
            radius: 24
          })
          .borderRadius(24)
          .onClick(() => {
            this.activeMode = mode
          })
      })
    }
    .width('100%')
  }

  @Builder
  orbitalControls() {
    Column({ space: 24 }) {
      Column({ space: 14 }) {
        Text('Solar wash')
          .fontSize(38)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.text)

        Text('Adjust orbital window glow')
          .fontSize(25)
          .fontColor(COLORS.muted)

        this.sliderRow(this.solarLevel, COLORS.primary, (value: number) => {
          this.solarLevel = value
        })

        Row() {
          Text('0%')
            .fontSize(21)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLORS.text)
          Text(`${Math.round(this.solarLevel * 100)}%`)
            .fontSize(31)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLORS.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }

      Column({ space: 14 }) {
        Text('Ambient glow')
          .fontSize(38)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.text)

        this.sliderRow(this.ambientGlow, COLORS.secondary, (value: number) => {
          this.ambientGlow = value
        })

        this.progressBar(this.ambientGlow, COLORS.secondary, COLORS.surfaceVariant, 8)
      }
    }
    .width('100%')
    .padding(32)
    .backgroundColor(COLORS.surface)
    .borderRadius(38)
  }

  @Builder
  sliderRow(value: number, accent: string, onChange: (value: number) => void) {
    Row() {
      Slider({
        value: value * 100,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .layoutWeight(1)
        .height(44)
        .selectedColor(accent)
        .trackColor(COLORS.palePurple)
        .blockColor(accent)
        .showSteps(false)
        .onChange((sliderValue: number) => {
          onChange(sliderValue / 100)
        })
    }
    .width('100%')
    .height(48)
  }

  @Builder
  orbitHealth() {
    Column({ space: 16 }) {
      Text('Orbit health')
        .fontSize(38)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)

      this.statusRow('Atmos mix', 0.74, COLORS.secondary)
      this.statusRow('Hull temp', 0.42, COLORS.primary)
      this.statusRow('Shield sync', 0.88, COLORS.tertiary)
    }
    .width('100%')
    .padding(32)
    .backgroundColor(COLORS.surfaceVariant)
    .borderRadius(38)
  }

  @Builder
  statusRow(label: string, value: number, accent: string) {
    Column({ space: 7 }) {
      Row() {
        Text(label)
          .fontSize(25)
          .fontColor(COLORS.text)
        Text(`${Math.round(value * 100)}%`)
          .fontSize(23)
          .fontWeight(FontWeight.Medium)
          .fontColor(accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      this.progressBar(value, accent, COLORS.surface, 8)
    }
    .width('100%')
  }

  @Builder
  progressBar(value: number, accent: string, track: string, height: number) {
    Stack() {
      Row()
        .width('100%')
        .height(height)
        .backgroundColor(track)
        .borderRadius(height / 2)

      Row()
        .width(`${Math.max(0, Math.min(1, value)) * 100}%`)
        .height(height)
        .backgroundColor(accent)
        .borderRadius(height / 2)
    }
    .width('100%')
    .height(height)
    .alignContent(Alignment.Start)
  }

  @Builder
  bottomBar() {
    Row() {
      Column({ space: 4 }) {
        Text('Grid draw')
          .fontSize(18)
          .fontColor(COLORS.text)
        Text('18.4 kWh')
          .fontSize(27)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.primary)
      }
      .alignItems(HorizontalAlign.Start)

      Button(this.ecoHold ? 'Eco hold active' : 'Engage eco hold')
        .fontSize(18)
        .fontColor('#1B1B1B')
        .fontWeight(FontWeight.Medium)
        .backgroundColor(COLORS.primary)
        .height(80)
        .width(256)
        .borderRadius(32)
        .onClick(() => {
          this.ecoHold = !this.ecoHold
        })
    }
    .width('100%')
    .height(126)
    .padding({ left: 32, right: 32, top: 14, bottom: 14 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFF7EF')
    .shadow({
      radius: 10,
      color: '#25000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}
