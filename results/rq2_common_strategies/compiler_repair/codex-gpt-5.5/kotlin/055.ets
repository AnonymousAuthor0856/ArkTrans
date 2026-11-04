class WorkoutColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
}

@Entry
@Component
struct Index {
  @Builder
  TopBar() {
    Row() {
      Text('Workout Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(WorkoutColors.onBackground)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height(64)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(WorkoutColors.surface)
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Home')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(WorkoutColors.primary)
      Text('Plan')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(WorkoutColors.onSurface)
      Text('Profile')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(WorkoutColors.onSurface)
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(WorkoutColors.surface)
    .shadow({ radius: 8, color: '#24000000', offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()
        Column() {
          Text('Sign In to Continue')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(WorkoutColors.onSurface)
            .margin({ bottom: 16 })

          Text('Workout Preview')
            .width('100%')
            .height(200)
            .fontSize(14)
            .fontColor(WorkoutColors.onSurface)
            .textAlign(TextAlign.Center)
            .backgroundColor(WorkoutColors.surface)
            .borderRadius(16)
            .border({ width: 1, color: WorkoutColors.outline })

          Button('Authenticate')
            .width('80%')
            .height(52)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(WorkoutColors.onPrimary)
            .backgroundColor(WorkoutColors.primary)
            .borderRadius(16)
            .margin({ top: 16 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#1A38BDF8', 0.0], ['#262563EB', 1.0]]
        })
      }
      .width('100%')
      .height('100%')
      .padding({ bottom: 64 })

      Column() {
        this.BottomBar()
      }
      .width('100%')
      .align(Alignment.Bottom)

      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .fontSize(28)
        .fontColor(WorkoutColors.onPrimary)
        .backgroundColor(WorkoutColors.primary)
        .margin({ right: 24, bottom: 76 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(WorkoutColors.background)
  }
}
