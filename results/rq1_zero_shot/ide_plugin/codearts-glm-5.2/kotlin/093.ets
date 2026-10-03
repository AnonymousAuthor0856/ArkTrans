class TeaPreset {
  name: string
  temp: string
  time: string
  description: string

  constructor(name: string, temp: string, time: string, description: string) {
    this.name = name
    this.temp = temp
    this.time = time
    this.description = description
  }
}

class AppTokens {
  static readonly Colors = {
    black: '#FF000000',
    white: '#FFFFFFFF',
    gray: '#FF888888',
    visualizerBg: '#FFF5F5F5',
    teaBrown: '#FF8D6E63',
    divider: '#FFE0E0E0',
    chipBorder: '#FFE0E0E0'
  }
}

@Entry
@Component
struct TeaBrewingScreen {
  private teaPresets: TeaPreset[] = [
    new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
    new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
    new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
    new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
    new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
  ]
  @State selectedTeaIndex: number = 0

  build() {
    Column() {
      Row() {
        Column() {
          Text('Tea Master')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.black)
          Text('Perfect brew, every time')
            .fontSize(12)
            .fontColor(AppTokens.Colors.gray)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text('⚙')
          .fontSize(24)
          .fontColor(AppTokens.Colors.black)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Column() {
          Text('♥')
            .fontSize(48)
            .fontColor(AppTokens.Colors.teaBrown)
          Text(this.teaPresets[this.selectedTeaIndex].name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.black)
            .margin({ top: 8 })
        }
        .width(180)
        .height(180)
        .borderRadius(90)
        .backgroundColor(AppTokens.Colors.visualizerBg)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width(220)
      .height(220)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 32 })

      Row() {
        InfoItem({ label: 'TEMP', value: this.teaPresets[this.selectedTeaIndex].temp })
        Column()
          .width(1)
          .height(40)
          .backgroundColor(AppTokens.Colors.divider)
        InfoItem({ label: 'TIME', value: this.teaPresets[this.selectedTeaIndex].time })
        Column()
          .width(1)
          .height(40)
          .backgroundColor(AppTokens.Colors.divider)
        InfoItem({ label: 'AMOUNT', value: '250ml' })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 40 })

      Column() {
        Text('Select Variety')
          .fontSize(14)
          .fontColor(AppTokens.Colors.black)
          .margin({ bottom: 12 })

        Scroll() {
          Row() {
            ForEach(this.teaPresets, (preset: TeaPreset, index: number) => {
              TeaChip({
                name: preset.name,
                isSelected: index === this.selectedTeaIndex,
                onClick: () => {
                  this.selectedTeaIndex = index
                }
              })
                .margin({ right: 12 })
            })
          }
          .padding({ left: 4, right: 4 })
        }
        .scrollDirection(Axis.Horizontal)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 40 })

      Column()
        .layoutWeight(1)

      Row() {
        Text('▶')
          .fontSize(16)
          .fontColor(AppTokens.Colors.white)
        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.white)
          .margin({ left: 8 })
      }
      .width('100%')
      .height(56)
      .borderRadius(16)
      .backgroundColor(AppTokens.Colors.black)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(AppTokens.Colors.white)
  }
}

@Component
struct InfoItem {
  @Prop label: string
  @Prop value: string

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.gray)
        .letterSpacing(1)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TeaChip {
  @Prop name: string
  @Prop isSelected: boolean
  onClick: () => void = () => {}

  build() {
    Text(this.name)
      .fontSize(14)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? AppTokens.Colors.white : AppTokens.Colors.black)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .borderRadius(50)
      .backgroundColor(this.isSelected ? AppTokens.Colors.black : AppTokens.Colors.white)
      .border({ width: 1, color: this.isSelected ? AppTokens.Colors.black : AppTokens.Colors.chipBorder })
      .onClick(() => {
        this.onClick()
      })
  }
}