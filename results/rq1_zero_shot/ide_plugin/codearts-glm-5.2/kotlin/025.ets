const AppColors = {
  primary: '#00FFFF',
  secondary: '#00FF88',
  tertiary: '#BB86FC',
  background: '#0D0D0D',
  surface: '#1C1C1C',
  surfaceVariant: '#2E2E2E',
  outline: '#3F3F3F',
  success: '#00FFAA',
  warning: '#FFC107',
  error: '#FF1744',
  onPrimary: '#000000',
  onSecondary: '#000000',
  onTertiary: '#000000',
  onBackground: '#FFFFFF',
  onSurface: '#FFFFFF'
}

const AppSpacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
}

@Entry
@Component
struct Index {
  @State nodesX: number[] = [200, 500, 350]
  @State nodesY: number[] = [400, 700, 250]
  @State currentColor: string = '#00FFFF'

  build() {
    Column() {
      Text('Neon Mind Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Stack() {
        ForEach(this.nodesX, (x: number, index: number) => {
          Column()
            .width(40)
            .height(40)
            .backgroundColor(this.currentColor)
            .borderRadius(20)
            .margin({ left: x - 20, top: this.nodesY[index] - 20 })
        }, (x: number, index: number) => index.toString())

        Button('+')
          .type(ButtonType.Normal)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(28)
          .width(56)
          .height(56)
          .margin({ left: 300, top: 500 })
          .onClick(() => {
            this.nodesX.push(Math.floor(Math.random() * 500) + 100)
            this.nodesY.push(Math.floor(Math.random() * 600) + 200)
          })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            this.nodesX.push(event.fingerList[0].localX)
            this.nodesY.push(event.fingerList[0].localY)
          })
      )

      Row() {
        Button('Cyan')
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(6)
          .onClick(() => {
            this.currentColor = '#00FFFF'
          })

        Button('Green')
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(6)
          .onClick(() => {
            this.currentColor = '#00FF88'
          })

        Button('Purple')
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(6)
          .onClick(() => {
            this.currentColor = '#BB86FC'
          })
      }
      .width('100%')
      .padding(AppSpacing.md)
      .backgroundColor(AppColors.surfaceVariant)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}