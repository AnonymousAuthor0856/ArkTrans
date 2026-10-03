class AppColors {
  static readonly primary: string = '#2563EB'
  static readonly secondary: string = '#38BDF8'
  static readonly backgroundTop: string = '#E8F8FF'
  static readonly backgroundBottom: string = '#DCE9FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E2E8F0'
  static readonly outline: string = '#CBD5E1'
  static readonly text: string = '#1E293B'
  static readonly darkText: string = '#0F172A'
}

interface UnitItem {
  name: string
}

@Entry
@Component
struct UnitConverterApp {
  @State private activeUnit: string = 'Length'

  private readonly units: UnitItem[] = [
    { name: 'Length' },
    { name: 'Weight' },
    { name: 'Temperature' },
    { name: 'Speed' }
  ]

  @Builder
  private mapArea() {
    Column({ space: 10 }) {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.text)
        .textAlign(TextAlign.Center)

      Text(`Active Unit: ${this.activeUnit}`)
        .fontSize(12)
        .fontColor(AppColors.text)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(104)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(14)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  private markerCard(item: UnitItem) {
    Column() {
      Text(item.name)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.text)
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('Tap to convert')
        .fontSize(12)
        .fontColor(AppColors.text)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ top: 2 })
    }
    .width('100%')
    .height(80)
    .padding(10)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.activeUnit === item.name ? '#9938BDF8' : AppColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.activeUnit = item.name
    })
  }

  @Builder
  private unitButton(item: UnitItem) {
    Button(item.name, { type: ButtonType.Normal, stateEffect: true })
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeUnit === item.name ? AppColors.surface : AppColors.text)
      .backgroundColor(this.activeUnit === item.name ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(6)
      .height(33)
      .layoutWeight(1)
      .padding({ left: 6, right: 6 })
      .onClick(() => {
        this.activeUnit = item.name
      })
  }

  build() {
    Column({ space: 14 }) {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.darkText)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(30)

      this.mapArea()

      ForEach(this.units, (item: UnitItem) => {
        this.markerCard(item)
      }, (item: UnitItem) => item.name)

      Blank()
        .height(10)

      Row({ space: 10 }) {
        ForEach(this.units, (item: UnitItem) => {
          this.unitButton(item)
        }, (item: UnitItem) => item.name)
      }
      .width('100%')
      .height(41)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 14, right: 14, top: 15, bottom: 14 })
    .linearGradient({
      angle: 180,
      colors: [[AppColors.backgroundTop, 0.0], [AppColors.backgroundBottom, 1.0]]
    })
  }
}
