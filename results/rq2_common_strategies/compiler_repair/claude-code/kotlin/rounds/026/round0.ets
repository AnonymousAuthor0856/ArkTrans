@Entry
@Component
struct Index {
  @State scrollY: number = 0;

  private readonly Colors = {
    primary: '#38BDF8',
    secondary: '#A78BFA',
    tertiary: '#7DD3FC',
    background: '#F1F5F9',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Glass Doc Reader')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.Colors.background)

        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .linearGradient({
              direction: GradientDirection.Bottom,
              colors: [
                [this.Colors.surfaceVariant + 'CC', 0.0],
                [this.Colors.background, 0.5],
                [this.Colors.surfaceVariant + 'CC', 1.0]
              ]
            })

          Column() {
            Text('Document Reader')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.Colors.primary)
              .margin({ bottom: 12 })

            ForEach([1, 2, 3, 4, 5, 6, 7, 8], (item: number) => {
              Text(`This is a sample line of text content number ${item}.`)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(this.Colors.onSurface)
                .margin({ bottom: 8 })
            })
          }
          .width('90%')
          .height(400)
          .padding(16)
          .backgroundColor(this.Colors.surface + 'B3')
          .borderRadius(20)
          .shadow({
            radius: 8,
            color: '#0000002E',
            offsetY: 4
          })
          .translate({ y: this.scrollY / 5 })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignContent(FlexAlign.Center)
        .onPanUpdate((event: PanEvent) => {
          this.scrollY += event.translateY;
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.Colors.background)
  }
}
